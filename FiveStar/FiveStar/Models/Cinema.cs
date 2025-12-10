using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace FiveStars.Models
{
    public class Cinema
    {
        [Key]
        public int CinemaID { get; set; }

        public string CinemaName { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string District { get; set; }
        public string PhoneNumber { get; set; }  // NOT ContactNumber

        // Navigation property
        public virtual ICollection<Hall> Halls { get; set; }
    }
}