using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    public class CinemasController : Controller
    {
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        public ActionResult Index()
        {
            const string targetCity = "İstanbul";

            // FIXED: Proper lambda expression in Where clause
            var allCinemas = _db.Cinemas
                .Include(c => c.Halls)
                .Where(c => c.City == targetCity)  // This is correct
                .ToList();

            // If you're still getting errors, try this alternative:
            // var allCinemas = (from c in _db.Cinemas.Include(c => c.Halls)
            //                  where c.City == targetCity
            //                  select c).ToList();

            // Group cinemas by District
            var regionGroups = allCinemas
                .GroupBy(c => c.District)
                .Select(g => new CinemaRegionGroup
                {
                    RegionName = g.Key ?? "Other",
                    Cinemas = g.Select(c => new CinemaItem
                    {
                        CinemaID = c.CinemaID,
                        Name = c.CinemaName,
                        Address = c.Address,
                        Phone = c.PhoneNumber,
                        Capacity = c.Halls != null ? c.Halls.Sum(h => h.Capacity ?? 0) : 0
                    }).ToList()
                })
                .OrderBy(g => g.RegionName)
                .ToList();

            var viewModel = new CinemaListViewModel
            {
                CityName = targetCity,
                RegionGroups = regionGroups
            };

            return View(viewModel);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                _db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}