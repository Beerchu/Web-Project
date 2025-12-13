using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    public class MoviesController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // GET: Movies
        public ActionResult Index(string searchTerm = "", int? selectedGenreId = null, int? selectedCinemaId = null)
        {
            var viewModel = BuildFilterViewModel(searchTerm, selectedGenreId, selectedCinemaId);
            return View(viewModel);
        }

        // AJAX: only returns the grid
        [HttpGet]
        public PartialViewResult Filter(string searchTerm = "", int? selectedGenreId = null, int? selectedCinemaId = null)
        {
            var vm = BuildFilterViewModel(searchTerm, selectedGenreId, selectedCinemaId);
            return PartialView("_MoviesGrid", vm.Movies);
        }

        private MovieFilterViewModel BuildFilterViewModel(string searchTerm, int? selectedGenreId, int? selectedCinemaId)
        {
            var query = _db.Movies.AsQueryable();

            if (!string.IsNullOrEmpty(searchTerm))
            {
                query = query.Where(m => m.Title.Contains(searchTerm) ||
                                         (m.Description != null && m.Description.Contains(searchTerm)));
            }

            if (selectedGenreId.HasValue)
            {
                // FIX: Value kullan
                query = query.Where(m => m.Genres_Movies.Any(gm => gm.GenreID == selectedGenreId.Value));
            }

            if (selectedCinemaId.HasValue)
            {
                // FIX: Value kullan
                query = query.Where(m => m.Showings.Any(s => s.Halls.CinemaID == selectedCinemaId.Value));
            }

            var movies = query.OrderByDescending(m => m.ReleaseDate).ToList();

            var genres = _db.Genres.OrderBy(g => g.Name).ToList();
            var cinemas = _db.Cinemas.OrderBy(c => c.CinemaName).ToList();

            return new MovieFilterViewModel
            {
                Movies = movies,
                SearchTerm = searchTerm,
                SelectedGenreId = selectedGenreId,
                SelectedCinemaId = selectedCinemaId,
                Genres = genres,
                Cinemas = cinemas
            };
        }

        // GET: Movies/Details/5
        public ActionResult Details(int id)
        {
            var movie = _db.Movies.Find(id);
            if (movie == null) return HttpNotFound();
            return View(movie);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) _db.Dispose();
            base.Dispose(disposing);
        }
    }
}
