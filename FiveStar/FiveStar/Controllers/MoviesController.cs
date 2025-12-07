using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FiveStars.Models;   // BU ÖNEMLİ

namespace FiveStars.Controllers
{
    public class MoviesController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        public ActionResult Index(int? genreId, int? cinemaId, string searchTerm)
        {
            var moviesQuery = _db.Movies.AsQueryable();

            // Tür filtresi
            if (genreId.HasValue)
            {
                int gId = genreId.Value;

                moviesQuery = moviesQuery
                    .Where(m => _db.Genres_Movies
                        .Any(gm => gm.MovieID == m.MovieID && gm.GenreID == gId));
            }


            // Sinema filtresi
            if (cinemaId.HasValue)
            {
                moviesQuery = moviesQuery
                    .Where(m => m.Showings.Any(s => s.Halls.Cinemas.CinemaID == cinemaId.Value));
            }

            // ARAMA: başlıkta geçen filmler
            if (!string.IsNullOrWhiteSpace(searchTerm))
            {
                var lower = searchTerm.ToLower();
                moviesQuery = moviesQuery
                    .Where(m => m.Title.ToLower().Contains(lower));
            }

            var genres = _db.Genres
                .OrderBy(g => g.Name)
                .ToList();

            var cinemas = _db.Cinemas
                // sadece İstanbul istiyorsan aç:
                // .Where(c => c.City == "İstanbul")
                .OrderBy(c => c.CinemaName)
                .ToList();

            var vm = new MovieFilterViewModel
            {
                SelectedGenreId = genreId,
                SelectedCinemaId = cinemaId,
                SearchTerm = searchTerm,
                Genres = genres,
                Cinemas = cinemas,
                Movies = moviesQuery.ToList()
            };

            return View(vm);
        }


        public ActionResult Details(int id)
        {
            var movie = _db.Movies.Find(id);

            if (movie == null)
            {
                return HttpNotFound();
            }

            return View(movie);
        }




    }
}
