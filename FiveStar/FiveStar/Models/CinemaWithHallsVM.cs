using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;

namespace FiveStars.Models.ViewModels
{
    // Tek bir hall satırı (Edit'te HallID dolu gelir, Create'te 0)
    public class HallRowVM
    {
        public int HallID { get; set; }   // existing hall -> dolu, yeni -> 0

        public string HallType { get; set; }  // Standard / VIP / IMAX

        public int Capacity { get; set; }     // sayı

        // Remove butonuna basınca true yapıp satırı “sil” olarak işaretliyoruz
        public bool IsDeleted { get; set; }
    }

    // Cinema + Halls tek formda post edilecek
    public class CinemaWithHallsVM : IValidatableObject
    {
        // Cinema
        public int CinemaID { get; set; }

        [Required]
        public string CinemaName { get; set; }

        [Required]
        public string Address { get; set; }

        [Required]
        public string City { get; set; }

        [Required]
        public string District { get; set; }

        [Required]
        public string PhoneNumber { get; set; }

        // Halls
        public List<HallRowVM> Halls { get; set; } = new List<HallRowVM>();

        // “Deleted” satırlar validation’dan muaf, aktif satırlar kontrol edilsin
        public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
        {
            var allowed = new HashSet<string>(new[] { "Standard", "VIP", "IMAX" });

            if (Halls == null || !Halls.Any(h => !h.IsDeleted))
            {
                yield return new ValidationResult(
                    "At least one hall is required.",
                    new[] { nameof(Halls) }
                );
                yield break;
            }

            for (int i = 0; i < Halls.Count; i++)
            {
                var h = Halls[i];
                if (h.IsDeleted) continue;

                if (string.IsNullOrWhiteSpace(h.HallType) || !allowed.Contains(h.HallType))
                {
                    yield return new ValidationResult(
                        "Hall type must be Standard, VIP, or IMAX.",
                        new[] { $"Halls[{i}].HallType" }
                    );
                }

                if (h.Capacity < 1 || h.Capacity > 1000)
                {
                    yield return new ValidationResult(
                        "Capacity must be between 1 and 1000.",
                        new[] { $"Halls[{i}].Capacity" }
                    );
                }
            }
        }
    }
}
