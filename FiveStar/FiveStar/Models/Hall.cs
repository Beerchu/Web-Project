using System.ComponentModel.DataAnnotations;

namespace FiveStars.Models
{
    public class Hall
    {
        [Key]
        public int HallID { get; set; }

        public string HallType { get; set; }
        public int? Capacity { get; set; }
        public int? CinemaID { get; set; }

        // Navigation property
        public virtual Cinema Cinemas { get; set; }  // Singular or plural? Check your EF model
    }
}