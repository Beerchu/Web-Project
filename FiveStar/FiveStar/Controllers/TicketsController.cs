using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

 

using FiveStars;


namespace FiveStars.Controllers
{
    // *** YENİ: Koltuk Seçim Sayfasından POST edilen veriyi karşılayacak model ***
    public class SeatSelectionPostModel
    {
        public int ShowingID { get; set; }
        public decimal BaseTotal { get; set; }
        public List<int> SelectedSeatIDs { get; set; }
        public List<string> SelectedSeatNumbers { get; set; }
    }

    public class TicketsController : Controller
    {
        // CinemaDBEntities içinde Order ve Ticket'a erişim Entity Framework tarafından sağlanır.
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // =========================
        // HELPER: DUMMY SEATING PLAN
        // =========================
        private IEnumerable<SeatRow> GetDummySeatingPlan(string hallType)
        {
            var random = new Random();
            var seatingPlan = new List<SeatRow>();

            int soldCount = random.Next(5, 16);
            var allSeats = new List<Seat>();

            // Recliner row
            var reclinerRow = new SeatRow { RowName = "R", Seats = new List<Seat>() };
            for (int i = 1; i <= 10; i++)
            {
                reclinerRow.Seats.Add(new Seat
                {
                    SeatID = 100 + i,
                    SeatNumber = "R" + i,
                    Status = "Available",
                    Type = "Recliner",
                    ExtraPrice = 15.00m
                });
            }
            seatingPlan.Add(reclinerRow);
            allSeats.AddRange(reclinerRow.Seats);

            // Standard rows
            for (char row = 'L'; row >= 'H'; row--)
            {
                var standardRow = new SeatRow { RowName = row.ToString(), Seats = new List<Seat>() };
                for (int i = 1; i <= 20; i++)
                {
                    standardRow.Seats.Add(new Seat
                    {
                        SeatID = (int)row * 100 + i,
                        SeatNumber = row + i.ToString(),
                        Status = "Available",
                        Type = "Standard",
                        ExtraPrice = 0
                    });
                }
                standardRow.Seats.Insert(10, null);
                standardRow.Seats.Insert(11, null);

                allSeats.AddRange(standardRow.Seats.Where(s => s != null));
                seatingPlan.Add(standardRow);
            }

            // Random sold seats
            foreach (var seat in allSeats.OrderBy(s => random.Next()).Take(soldCount))
            {
                seat.Status = "Sold";
            }

            return seatingPlan;
        }

        // =========================
        // PUBLIC: SHOWTIMES
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
        // 🔐 PROTECTED: SEAT SELECTION
        // =========================
        [Authorize]
        public ActionResult SelectSeats(int showingId)
        {
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
                SeatingPlan = GetDummySeatingPlan(showing.Halls.HallType)
            };

            return View(viewModel);
        }

        // *** BAĞLANTIYI TAMAMLAYAN KRİTİK ACTION: ORDER OLUŞTURMA VE YÖNLENDİRME ***
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateOrderAndRedirectToPayment(SeatSelectionPostModel model)
        {
            // Kullanıcı girişi kontrolü (Session'dan çekilir)
            if (Session["UserID"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            int currentUserId = (int)Session["UserID"];

            if (model == null || model.SelectedSeatIDs == null || !model.SelectedSeatIDs.Any())
            {
                // Koltuk seçim ekranına geri dön
                return RedirectToAction("SelectSeats", new { showingId = model.ShowingID });
            }

            // 1. Yeni Order kaydı oluştur
            var newOrder = new Orders
            {
                UserID = currentUserId,
                CreatedAt = DateTime.Now,
                TotalAmount = model.BaseTotal,
                Status = "Pending",
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

        // Dispoz metodu (MEVCUT)
        protected override void Dispose(bool disposing)
        {
            if (disposing)
                _db.Dispose();

            base.Dispose(disposing);
        }
    }
}
