using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;   // ❤️ REQUIRED! Your controller could not see User without this

namespace FiveStars.Controllers
{
    public class AccountController : Controller
    {
        // Fake users
        List<User> users = new List<User>()
        {
            new User { Id = 1, Email = "test@gmail.com", Password = "1234", FullName = "Test User" },
            new User { Id = 2, Email = "admin@gmail.com", Password = "admin", FullName = "Admin User" }
        };

        // SHOW LOGIN PAGE
        public ActionResult Login()
        {
            return View();
        }

        // HANDLE LOGIN
        [HttpPost]
        public ActionResult Login(string email, string password)
        {
            var user = users.FirstOrDefault(x => x.Email == email && x.Password == password);

            if (user != null)
            {
                Session["User"] = user;
                return RedirectToAction("Index", "Home");
            }

            ViewBag.Error = "Invalid email or password!";
            return View();
        }

        // LOGOUT
        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Login");
        }

        // SHOW PROFILE PAGE (renamed to avoid conflict)
        public ActionResult UserProfile()
        {
            if (Session["User"] == null)
                return RedirectToAction("Login");

            return View();
        }

        // SHOW SIGN UP PAGE
        public ActionResult Register()
        {
            return View();
        }

        // HANDLE SIGN UP
        [HttpPost]
        public ActionResult Register(string fullName, string email, string password)
        {
            var newUser = new User
            {
                Id = 99,
                FullName = fullName,
                Email = email,
                Password = password
            };

            Session["User"] = newUser; // auto login
            return RedirectToAction("Index", "Home");
        }
    }
}
