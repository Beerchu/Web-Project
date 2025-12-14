using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models; // CampaignModel ve PaymentViewModel artık buradan çekiliyor

// NECESSARY USING FOR ENTITY FRAMEWORK CLASSES (Order/Ticket)
using FiveStars;


namespace FiveStars.Controllers
{
    // *** ViewModel Definitions (Bu kısım TAŞINDIĞI için BOŞ) ***

    public class PaymentController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // ** A.1. Helper Method: Check Campaign Eligibility **
        // Kampanyanın geçerli olup olmadığını kontrol eder. Geçersizse hata mesajı döner.
        private string CheckCampaignEligibility(int orderId, int campaignId)
        {
            var orderTickets = _db.Tickets
                                 .Include(t => t.Showings)
                                 .Where(t => t.OrderID == orderId)
                                 .ToList();

            if (!orderTickets.Any())
                return "Order details could not be found.";

            int numTickets = orderTickets.Count;
            DateTime showingDate = orderTickets.First().Showings.ShowTime;

            // Koşul kontrolü
            switch (campaignId)
            {
                case 2: // Family Package: Buy 4 Pay for 3
                    if (numTickets < 4)
                    {
                        return "Family Package requires a minimum of 4 tickets to be selected.";
                    }
                    break;

                case 3: // Tuesday Cinema
                    // Gün kontrolü
                    if (showingDate.DayOfWeek != DayOfWeek.Tuesday)
                    {
                        return "Tuesday Cinema Discount is only valid for shows on Tuesdays.";
                    }
                    break;

                case 5: // Couple Ticket (ID'nin 5 olduğunu varsayıyoruz)
                    if (numTickets != 2)
                    {
                        return "Couple Ticket requires exactly 2 tickets to be selected.";
                    }
                    break;

                // Diğer kampanyalar (Örn: Popcorn, Student) artık Controller tarafından işlenmeyecek.

                default:
                    // Eğer 1 (Student) veya diğer kaldırılan kampanyalar seçilirse, geçersiz kabul et.
                    if (campaignId != 1 && campaignId != 4)
                    {
                        // Sadece aktif ve tanımlanmış kampanyalara izin veriyoruz.
                        return "Invalid campaign selection or conditions not met.";
                    }
                    break;
            }

            // Koşullar sağlanıyorsa veya kampanya bilinmiyorsa (ancak AJAX'tan geldiği için) boş string dön
            return "";
        }


        // ** A. Helper Method: Price Calculation Logic **
        private (decimal Discount, decimal FinalTotal) CalculateOrderPrice(int orderId, int? campaignId)
        {
            var orderTickets = _db.Tickets
                                     .Include(t => t.Showings)
                                     .Where(t => t.OrderID == orderId)
                                     .ToList();

            if (!orderTickets.Any()) return (0m, 0m);

            // CS1061 hatasını çözmek için düzeltme yapıldı: GetValueOrDefault kaldırıldı
            decimal ticketPrice = (decimal)orderTickets.First().Showings.TicketPrice;
            decimal baseTotal = orderTickets.Count * ticketPrice;
            decimal discountAmount = 0m;
            int numTickets = orderTickets.Count;

            // ** YENİ EK: Koşulları sağlama kontrolü (Güvenlik için) **
            if (campaignId.HasValue && campaignId.Value > 0)
            {
                string eligibilityCheck = CheckCampaignEligibility(orderId, campaignId.Value);
                if (!string.IsNullOrEmpty(eligibilityCheck))
                {
                    // Koşullar sağlanmıyorsa indirimi sıfırla
                    campaignId = null;
                }
            }


            // Apply Campaign Discount
            if (campaignId.HasValue && campaignId.Value > 0)
            {
                switch (campaignId.Value)
                {
                    case 1: // Student Discount 20% (Kaldırılması istendi, ancak DB'den gelirse %20 indirim uyguluyoruz)
                        discountAmount = baseTotal * 0.20m;
                        break;
                    case 2: // Family Package: Buy 4 Pay for 3
                        if (numTickets >= 4) // Koşul kontrolü CheckCampaignEligibility'de yapıldı, burada sadece hesaplama var
                        {
                            discountAmount = (numTickets / 4) * ticketPrice;
                        }
                        break;
                    case 3: // Tuesday Cinema: Fixed Discount (60 TL)
                        // Koşul kontrolü CheckCampaignEligibility'de yapıldı
                        discountAmount = 60.00m;
                        break;
                    case 5: // Couple Ticket
                        if (numTickets == 2) // Koşul kontrolü CheckCampaignEligibility'de yapıldı
                        {
                            // Varsayalım ki Couple Ticket 1 bilet fiyatı kadar indirim yapıyor.
                            discountAmount = ticketPrice;
                        }
                        break;
                        // Case 4 (Popcorn) kaldırıldı
                }
            }

            decimal finalTotal = baseTotal - discountAmount;

            // Round results and ensure total is not negative
            return (Math.Round(discountAmount, 2), Math.Round(Math.Max(0m, finalTotal), 2));
        }

        private void ReleaseExpiredHolds()
        {
            var cutoff = DateTime.Now.AddMinutes(-10);

            var expiredOrders = _db.Orders
                .Where(o => o.Status == "Pending" && o.CreatedAt < cutoff)
                .ToList();

            if (!expiredOrders.Any()) return;

            var expiredIds = expiredOrders.Select(o => o.OrderID).ToList();

            var expiredTickets = _db.Tickets
                .Where(t => t.OrderID.HasValue
                         && expiredIds.Contains(t.OrderID.Value)
                         && t.Status == "booked")
                .ToList();


            _db.Tickets.RemoveRange(expiredTickets);
            _db.Orders.RemoveRange(expiredOrders);

            _db.SaveChanges();
        }

        // ** B. GET Method: Load Payment Page (Shows BaseTotal and Campaigns) **
        [Authorize]
        public ActionResult Payment(int orderId)
        {
            ReleaseExpiredHolds();
            var order = _db.Orders
                           .Include(o => o.Tickets)
                           .FirstOrDefault(o => o.OrderID == orderId);

            if (order == null || order.Status == "Paid") return RedirectToAction("Index", "Home");

            // Calculate initial prices (Undiscounted Base Total)
            var (discount, finalTotal) = CalculateOrderPrice(orderId, null);

            int userId = GetCurrentUserId();

            var availableCampaigns = (from uc in _db.User_Campaigns
                                      join c in _db.Campaigns on uc.CampaignID equals c.CampaignID
                                      where uc.UserID == userId
                                            && c.IsActive
                                            && c.CampaignID != 1 && c.CampaignID != 4
                                      orderby c.CampaignID descending
                                      select new CampaignModel
                                      {
                                          CampaignID = c.CampaignID,
                                          Title = c.Title
                                      }).ToList();


            var viewModel = new PaymentViewModel
            {
                OrderID = orderId,
                BaseTotal = finalTotal,
                FinalTotal = finalTotal,
                DiscountAmount = discount,
                AvailableCampaigns = availableCampaigns,
                SelectedSeats = order.Tickets.Select(t => t.SeatNumber).ToList()
            };

            return View(viewModel);
        }

        [Authorize]
        [HttpPost]
        public JsonResult RecalculatePrice(int orderId, int campaignId)
        {
            int? selectedCampaignId = campaignId > 0 ? campaignId : (int?)null;

            // Ownership check
            if (selectedCampaignId.HasValue)
            {
                int userId = GetCurrentUserId();

                bool owns = _db.User_Campaigns.Any(uc =>
                    uc.UserID == userId && uc.CampaignID == selectedCampaignId.Value);

                if (!owns)
                {
                    var baseTotal = _db.Orders.FirstOrDefault(o => o.OrderID == orderId)?.TotalAmount ?? 0m;

                    return Json(new
                    {
                        success = false,
                        message = "You can only use campaigns saved in your account.",
                        discount = 0m.ToString("C"),
                        finalTotal = baseTotal.ToString("C"),
                        selectedCampaignId = (int?)null
                    });
                }
            }

            // Existing eligibility check
            string validationMessage = "";
            if (campaignId > 0)
                validationMessage = CheckCampaignEligibility(orderId, campaignId);

            if (!string.IsNullOrEmpty(validationMessage))
            {
                decimal baseTotal = _db.Orders.FirstOrDefault(o => o.OrderID == orderId)?.TotalAmount ?? 0m;

                return Json(new
                {
                    success = false,
                    message = validationMessage,
                    discount = 0m.ToString("C"),
                    finalTotal = baseTotal.ToString("C"),
                    selectedCampaignId = (int?)null
                });
            }

            var (discount, finalTotal) = CalculateOrderPrice(orderId, selectedCampaignId);

            return Json(new
            {
                success = true,
                discount = discount.ToString("C"),
                finalTotal = finalTotal.ToString("C"),
                selectedCampaignId = selectedCampaignId
            });
        }


        // ** D. POST Method: Confirm Payment and Update DB **
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ConfirmPayment(PaymentViewModel model)
        {
            // Payment Gateway Integration Simulation...
            bool paymentSuccess = true;

            if (paymentSuccess)
            {
                var order = _db.Orders
                               .Include(o => o.Tickets)
                               .FirstOrDefault(o => o.OrderID == model.OrderID);



                if (order != null && order.Status != "Paid")
                {
                    int? chosen = model.SelectedCampaignID;

                    if (chosen.HasValue)
                    {
                        int userId = GetCurrentUserId();
                        bool owns = _db.User_Campaigns.Any(uc => uc.UserID == userId && uc.CampaignID == chosen.Value);
                        if (!owns) chosen = null;
                    }

                    var (discount, finalTotal) = CalculateOrderPrice(model.OrderID, chosen);

                    // Update Order record (use chosen, not model.SelectedCampaignID)
                    order.Status = "Paid";
                    order.CampaignID = chosen;
                    order.DiscountAmount = discount;
                    order.TotalAmount = finalTotal;


                    // 3. Mark Tickets as "Paid"
                    foreach (var ticket in order.Tickets)
                    {
                        ticket.Status = "Paid";
                    }

                    _db.SaveChanges();

                    // 4. Redirect to Success page
                    return RedirectToAction("PaymentSuccess", new { orderId = model.OrderID });
                }
            }

            ModelState.AddModelError("", "Payment failed or Order could not be updated.");
            return RedirectToAction("Payment", new { orderId = model.OrderID });
        }

        private int GetCurrentUserId()
        {
            var name = (User.Identity?.Name ?? "").Trim();

            // If your auth stores numeric id in Name:
            if (int.TryParse(name, out int parsedId))
                return parsedId;

            // Otherwise assume it's email:
            var user = _db.Users.FirstOrDefault(u => u.Email == name);
            if (user == null)
                throw new InvalidOperationException("Logged-in user not found. Check what User.Identity.Name contains.");

            return user.UserID;
        }


        // Dispose Method
        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}