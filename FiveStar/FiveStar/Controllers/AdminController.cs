using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.Mvc;
using FiveStars.Models;
using FiveStars.Models.ViewModels;
using System.Data.Entity.Infrastructure;


namespace FiveStars.Controllers
{
    [Authorize(Roles = "admin")]
    public class AdminController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        
        // Helpers

        private void PopulateGenres(int[] selectedGenreIds = null)
        {
            var genres = _db.Genres
                .OrderBy(g => g.Name)
                .ToList();

            ViewBag.Genres = genres;
            ViewBag.SelectedGenreIds = selectedGenreIds ?? new int[0];
        }

        // Ratings: accept comma decimals (e.g., 8,5), reject dot decimals (8.5),
        // and enforce range 0..10 with English messages.
        private void NormalizeAndValidateRating(Movies movie)
        {
            // NOTE: Browser "number" inputs don't accept comma, so the view must use type="text".
            // This method guarantees server-side correctness even if client-side is bypassed.

            var rawObj = Request?.Form?["Ratings"] ?? Request?.Form?["movie.Ratings"];
            if (rawObj == null) return; // field not posted

            string raw = (rawObj ?? string.Empty).Trim();

            // Clear any binder-produced error first; we'll add our own English errors.
            ModelState.Remove("Ratings");
            ModelState.Remove("movie.Ratings");

            if (string.IsNullOrWhiteSpace(raw))
            {
                movie.Ratings = null;
                return; // rating is optional
            }

            // Enforce comma as decimal separator (user requested "virgüllü")
            if (raw.Contains("."))
            {
                ModelState.AddModelError("Ratings",
                    "Use a comma (,) as the decimal separator. Example: 8,5");
                return;
            }

            // Basic format guard: 0..10, optionally with 1-2 decimal digits using comma
            // Examples: 8,5  |  8  |  10  |  10,0
            if (!Regex.IsMatch(raw, @"^\d{1,2}(,\d)?$"))
            {
                ModelState.AddModelError("Ratings",
                    "Invalid rating format. Use e.g. 8 or 8,5 (max 1 decimal).");
                return;
            }

            var tr = CultureInfo.GetCultureInfo("tr-TR");
            if (!decimal.TryParse(raw, NumberStyles.Number, tr, out decimal rating))
            {
                ModelState.AddModelError("Ratings",
                    "Invalid rating value. Use e.g. 8 or 8,5.");
                return;
            }

            if (rating < 0m || rating > 10m)
            {
                ModelState.AddModelError("Ratings",
                    "Rating must be between 0 and 10.");
                return;
            }

            movie.Ratings = rating;
        }




        private void ValidateMovieTitle(Movies movie)
        {
            if (movie == null) return;

            if (string.IsNullOrWhiteSpace(movie.Title))
            {
                ModelState.AddModelError("Title", "Movie title is required.");
            }
        }

        // DASHBOARD
        
        public ActionResult Index()
        {
            ViewBag.TotalMovies = _db.Movies.Count();
            ViewBag.ActiveShowings = _db.Showings.Count(s => s.ShowTime > DateTime.Now);
            ViewBag.TotalUsers = _db.Users.Count();
            ViewBag.ActiveCampaigns = _db.Campaigns.Count(c => c.IsActive);
            ViewBag.TotalCinemas = _db.Cinemas.Count();

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
            PopulateGenres();
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateMovie(Movies movie, int[] selectedGenreIds)
        {
            NormalizeAndValidateRating(movie);
            ValidateMovieTitle(movie);

            if (ModelState.IsValid)
            {
                // Defensive default (DB typically expects a value)
                if (string.IsNullOrWhiteSpace(movie.Status))
                    movie.Status = "Coming Soon";

                _db.Movies.Add(movie);
                _db.SaveChanges();

                // Save Movie -> Genre links (many-to-many)
                if (selectedGenreIds != null && selectedGenreIds.Length > 0)
                {
                    foreach (var genreId in selectedGenreIds.Distinct())
                    {
                        _db.Genres_Movies.Add(new Genres_Movies
                        {
                            MovieID = movie.MovieID,
                            GenreID = genreId
                        });
                    }
                    _db.SaveChanges();
                }

                TempData["SuccessMessage"] = "Movie created successfully!";
                return RedirectToAction("Movies");
            }

            // ModelState invalid -> re-fill genres so the view can render
            PopulateGenres(selectedGenreIds);
            return View(movie);
        }

        public ActionResult EditMovie(int id)
        {
            var movie = _db.Movies
                .Include(m => m.Genres_Movies)
                .FirstOrDefault(m => m.MovieID == id);

            if (movie == null) return HttpNotFound();

            var selectedGenreIds = movie.Genres_Movies
                .Where(gm => gm.GenreID.HasValue)
                .Select(gm => gm.GenreID.Value)
                .ToArray();

            PopulateGenres(selectedGenreIds);
            return View(movie);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditMovie(Movies movie, int[] selectedGenreIds)
        {
            NormalizeAndValidateRating(movie);
            ValidateMovieTitle(movie);

            if (ModelState.IsValid)
            {
                // Always update using tracked entity (avoids detached update + keeps relations under control)
                var dbMovie = _db.Movies
                    .Include(m => m.Genres_Movies)
                    .FirstOrDefault(m => m.MovieID == movie.MovieID);

                if (dbMovie == null) return HttpNotFound();

                // Update scalar fields
                dbMovie.Title = movie.Title;
                dbMovie.Description = movie.Description;
                dbMovie.Duration_min = movie.Duration_min;
                dbMovie.PosterUrl = movie.PosterUrl;
                dbMovie.Ratings = movie.Ratings;
                dbMovie.Status = string.IsNullOrWhiteSpace(movie.Status) ? "Coming Soon" : movie.Status;
                dbMovie.ReleaseDate = movie.ReleaseDate;

                // Update Movie -> Genre links
                var newIds = (selectedGenreIds ?? new int[0]).Distinct().ToList();
                var existingLinks = dbMovie.Genres_Movies.ToList();

                // Remove links not selected anymore
                foreach (var link in existingLinks)
                {
                    if (link.GenreID.HasValue && !newIds.Contains(link.GenreID.Value))
                    {
                        _db.Genres_Movies.Remove(link);
                    }
                }

                // Add missing links
                var existingIds = existingLinks
                    .Where(l => l.GenreID.HasValue)
                    .Select(l => l.GenreID.Value)
                    .ToHashSet();

                foreach (var gid in newIds)
                {
                    if (!existingIds.Contains(gid))
                    {
                        _db.Genres_Movies.Add(new Genres_Movies
                        {
                            MovieID = dbMovie.MovieID,
                            GenreID = gid
                        });
                    }
                }

                _db.SaveChanges();
                TempData["SuccessMessage"] = "Movie updated successfully!";
                return RedirectToAction("Movies");
            }

            PopulateGenres(selectedGenreIds);
            return View(movie);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteMovie(int id)
        {
            var movie = _db.Movies.Find(id);
            if (movie != null)
            {
                try
                {
                    // If the movie has genres, remove the junction rows first (avoids FK errors)
                    var links = _db.Genres_Movies.Where(gm => gm.MovieID == id).ToList();
                    if (links.Any())
                    {
                        _db.Genres_Movies.RemoveRange(links);
                    }

                    _db.Movies.Remove(movie);
                    _db.SaveChanges();
                    TempData["SuccessMessage"] = "Movie deleted successfully!";
                }
                catch
                {
                    // Most likely: this movie has related showtimes/reservations/tickets etc.
                    TempData["ErrorMessage"] = "Cannot delete this movie because it has related records (showtimes / tickets / reservations). Delete those first.";
                }
            }
            return RedirectToAction("Movies");
        }

        #endregion


        #region Cinema Management

        public ActionResult Cinemas()
        {
            var cinemas = _db.Cinemas
                .Include(c => c.Halls)
                .OrderBy(c => c.CinemaName)
                .ToList();
                


            return View(cinemas);
        }

        public ActionResult CreateCinema()
        {
            var vm = new CinemaWithHallsVM();

            // boş gelmesin diye 1 satır default
            vm.Halls.Add(new HallRowVM { HallType = "Standard", Capacity = 120 });

            return View(vm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateCinema(CinemaWithHallsVM vm)
        {
            // Halls null gelirse patlamasın
            vm.Halls = vm.Halls ?? new List<HallRowVM>();

            if (ModelState.IsValid)
            {
                // 1) Cinema ekle
                var cinema = new Cinemas
                {
                    CinemaName = vm.CinemaName,
                    Address = vm.Address,
                    City = vm.City,
                    District = vm.District,
                    PhoneNumber = vm.PhoneNumber
                };

                _db.Cinemas.Add(cinema);
                _db.SaveChanges(); // CinemaID oluşsun

                // 2) Halls ekle
                foreach (var h in vm.Halls.Where(x => !x.IsDeleted))
                {
                    _db.Halls.Add(new Halls
                    {
                        CinemaID = cinema.CinemaID,
                        HallType = h.HallType,
                        Capacity = h.Capacity
                    });
                }

                _db.SaveChanges();

                TempData["SuccessMessage"] = "Cinema + halls created successfully!";
                return RedirectToAction("Cinemas");
            }

            // invalid -> yine satır göster
            if (vm.Halls.Count == 0) vm.Halls.Add(new HallRowVM { HallType = "Standard", Capacity = 120 });
            return View(vm);
        }

        public ActionResult EditCinema(int id)
        {
            var cinema = _db.Cinemas
                .Include(c => c.Halls)
                .FirstOrDefault(c => c.CinemaID == id);

            if (cinema == null) return HttpNotFound();

            var vm = new CinemaWithHallsVM
            {
                CinemaID = cinema.CinemaID,
                CinemaName = cinema.CinemaName,
                Address = cinema.Address,
                City = cinema.City,
                District = cinema.District,
                PhoneNumber = cinema.PhoneNumber,
                Halls = cinema.Halls
                    .Select(h => new HallRowVM
                    {
                        HallID = h.HallID,
                        HallType = h.HallType,
                        Capacity = h.Capacity ?? 0,
                        IsDeleted = false
                    })
                    .ToList()
            };

            if (vm.Halls.Count == 0)
                vm.Halls.Add(new HallRowVM { HallType = "Standard", Capacity = 120 });

            return View(vm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditCinema(CinemaWithHallsVM vm)
        {
            vm.Halls = vm.Halls ?? new List<HallRowVM>();

            if (!ModelState.IsValid)
                return View(vm);

            var cinema = _db.Cinemas
                .Include(c => c.Halls)
                .FirstOrDefault(c => c.CinemaID == vm.CinemaID);

            if (cinema == null) return HttpNotFound();

            // 1) Cinema alanları güncelle
            cinema.CinemaName = vm.CinemaName;
            cinema.Address = vm.Address;
            cinema.City = vm.City;
            cinema.District = vm.District;
            cinema.PhoneNumber = vm.PhoneNumber;

            // 2) Halls güncelle/ekle/sil
            var existing = cinema.Halls.ToDictionary(h => h.HallID);

            foreach (var row in vm.Halls)
            {
                // yeni hall
                if (row.HallID == 0)
                {
                    if (row.IsDeleted) continue;

                    _db.Halls.Add(new Halls
                    {
                        CinemaID = cinema.CinemaID,
                        HallType = row.HallType,
                        Capacity = row.Capacity
                    });
                    continue;
                }

                // eski hall
                if (!existing.TryGetValue(row.HallID, out var hall))
                    continue;

                if (row.IsDeleted)
                {
                    // Bu hall showtime'a bağlıysa silme (FK patlatır)
                    bool hasShowtime = _db.Showings.Any(s => s.HallID == hall.HallID);
                    if (hasShowtime)
                    {
                        ModelState.AddModelError("", "Cannot remove a hall that has showtimes. Edit it instead.");
                        return View(vm);
                    }

                    _db.Halls.Remove(hall);
                    continue;
                }

                // update
                hall.HallType = row.HallType;
                hall.Capacity = row.Capacity;
            }

            _db.SaveChanges();

            TempData["SuccessMessage"] = "Cinema + halls updated successfully!";
            return RedirectToAction("Cinemas");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteCinema(int id)
        {
            var cinema = _db.Cinemas.Find(id);

            if (cinema != null)
            {
                try
                {
                    _db.Cinemas.Remove(cinema);
                    _db.SaveChanges();

                    TempData["SuccessMessage"] = "Cinema deleted successfully!";
                }
                catch
                {
                    TempData["ErrorMessage"] =
                        "Cannot delete this cinema because it has related records (halls / showtimes). Delete those first.";
                }
            }

            return RedirectToAction("Cinemas");
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
