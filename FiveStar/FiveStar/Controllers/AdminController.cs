using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using FiveStars.Models;

namespace FiveStars.Controllers
{
    [Authorize(Roles = "admin")]
    public class AdminController : Controller
    {
        private string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

        // GET: Admin
        public ActionResult Index()
        {
            return View();
        }

        #region Movie Management

        // GET: Admin/Movies
        public ActionResult Movies()
        {
            var movies = new List<Movie>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Movies ORDER BY ReleaseDate DESC";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    movies.Add(new Movie
                    {
                        MovieID = Convert.ToInt32(reader["MovieID"]),
                        Title = reader["Title"].ToString(),
                        Duration_min = reader["Duration_min"] != DBNull.Value ? (int?)Convert.ToInt32(reader["Duration_min"]) : null,
                        PosterUrl = reader["PosterUrl"] != DBNull.Value ? reader["PosterUrl"].ToString() : null,
                        Ratings = reader["Ratings"] != DBNull.Value ? (decimal?)Convert.ToDecimal(reader["Ratings"]) : null,
                        Status = reader["Status"].ToString(),
                        ReleaseDate = reader["ReleaseDate"] != DBNull.Value ? (DateTime?)Convert.ToDateTime(reader["ReleaseDate"]) : null,
                        Description = reader["Description"] != DBNull.Value ? reader["Description"].ToString() : null
                    });
                }
                reader.Close();
            }

            return View(movies);
        }

        // GET: Admin/CreateMovie
        public ActionResult CreateMovie()
        {
            return View();
        }

        // POST: Admin/CreateMovie
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateMovie(Movie movie)
        {
            if (ModelState.IsValid)
            {
                // Handle file upload
                if (movie.PosterFile != null && movie.PosterFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(movie.PosterFile.FileName);
                    string path = Path.Combine(Server.MapPath("~/images/"), fileName);
                    movie.PosterFile.SaveAs(path);
                    movie.PosterUrl = "images/" + fileName;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Movies (Title, Duration_min, PosterUrl, Ratings, Status, ReleaseDate, Description) 
                                   VALUES (@Title, @Duration, @PosterUrl, @Ratings, @Status, @ReleaseDate, @Description)";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@Title", movie.Title);
                    cmd.Parameters.AddWithValue("@Duration", movie.Duration_min ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@PosterUrl", movie.PosterUrl ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Ratings", movie.Ratings ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Status", movie.Status);
                    cmd.Parameters.AddWithValue("@ReleaseDate", movie.ReleaseDate ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Description", movie.Description ?? (object)DBNull.Value);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                return RedirectToAction("Movies");
            }

            return View(movie);
        }

        // GET: Admin/EditMovie/5
        public ActionResult EditMovie(int id)
        {
            Movie movie = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Movies WHERE MovieID = @MovieID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MovieID", id);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    movie = new Movie
                    {
                        MovieID = Convert.ToInt32(reader["MovieID"]),
                        Title = reader["Title"].ToString(),
                        Duration_min = reader["Duration_min"] != DBNull.Value ? (int?)Convert.ToInt32(reader["Duration_min"]) : null,
                        PosterUrl = reader["PosterUrl"] != DBNull.Value ? reader["PosterUrl"].ToString() : null,
                        Ratings = reader["Ratings"] != DBNull.Value ? (decimal?)Convert.ToDecimal(reader["Ratings"]) : null,
                        Status = reader["Status"].ToString(),
                        ReleaseDate = reader["ReleaseDate"] != DBNull.Value ? (DateTime?)Convert.ToDateTime(reader["ReleaseDate"]) : null,
                        Description = reader["Description"] != DBNull.Value ? reader["Description"].ToString() : null
                    };
                }
                reader.Close();
            }

            if (movie == null)
            {
                return HttpNotFound();
            }

            return View(movie);
        }

        // POST: Admin/EditMovie/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditMovie(Movie movie)
        {
            if (ModelState.IsValid)
            {
                // Handle file upload
                if (movie.PosterFile != null && movie.PosterFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(movie.PosterFile.FileName);
                    string path = Path.Combine(Server.MapPath("~/images/"), fileName);
                    movie.PosterFile.SaveAs(path);
                    movie.PosterUrl = "images/" + fileName;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Movies SET 
                                   Title = @Title, 
                                   Duration_min = @Duration,
                                   PosterUrl = @PosterUrl,
                                   Ratings = @Ratings,
                                   Status = @Status,
                                   ReleaseDate = @ReleaseDate,
                                   Description = @Description
                                   WHERE MovieID = @MovieID";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@MovieID", movie.MovieID);
                    cmd.Parameters.AddWithValue("@Title", movie.Title);
                    cmd.Parameters.AddWithValue("@Duration", movie.Duration_min ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@PosterUrl", movie.PosterUrl ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Ratings", movie.Ratings ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Status", movie.Status);
                    cmd.Parameters.AddWithValue("@ReleaseDate", movie.ReleaseDate ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@Description", movie.Description ?? (object)DBNull.Value);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                return RedirectToAction("Movies");
            }

            return View(movie);
        }

        // POST: Admin/DeleteMovie/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteMovie(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Movies WHERE MovieID = @MovieID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@MovieID", id);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            return RedirectToAction("Movies");
        }

        #endregion

        #region Showtimes Management

        // GET: Admin/Showtimes
        public ActionResult Showtimes()
        {
            var showings = new List<Showing>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT s.*, m.Title as MovieTitle, h.HallType, c.CinemaName 
                               FROM Showings s
                               LEFT JOIN Movies m ON s.MovieID = m.MovieID
                               LEFT JOIN Halls h ON s.HallID = h.HallID
                               LEFT JOIN Cinemas c ON h.CinemaID = c.CinemaID
                               ORDER BY s.ShowTime DESC";

                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    showings.Add(new Showing
                    {
                        ShowingID = Convert.ToInt32(reader["ShowingID"]),
                        ShowTime = Convert.ToDateTime(reader["ShowTime"]),
                        TicketPrice = Convert.ToDecimal(reader["TicketPrice"]),
                        MovieID = reader["MovieID"] != DBNull.Value ? (int?)Convert.ToInt32(reader["MovieID"]) : null,
                        HallID = reader["HallID"] != DBNull.Value ? (int?)Convert.ToInt32(reader["HallID"]) : null,
                        MovieTitle = reader["MovieTitle"].ToString(),
                        HallType = reader["HallType"] != DBNull.Value ? reader["HallType"].ToString() : null,
                        CinemaName = reader["CinemaName"] != DBNull.Value ? reader["CinemaName"].ToString() : null
                    });
                }
                reader.Close();
            }

            return View(showings);
        }

        // GET: Admin/CreateShowtime
        public ActionResult CreateShowtime()
        {
            var showing = new Showing();

            // Get movies for dropdown
            var movies = GetMoviesSelectList();
            ViewBag.MoviesList = movies;

            // Get halls for dropdown
            var halls = GetHallsSelectList();
            ViewBag.HallsList = halls;

            showing.ShowTime = DateTime.Now.AddHours(1);

            return View(showing);
        }

        // POST: Admin/CreateShowtime
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateShowtime(Showing showing)
        {
            if (ModelState.IsValid)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Showings (ShowTime, TicketPrice, MovieID, HallID) 
                           VALUES (@ShowTime, @TicketPrice, @MovieID, @HallID)";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@ShowTime", showing.ShowTime);
                    cmd.Parameters.AddWithValue("@TicketPrice", showing.TicketPrice);
                    cmd.Parameters.AddWithValue("@MovieID", showing.MovieID);
                    cmd.Parameters.AddWithValue("@HallID", showing.HallID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                return RedirectToAction("Showtimes");
            }

            // Repopulate dropdowns if validation fails
            ViewBag.MoviesList = GetMoviesSelectList();
            ViewBag.HallsList = GetHallsSelectList();
            return View(showing);
        }

        // GET: Admin/EditShowtime/5
        public ActionResult EditShowtime(int id)
        {
            Showing showing = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Showings WHERE ShowingID = @ShowingID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ShowingID", id);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    showing = new Showing
                    {
                        ShowingID = Convert.ToInt32(reader["ShowingID"]),
                        ShowTime = Convert.ToDateTime(reader["ShowTime"]),
                        TicketPrice = Convert.ToDecimal(reader["TicketPrice"]),
                        MovieID = reader["MovieID"] != DBNull.Value ? (int?)Convert.ToInt32(reader["MovieID"]) : null,
                        HallID = reader["HallID"] != DBNull.Value ? (int?)Convert.ToInt32(reader["HallID"]) : null
                    };
                }
                reader.Close();
            }

            if (showing == null)
            {
                return HttpNotFound();
            }

            showing.MoviesList = GetMoviesSelectList();
            showing.HallsList = GetHallsSelectList();
            return View(showing);
        }

        // POST: Admin/EditShowtime/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditShowtime(Showing showing)
        {
            if (ModelState.IsValid)
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Showings SET 
                                   ShowTime = @ShowTime, 
                                   TicketPrice = @TicketPrice,
                                   MovieID = @MovieID,
                                   HallID = @HallID
                                   WHERE ShowingID = @ShowingID";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@ShowingID", showing.ShowingID);
                    cmd.Parameters.AddWithValue("@ShowTime", showing.ShowTime);
                    cmd.Parameters.AddWithValue("@TicketPrice", showing.TicketPrice);
                    cmd.Parameters.AddWithValue("@MovieID", showing.MovieID);
                    cmd.Parameters.AddWithValue("@HallID", showing.HallID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                return RedirectToAction("Showtimes");
            }

            showing.MoviesList = GetMoviesSelectList();
            showing.HallsList = GetHallsSelectList();
            return View(showing);
        }

        // POST: Admin/DeleteShowtime/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteShowtime(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Showings WHERE ShowingID = @ShowingID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@ShowingID", id);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            return RedirectToAction("Showtimes");
        }

        #endregion

        #region Campaign Management

        // GET: Admin/Campaigns
        public ActionResult Campaigns()
        {
            var campaigns = new List<Campaign>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Campaigns ORDER BY CampaignID DESC";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    campaigns.Add(new Campaign
                    {
                        CampaignID = Convert.ToInt32(reader["CampaignID"]),
                        Title = reader["Title"].ToString(),
                        Description = reader["Description"] != DBNull.Value ? reader["Description"].ToString() : null,
                        ImageUrl = reader["ImageUrl"] != DBNull.Value ? reader["ImageUrl"].ToString() : null,
                        DurationText = reader["DurationText"] != DBNull.Value ? reader["DurationText"].ToString() : null,
                        IsActive = Convert.ToBoolean(reader["IsActive"])
                    });
                }
                reader.Close();
            }

            return View(campaigns);
        }

        // GET: Admin/CreateCampaign
        public ActionResult CreateCampaign()
        {
            return View();
        }

        // POST: Admin/CreateCampaign
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult CreateCampaign(Campaign campaign)
        {
            if (ModelState.IsValid)
            {
                // Handle file upload
                if (campaign.ImageFile != null && campaign.ImageFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(campaign.ImageFile.FileName);
                    string path = Path.Combine(Server.MapPath("~/images/"), fileName);
                    campaign.ImageFile.SaveAs(path);
                    campaign.ImageUrl = "images/" + fileName;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Campaigns (Title, Description, ImageUrl, DurationText, IsActive) 
                                   VALUES (@Title, @Description, @ImageUrl, @DurationText, @IsActive)";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@Title", campaign.Title);
                    cmd.Parameters.AddWithValue("@Description", campaign.Description ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@ImageUrl", campaign.ImageUrl ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@DurationText", campaign.DurationText ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@IsActive", campaign.IsActive);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                return RedirectToAction("Campaigns");
            }

            return View(campaign);
        }

        // GET: Admin/EditCampaign/5
        public ActionResult EditCampaign(int id)
        {
            Campaign campaign = null;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Campaigns WHERE CampaignID = @CampaignID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CampaignID", id);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                if (reader.Read())
                {
                    campaign = new Campaign
                    {
                        CampaignID = Convert.ToInt32(reader["CampaignID"]),
                        Title = reader["Title"].ToString(),
                        Description = reader["Description"] != DBNull.Value ? reader["Description"].ToString() : null,
                        ImageUrl = reader["ImageUrl"] != DBNull.Value ? reader["ImageUrl"].ToString() : null,
                        DurationText = reader["DurationText"] != DBNull.Value ? reader["DurationText"].ToString() : null,
                        IsActive = Convert.ToBoolean(reader["IsActive"])
                    };
                }
                reader.Close();
            }

            if (campaign == null)
            {
                return HttpNotFound();
            }

            return View(campaign);
        }

        // POST: Admin/EditCampaign/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult EditCampaign(Campaign campaign)
        {
            if (ModelState.IsValid)
            {
                // Handle file upload
                if (campaign.ImageFile != null && campaign.ImageFile.ContentLength > 0)
                {
                    string fileName = Path.GetFileName(campaign.ImageFile.FileName);
                    string path = Path.Combine(Server.MapPath("~/images/"), fileName);
                    campaign.ImageFile.SaveAs(path);
                    campaign.ImageUrl = "images/" + fileName;
                }

                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    string query = @"UPDATE Campaigns SET 
                                   Title = @Title, 
                                   Description = @Description,
                                   ImageUrl = @ImageUrl,
                                   DurationText = @DurationText,
                                   IsActive = @IsActive
                                   WHERE CampaignID = @CampaignID";

                    SqlCommand cmd = new SqlCommand(query, conn);

                    cmd.Parameters.AddWithValue("@CampaignID", campaign.CampaignID);
                    cmd.Parameters.AddWithValue("@Title", campaign.Title);
                    cmd.Parameters.AddWithValue("@Description", campaign.Description ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@ImageUrl", campaign.ImageUrl ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@DurationText", campaign.DurationText ?? (object)DBNull.Value);
                    cmd.Parameters.AddWithValue("@IsActive", campaign.IsActive);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }

                return RedirectToAction("Campaigns");
            }

            return View(campaign);
        }

        // POST: Admin/DeleteCampaign/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteCampaign(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Campaigns WHERE CampaignID = @CampaignID";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@CampaignID", id);

                conn.Open();
                cmd.ExecuteNonQuery();
            }

            return RedirectToAction("Campaigns");
        }

        #endregion

        #region Helper Methods

        private SelectList GetMoviesSelectList()
        {
            var movies = new List<SelectListItem>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT MovieID, Title FROM Movies ORDER BY Title";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    movies.Add(new SelectListItem
                    {
                        Value = reader["MovieID"].ToString(),
                        Text = reader["Title"].ToString()
                    });
                }
                reader.Close();
            }

            return new SelectList(movies, "Value", "Text");
        }

        private SelectList GetHallsSelectList()
        {
            var halls = new List<SelectListItem>();

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"SELECT h.HallID, c.CinemaName + ' - ' + h.HallType as HallInfo 
                               FROM Halls h
                               LEFT JOIN Cinemas c ON h.CinemaID = c.CinemaID
                               ORDER BY c.CinemaName, h.HallType";
                SqlCommand cmd = new SqlCommand(query, conn);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                while (reader.Read())
                {
                    halls.Add(new SelectListItem
                    {
                        Value = reader["HallID"].ToString(),
                        Text = reader["HallInfo"].ToString()
                    });
                }
                reader.Close();
            }

            return new SelectList(halls, "Value", "Text");
        }

        #endregion
    }
}