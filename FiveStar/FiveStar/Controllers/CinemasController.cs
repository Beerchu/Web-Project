// Controllers/CinemasController.cs
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using FiveStars.Models; // ViewModel'ler için gerekli
using System.Data.Entity; // Halls kapasitesi çekimi için gerekli

// Projenin ana namespace'ini ekliyoruz. 
// CinemaDBEntities büyük ihtimalle buradadır.
using FiveStars;

namespace FiveStars.Controllers
{
    // CinemaDBEntities'i bu using ifadesi bulmalıdır.
    public class CinemasController : Controller
    {
        // Veritabanı Context'ini başlatma
        private readonly CinemaDBEntities _db = new CinemaDBEntities();

        // GET: /Cinemas/Index
        public ActionResult Index()
        {
            // Sinemaların sadece İstanbul'da olanları için filtreleme
            // Bu, örnek olarak kalabilir veya projenin ihtiyacına göre değiştirilebilir.
            const string targetCity = "İstanbul";

            // 1. Veritabanından sinemaları çekme
            var allCinemas = _db.Cinemas
                .Where(c => c.City == targetCity)
                .ToList();

            // 2. Sinemaları ŞEHİRE göre gruplama (EDMX'te tanımlı olan c.City kullanıldı)
            // NOT: Her sinema İstanbul'da olduğu için, bu gruplama tek bir 'İstanbul' grubu oluşturacaktır.
            var regionGroups = allCinemas
                .GroupBy(c => c.City) // Gruplama, tanimli olan c.City alanına göre yapildi.
                .Select(g => new CinemaRegionGroup
                {
                    RegionName = g.Key, // Anahtar (Key) olarak Şehir Adı (İstanbul)
                    Cinemas = g.Select(c => new CinemaItem
                    {
                        CinemaID = c.CinemaID,
                        Name = c.CinemaName,
                        Address = c.Address,
                        Phone = c.ContactNumber, // EDMX'e göre ContactNumber
                        // Kapasite bilgisini Halls tablosundan çekiyoruz (EDMX'e göre)
                        Capacity = c.Halls.Sum(h => (int?)h.Capacity)
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