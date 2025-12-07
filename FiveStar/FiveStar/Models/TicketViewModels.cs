using System;
using System.Collections.Generic;

namespace FiveStars.Models
{
    public class ShowingListItemViewModel
    {
        public int ShowingID { get; set; }

        public string CinemaName { get; set; }

        // Bizde Halls tablosunda "HallType" var, onu salon adı gibi kullanacağız
        public string HallType { get; set; }

        public DateTime ShowTime { get; set; }

        public decimal TicketPrice { get; set; }
    }

    public class TicketStartViewModel
    {
        public Movies Movie { get; set; }

        public List<ShowingListItemViewModel> Showings { get; set; }
    }
}
