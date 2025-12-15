using System;
using System.Collections.Generic;

namespace FiveStars.Models
{
    public class HomeIndexViewModel
    {//  DB’den basmak için
        public List<NowShowingMovieVM> NowShowing { get; set; } = new List<NowShowingMovieVM>();
        public List<Campaigns> Campaigns { get; set; } = new List<Campaigns>();
        public List<Top10MovieVM> Top10 { get; set; } = new List<Top10MovieVM>();
        public List<Movies> ComingSoon { get; set; } = new List<Movies>();
        public List<Movies> LastWeek { get; set; } = new List<Movies>();


    }

    public class NowShowingMovieVM
    {
        public Movies Movie { get; set; }
        public List<Showings> Showings { get; set; } = new List<Showings>();
    }

    public class Top10MovieVM
    {
        public Movies Movie { get; set; }
        public int RankOrder { get; set; }
        public DateTime WeekOf { get; set; }
    }
}
