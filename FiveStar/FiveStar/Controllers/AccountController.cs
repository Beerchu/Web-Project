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
       
        // LOGIN (GET)
        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        
        // LOGIN (POST)
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

        
        // LOGOUT
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Logout()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.Abandon();

            return RedirectToAction("Login", "Account");
        }

        
        // REGISTER (GET)
        [AllowAnonymous]
        public ActionResult Register(string returnUrl)
        {
            ViewBag.ReturnUrl = returnUrl;
            return View();
        }

        
        // REGISTER (POST)
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

       
        // USER PROFILE
        // - Active bookings count
        // - Redeemed campaigns not used yet (from User_Campaigns)
        
        [Authorize]
        public ActionResult UserProfile()
        {
            using (var db = new CinemaDBEntities())
            {
                var email = User.Identity?.Name;
                if (string.IsNullOrEmpty(email))
                    return RedirectToAction("Login");

                var user = db.Users.FirstOrDefault(u => u.Email == email && u.IsActive == true);
                if (user == null)
                    return RedirectToAction("Login");

                int activeBookings = 0;
                TryScalarInt(db,
                    @"SELECT COUNT(*) 
                      FROM Orders 
                      WHERE UserID = @UserID 
                        AND (Status = 'PAID' OR Status = 'COMPLETED')",
                    out activeBookings,
                    new SqlParameter("@UserID", user.UserID));

                var redeemedNotUsed = FetchRedeemedNotUsedCampaigns(db, user.UserID);

                var vm = new UserProfileViewModel
                {
                    User = user,
                    ActiveBookingsCount = activeBookings,
                    RedeemedCampaigns = redeemedNotUsed,
                    RedeemedCampaignsCount = redeemedNotUsed.Count
                };

                Session["User"] = user;
                return View(vm);
            }
        }

        // =========================
        // Helper: safe scalar int
        // =========================
        private bool TryScalarInt(CinemaDBEntities db, string sql, out int value, params SqlParameter[] parameters)
        {
            try
            {
                value = db.Database.SqlQuery<int>(sql, parameters).FirstOrDefault();
                return true;
            }
            catch
            {
                value = 0;
                return false;
            }
        }

        private List<RedeemedCampaignViewModel> FetchRedeemedNotUsedCampaigns(CinemaDBEntities db, int userId)
        {
            // Attempt 1: redeemed minus used in PAID/COMPLETED orders
            try
            {
                string sql = @"
                    WITH redeemed AS (
                        SELECT
                            uc.UserID,
                            uc.CampaignID,
                            MAX(uc.RedeemedDate) AS RedeemedDate
                        FROM User_Campaigns uc
                        WHERE uc.UserID = @UserID
                        GROUP BY uc.UserID, uc.CampaignID
                    )
                    SELECT
                        c.CampaignID,
                        c.Title,
                        c.Description,
                        c.ImageUrl,
                        c.DurationText,
                        c.IsActive,
                        r.RedeemedDate
                    FROM redeemed r
                    INNER JOIN Campaigns c ON c.CampaignID = r.CampaignID
                    WHERE NOT EXISTS (
                        SELECT 1
                        FROM Orders o
                        WHERE o.UserID = r.UserID
                          AND o.CampaignID = r.CampaignID
                          AND (o.Status = 'PAID' OR o.Status = 'COMPLETED')
                    )
                    ORDER BY r.RedeemedDate DESC;
                ";

                var list = db.Database.SqlQuery<RedeemedCampaignViewModel>(
                    sql,
                    new SqlParameter("@UserID", userId)
                ).ToList();

                return list ?? new List<RedeemedCampaignViewModel>();
            }
            catch
            {
                // Attempt 2 (fallback): show ALL redeemed campaigns even if "used" logic fails
                try
                {
                    string sqlFallback = @"
                        WITH redeemed AS (
                            SELECT
                                uc.UserID,
                                uc.CampaignID,
                                MAX(uc.RedeemedDate) AS RedeemedDate
                            FROM User_Campaigns uc
                            WHERE uc.UserID = @UserID
                            GROUP BY uc.UserID, uc.CampaignID
                        )
                        SELECT
                            c.CampaignID,
                            c.Title,
                            c.Description,
                            c.ImageUrl,
                            c.DurationText,
                            c.IsActive,
                            r.RedeemedDate
                        FROM redeemed r
                        INNER JOIN Campaigns c ON c.CampaignID = r.CampaignID
                        ORDER BY r.RedeemedDate DESC;
                    ";

                    var list2 = db.Database.SqlQuery<RedeemedCampaignViewModel>(
                        sqlFallback,
                        new SqlParameter("@UserID", userId)
                    ).ToList();

                    return list2 ?? new List<RedeemedCampaignViewModel>();
                }
                catch
                {
                    return new List<RedeemedCampaignViewModel>();
                }
            }
        }

        
        // EDIT PROFILE (GET)
        
        [Authorize]
        public ActionResult EditProfile()
        {
            using (var db = new CinemaDBEntities())
            {
                var email = User.Identity?.Name;
                if (string.IsNullOrEmpty(email))
                    return RedirectToAction("Login");

                var user = db.Users.FirstOrDefault(u => u.Email == email && u.IsActive == true);
                if (user == null)
                    return RedirectToAction("Login");

                var vm = new EditProfileViewModel
                {
                    UserID = user.UserID,
                    FirstName = user.FirstName,
                    LastName = user.LastName,
                    Email = user.Email,
                    ProfileImagePath = user.ProfileImagePath
                };

                return View(vm);
            }
        }

        // EDIT PROFILE (POST)
        [HttpPost]
        [Authorize]
        [ValidateAntiForgeryToken]
        public ActionResult EditProfile(EditProfileViewModel vm)
        {
            if (!ModelState.IsValid)
                return View(vm);

            using (var db = new CinemaDBEntities())
            {
                var user = db.Users.FirstOrDefault(u => u.UserID == vm.UserID);
                if (user == null)
                    return RedirectToAction("Login");

                var emailTaken = db.Users.Any(u => u.Email == vm.Email && u.UserID != vm.UserID);
                if (emailTaken)
                {
                    ModelState.AddModelError("Email", "This email is already used by another account.");
                    return View(vm);
                }

                user.FirstName = vm.FirstName;
                user.LastName = vm.LastName;
                user.Email = vm.Email;
                user.ProfileImagePath = vm.ProfileImagePath;

                db.SaveChanges();

                FormsAuthentication.SetAuthCookie(user.Email, false);
                Session["User"] = user;

                return RedirectToAction("UserProfile");
            }
        }
    }
}
