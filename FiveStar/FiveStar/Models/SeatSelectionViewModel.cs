// Models/SeatSelectionViewModel.cs
using System.Collections.Generic;

namespace FiveStars.Models
{
    // Koltuk Seçim Sayfasının ana ViewModel'i
    public class SeatSelectionViewModel
    {
        public int SessionTimeID { get; set; }
        public string MovieTitle { get; set; }
        public string CinemaName { get; set; }
        public System.DateTime StartTime { get; set; }
        public string ScreenType { get; set; }
        public decimal TicketPrice { get; set; }

        // Koltuk düzenini tutan yapı
        public IEnumerable<SeatRow> SeatingPlan { get; set; }
    }

    // Bir sıradaki koltukları temsil eder
    public class SeatRow
    {
        public string RowName { get; set; } // Örn: 'A', 'B', 'PRIME'
        public List<Seat> Seats { get; set; }
    }

    // Tek bir koltuğu temsil eder
    public class Seat
    {
        public int SeatID { get; set; }
        public string SeatNumber { get; set; } // Örn: 'A5', '12'
        public string Status { get; set; }      // "Available", "Selected", "Sold", "Recliner"
        public string Type { get; set; }        // "Standard", "VIP", "Recliner"
        public decimal ExtraPrice { get; set; } // Standart dışı koltuklar için ek ücret
    }
}