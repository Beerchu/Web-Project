using System;
using System.ComponentModel.DataAnnotations;
using System.Web;

namespace FiveStars.Models
{
    public class Movie
    {
        public int MovieID { get; set; }

        [Required(ErrorMessage = "Title is required")]
        public string Title { get; set; }

        [Display(Name = "Duration (minutes)")]
        public int? Duration_min { get; set; }

        [Display(Name = "Poster URL")]
        public string PosterUrl { get; set; }

        [Range(0, 10, ErrorMessage = "Rating must be between 0 and 10")]
        public decimal? Ratings { get; set; }

        [Required(ErrorMessage = "Status is required")]
        public string Status { get; set; } = "Coming Soon";

        [Display(Name = "Release Date")]
        [DataType(DataType.Date)]
        public DateTime? ReleaseDate { get; set; }

        [DataType(DataType.MultilineText)]
        public string Description { get; set; }

        // For file upload
        [Display(Name = "Poster Image")]
        public HttpPostedFileBase PosterFile { get; set; }
    }
}