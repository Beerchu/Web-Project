// Models/PaymentViewModel.cs

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace FiveStars.Models // KRİTİK: Namespace'i FiveStars.Models olarak ayarlayın
{
    // Kampanya Dropdown'ı için basit bir model.
    public class CampaignModel
    {
        public int CampaignID { get; set; }
        public string Title { get; set; }
    }

    public class PaymentViewModel
    {
        // Temel Sipariş Bilgisi (Gizli olarak taşınır)
        [Required]
        public int OrderID { get; set; }

        // 1. Gösterim ve Hesaplama Girişleri
        [Display(Name = "Temel Toplam")]
        public decimal BaseTotal { get; set; }

        [Display(Name = "Seçilen Koltuklar")]
        public List<string> SelectedSeats { get; set; }

        // 2. Kampanya Seçimi
        [Display(Name = "Uygulanan Kampanya")]
        public int? SelectedCampaignID { get; set; }

        // Dropdown listesinde gösterilecek mevcut kampanyaların listesi
        public List<CampaignModel> AvailableCampaigns { get; set; }

        // 3. Hesaplama Sonuçları
        [Display(Name = "İndirim Miktarı")]
        public decimal DiscountAmount { get; set; }

        // Ödenecek son tutar (BaseTotal - DiscountAmount)
        [Display(Name = "Ödenecek Toplam")]
        public decimal FinalTotal { get; set; }
    }
}