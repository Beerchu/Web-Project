using System;
using System.Collections.Generic;

namespace FiveStars.Models
{
    public class ShowtimeSelectionViewModel
    {
        public int MovieId { get; set; }
        public string MovieTitle { get; set; }
        public string PosterUrl { get; set; }   // images/now1.jpg gibi
        public string Status { get; set; }      // "Now Showing" / "Coming Soon" / "Archived"

        public List<ShowtimeItem> Showtimes { get; set; } = new List<ShowtimeItem>();
    }

    public class ShowtimeItem
    {
        public int ShowingId { get; set; }
        public DateTime ShowTime { get; set; }  // Showings.ShowTime
        public string CinemaName { get; set; }
        public string HallName { get; set; }
        public decimal TicketPrice { get; set; }
    }
}
