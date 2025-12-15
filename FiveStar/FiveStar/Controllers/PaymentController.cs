using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models; // CampaignModel ve PaymentViewModel buradan geliyor
using FiveStars; // Order, Ticket ve CinemaDBEntities buradan geliyor

namespace FiveStars.Controllers
{
    public class PaymentController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // =========================================================
        // A. HELPER METOTLAR (Kampanya/Fiyat/Cleanup)
        // =========================================================

        // A.1. Kampanya Uygunluk Kontrolü
        private string CheckCampaignEligibility(int orderId, int campaignId)
        {
            var orderTickets = _db.Tickets
                                 .Include(t => t.Showings)
                                 .Where(t => t.OrderID == orderId)
                                 .ToList();

            if (!orderTickets.Any())
                return "Order details could not be found.";

            int numTickets = orderTickets.Count;
            // Ticket entity'sinde Showings referansının null olmadığı varsayılmıştır.
            DateTime showingDate = orderTickets.First().Showings.ShowTime;

            switch (campaignId)
            {
                case 2: // Family Package: Buy 4 Pay for 3
                    if (numTickets < 4)
                        return "Family Package requires a minimum of 4 tickets to be selected.";
                    break;
                case 3: // Tuesday Cinema
                    if (showingDate.DayOfWeek != DayOfWeek.Tuesday)
                        return "Tuesday Cinema Discount is only valid for shows on Tuesdays.";
                    break;
                case 5: // Couple Ticket
                    if (numTickets != 2)
                        return "Couple Ticket requires exactly 2 tickets to be selected.";
                    break;
                default:
                    if (campaignId != 1 && campaignId != 4)
                        return "Invalid campaign selection or conditions not met.";
                    break;
            }
            return "";
        }

        // A.2. Fiyat Hesaplama Mantığı
        private (decimal Discount, decimal FinalTotal) CalculateOrderPrice(int orderId, int? campaignId)
        {
            var orderTickets = _db.Tickets
                                 .Include(t => t.Showings)
                                 .Where(t => t.OrderID == orderId)
                                 .ToList();

            if (!orderTickets.Any()) return (0m, 0m);

            // TicketPrice'ın nullable olması durumuna karşı güvenlik önlemi
            decimal ticketPrice = (decimal?)orderTickets.First().Showings.TicketPrice ?? 0m;
            decimal baseTotal = orderTickets.Count * ticketPrice;
            decimal discountAmount = 0m;
            int numTickets = orderTickets.Count;

            // Uygunluk kontrolü (AJAX'tan sonra güvenlik için tekrar kontrol)
            if (campaignId.HasValue && campaignId.Value > 0)
            {
                string eligibilityCheck = CheckCampaignEligibility(orderId, campaignId.Value);
                if (!string.IsNullOrEmpty(eligibilityCheck))
                {
                    campaignId = null; // Uygun değilse kampanyayı sıfırla
                }
            }

            // İndirimi Uygula
            if (campaignId.HasValue && campaignId.Value > 0)
            {
                switch (campaignId.Value)
                {
                    case 1: discountAmount = baseTotal * 0.20m; break; // Student Discount
                    case 2: // Family Package
                        if (numTickets >= 4) discountAmount = (numTickets / 4) * ticketPrice;
                        break;
                    case 3: // Tuesday Cinema
                        discountAmount = 60.00m;
                        break;
                    case 5: // Couple Ticket
                        if (numTickets == 2) discountAmount = ticketPrice;
                        break;
                }
            }

            decimal finalTotal = baseTotal - discountAmount;

            return (Math.Round(discountAmount, 2), Math.Round(Math.Max(0m, finalTotal), 2));
        }

        // A.3. Süresi Dolan Siparişleri Serbest Bırakma
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

        // A.4. Mevcut Kullanıcı ID'sini Alma
        private int GetCurrentUserId()
        {
            var name = (User.Identity?.Name ?? "").Trim();

            if (int.TryParse(name, out int parsedId))
                return parsedId;

            var user = _db.Users.FirstOrDefault(u => u.Email == name);
            if (user == null)
                throw new InvalidOperationException("Logged-in user not found. Check what User.Identity.Name contains.");

            return user.UserID;
        }

        // =========================================================
        // B. GET ACTION: ÖDEME SAYFASINI YÜKLE
        // =========================================================

        [Authorize]
        public ActionResult Payment(int orderId)
        {
            ReleaseExpiredHolds();
            var order = _db.Orders
                           .Include(o => o.Tickets)
                           .FirstOrDefault(o => o.OrderID == orderId);

            if (order == null || order.Status == "Paid") return RedirectToAction("Index", "Home");

            // Başlangıç fiyatlarını hesapla (Kampanyasız, sadece temel toplamı görmek için)
            var (discount, finalTotal) = CalculateOrderPrice(orderId, null);

            int userId = GetCurrentUserId();

            // Kullanıcıya ait mevcut kampanyaları getir (Kampanya ID 1 ve 4 hariç)
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

        // =========================================================
        // C. POST ACTION: AJAX FİYAT YENİDEN HESAPLAMA
        // =========================================================

        [Authorize]
        [HttpPost]
        public JsonResult RecalculatePrice(int orderId, int campaignId)
        {
            int? selectedCampaignId = campaignId > 0 ? campaignId : (int?)null;

            // 1. Sahip olma kontrolü
            if (selectedCampaignId.HasValue)
            {
                int userId = GetCurrentUserId();
                bool owns = _db.User_Campaigns.Any(uc => uc.UserID == userId && uc.CampaignID == selectedCampaignId.Value);

                if (!owns)
                {
                    decimal baseTotal = _db.Orders.FirstOrDefault(o => o.OrderID == orderId)?.TotalAmount ?? 0m;
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

            // 2. Uygunluk kontrolü
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

            // 3. Fiyatı hesapla
            var (discount, finalTotal) = CalculateOrderPrice(orderId, selectedCampaignId);

            return Json(new
            {
                success = true,
                discount = discount.ToString("C"),
                finalTotal = finalTotal.ToString("C"),
                selectedCampaignId = selectedCampaignId
            });
        }


        // =========================================================
        // D. POST ACTION: ÖDEME ONAYI VE DB GÜNCELLEMESİ
        // =========================================================

        [Authorize]
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ConfirmPayment(PaymentViewModel model)
        {
            // 1. Model Doğrulama (Kart Bilgileri için)
            if (!ModelState.IsValid)
            {
                ViewBag.Error = "Lütfen kart bilgilerinizi eksiksiz ve doğru formatta girin.";

                // Kampanyaları tekrar yükle (UI'ın bozulmaması için)
                int userId = GetCurrentUserId();
                model.AvailableCampaigns = (from uc in _db.User_Campaigns
                                            join c in _db.Campaigns on uc.CampaignID equals c.CampaignID
                                            where uc.UserID == userId && c.IsActive && c.CampaignID != 1 && c.CampaignID != 4
                                            select new CampaignModel { CampaignID = c.CampaignID, Title = c.Title }).ToList();

                return View("Payment", model);
            }

            // 2. Ödeme Ağ Geçidi Simülasyonu
            bool paymentSuccess = true;

            if (paymentSuccess)
            {
                var order = _db.Orders
                               .Include(o => o.Tickets)
                               .FirstOrDefault(o => o.OrderID == model.OrderID);

                if (order != null && order.Status != "Paid")
                {
                    int? chosen = model.SelectedCampaignID;

                    // Nihai güvenlik ve hesaplama (sahip olma ve uygunluk kontrolü)
                    if (chosen.HasValue)
                    {
                        int userId = GetCurrentUserId();
                        bool owns = _db.User_Campaigns.Any(uc => uc.UserID == userId && uc.CampaignID == chosen.Value);
                        if (!owns) chosen = null;

                        if (chosen.HasValue && !string.IsNullOrEmpty(CheckCampaignEligibility(model.OrderID, chosen.Value)))
                        {
                            chosen = null;
                        }
                    }

                    var (discount, finalTotal) = CalculateOrderPrice(model.OrderID, chosen);

                    // 3. Veritabanı Güncelleme (Sipariş ve Bilet Statüsü)
                    order.Status = "Paid";
                    order.CampaignID = chosen;
                    order.DiscountAmount = discount;
                    // Order.TotalAmount'u sunucuda hesaplanan finalTotal ile güncelle
                    order.TotalAmount = finalTotal;

                    foreach (var ticket in order.Tickets)
                    {
                        ticket.Status = "Paid";
                    }

                    _db.SaveChanges();

                    // 4. Başarı sayfasına yönlendirme
                    return RedirectToAction("PaymentSuccess", new { orderId = model.OrderID });
                }
            }

            // Ödeme Başarısız olursa
            ModelState.AddModelError("", "Payment failed or Order could not be updated.");
            return RedirectToAction("Payment", new { orderId = model.OrderID });
        }

        // =========================================================
        // E. GET ACTION: ÖDEME BAŞARI SAYFASI
        // =========================================================

        [Authorize]
        public ActionResult PaymentSuccess(int orderId)
        {
            var order = _db.Orders
                           .FirstOrDefault(o => o.OrderID == orderId && o.Status == "Paid");

            if (order == null)
            {
                return RedirectToAction("Index", "Home");
            }

            var successModel = new PaymentViewModel
            {
                OrderID = orderId,
                // Hata çözümü: TotalAmount'ın decimal olduğunu varsayıyoruz.
                FinalTotal = order.TotalAmount,
            };

            // Onay mesajı (Home Controller'da gösterilmek üzere)
            TempData["PaymentConfirmed"] = "Ödeme işleminiz başarıyla onaylanmıştır! Biletleriniz e-posta adresinize gönderilmiştir.";

            // Bu, sizin oluşturduğunuz PaymentSuccess.cshtml görünümünü yükler.
            return View(successModel);
        }

        // =========================================================
        // F. Dispose Method
        // =========================================================

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