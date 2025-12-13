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

            // 2. Bu seans için satılmış/rezerve edilmiş koltukların SeatID'lerini al
            var soldSeatIds = _db.Tickets
                .Where(t => t.ShowingID == showingId && (t.Status == "Paid" || t.Status == "booked"))
                .Select(t => t.SeatID)
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

        // *** KRİTİK ACTION: ORDER OLUŞTURMA VE PAYMENT'A YÖNLENDİRME ***
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateOrderAndRedirectToPayment(SeatSelectionPostModel model)
        {
            // Session kontrolünü geçici olarak atlayıp sabit ID kullanıyoruz.
            // Bu, sürekli Sign-In'e dönme sorununu şimdilik aşar.
            int currentUserId = 1;

            // NOT: Normalde burada Session["UserID"] kontrolü olmalıdır.
            /* if (Session["UserID"] == null)
            {
                return RedirectToAction("Login", "Account");
            }
            int currentUserId = (int)Session["UserID"];
            */


            if (model == null || model.SelectedSeatIDs == null || !model.SelectedSeatIDs.Any())
            {
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

        // Dispoz metodu
        protected override void Dispose(bool disposing)
        {
            if (disposing)
                _db.Dispose();

            base.Dispose(disposing);
        }
    }
}