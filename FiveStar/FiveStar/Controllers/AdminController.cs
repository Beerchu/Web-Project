using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    // LAB 12 – AUTHORIZATION (WORKS WITH FORMS AUTH)
    [Authorize(Roles = "admin")]
    public class AdminController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // =========================
        // DASHBOARD
        // =========================
        public ActionResult Index()
        {
            ViewBag.TotalMovies = _db.Movies.Count();
            ViewBag.ActiveShowings = _db.Showings.Count(s => s.ShowTime > DateTime.Now);
            ViewBag.TotalUsers = _db.Users.Count();
            ViewBag.ActiveCampaigns = _db.Campaigns.Count(c => c.IsActive);

            return View();
        }

        #region Movie Management

        public ActionResult Movies()
        {
            var movies = _db.Movies
                .OrderByDescending(m => m.ReleaseDate)
                .ToList();
            return View(movies);
        }

        public ActionResult CreateMovie()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateMovie(Movies movie)
        {
            if (ModelState.IsValid)
            {
                _db.Movies.Add(movie);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Movie created successfully!";
                return RedirectToAction("Movies");
            }
            return View(movie);
        }

        public ActionResult EditMovie(int id)
        {
            var movie = _db.Movies.Find(id);
            if (movie == null) return HttpNotFound();
            return View(movie);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditMovie(Movies movie)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(movie).State = EntityState.Modified;
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Movie updated successfully!";
                return RedirectToAction("Movies");
            }
            return View(movie);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteMovie(int id)
        {
            var movie = _db.Movies.Find(id);
            if (movie != null)
            {
                _db.Movies.Remove(movie);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Movie deleted successfully!";
            }
            return RedirectToAction("Movies");
        }

        #endregion

        #region Showtimes Management

        public ActionResult Showtimes()
        {
            var showings = _db.Showings
                .Include(s => s.Movies)
                .Include(s => s.Halls)
                .Include(s => s.Halls.Cinemas)
                .OrderByDescending(s => s.ShowTime)
                .ToList();

            return View(showings);
        }

        public ActionResult CreateShowtime()
        {
            ViewBag.MovieID = new SelectList(_db.Movies, "MovieID", "Title");

            var halls = (from h in _db.Halls
                         join c in _db.Cinemas on h.CinemaID equals c.CinemaID
                         select new
                         {
                             h.HallID,
                             DisplayName = c.CinemaName + " - " + h.HallType
                         }).ToList();

            ViewBag.HallID = new SelectList(halls, "HallID", "DisplayName");

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateShowtime(Showings showing)
        {
            if (ModelState.IsValid)
            {
                _db.Showings.Add(showing);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Showtime created successfully!";
                return RedirectToAction("Showtimes");
            }

            ViewBag.MovieID = new SelectList(_db.Movies, "MovieID", "Title", showing.MovieID);

            var halls = (from h in _db.Halls
                         join c in _db.Cinemas on h.CinemaID equals c.CinemaID
                         select new
                         {
                             h.HallID,
                             DisplayName = c.CinemaName + " - " + h.HallType
                         }).ToList();

            ViewBag.HallID = new SelectList(halls, "HallID", "DisplayName", showing.HallID);

            return View(showing);
        }

        public ActionResult EditShowtime(int id)
        {
            var showing = _db.Showings.Find(id);
            if (showing == null) return HttpNotFound();

            ViewBag.MovieID = new SelectList(_db.Movies, "MovieID", "Title", showing.MovieID);

            var halls = (from h in _db.Halls
                         join c in _db.Cinemas on h.CinemaID equals c.CinemaID
                         select new
                         {
                             h.HallID,
                             DisplayName = c.CinemaName + " - " + h.HallType
                         }).ToList();

            ViewBag.HallID = new SelectList(halls, "HallID", "DisplayName", showing.HallID);

            return View(showing);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditShowtime(Showings showing)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(showing).State = EntityState.Modified;
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Showtime updated successfully!";
                return RedirectToAction("Showtimes");
            }

            ViewBag.MovieID = new SelectList(_db.Movies, "MovieID", "Title", showing.MovieID);

            var halls = (from h in _db.Halls
                         join c in _db.Cinemas on h.CinemaID equals c.CinemaID
                         select new
                         {
                             h.HallID,
                             DisplayName = c.CinemaName + " - " + h.HallType
                         }).ToList();

            ViewBag.HallID = new SelectList(halls, "HallID", "DisplayName", showing.HallID);

            return View(showing);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteShowtime(int id)
        {
            var showing = _db.Showings.Find(id);
            if (showing != null)
            {
                _db.Showings.Remove(showing);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Showtime deleted successfully!";
            }
            return RedirectToAction("Showtimes");
        }

        #endregion

        #region Campaign Management

        public ActionResult Campaigns()
        {
            var campaigns = _db.Campaigns
                .OrderByDescending(c => c.CampaignID)
                .ToList();
            return View(campaigns);
        }

        public ActionResult CreateCampaign()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateCampaign(Campaigns campaign)
        {
            if (ModelState.IsValid)
            {
                _db.Campaigns.Add(campaign);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Campaign created successfully!";
                return RedirectToAction("Campaigns");
            }
            return View(campaign);
        }

        public ActionResult EditCampaign(int id)
        {
            var campaign = _db.Campaigns.Find(id);
            if (campaign == null) return HttpNotFound();
            return View(campaign);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditCampaign(Campaigns campaign)
        {
            if (ModelState.IsValid)
            {
                _db.Entry(campaign).State = EntityState.Modified;
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Campaign updated successfully!";
                return RedirectToAction("Campaigns");
            }
            return View(campaign);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteCampaign(int id)
        {
            var campaign = _db.Campaigns.Find(id);
            if (campaign != null)
            {
                _db.Campaigns.Remove(campaign);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "Campaign deleted successfully!";
            }
            return RedirectToAction("Campaigns");
        }

        #endregion

        #region User Management

        public ActionResult Users()
        {
            var users = _db.Users
                .OrderBy(u => u.FirstName)
                .ThenBy(u => u.LastName)
                .ToList();

            return View(users);
        }

        public ActionResult EditUser(int id)
        {
            var user = _db.Users.Find(id);
            if (user == null) return HttpNotFound();
            return View(user);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditUser(Users user, string Password, bool? IsActive)
        {
            if (ModelState.IsValid)
            {
                var existingUser = _db.Users.Find(user.UserID);
                if (existingUser != null)
                {
                    existingUser.FirstName = user.FirstName;
                    existingUser.LastName = user.LastName;
                    existingUser.Email = user.Email;
                    existingUser.Role = user.Role;
                    existingUser.IsActive = IsActive ?? false;

                    if (!string.IsNullOrEmpty(Password))
                    {
                        existingUser.PasswordHash = Password;
                    }

                    _db.SaveChanges();
                    TempData["SuccessMessage"] = "User updated successfully!";
                }
                return RedirectToAction("Users");
            }
            return View(user);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteUser(int id)
        {
            var user = _db.Users.Find(id);

            if (user != null && user.UserID != 1)
            {
                _db.Users.Remove(user);
                _db.SaveChanges();
                TempData["SuccessMessage"] = "User deleted successfully!";
            }
            else if (user != null && user.UserID == 1)
            {
                TempData["ErrorMessage"] = "Cannot delete the main administrator!";
            }

            return RedirectToAction("Users");
        }

        #endregion

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
