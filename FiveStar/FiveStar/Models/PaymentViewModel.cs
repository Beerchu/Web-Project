// Models/PaymentViewModel.cs

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace YourProjectName.Models
{
    // Kampanya Dropdown'ý için basit bir model.
    // Bu, DB'den sadece ID ve Title çekmek için kullanýlýr.
    public class CampaignModel
    {
        public int CampaignID { get; set; }
        public string Title { get; set; }
    }

    public class PaymentViewModel
    {
        // Temel Sipariþ Bilgisi (Gizli olarak taþýnýr)
        [Required]
        public int OrderID { get; set; }

        // 1. Gösterim ve Hesaplama Giriþleri

        // Seçilen koltuklarýn indirimsiz toplam fiyatý (Controller tarafýndan hesaplanýr)
        [Display(Name = "Temel Toplam")]
        public decimal BaseTotal { get; set; }

        // Görüntüleme için seçilen koltuklarýn listesi (Örn: "A1, B5, C3")
        [Display(Name = "Seçilen Koltuklar")]
        public List<string> SelectedSeats { get; set; }

        // 2. Kampanya Seçimi

        // Kullanýcýnýn dropdown'dan seçtiði Kampanya ID'si
        // Nullable olmalý, çünkü kullanýcý kampanya seçmeyebilir.
        [Display(Name = "Uygulanan Kampanya")]
        public int? SelectedCampaignID { get; set; }

        // Dropdown listesinde gösterilecek mevcut kampanyalarýn listesi
        public List<CampaignModel> AvailableCampaigns { get; set; }

        // 3. Hesaplama Sonuçlarý

        // Kampanya sonucunda düþülen miktar
        [Display(Name = "Ýndirim Miktarý")]
        public decimal DiscountAmount { get; set; }

        // Ödenecek son tutar (BaseTotal - DiscountAmount)
        [Display(Name = "Ödenecek Toplam")]
        public decimal FinalTotal { get; set; }

        // Not: Eðer ödeme bilgileri (Kart No, CVV, vb.) formda tutulacaksa, 
        // buraya ek alanlar eklenmelidir, ancak hassas verilerin 
        // ViewModel'de taþýnmasý yerine doðrudan ödeme servisine gönderilmesi tercih edilir.
    }
}