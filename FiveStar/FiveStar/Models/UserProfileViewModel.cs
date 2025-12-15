using System;
using System.Collections.Generic;

namespace FiveStars.Models
{
    public class UserProfileViewModel
    {
        public Users User { get; set; }

        public int ActiveBookingsCount { get; set; }

        // Redeemed = claimed/saved by user but not used yet
        public int RedeemedCampaignsCount { get; set; }
        public List<RedeemedCampaignViewModel> RedeemedCampaigns { get; set; } = new List<RedeemedCampaignViewModel>();
    }

    public class RedeemedCampaignViewModel
    {
        public int CampaignID { get; set; }
        public string Title { get; set; }
        public string Description { get; set; }

        public string ImageUrl { get; set; }
        public string DurationText { get; set; }

        public bool? IsActive { get; set; }
        public DateTime? RedeemedDate { get; set; }
    }
}
