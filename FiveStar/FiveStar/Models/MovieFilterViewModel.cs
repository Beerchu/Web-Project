using System.Collections.Generic;

namespace FiveStars.Models
{
    public class MovieFilterViewModel
    {
        public int? SelectedGenreId { get; set; }
        public int? SelectedCinemaId { get; set; }

        
        public string SearchTerm { get; set; }

        public List<Genres> Genres { get; set; }
        public List<Cinemas> Cinemas { get; set; }
        public List<Movies> Movies { get; set; }
    }
}
