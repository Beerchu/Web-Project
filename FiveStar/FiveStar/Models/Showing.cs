using System;
using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace FiveStars.Models
{
    public class Showing
    {
        public int ShowingID { get; set; }

        [Required(ErrorMessage = "Show time is required")]
        [Display(Name = "Show Time")]
        [DataType(DataType.DateTime)]
        public DateTime ShowTime { get; set; }

        [Required(ErrorMessage = "Ticket price is required")]
        [Display(Name = "Ticket Price")]
        [Range(0, 1000, ErrorMessage = "Price must be between 0 and 1000")]
        [DataType(DataType.Currency)]
        public decimal TicketPrice { get; set; }

        [Required(ErrorMessage = "Movie is required")]
        [Display(Name = "Movie")]
        public int? MovieID { get; set; }

        [Required(ErrorMessage = "Hall is required")]
        [Display(Name = "Hall")]
        public int? HallID { get; set; }

        // For display only
        public string MovieTitle { get; set; }
        public string HallType { get; set; }
        public string CinemaName { get; set; }

        // For dropdown lists
        public SelectList MoviesList { get; set; }
        public SelectList HallsList { get; set; }
    }
}