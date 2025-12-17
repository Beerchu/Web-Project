using System.Collections.Generic;

namespace FiveStars.Models.ViewModels
{
    // Cinemas sayfası için viewmodel
    public class CinemaListViewModel
    {
        public string CityName { get; set; }
        public List<CinemaRegionGroup> RegionGroups { get; set; } = new List<CinemaRegionGroup>();
    }

    // District bazlı grup
    public class CinemaRegionGroup
    {
        public string RegionName { get; set; }
        public List<CinemaItem> Cinemas { get; set; } = new List<CinemaItem>();
    }

    // Listede gösterilecek tek sinema item’ı
    public class CinemaItem
    {
        public int CinemaID { get; set; }
        public string Name { get; set; }
        public string Address { get; set; }
        public string Phone { get; set; }
        public int Capacity { get; set; }
    }
}
