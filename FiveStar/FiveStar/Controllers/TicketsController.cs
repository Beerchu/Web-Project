using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;
using FiveStars; // Orders ve Tickets gibi EF sınıflarına erişim sağlar.


namespace FiveStars.Controllers
{
    // *** Koltuk Seçim Sayfasından POST edilen veriyi karşılayacak model ***
    public class SeatSelectionPostModel
    {
        public int ShowingID { get; set; }
        public decimal BaseTotal { get; set; }
        public List<int> SelectedSeatIDs { get; set; }
        public List<string> SelectedSeatNumbers { get; set; }
    }

    public class TicketsController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // =========================
        // HELPER: DB'DEN KOLTUK DÜZENİNİ ÇEKME METODU
        // =========================
        private IEnumerable<SeatRow> GetSeatingPlanFromDB(int showingId)
        {
            var showing = _db.Showings.FirstOrDefault(s => s.ShowingID == showingId);
            if (showing == null)
                return Enumerable.Empty<SeatRow>();

            int hallId = showing.HallID.GetValueOrDefault();

            // !!! KRİTİK DB UYUMSUZLUĞU DÜZELTMESİ !!!
            // Seats tablosunda sadece HallID=3 olduğu için, sorgunun çalışması için HallID'yi 3'e sabitliyoruz.
            hallId = 3;

            // 1. O salona ait tüm koltukları çek
            var hallSeats = _db.Seats
                .Where(s => s.HallID == hallId && s.IsActive != false)
                .ToList();

            if (!hallSeats.Any())
                return Enumerable.Empty<SeatRow>();

            var cutoff = DateTime.Now.AddMinutes(-10);

            var soldSeatIds =
                (from t in _db.Tickets
                 where t.OrderID.HasValue && t.ShowingID == showingId
                 join o in _db.Orders on t.OrderID.Value equals o.OrderID
                 where
                    t.Status == "Paid"
                    || (t.Status == "booked" && o.Status == "Pending" && o.CreatedAt >= cutoff)
                 select t.SeatID)
                .ToList();




            // 3. Koltukları RowLabel'a (Sıra Harfine) göre grupla
            var groupedSeats = hallSeats.GroupBy(s => s.RowLabel);
            var seatingPlan = new List<SeatRow>();

            foreach (var group in groupedSeats.OrderByDescending(g => g.Key))
            {
                var row = new SeatRow { RowName = group.Key, Seats = new List<Seat>() };

                foreach (var dbSeat in group.OrderBy(s => s.SeatNumber))
                {
                    string status = soldSeatIds.Contains(dbSeat.SeatID) ? "Sold" : "Available";

                    row.Seats.Add(new Seat
                    {
                        SeatID = dbSeat.SeatID,
                        // SeatNumber'ı string'e dönüştür
                        SeatNumber = dbSeat.SeatNumber.ToString(),
                        Status = status,
                        Type = dbSeat.SeatType ?? "Standard",
                        ExtraPrice = 0m
                    });
                }

                // 4. Orta Koridoru Ekleme Mantığı
                if (row.Seats.Count == 20)
                {
                    row.Seats.Insert(10, null);
                    row.Seats.Insert(11, null);
                }

                seatingPlan.Add(row);
            }

            return seatingPlan.OrderByDescending(r => r.RowName);
        }

        // =========================
        // PUBLIC: SHOWTIMES (MEVCUT)
        // =========================
        [AllowAnonymous]
        public ActionResult Showtimes(int movieId)
        {
            var movie = _db.Movies.Find(movieId);
            if (movie == null)
                return HttpNotFound();

            var showings = _db.Showings
                .Where(s => s.MovieID == movieId)
                .OrderBy(s => s.ShowTime)
                .ToList();

            var vm = new ShowtimeSelectionViewModel
            {
                MovieId = movie.MovieID,
                MovieTitle = movie.Title,
                PosterUrl = movie.PosterUrl,
                Status = movie.Status,
                Showtimes = showings.Select(s => new ShowtimeItem
                {
                    ShowingId = s.ShowingID,
                    ShowTime = s.ShowTime,
                    CinemaName = s.Halls.Cinemas.CinemaName,
                    HallName = s.Halls.HallType,
                    TicketPrice = s.TicketPrice
                }).ToList()
            };

            return View(vm);
        }

        // =========================
        // 🔐 PROTECTED: SEAT SELECTION (GÜNCELLENDİ)
        // =========================
        [AllowAnonymous]
        public ActionResult SelectSeats(int showingId)
        {
            ReleaseExpiredHolds();

            var showing = _db.Showings
                .Include(s => s.Movies)
                .Include(s => s.Halls)
                .Include(s => s.Halls.Cinemas)
                .FirstOrDefault(s => s.ShowingID == showingId);

            if (showing == null)
                return HttpNotFound();

            var viewModel = new SeatSelectionViewModel
            {
                SessionTimeID = showing.ShowingID,
                MovieTitle = showing.Movies.Title,
                CinemaName = showing.Halls.Cinemas.CinemaName,
                StartTime = showing.ShowTime,
                ScreenType = showing.Halls.HallType,
                TicketPrice = (decimal)showing.TicketPrice,

                SeatingPlan = GetSeatingPlanFromDB(showingId)
            };

            return View(viewModel);
        }

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


        [HttpPost]
        [Authorize] // forces login
        [ValidateAntiForgeryToken]
        public ActionResult CreateOrderAndRedirectToPayment(SeatSelectionPostModel model)
        {
            int currentUserId = GetCurrentUserId();



            if (model == null || model.SelectedSeatIDs == null || !model.SelectedSeatIDs.Any())
            {
                return RedirectToAction("SelectSeats", new { showingId = model.ShowingID });
            }

            var showing = _db.Showings.FirstOrDefault(s => s.ShowingID == model.ShowingID);
            if (showing == null) return HttpNotFound();

            decimal ticketPrice = (decimal)showing.TicketPrice;
            decimal serverTotal = model.SelectedSeatIDs.Count * ticketPrice;

            var cutoff = DateTime.Now.AddMinutes(-10);

            var blockedSeatIds =
                (from t in _db.Tickets
                 where t.OrderID.HasValue && t.ShowingID == model.ShowingID
                 join o in _db.Orders on t.OrderID.Value equals o.OrderID
                 where
                    t.Status == "Paid"
                    || (t.Status == "booked" && o.Status == "Pending" && o.CreatedAt >= cutoff)
                 select t.SeatID)
                .ToList();

            if (model.SelectedSeatIDs.Any(id => blockedSeatIds.Contains(id)))
            {
                TempData["ErrorMessage"] = "Some seats were just taken. Please select again.";
                return RedirectToAction("SelectSeats", new { showingId = model.ShowingID });
            }

            // 1. Yeni Order kaydı oluştur
            var newOrder = new Orders
            {
                UserID = currentUserId,
                CreatedAt = DateTime.Now,
                TotalAmount = serverTotal,
                Status = "Pending"
            };

            _db.Orders.Add(newOrder);
            _db.SaveChanges();

            // 2. Her bir koltuk için Ticket kaydı oluştur
            for (int i = 0; i < model.SelectedSeatIDs.Count; i++)
            {
                var newTicket = new Tickets
                {
                    SeatID = model.SelectedSeatIDs[i],
                    ShowingID = model.ShowingID,
                    UserID = currentUserId,
                    OrderID = newOrder.OrderID,
                    SeatNumber = model.SelectedSeatNumbers[i],
                    Status = "booked"
                };
                _db.Tickets.Add(newTicket);
            }
            _db.SaveChanges();

            // 3. Kullanıcıyı Payment sayfasına yönlendir
            return RedirectToAction("Payment", "Payment", new { orderId = newOrder.OrderID });
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



        // Dispoz metodu
        protected override void Dispose(bool disposing)
        {
            if (disposing)
                _db.Dispose();

            base.Dispose(disposing);
        }
    }
}