using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    public class TicketsController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // GET: /Tickets/Showtimes?movieId=1
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
                    ShowTime = s.ShowTime,                      // ShowTime VAR
                    CinemaName = s.Halls.Cinemas.CinemaName,
                    HallName = s.Halls.HallType,                // <== HallName değil HallType
                    TicketPrice = s.TicketPrice                 // decimal, ?? 0 YOK
                }).ToList()
            };

            return View(vm);
        }

        // Koltuk seçimi – şimdilik iskelet
        public ActionResult SelectSeat(int showingId)
        {
            return Content("Seat selection page – TODO (showingId = " + showingId + ")");
        }
    }
}
