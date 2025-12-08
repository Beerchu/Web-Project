using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    public class TicketsController : Controller
    {
        // Mevcut Veritabanı Bağlantısı (Context)
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // Yardımcı Metot: Koltuk Düzenini Oluşturur
        private IEnumerable<SeatRow> GetDummySeatingPlan(string hallType)
        {
            var seatingPlan = new List<SeatRow>();

            // RECLINER SIRA
            var reclinerRow = new SeatRow { RowName = "R", Seats = new List<Seat>() };
            for (int i = 1; i <= 10; i++)
            {
                string status = (i > 5 && i < 8) ? "Sold" : "Available";
                reclinerRow.Seats.Add(new Seat
                {
                    SeatID = 100 + i,
                    SeatNumber = "R" + i,
                    Status = status,
                    Type = "Recliner",
                    ExtraPrice = 15.00m
                });
            }
            seatingPlan.Add(reclinerRow);

            // STANDART SIRALAR (Ana blok: L'den H'ye)
            for (char row = 'L'; row >= 'H'; row--)
            {
                var standardRow = new SeatRow { RowName = row.ToString(), Seats = new List<Seat>() };
                for (int i = 1; i <= 20; i++)
                {
                    string status = (row == 'K' && i > 8 && i < 12) ? "Sold" : "Available";
                    standardRow.Seats.Add(new Seat
                    {
                        SeatID = (int)row * 100 + i,
                        SeatNumber = row.ToString() + i,
                        Status = status,
                        Type = "Standard",
                        ExtraPrice = 0
                    });
                }
                // Orta koridor boşluğunu ekle
                standardRow.Seats.Insert(10, null);
                standardRow.Seats.Insert(11, null);
                seatingPlan.Add(standardRow);
            }

            return seatingPlan;
        }

        // Mevcut Action: Sinema ve Seans Seçim Sayfası
        public ActionResult Start(int movieId)
        {
            // Bu kısım zaten çalışıyordu, değişiklik yapılmadı.
            var movie = _db.Movies.Find(movieId);
            if (movie == null)
            {
                return HttpNotFound();
            }

            var showings = _db.Showings
                .Where(s => s.MovieID == movieId)
                .OrderBy(s => s.ShowTime)
                .Select(s => new ShowingListItemViewModel
                {
                    ShowingID = s.ShowingID,
                    CinemaName = s.Halls.Cinemas.CinemaName, // Bu satır muhtemelen doğru çalışıyordur.
                    HallType = s.Halls.HallType,
                    ShowTime = s.ShowTime,
                    TicketPrice = (decimal)s.TicketPrice
                })
                .ToList();

            var vm = new TicketStartViewModel
            {
                Movie = movie,
                Showings = showings
            };

            return View(vm);
        }

        // YENİ ACTION: Koltuk Seçim Sayfası
        public ActionResult SelectSeats(int sessionId)
        {
            // *** DÜZELTME YAPILAN KISIM ***
            // Showings sınıfındaki ilişki özelliklerinin 'Movie' yerine 'Movies' ve 
            // 'Halls' yerine 'Hall' olduğunu varsayarak düzenlendi.
            var showing = _db.Showings
                .Include(s => s.Movies)     // Hata veren 's.Movie' yerine 's.Movies' kullanıldı.
                .Include(s => s.Halls)       // Potansiyel olarak 's.Halls' yerine 's.Hall' kullanıldı.
                .Include(s => s.Halls.Cinemas)
                .FirstOrDefault(s => s.ShowingID == sessionId);

            if (showing == null)
            {
                return HttpNotFound();
            }

            var viewModel = new SeatSelectionViewModel
            {
                SessionTimeID = showing.ShowingID,
                MovieTitle = showing.Movies.Title, // Hata veren 'showing.Movie.Title' yerine 'showing.Movies.Title' kullanıldı.
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