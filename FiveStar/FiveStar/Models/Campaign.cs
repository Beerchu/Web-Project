using System.ComponentModel.DataAnnotations;
using System.Web;

namespace FiveStars.Models
{
    public class Campaign
    {
        public int CampaignID { get; set; }

        [Required(ErrorMessage = "Title is required")]
        public string Title { get; set; }

        [DataType(DataType.MultilineText)]
        public string Description { get; set; }

        [Display(Name = "Image URL")]
        public string ImageUrl { get; set; }

        [Display(Name = "Duration")]
        public string DurationText { get; set; }

        [Display(Name = "Active")]
        public bool IsActive { get; set; } = true;

        // For file upload
        [Display(Name = "Campaign Image")]
        public HttpPostedFileBase ImageFile { get; set; }
    }
}