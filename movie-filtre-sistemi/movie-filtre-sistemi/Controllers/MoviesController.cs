using System.Linq;
using System.Web.Mvc;
using movie_filtre_sistemi.Models;

namespace movie_filtre_sistemi.Controllers
{
    public class MoviesController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        public ActionResult Index(int? genreId, int? cinemaId)
        {
            var moviesQuery = _db.Movies.AsQueryable();

            // 1) Tür filtresi
            if (genreId.HasValue)
            {
                moviesQuery = moviesQuery
                    .Where(m => _db.Genres_Movies
                        .Any(gm => gm.MovieID == m.MovieID &&
                                   gm.GenreID == genreId.Value));
            }

            // 2) Sinema filtresi
            if (cinemaId.HasValue)
            {
                moviesQuery = moviesQuery
                    .Where(m => m.Showings
                        .Any(s => s.Halls.CinemaID == cinemaId.Value));
            }

            var genres = _db.Genres
                            .OrderBy(g => g.Name)
                            .ToList();

            // sadece İstanbul istersen buraya City filtresi koyarsın:
            // var cinemas = _db.Cinemas.Where(c => c.City == "Istanbul")
            var cinemas = _db.Cinemas
                             .OrderBy(c => c.CinemaName)
                             .ToList();

            var vm = new MovieFilterViewModel
            {
                SelectedGenreId = genreId,
                SelectedCinemaId = cinemaId,
                Genres = genres,
                Cinemas = cinemas,
                Movies = moviesQuery.ToList()
            };

            return View(vm);
        }
    }
}
