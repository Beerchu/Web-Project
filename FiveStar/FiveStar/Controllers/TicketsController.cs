using System;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    public class TicketsController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // 1. ADIM: Belirli bir film için seans seçme sayfası
        public ActionResult Showtimes(int movieId)
        {
            var movie = _db.Movies.Find(movieId);
            if (movie == null)
                return HttpNotFound();

            // İlgili filmin tüm seansları
            var showings = _db.Showings
                .Where(s => s.MovieID == movieId)
                .OrderBy(s => s.ShowTime)
                .ToList();


            // TODO: kendi kolon isimlerine göre düzenle
            var vm = new ShowtimeSelectionViewModel
            {
                MovieId = movie.MovieID,
                MovieTitle = movie.Title,
                PosterUrl = movie.PosterUrl,      // View'de path'e çevireceğiz
                Status = movie.Status,
                Showtimes = showings.Select(s => new ShowtimeItem
                {
                    ShowingId = s.ShowingID,
                    ShowTime = s.ShowTime,                       // *** ShowDate YOK, ShowTime var ***
                    CinemaName = s.Halls.Cinemas.CinemaName,
                    HallName = s.Halls.HallName,
                    TicketPrice = s.TicketPrice ?? 0
                }).ToList()
            };


            return View(vm);
        }

        // 2. ADIM: Seans seçildikten sonra koltuk sayfasına geçeceğiz (şimdilik stub)
        public ActionResult SelectSeats(int showingId)
        {
            // Şimdilik sadece ID’yi kontrol edip boş bir sayfa dön
            var showing = _db.Showings.Find(showingId);
            if (showing == null)
                return HttpNotFound();

            // Sonra burada seat-selection ekranını yapacağız
            return Content("Seats page – showingId = " + showingId);
        }


        public ActionResult SelectCinema(int movieId)
        {
            var movie = _db.Movies.Find(movieId);
            if (movie == null) return HttpNotFound();

            // şimdilik sade kalsın, sonra seans/cinema ekleriz
            return View(movie);
        }


    }
}
