using System.ComponentModel.DataAnnotations;

namespace FiveStars.Models
{
    public class EditProfileViewModel
    {
        [Required]
        public int UserID { get; set; }

        [Required, StringLength(50)]
        public string FirstName { get; set; }

        [Required, StringLength(50)]
        public string LastName { get; set; }

        [Required, EmailAddress, StringLength(100)]
        public string Email { get; set; }

        public string ProfileImagePath { get; set; }
    }
}
