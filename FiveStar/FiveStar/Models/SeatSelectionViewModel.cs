// Models/SeatSelectionViewModel.cs
using System.Collections.Generic;

namespace FiveStars.Models
{
    public class SeatSelectionViewModel
    {
        public int SessionTimeID { get; set; }
        public string MovieTitle { get; set; }
        public string CinemaName { get; set; }
        public System.DateTime StartTime { get; set; }
        public string ScreenType { get; set; }
        public decimal TicketPrice { get; set; }

        public IEnumerable<SeatRow> SeatingPlan { get; set; }
    }

    public class SeatRow
    {
        public string RowName { get; set; }
        public List<Seat> Seats { get; set; }
    }

    public class Seat
    {
        public int SeatID { get; set; }
        public string SeatNumber { get; set; }
        public string Status { get; set; }      // "Available", "Selected", "Sold"
        public string Type { get; set; }        // "Standard", "VIP", "Recliner"
        public decimal ExtraPrice { get; set; }
    }
}