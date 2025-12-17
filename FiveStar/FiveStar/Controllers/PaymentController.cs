using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars;          // CinemaDBEntities, EF entities
using FiveStars.Models;   // PaymentViewModel, CampaignModel

namespace FiveStars.Controllers
{
    public class PaymentController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        
        // HELPER METOTLAR (Kampanya/Fiyat/Cleanup)
        
        //Kampanya Uygunluk Kontrolü
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

            switch (campaignId)
            {
                case 2: // Family Package: Buy 4 Pay for 3
                    if (numTickets < 4) return "Family Package requires a minimum of 4 tickets.";
                    break;

                case 3: // Tuesday Cinema
                    if (showingDate.DayOfWeek != DayOfWeek.Tuesday) return "Tuesday discount is only valid on Tuesdays.";
                    break;

                case 5: // Couple Ticket
                    if (numTickets != 2) return "Couple Ticket requires exactly 2 tickets.";
                    break;

                default:
                    // allow: 1,2,3,4,5 (but you hide 1 & 4 in list)
                    if (campaignId != 1 && campaignId != 4)
                        return "Invalid campaign selection.";
                    break;
            }

            return "";
        }

        // Returns BaseTotal (no discount), Discount, FinalTotal
        private (decimal BaseTotal, decimal Discount, decimal FinalTotal) CalculateOrderPrice(int orderId, int? campaignId)
        {
            var orderTickets = _db.Tickets
                .Include(t => t.Showings)
                .Where(t => t.OrderID == orderId)
                .ToList();

            if (!orderTickets.Any())
                return (0m, 0m, 0m);

            decimal ticketPrice = (decimal?)orderTickets.First().Showings.TicketPrice ?? 0m;
            int numTickets = orderTickets.Count;

            decimal baseTotal = numTickets * ticketPrice;
            decimal discountAmount = 0m;

            // Safety: campaign eligibility re-check
            if (campaignId.HasValue && campaignId.Value > 0)
            {
                var eligibility = CheckCampaignEligibility(orderId, campaignId.Value);
                if (!string.IsNullOrEmpty(eligibility))
                    campaignId = null;
            }

            if (campaignId.HasValue && campaignId.Value > 0)
            {
                switch (campaignId.Value)
                {
                    case 1: // Student 20%
                        discountAmount = baseTotal * 0.20m;
                        break;

                    case 2: // Family: for each 4 tickets, 1 ticket free
                        if (numTickets >= 4)
                            discountAmount = (numTickets / 4) * ticketPrice;
                        break;

                    case 3: // Tuesday fixed discount
                        discountAmount = 60.00m;
                        break;

                    case 5: // Couple: 2 tickets pay 1
                        if (numTickets == 2)
                            discountAmount = ticketPrice;
                        break;
                }
            }

            decimal finalTotal = Math.Max(0m, baseTotal - discountAmount);

            return (Math.Round(baseTotal, 2), Math.Round(discountAmount, 2), Math.Round(finalTotal, 2));
        }

        // Süresi Dolan Siparişleri Serbest Bırakma
        private void ReleaseExpiredHolds()
        {
            var cutoff = DateTime.Now.AddMinutes(-10);

            var expiredOrders = _db.Orders
                .Where(o => o.Status == "Pending" && o.CreatedAt < cutoff)
                .ToList();

            if (!expiredOrders.Any())
                return;

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

        // Mevcut Kullanıcı ID'sini Alma
        private int GetCurrentUserId()
        {
            var name = (User.Identity?.Name ?? "").Trim();

            // some projects store ID in Name
            if (int.TryParse(name, out int parsedId))
                return parsedId;

            // otherwise treat it as email
            var user = _db.Users.FirstOrDefault(u => u.Email == name);
            if (user == null)
                throw new InvalidOperationException("Logged-in user not found. Check what User.Identity.Name contains.");

            return user.UserID;
        }

        
        // GET ACTION: ÖDEME SAYFASINI YÜKLE
        

        [Authorize]
        public ActionResult Payment(int orderId)
        {
            ReleaseExpiredHolds();

            var order = _db.Orders
                .Include(o => o.Tickets)
                .FirstOrDefault(o => o.OrderID == orderId);

            if (order == null || order.Status == "Paid")
                return RedirectToAction("Index", "Home");

            // initial pricing (no campaign)
            var pricing = CalculateOrderPrice(orderId, null);

            int userId = GetCurrentUserId();

            // campaigns owned by user (excluding 1 and 4 as in your original logic)
            var availableCampaigns =
                (from uc in _db.User_Campaigns
                 join c in _db.Campaigns on uc.CampaignID equals c.CampaignID
                 where uc.UserID == userId && c.IsActive && c.CampaignID != 1 && c.CampaignID != 4
                 orderby c.CampaignID descending
                 select new CampaignModel
                 {
                     CampaignID = c.CampaignID,
                     Title = c.Title
                 }).ToList();

            var viewModel = new PaymentViewModel
            {
                OrderID = orderId,
                BaseTotal = pricing.BaseTotal,
                FinalTotal = pricing.FinalTotal,
                DiscountAmount = pricing.Discount,
                AvailableCampaigns = availableCampaigns,
                SelectedSeats = order.Tickets.Select(t => t.SeatNumber).ToList()
            };

            return View(viewModel);
        }

        
        //POST ACTION: AJAX FİYAT YENİDEN HESAPLAMA
      

        [Authorize]
        [HttpPost]
        public JsonResult RecalculatePrice(int orderId, int campaignId)
        {
            int? selectedCampaignId = campaignId > 0 ? campaignId : (int?)null;

            //Sahip olma kontrolü
            if (selectedCampaignId.HasValue)
            {
                int userId = GetCurrentUserId();
                bool owns = _db.User_Campaigns.Any(uc => uc.UserID == userId && uc.CampaignID == selectedCampaignId.Value);
                if (!owns)
                {
                    var basePricing = CalculateOrderPrice(orderId, null);
                    return Json(new
                    {
                        success = false,
                        message = "You can only use campaigns saved in your account.",
                        discount = 0m.ToString("C"),
                        finalTotal = basePricing.BaseTotal.ToString("C"),
                        selectedCampaignId = (int?)null
                    });
                }
            }

            // 2) eligibility check
            if (campaignId > 0)
            {
                string validationMessage = CheckCampaignEligibility(orderId, campaignId);
                if (!string.IsNullOrEmpty(validationMessage))
                {
                    var basePricing = CalculateOrderPrice(orderId, null);
                    return Json(new
                    {
                        success = false,
                        message = validationMessage,
                        discount = 0m.ToString("C"),
                        finalTotal = basePricing.BaseTotal.ToString("C"),
                        selectedCampaignId = (int?)null
                    });
                }
            }

            // 3) compute pricing
            var pricing = CalculateOrderPrice(orderId, selectedCampaignId);

            return Json(new
            {
                success = true,
                discount = pricing.Discount.ToString("C"),
                finalTotal = pricing.FinalTotal.ToString("C"),
                selectedCampaignId = selectedCampaignId
            });
        }


        
        //POST ACTION: ÖDEME ONAYI VE DB GÜNCELLEMESİ
        
        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ConfirmPayment(PaymentViewModel model)
        {
            // IMPORTANT: if invalid -> do NOT mark paid, do NOT redirect success, do NOT lose totals.
            if (!ModelState.IsValid)
            {
                ViewBag.Error = "Please enter valid card details (Card: 16 digits, Exp: MM/YYYY, CVV: 3-4 digits).";

                // Reload campaigns + seats + totals so the page doesn't become 0/empty after a failed submit
                int userId = GetCurrentUserId();

                model.AvailableCampaigns =
                    (from uc in _db.User_Campaigns
                     join c in _db.Campaigns on uc.CampaignID equals c.CampaignID
                     where uc.UserID == userId && c.IsActive && c.CampaignID != 1 && c.CampaignID != 4
                     orderby c.CampaignID descending
                     select new CampaignModel { CampaignID = c.CampaignID, Title = c.Title }).ToList();

                var order = _db.Orders.Include(o => o.Tickets).FirstOrDefault(o => o.OrderID == model.OrderID);
                if (order != null)
                    model.SelectedSeats = order.Tickets.Select(t => t.SeatNumber).ToList();

                var pricing = CalculateOrderPrice(model.OrderID, model.SelectedCampaignID);
                model.BaseTotal = pricing.BaseTotal;
                model.DiscountAmount = pricing.Discount;
                model.FinalTotal = pricing.FinalTotal;

                return View("Payment", model);
            }

            // Payment gateway simulation (still always true) - but only AFTER validation
            bool paymentSuccess = true;
            if (!paymentSuccess)
            {
                TempData["PaymentError"] = "Payment failed. Please try again.";
                return RedirectToAction("Payment", new { orderId = model.OrderID });
            }

            var dbOrder = _db.Orders
                .Include(o => o.Tickets)
                .FirstOrDefault(o => o.OrderID == model.OrderID);

            if (dbOrder == null || dbOrder.Status == "Paid")
                return RedirectToAction("Payment", new { orderId = model.OrderID });

            int? chosen = model.SelectedCampaignID;

            // ownership + eligibility final safety
            if (chosen.HasValue)
            {
                int userId = GetCurrentUserId();
                bool owns = _db.User_Campaigns.Any(uc => uc.UserID == userId && uc.CampaignID == chosen.Value);
                if (!owns) chosen = null;

                if (chosen.HasValue && !string.IsNullOrEmpty(CheckCampaignEligibility(model.OrderID, chosen.Value)))
                    chosen = null;
            }

            var pricingFinal = CalculateOrderPrice(model.OrderID, chosen);

            // Update DB
            dbOrder.Status = "Paid";
            dbOrder.CampaignID = chosen;
            dbOrder.DiscountAmount = pricingFinal.Discount;
            dbOrder.TotalAmount = pricingFinal.FinalTotal;

            foreach (var ticket in dbOrder.Tickets)
                ticket.Status = "Paid";

            _db.SaveChanges();

            return RedirectToAction("PaymentSuccess", new { orderId = model.OrderID });
        }

     
        //GET ACTION: ÖDEME BAŞARI SAYFASI
        

        [Authorize]
        public ActionResult PaymentSuccess(int orderId)
        {
            var order = _db.Orders.FirstOrDefault(o => o.OrderID == orderId && o.Status == "Paid");
            if (order == null)
                return RedirectToAction("Index", "Home");

            var successModel = new PaymentViewModel
            {
                OrderID = orderId,
                FinalTotal = order.TotalAmount
            };

            TempData["PaymentConfirmed"] = "Payment confirmed. Your tickets have been issued.";
            return View(successModel);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) _db.Dispose();
            base.Dispose(disposing);
        }
    }
}
