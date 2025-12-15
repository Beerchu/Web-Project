using System;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;
using System.Collections.Generic;

namespace FiveStars.Controllers
{
    public class HomeController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        public ActionResult Index()
        {
            var today = DateTime.Today;

            // NOW SHOWING + TÜM seanslar
            var nowShowingMovies = _db.Movies
                .Include(m => m.Showings)
                .Where(m => m.Status != null && m.Status.Trim().ToLower() == "now showing")
                .ToList();

            var nowShowing = nowShowingMovies
                .Select(m => new NowShowingMovieVM
                {
                    Movie = m,
                    Showings = m.Showings
                        .Where(s => s.ShowTime >= today)
                        .OrderBy(s => s.ShowTime)
                        .ToList()
                })
                .ToList();

            // CAMPAIGNS
            var campaigns = _db.Campaigns
                .Where(c => c.IsActive)
                .OrderByDescending(c => c.CampaignID)
                .ToList();

            // COMING SOON
            var comingSoon = _db.Movies
                .Where(m => m.Status != null && m.Status.Trim().ToLower() == "coming soon")
                .OrderBy(m => m.ReleaseDate)
                .ToList();

        


            // TOP 10 (Top10Movies tablosundan en güncel WeekOf)
            var latestWeek = _db.Top10Movies
                .Select(t => (DateTime?)t.WeekOf)
                .OrderByDescending(d => d)
                .FirstOrDefault();

            var top10 = (latestWeek == null)
                ? Enumerable.Empty<Top10MovieVM>().ToList()
                : _db.Top10Movies
                    .Where(t => t.WeekOf == latestWeek.Value)
                    .OrderBy(t => t.RankOrder)
                    .Select(t => new Top10MovieVM
                    {
                        Movie = t.Movies,
                        RankOrder = t.RankOrder,
                        WeekOf = t.WeekOf
                    })
                    .ToList();

          

            // LAST WEEK’S MOVIES: “Now Showing” olmayan, yakın zamanda vizyondan düşenler gibi düşün.
            // Elinizde status “Archived” varsa onu çekiyoruz. Yoksa “Coming Soon değil ve Now Showing değil” fallback.
            var lastWeek = _db.Movies
                .Where(m => m.Status != null &&
                            (m.Status.Trim().ToLower() == "archived"
                             || (m.Status.Trim().ToLower() != "now showing" && m.Status.Trim().ToLower() != "coming soon")))
                .OrderByDescending(m => m.ReleaseDate)
                .Take(10)
                .ToList();

            var vm = new HomeIndexViewModel
            {
                NowShowing = nowShowing,
                Campaigns = campaigns,
                ComingSoon = comingSoon,
                Top10 = top10,
                LastWeek = lastWeek
            };


            return View(vm);
        }

        public ActionResult Campaigns()
        {
            return RedirectToAction("Index", "Campaigns");
        }

        public ActionResult About() => View();
        public ActionResult Contact() => View();

        protected override void Dispose(bool disposing)
        {
            if (disposing) _db.Dispose();
            base.Dispose(disposing);
        }
    }
}
