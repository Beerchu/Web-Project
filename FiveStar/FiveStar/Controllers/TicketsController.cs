using System;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    public class TicketsController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // GET: /Tickets/Start?movieId=5
        public ActionResult Start(int movieId)
        {
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
                    CinemaName = s.Halls.Cinemas.CinemaName,
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
    }
}
