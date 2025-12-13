using System;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    public class AccountController : Controller
    {
        // =========================
        // LOGIN (GET)
        // =========================
        [AllowAnonymous]
        public ActionResult Login()
        {
            return View();
        }

        // =========================
        // LOGIN (POST)
        // =========================
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(string email, string password)
        {
            using (var db = new CinemaDBEntities())
            {
                var user = db.Users.FirstOrDefault(u =>
                    u.Email == email &&
                    u.PasswordHash == password &&
                    u.IsActive == true);

                if (user != null)
                {
                    FormsAuthentication.SetAuthCookie(user.Email, false);
                    Session["User"] = user;

                    return RedirectToAction("Index", "Home");
                }
            }

            ViewBag.Error = "Invalid email or password!";
            return View();
        }

        // =========================
        // LOGOUT
        // =========================
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.Abandon();
            return RedirectToAction("Login");
        }

        // =========================
        // REGISTER (GET)
        // =========================
        [AllowAnonymous]
        public ActionResult Register()
        {
            return View();
        }

        // =========================
        // REGISTER (POST)
        // =========================
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Register(string firstName, string lastName, string email, string password)
        {
            using (var db = new CinemaDBEntities())
            {
                if (db.Users.Any(u => u.Email == email))
                {
                    ViewBag.Error = "Email already exists!";
                    return View();
                }

                var newUser = new Users
                {
                    FirstName = firstName,
                    LastName = lastName,
                    Email = email,
                    PasswordHash = password,
                    Role = "customer",
                    IsActive = true,
                    CreatedAt = DateTime.Now
                };

                db.Users.Add(newUser);
                db.SaveChanges();

                // Auto-login after register
                FormsAuthentication.SetAuthCookie(newUser.Email, false);
                Session["User"] = newUser;

                return RedirectToAction("Index", "Home");
            }
        }

        // =========================
        // USER PROFILE
        // =========================
        [Authorize]
        public ActionResult UserProfile()
        {
            var sessionUser = Session["User"] as Users;
            if (sessionUser == null)
                return RedirectToAction("Login");

            using (var db = new CinemaDBEntities())
            {
                var user = db.Users.FirstOrDefault(u => u.UserID == sessionUser.UserID);
                return View(user);
            }
        }
    }
}
