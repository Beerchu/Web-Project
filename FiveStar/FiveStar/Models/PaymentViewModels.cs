using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace FiveStars.Models
{
    public class CampaignModel
    {
        public int CampaignID { get; set; }
        public string Title { get; set; }
    }

    public class PaymentViewModel : IValidatableObject
    {
        // =========================
        // ORDER / PRICING
        // =========================
        [Required]
        public int OrderID { get; set; }

        [Display(Name = "Base Total")]
        public decimal BaseTotal { get; set; }

        [Display(Name = "Discount Amount")]
        public decimal DiscountAmount { get; set; }

        [Display(Name = "Final Total")]
        public decimal FinalTotal { get; set; }

        public List<string> SelectedSeats { get; set; } = new List<string>();

        public int? SelectedCampaignID { get; set; }
        public List<CampaignModel> AvailableCampaigns { get; set; } = new List<CampaignModel>();

        // =========================
        // CARD INPUTS
        // =========================
        [Required(ErrorMessage = "Card Holder Name is required.")]
        [Display(Name = "Card Holder Name")]
        public string CardHolderName { get; set; }

        [Required(ErrorMessage = "Card Number is required.")]
        [Display(Name = "Card Number")]
        public string CardNumber { get; set; } // user types "xxxx xxxx xxxx xxxx"

        [Required(ErrorMessage = "Expiration Date is required.")]
        [Display(Name = "Expiration Date (MM/YYYY)")]
        public string ExpirationDate { get; set; } // MM/YYYY

        [Required(ErrorMessage = "CVV is required.")]
        [Display(Name = "CVV")]
        public string CVV { get; set; } // 3-4 digits

        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            // --- Card Number: 16 digits only (spaces allowed in input) ---
            var digits = new string((CardNumber ?? "").Where(char.IsDigit).ToArray());
            if (digits.Length != 16)
                yield return new ValidationResult("Card number must be 16 digits.", new[] { nameof(CardNumber) });

            // --- Expiration Date: MM/YYYY and must NOT be expired ---
            var exp = (ExpirationDate ?? "").Trim();
            if (!TryParseExpMmYyyy(exp, out int year, out int month))
            {
                yield return new ValidationResult("Invalid date format. Use MM/YYYY.", new[] { nameof(ExpirationDate) });
            }
            else
            {
                // Valid through the end of the expiry month
                var endOfExpiryMonth = new DateTime(year, month, DateTime.DaysInMonth(year, month));
                if (endOfExpiryMonth < DateTime.Today)
                    yield return new ValidationResult("Card is expired.", new[] { nameof(ExpirationDate) });
            }


            // --- CVV: 3-4 digits only ---
            var cvv = (CVV ?? "").Trim();
            if (!(cvv.Length == 3 || cvv.Length == 4) || !cvv.All(char.IsDigit))
                yield return new ValidationResult("CVV must be 3 or 4 digits.", new[] { nameof(CVV) });

            // --- Card holder name: required, basic sanity only ---
            var name = (CardHolderName ?? "").Trim();
            if (name.Length < 2)
                yield return new ValidationResult("Card Holder Name is required.", new[] { nameof(CardHolderName) });
        }


        private static bool TryParseExpMmYyyy(string input, out int year, out int month)
        {
            year = 0;
            month = 0;

            var parts = input.Split('/');
            if (parts.Length != 2) return false;

            if (!int.TryParse(parts[0], out month)) return false;
            if (!int.TryParse(parts[1], out year)) return false;

            if (month < 1 || month > 12) return false;
            if (year < 1900 || year > 3000) return false;

            return true;
        }

        private static bool IsLuhnValid(string digits)
        {
            int sum = 0;
            bool alt = false;

            for (int i = digits.Length - 1; i >= 0; i--)
            {
                int n = digits[i] - '0';
                if (alt)
                {
                    n *= 2;
                    if (n > 9) n -= 9;
                }
                sum += n;
                alt = !alt;
            }

            return (sum % 10) == 0;
        }
    }
}
