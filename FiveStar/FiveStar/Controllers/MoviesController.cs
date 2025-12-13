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
            // Start with all movies
            var query = _db.Movies.AsQueryable();

            // Apply search filter
            if (!string.IsNullOrEmpty(searchTerm))
            {
                query = query.Where(m => m.Title.Contains(searchTerm) ||
                                         (m.Description != null && m.Description.Contains(searchTerm)));
            }

            // Apply genre filter (if you have Genre-Movie relationship)
            if (selectedGenreId.HasValue)
            {
                // Assuming you have a Genres_Movies table
                query = query.Where(m => m.Genres_Movies.Any(gm => gm.GenreID == selectedGenreId.Value));


            }

            // Apply cinema filter (if you have Showings)
            if (selectedCinemaId.HasValue)
            {
                query = query.Where(m => m.Showings.Any(s => s.Halls.CinemaID == selectedCinemaId.Value));
z            }

            // Order and get results
            var movies = query.OrderByDescending(m => m.ReleaseDate).ToList();

            // Get genres for dropdown - CORRECT TYPE: List<Genres>
            var genres = _db.Genres.OrderBy(g => g.Name).ToList();

            // Get cinemas for dropdown - CORRECT TYPE: List<Cinemas>
            var cinemas = _db.Cinemas.OrderBy(c => c.CinemaName).ToList();

            // Create the view model - MATCHING YOUR ACTUAL CLASS
            var viewModel = new MovieFilterViewModel
            {
                Movies = movies,
                SearchTerm = searchTerm,
                SelectedGenreId = selectedGenreId,
                SelectedCinemaId = selectedCinemaId,
                Genres = genres,    // List<Genres>
                Cinemas = cinemas   // List<Cinemas>

                // NOTE: Your class doesn't have SelectedStatus or StatusList properties
                // So we removed those from here
            };

            return View(viewModel);
        }
        //

        [HttpGet]
        public PartialViewResult Filter(string searchTerm = "", int? selectedGenreId = null, int? selectedCinemaId = null)
        {
            var query = _db.Movies.AsQueryable();

            if (!string.IsNullOrEmpty(searchTerm))
            {
                query = query.Where(m => m.Title.Contains(searchTerm) ||
                                         (m.Description != null && m.Description.Contains(searchTerm)));
            }

            if (selectedGenreId.HasValue)
            {
                query = query.Where(m => m.Genres_Movies.Any(gm => gm.GenreID == selectedGenreId.Value));
            }

            if (selectedCinemaId.HasValue)
            {
                query = query.Where(m => m.Showings.Any(s => s.Halls.CinemaID == selectedCinemaId.Value));
            }

            var movies = query.OrderByDescending(m => m.ReleaseDate).ToList();
            return PartialView("_MoviesGrid", movies);
        }


        // GET: Movies/Details/5
        public ActionResult Details(int id)
        {
            var movie = _db.Movies.Find(id);
            if (movie == null)
            {
                return HttpNotFound();
            }

            return View(movie);
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