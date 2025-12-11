using System;

namespace FiveStars.Models
{
    // Sadece AccountController için kullanılan basit "fake" kullanıcı modeli
    public class User
    {
        public int Id { get; set; }          // AccountController'da kullanılan Id
        public string FullName { get; set; } // AccountController'da kullanılan FullName
        public string Email { get; set; }    // AccountController'da kullanılan Email
        public string Password { get; set; } // AccountController'da kullanılan Password
    }
}
