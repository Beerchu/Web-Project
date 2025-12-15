// Models/PaymentViewModel.cs

using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq; // List<string>.Any() kullanmak için eklenmiştir

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
        // ===========================================
        // 1. SİPARİŞ ve HESAPLAMA BİLGİLERİ (Controller'dan View'a ve Geriye)
        // ===========================================

        [Required]
        public int OrderID { get; set; }

        [Display(Name = "Temel Toplam")]
        public decimal BaseTotal { get; set; }

        [Display(Name = "Seçilen Koltuklar")]
        public List<string> SelectedSeats { get; set; }

        // Kampanya Seçimi ve Hesaplama Sonuçları
        [Display(Name = "Uygulanan Kampanya")]
        public int? SelectedCampaignID { get; set; }

        public List<CampaignModel> AvailableCampaigns { get; set; }

        [Display(Name = "İndirim Miktarı")]
        public decimal DiscountAmount { get; set; }

        [Display(Name = "Ödenecek Toplam")]
        public decimal FinalTotal { get; set; }


        // ===========================================
        // 2. KART BİLGİLERİ (ÖDEME FORMU GİRİŞLERİ) - YENİ EKLENEN KISIM
        // ===========================================

        // Kart sahibinin tam adı
        [Required(ErrorMessage = "Card Holder Name is required.")]
        [Display(Name = "Card Holder Name")]
        public string CardHolderName { get; set; }

        // 13-19 haneli Kart Numarası (Standart VISA/MasterCard/Amex vb. için)
        [Required(ErrorMessage = "Card Number is required.")]
        [RegularExpression(@"^\d{13,19}$", ErrorMessage = "Invalid Card Number.")]
        [Display(Name = "Card Number")]
        public string CardNumber { get; set; }

        // Son Kullanma Ay ve Yıl bilgisi (MM/YY formatında)
        // Regex: (01-12) / (00-99)
        [Required(ErrorMessage = "Expiration Date is required.")]
        [RegularExpression(@"^(0[1-9]|1[0-2])\/?([0-9]{2})$", ErrorMessage = "Invalid Date Format (MM/YY).")]
        [Display(Name = "Expiration Date (MM/YY)")]
        public string ExpirationDate { get; set; }

        // CVV kodu (3 veya 4 hane)
        [Required(ErrorMessage = "CVV is required.")]
        [StringLength(4, MinimumLength = 3, ErrorMessage = "CVV must be 3 or 4 digits.")]
        [Display(Name = "CVV")]
        public string Cvv { get; set; }
    }
}