// Models/CinemaListViewModel.cs
using System.Collections.Generic;

namespace FiveStars.Models
{
    // Sayfanın genel Model'i (Tüm bölgeler listesi)
    public class CinemaListViewModel
    {
        // Örn: İstanbul, Ankara gibi büyük illerin listesi
        public string CityName { get; set; }

        // Sinemaları ilçeye göre gruplandıran liste
        public List<CinemaRegionGroup> RegionGroups { get; set; }
    }

    // Bir ilçeyi (bölgeyi) ve o ilçedeki sinemaları temsil eder
    public class CinemaRegionGroup
    {
        public string RegionName { get; set; } // Örn: Levent, Bakırköy
        public List<CinemaItem> Cinemas { get; set; }
    }

    // Tek bir sinema salonunun detayları (View için basitleştirilmiş)
    public class CinemaItem
    {
        public int CinemaID { get; set; }
        public string Name { get; set; }        // Örn: Paribu Cineverse
        public string Address { get; set; }     // Detaylı Adres
        public string Phone { get; set; }       // Telefon Numarası
        public int? Capacity { get; set; }      // Kapasite bilgisi (varsa)
    }
}