using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

// 👇 NECESSARY USING FOR ENTITY FRAMEWORK CLASSES (Order/Ticket)
// This line assumes your EF entities (Order, Ticket) are defined under the root namespace 'FiveStars'.
using FiveStars;


namespace FiveStars.Controllers
{
    // *** ViewModel Definitions (These should ideally be in /Models folder) ***

    // Simple model for Campaign Dropdown
    public class CampaignModel
    {
        public int CampaignID { get; set; }
        public string Title { get; set; }
    }

    // Main model to transfer data between Controller and View
    public class PaymentViewModel
    {
        public int OrderID { get; set; }
        public decimal BaseTotal { get; set; }
        public int? SelectedCampaignID { get; set; }
        public List<CampaignModel> AvailableCampaigns { get; set; }
        public decimal DiscountAmount { get; set; }
        public decimal FinalTotal { get; set; }
        public List<string> SelectedSeats { get; set; }
    }

    // *** Payment Controller Start ***

    public class PaymentController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // ** A. Helper Method: Price Calculation Logic **
        private (decimal Discount, decimal FinalTotal) CalculateOrderPrice(int orderId, int? campaignId)
        {
            var orderTickets = _db.Tickets
                                  .Include(t => t.Showings)
                                  .Where(t => t.OrderID == orderId)
                                  .ToList();

            if (!orderTickets.Any()) return (0m, 0m);

            // Calculate Base Total
            decimal ticketPrice = (decimal)orderTickets.First().Showings.TicketPrice;
            decimal baseTotal = orderTickets.Count * ticketPrice;
            decimal discountAmount = 0m;

            // Apply Campaign Discount (Manual logic due to missing DB fields for discount rates)
            if (campaignId.HasValue && campaignId.Value > 0)
            {
                switch (campaignId.Value)
                {
                    case 1: // Student Discount 20%
                        discountAmount = baseTotal * 0.20m;
                        break;
                    case 2: // Family Package: Buy 4 Pay for 3 (1 free ticket for every 4)
                        int numTickets = orderTickets.Count;
                        if (numTickets >= 4)
                        {
                            discountAmount = (numTickets / 4) * ticketPrice;
                        }
                        break;
                    case 3: // Tuesday Cinema: Fixed Discount (Example: 50 TL)
                        discountAmount = 50.00m;
                        break;
                        // Other campaigns...
                }
            }

            decimal finalTotal = baseTotal - discountAmount;

            // Round results and ensure total is not negative
            return (Math.Round(discountAmount, 2), Math.Round(Math.Max(0m, finalTotal), 2));
        }


        // ** B. GET Method: Load Payment Page (Shows BaseTotal and Campaigns) **
        public ActionResult Payment(int orderId)
        {
            var order = _db.Orders
                           .Include(o => o.Tickets)
                           .FirstOrDefault(o => o.OrderID == orderId);

            // Redirect if order not found or already paid
            if (order == null || order.Status == "Paid") return RedirectToAction("Index", "Home");

            // Calculate initial prices (Undiscounted Base Total)
            var (discount, finalTotal) = CalculateOrderPrice(orderId, null);

            // Fetch active campaigns
            var availableCampaigns = _db.Campaigns
                                        .Where(c => c.IsActive)
                                        .Select(c => new CampaignModel { CampaignID = c.CampaignID, Title = c.Title })
                                        .ToList();

            var viewModel = new PaymentViewModel
            {
                OrderID = orderId,
                BaseTotal = finalTotal, // BaseTotal is the undiscounted price
                FinalTotal = finalTotal,
                DiscountAmount = discount,
                AvailableCampaigns = availableCampaigns,
                SelectedSeats = order.Tickets.Select(t => t.SeatNumber).ToList()
            };

            return View(viewModel);
        }

        // ** C. Ajax Endpoint: Recalculate Price (Triggered by dropdown change) **
        [HttpPost]
        public JsonResult RecalculatePrice(int orderId, int campaignId)
        {
            // If campaignId = 0 (No campaign selected), set to null
            int? selectedCampaignId = campaignId > 0 ? campaignId : (int?)null;

            var (discount, finalTotal) = CalculateOrderPrice(orderId, selectedCampaignId);

            // Return results as JSON
            return Json(new
            {
                success = true,
                discount = discount.ToString("C"),
                finalTotal = finalTotal.ToString("C"),
                selectedCampaignId = selectedCampaignId
            });
        }

        // ** D. POST Method: Confirm Payment and Update DB **
        [HttpPost]
        [ValidateAntiForgeryToken] // Prevents CSRF attacks, token required in the form
        public ActionResult ConfirmPayment(PaymentViewModel model)
        {
            // *** Payment Gateway Integration Simulation ***
            bool paymentSuccess = true;

            if (paymentSuccess)
            {
                // 1. Find the Order record
                var order = _db.Orders
                               .Include(o => o.Tickets)
                               .FirstOrDefault(o => o.OrderID == model.OrderID);

                if (order != null && order.Status != "Paid")
                {
                    // Recalculate prices one last time for security
                    var (discount, finalTotal) = CalculateOrderPrice(model.OrderID, model.SelectedCampaignID);

                    // 2. Update Order record
                    order.Status = "Paid";
                    order.CampaignID = model.SelectedCampaignID;
                    order.DiscountAmount = discount;
                    order.TotalAmount = finalTotal;

                    // 3. Mark Tickets as "Paid" (Sells the seats)
                    foreach (var ticket in order.Tickets)
                    {
                        ticket.Status = "Paid";
                        // This status update marks the seats as sold/occupied for the showtime.
                    }

                    _db.SaveChanges();

                    // 4. Redirect to Success page
                    return RedirectToAction("PaymentSuccess", new { orderId = model.OrderID });
                }
            }

            // If payment fails or Order is invalid
            ModelState.AddModelError("", "Payment failed or Order could not be updated.");
            // Redirect back to Payment page to display error
            return RedirectToAction("Payment", new { orderId = model.OrderID });
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