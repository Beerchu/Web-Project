using System;
using System.Collections.Generic;
using System.Data.Entity;      // Include() metodu için gerekli
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    public class TicketsController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // Yardımcı Metot: Koltuk Düzenini Oluşturur
        // Controllers/TicketsController.cs dosyasında GetDummySeatingPlan metodu yerine bu kodu kullanın.

        private IEnumerable<SeatRow> GetDummySeatingPlan(string hallType)
        {
            // Rastgelelik için basit bir Random nesnesi
            var random = new Random();
            var seatingPlan = new List<SeatRow>();

            // Toplam satılmış koltuk sayısını rastgele belirleyelim (Örn: 5 ile 15 arasında)
            int soldCount = random.Next(5, 16);
            var allSeats = new List<Seat>();

            // 1. RECLINER SIRA
            var reclinerRow = new SeatRow { RowName = "R", Seats = new List<Seat>() };
            for (int i = 1; i <= 10; i++)
            {
                reclinerRow.Seats.Add(new Seat
                {
                    SeatID = 100 + i,
                    SeatNumber = "R" + i,
                    Status = "Available", // Başlangıçta hepsi müsait
                    Type = "Recliner",
                    ExtraPrice = 15.00m
                });
            }
            seatingPlan.Add(reclinerRow);
            allSeats.AddRange(reclinerRow.Seats);

            // 2. STANDART SIRALAR (Ana blok: L'den H'ye)
            for (char row = 'L'; row >= 'H'; row--)
            {
                var standardRow = new SeatRow { RowName = row.ToString(), Seats = new List<Seat>() };
                for (int i = 1; i <= 20; i++)
                {
                    standardRow.Seats.Add(new Seat
                    {
                        SeatID = (int)row * 100 + i,
                        SeatNumber = row.ToString() + i,
                        Status = "Available", // Başlangıçta hepsi müsait
                        Type = "Standard",
                        ExtraPrice = 0
                    });
                }
                // Orta koridor boşluğunu ekle
                standardRow.Seats.Insert(10, null);
                standardRow.Seats.Insert(11, null);

                // Null olmayan koltukları ana listeye ekle
                allSeats.AddRange(standardRow.Seats.Where(s => s != null));
                seatingPlan.Add(standardRow);
            }

            // 3. Rastgele Koltukları Satılmış Olarak İşaretle (Sold)
            // Tüm müsait koltuklar arasından rastgele soldCount kadarını seç
            var seatsToSell = allSeats.OrderBy(s => random.Next()).Take(soldCount).ToList();

            foreach (var seat in seatsToSell)
            {
                seat.Status = "Sold";
            }

            return seatingPlan;
        }

        // Mevcut Action: Film Detayından Gelinen Seans Seçim Sayfası
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

        // YENİ ACTION: Koltuk Seçim Sayfası
        // Showtimes.cshtml sayfasından gelen 'showingId' parametresini bekler.
        public ActionResult SelectSeats(int showingId)
        {
            var showing = _db.Showings
                .Include(s => s.Movies)
                .Include(s => s.Halls)
                .Include(s => s.Halls.Cinemas)
                .FirstOrDefault(s => s.ShowingID == showingId);

            if (showing == null)
            {
                return HttpNotFound();
            }

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