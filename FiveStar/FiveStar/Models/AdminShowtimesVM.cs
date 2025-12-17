using System;
using System.Collections.Generic;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Models.ViewModels
{
    // Admin/Showtimes sayfası için filtre + liste VM'i
    public class AdminShowtimesVM
    {
        // Filtre değerleri
        public int? SelectedMovieId { get; set; }
        public string SelectedHallType { get; set; }
        public DateTime? SelectedDate { get; set; }
        public string SelectedTime { get; set; } // "HH:mm"

        // Dropdown kaynakları
        public SelectList Movies { get; set; }
        public SelectList HallTypes { get; set; }

        // Sonuç listesi
        public IEnumerable<Showings> Showings { get; set; } = new List<Showings>();
    }
}
