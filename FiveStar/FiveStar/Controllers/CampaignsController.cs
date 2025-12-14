using System;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

public class CampaignsController : Controller
{
    private readonly CinemaDBEntities _db = new CinemaDBEntities();

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


    [HttpPost]
    [Authorize]
    [ValidateAntiForgeryToken]
    public ActionResult Apply(int id)
    {
        int userId = GetCurrentUserId();

        var campaign = _db.Campaigns.FirstOrDefault(c => c.CampaignID == id && c.IsActive);
        if (campaign == null)
        {
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
            TempData["SuccessMessage"] = "Campaign saved to your account!";
        }
        else
        {
            TempData["InfoMessage"] = "You already applied this campaign.";
        }

        return RedirectToAction("Index");
    }


    private int GetCurrentUserId()
    {
        // Çoğu projede User.Identity.Name = email olur
        var name = (User.Identity?.Name ?? "").Trim();

        // Eğer sizde numeric id tutuluyorsa:
        if (int.TryParse(name, out int parsedId))
            return parsedId;

        var user = _db.Users.FirstOrDefault(u => u.Email == name);
        if (user == null)
            throw new InvalidOperationException("Logged-in user not found. Check login setup (User.Identity.Name).");

        return user.UserID;
    }
}
