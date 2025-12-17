using System;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    public class CampaignsController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // GET: /Campaigns
        [HttpGet]
        public ActionResult Index()
        {
            var campaigns = _db.Campaigns
                .Where(c => c.IsActive)
                .OrderByDescending(c => c.CampaignID)
                .ToList();

            if (User.Identity.IsAuthenticated)
            {
                int userId = GetCurrentUserId();

                ViewBag.AppliedCampaignIds = _db.User_Campaigns
                    .Where(x => x.UserID == userId)
                    .Select(x => x.CampaignID)
                    .ToList();
            }

            return View(campaigns);
        }

        // POST: /Campaigns/Apply/{id}
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Apply(int id)
        {
            bool isAjax = Request.IsAjaxRequest();

            // 1) Not logged in
            if (!User.Identity.IsAuthenticated)
            {
                if (isAjax)
                {
                    Response.StatusCode = 401;
                    return Json(new
                    {
                        ok = false,
                        requiresLogin = true,
                        message = "You must be logged in to apply this offer."
                    });
                }

                TempData["ErrorMessage"] = "You must be logged in to apply this offer.";
                return RedirectToAction("Index");
            }

            // 2) Logged in -> normal apply logic
            int userId = GetCurrentUserId();

            var campaign = _db.Campaigns.FirstOrDefault(c => c.CampaignID == id && c.IsActive);
            if (campaign == null)
            {
                if (isAjax)
                {
                    Response.StatusCode = 404;
                    return Json(new { ok = false, message = "Campaign not found or inactive." });
                }

                TempData["ErrorMessage"] = "Campaign not found or inactive.";
                return RedirectToAction("Index");
            }

            bool alreadyApplied = _db.User_Campaigns.Any(x => x.UserID == userId && x.CampaignID == id);

            if (!alreadyApplied)
            {
                _db.User_Campaigns.Add(new User_Campaigns
                {
                    UserID = userId,
                    CampaignID = id,
                    RedeemedDate = DateTime.Now
                });

                _db.SaveChanges();
            }

            // 3) AJAX response (no refresh)
            if (isAjax)
            {
                return Json(new
                {
                    ok = true,
                    alreadyApplied = alreadyApplied,
                    campaignId = id,
                    message = alreadyApplied ? "You already applied this campaign." : "Campaign saved to your account!"
                });
            }

            // 4) Non-AJAX fallback
            TempData[alreadyApplied ? "InfoMessage" : "SuccessMessage"] =
                alreadyApplied ? "You already applied this campaign." : "Campaign saved to your account!";

            return RedirectToAction("Index");
        }

        private int GetCurrentUserId()
        {
            var name = (User.Identity?.Name ?? "").Trim();

            if (int.TryParse(name, out int parsedId))
                return parsedId;

            var user = _db.Users.FirstOrDefault(u => u.Email == name);
            if (user == null)
                throw new InvalidOperationException("Logged-in user not found. Check login setup (User.Identity.Name).");

            return user.UserID;
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing) _db.Dispose();
            base.Dispose(disposing);
        }
    }
}
