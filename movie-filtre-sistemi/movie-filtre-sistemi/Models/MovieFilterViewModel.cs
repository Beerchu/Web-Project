using System.Collections.Generic;

namespace movie_filtre_sistemi.Models
{
    public class MovieFilterViewModel
    {
        public int? SelectedGenreId { get; set; }
        public int? SelectedCinemaId { get; set; }

        // YENİ: arama kutusu
        public string SearchTerm { get; set; }

        public List<Genres> Genres { get; set; }
        public List<Cinemas> Cinemas { get; set; }
        public List<Movies> Movies { get; set; }
    }
}
