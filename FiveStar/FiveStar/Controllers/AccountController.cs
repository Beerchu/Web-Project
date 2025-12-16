using System;
using System.Linq;
using System.Web.Mvc;
using System.Web.Security;
using FiveStars.Models;
using System.Data.SqlClient;
using System.Collections.Generic;

namespace FiveStars.Controllers
{
    public class AccountController : Controller
    {
        // =========================
        // LOGIN (GET)
        // =========================
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        // =========================
        // LOGIN (POST)
        // =========================
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Login(string email, string password, string returnUrl)
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

                    if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
                        return Redirect(returnUrl);

                    return RedirectToAction("Index", "Home");
                }
            }

            ViewBag.Error = "Invalid email or password!";
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        // =========================
        // LOGOUT
        // =========================
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.Abandon();

            return RedirectToAction("Login", "Account");
        }

        // =========================
        // REGISTER (GET)
        // =========================
        [AllowAnonymous]
        public ActionResult Register(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        // =========================
        // REGISTER (POST)
        // =========================
        [HttpPost]
        [AllowAnonymous]
        public ActionResult Register(string firstName, string lastName, string email, string password, string returnUrl)
        {
            using (var db = new CinemaDBEntities())
            {
                if (db.Users.Any(u => u.Email == email))
                {
                    ViewBag.Error = "Email already exists!";
                    ViewBag.ReturnUrl = returnUrl;
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

                FormsAuthentication.SetAuthCookie(newUser.Email, false);
                Session["User"] = newUser;

                if (!string.IsNullOrEmpty(returnUrl) && Url.IsLocalUrl(returnUrl))
                    return Redirect(returnUrl);

                return RedirectToAction("Index", "Home");
            }
        }
    }
}
