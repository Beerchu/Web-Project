/****** Object:  Database [CinemaDB]    Script Date: 7.12.2025 00:03:59 ******/
CREATE DATABASE [CinemaDB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CinemaDB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.T2200004231\MSSQL\DATA\CinemaDB.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CinemaDB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.T2200004231\MSSQL\DATA\CinemaDB_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CinemaDB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CinemaDB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CinemaDB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CinemaDB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CinemaDB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CinemaDB] SET ARITHABORT OFF 
GO
ALTER DATABASE [CinemaDB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CinemaDB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CinemaDB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CinemaDB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CinemaDB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CinemaDB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CinemaDB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CinemaDB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CinemaDB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CinemaDB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CinemaDB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CinemaDB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CinemaDB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CinemaDB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CinemaDB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CinemaDB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CinemaDB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CinemaDB] SET RECOVERY FULL 
GO
ALTER DATABASE [CinemaDB] SET  MULTI_USER 
GO
ALTER DATABASE [CinemaDB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CinemaDB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CinemaDB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CinemaDB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CinemaDB] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CinemaDB] SET QUERY_STORE = ON
GO
ALTER DATABASE [CinemaDB] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200)
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart](
	[CartID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[ShowingID] [int] NOT NULL,
	[SeatNumber] [nvarchar](10) NULL,
	[AddedAt] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](255) NOT NULL,
	[LastName] [nvarchar](255) NOT NULL,
	[Email] [nvarchar](255) NOT NULL,
	[PasswordHash] [nvarchar](512) NOT NULL,
	[Role] [nvarchar](50) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Movies](
	[MovieID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Duration_min] [int] NULL,
	[PosterUrl] [nvarchar](255) NULL,
	[Ratings] [decimal](3, 1) NULL,
	[Status] [nvarchar](50) NOT NULL,
	[ReleaseDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Showings]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Showings](
	[ShowingID] [int] IDENTITY(1,1) NOT NULL,
	[ShowTime] [datetime2](2) NOT NULL,
	[TicketPrice] [money] NOT NULL,
	[MovieID] [int] NULL,
	[HallID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ShowingID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_UserCartDetails]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_UserCartDetails] AS
SELECT 
    c.CartID,
    u.Email,
    m.Title,
    s.ShowTime,
    c.SeatNumber,
    c.AddedAt
FROM Cart c
JOIN Users u ON c.UserID = u.UserID
JOIN Showings s ON c.ShowingID = s.ShowingID
JOIN Movies m ON s.MovieID = m.MovieID;
GO
/****** Object:  Table [dbo].[Campaigns]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Campaigns](
	[CampaignID] [int] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](255) NOT NULL,
	[Description] [nvarchar](max) NULL,
	[ImageUrl] [nvarchar](255) NULL,
	[DurationText] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cinemas]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cinemas](
	[CinemaID] [int] IDENTITY(1,1) NOT NULL,
	[CinemaName] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[City] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[CinemaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres](
	[GenreID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Genres_Movies]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Genres_Movies](
	[GenreMovieID] [int] IDENTITY(1,1) NOT NULL,
	[GenreID] [int] NULL,
	[MovieID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[GenreMovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Halls]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Halls](
	[HallID] [int] IDENTITY(1,1) NOT NULL,
	[HallType] [nvarchar](50) NULL,
	[Capacity] [int] NULL,
	[CinemaID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[HallID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payments](
	[PaymentID] [int] IDENTITY(1,1) NOT NULL,
	[Amount] [money] NOT NULL,
	[PaymentMethod] [nvarchar](50) NULL,
	[TicketID] [int] NULL,
	[PaymentTimestamp] [datetime2](2) NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tickets](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[SeatNumber] [nvarchar](10) NOT NULL,
	[Status] [nvarchar](20) NULL,
	[UserID] [int] NULL,
	[ShowingID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Top10Movies]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Top10Movies](
	[TopMovieID] [int] IDENTITY(1,1) NOT NULL,
	[MovieID] [int] NOT NULL,
	[RankOrder] [int] NOT NULL,
	[WeekOf] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[TopMovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User_Campaigns]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User_Campaigns](
	[UserCampaignID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CampaignID] [int] NOT NULL,
	[RedeemedDate] [datetime2](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserCampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Campaigns] ON 
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText]) VALUES (1, N'Student Discount 20%', N'Student Discount 20%', N'images/campaign_pic1.jpg', N'30 DAYS')
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText]) VALUES (2, N'Family Package: Buy 4 Pay for 3', N'Family Package: Buy 4 Pay for 3', N'images/campaign_pic2.jpg', N'LIMITED')
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText]) VALUES (3, N'Tuesday Cinema: 60 TL', N'Tuesday Cinema: 60 TL', N'images/campaign_pic3.jpg', N'WEEKLY')
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText]) VALUES (4, N'Popcorn Special', N'Popcorn Special', N'images/campaign_pic4.jpg', N'15 DAYS')
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText]) VALUES (5, N'Couple Ticket', N'Couple Ticket', N'images/campaign_pic5.jpg', N'VALENTINE')
GO
SET IDENTITY_INSERT [dbo].[Campaigns] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (3, 2, 2, N'A5', CAST(N'2025-11-09T18:30:45.1381170' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (4, 3, 3, N'B1', CAST(N'2025-11-09T18:30:45.1381170' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (5, 4, 4, N'C2', CAST(N'2025-11-09T18:30:45.1381170' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (6, 2, 2, N'A5', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (7, 3, 2, N'B1', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (8, 4, 2, N'C2', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (9, 2, 3, N'A5', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (10, 3, 3, N'B1', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (11, 4, 3, N'C2', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (12, 2, 4, N'A5', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (13, 3, 4, N'B1', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2))
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt]) VALUES (14, 4, 4, N'C2', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Cinemas] ON 
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City]) VALUES (1, N'Cinema Ataköy', N'Ataköy 1. Kısım, 34158 Bakırköy/İstanbul', N'İstanbul')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City]) VALUES (2, N'Cinema A Plus', N'Ataköy AVM, Adnan Kahveci Blv. No:1, 34158 Bakırköy/İstanbul', N'İstanbul')
GO
SET IDENTITY_INSERT [dbo].[Cinemas] OFF
GO
SET IDENTITY_INSERT [dbo].[Genres] ON 
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (2, N'Action')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (7, N'Animation')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (4, N'Biography')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (10, N'Comedy')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (8, N'Crime')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (5, N'Drama')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (11, N'Fantasy')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (6, N'History')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (12, N'Musical')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (1, N'Sci-Fi')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (9, N'Sport')
GO
INSERT [dbo].[Genres] ([GenreID], [Name]) VALUES (3, N'Thriller')
GO
SET IDENTITY_INSERT [dbo].[Genres] OFF
GO
SET IDENTITY_INSERT [dbo].[Genres_Movies] ON 
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (2, 1, 1)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (11, 1, 4)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (15, 1, 6)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (20, 1, 8)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (30, 1, 12)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (38, 1, 16)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (40, 1, 17)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (44, 1, 18)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (3, 2, 1)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (4, 2, 2)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (10, 2, 4)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (12, 2, 5)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (19, 2, 8)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (24, 2, 10)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (28, 2, 12)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (39, 2, 16)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (41, 2, 17)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (43, 2, 18)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (5, 3, 2)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (33, 3, 13)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (6, 4, 3)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (49, 4, 21)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (7, 5, 3)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (14, 5, 5)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (16, 5, 6)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (17, 5, 7)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (32, 5, 13)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (37, 5, 15)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (42, 5, 17)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (50, 5, 21)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (8, 6, 3)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (9, 7, 4)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (23, 7, 10)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (26, 7, 11)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (34, 7, 14)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (36, 7, 15)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (45, 7, 19)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (13, 8, 5)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (18, 9, 7)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (21, 10, 9)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (29, 10, 12)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (46, 10, 19)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (47, 10, 20)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (22, 11, 9)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (25, 11, 10)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (27, 11, 11)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (48, 11, 20)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (31, 12, 13)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (35, 12, 14)
GO
INSERT [dbo].[Genres_Movies] ([GenreMovieID], [GenreID], [MovieID]) VALUES (51, 12, 21)
GO
SET IDENTITY_INSERT [dbo].[Genres_Movies] OFF
GO
SET IDENTITY_INSERT [dbo].[Halls] ON 
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (1, N'Standard', 120, 1)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (2, N'Standard', 120, 1)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (3, N'IMAX', 80, 1)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (4, N'Standard', 100, 2)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (5, N'VIP', 40, 2)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (6, N'Standard', 120, 1)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (7, N'Standard', 120, 1)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (8, N'IMAX', 80, 1)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (9, N'Standard', 100, 2)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (10, N'VIP', 40, 2)
GO
SET IDENTITY_INSERT [dbo].[Halls] OFF
GO
SET IDENTITY_INSERT [dbo].[Movies] ON 
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (1, N'AVATAR: THE WAY OF WATER', 192, N'images/now1.jpg', CAST(7.8 AS Decimal(3, 1)), N'Now Showing', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (2, N'JOHN WICK 4', 169, N'images/now2.jpg', CAST(8.5 AS Decimal(3, 1)), N'Now Showing', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (3, N'OPPENHEIMER', 180, N'images/now3.jpg', CAST(8.9 AS Decimal(3, 1)), N'Now Showing', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (4, N'SPIDER-MAN: ACROSS THE SPIDERVERSE', 140, N'images/now4.jpg', CAST(9.2 AS Decimal(3, 1)), N'Now Showing', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (5, N'THE BATMAN', 176, N'images/now5.jpg', CAST(9.0 AS Decimal(3, 1)), N'Now Showing', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (6, N'Interstellar', 169, N'images/movie1.jpg', CAST(8.7 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (7, N'F1 Movie', 120, N'images/movie2.jpg', CAST(7.3 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (8, N'Avengers Infinity War', 149, N'images/movie_thumbnail_3.jpg', CAST(8.4 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (9, N'Barbie the Movie', 114, N'images/movie_thumbnail_4.jpg', CAST(6.8 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (10, N'Demon Slayer Infinity Castle', 120, N'images/movie_thumbnail_5.jpg', CAST(7.8 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (11, N'How To Train Your Dragon', 98, N'images/movie_thumbnail_6.jpg', CAST(8.1 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (12, N'DEADPOOL & WOLVERINE', NULL, N'images/coming_soon_1.jpg', CAST(8.6 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-07-26' AS Date))
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (13, N'JOKER: FOLIE À DEUX', NULL, N'images/coming_soon_2.jpg', CAST(7.1 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-10-04' AS Date))
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (14, N'MOANA 2', NULL, N'images/coming_soon_3.jpg', CAST(7.1 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-11-27' AS Date))
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (15, N'MUFASA: THE LION KING', NULL, N'images/coming_soon_4.jpg', CAST(7.6 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-20' AS Date))
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (16, N'AVATAR 3', NULL, N'images/coming_soon_5.jpg', CAST(7.4 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-19' AS Date))
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (17, N'DUNE: PART TWO', 166, N'images/last_week_1.jpg', CAST(8.7 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (18, N'GODZILLA X KONG', 115, N'images/last_week_2.jpg', CAST(7.2 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (19, N'KUNG FU PANDA 4', 94, N'images/last_week_3.jpg', CAST(6.8 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (20, N'GHOSTBUSTERS 4', 115, N'images/last_week_4.jpg', CAST(6.5 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (21, N'BOB MARLEY: ONE LOVE', 107, N'images/last_week_5.jpg', CAST(6.7 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (22, N'The Matrix', 136, N'images/movie_7.jpg', CAST(9.3 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (23, N'Charlie And The Chocolate Factory', 115, N'images/movie_8.jpg', CAST(9.1 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (24, N'Mission Impossible', 148, N'images/movie_10.jpg', CAST(8.5 AS Decimal(3, 1)), N'Archived', NULL)
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate]) VALUES (25, N'The Greatest Showman', 150, N'images/movie_9.jpg', CAST(7.1 AS Decimal(3, 1)), N'Archived', NULL)
GO
SET IDENTITY_INSERT [dbo].[Movies] OFF
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (3, 250.0000, N'Online', 4, CAST(N'2025-11-08T16:11:58.6200000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (4, 250.0000, N'Online', 5, CAST(N'2025-11-08T16:11:58.6300000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (5, 250.0000, N'Credit Card', 6, CAST(N'2025-11-08T16:13:40.2300000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (6, 250.0000, N'Credit Card', 7, CAST(N'2025-11-08T16:13:40.2300000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (7, 250.0000, N'Credit Card', 8, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (8, 250.0000, N'Credit Card', 9, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (9, 250.0000, N'Mobile Payment', 10, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (10, 250.0000, N'Credit Card', 11, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (11, 250.0000, N'Credit Card', 12, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (12, 250.0000, N'Credit Card', 13, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (13, 250.0000, N'Credit Card', 14, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (14, 500.0000, N'Credit Card', 17, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (15, 250.0000, N'Online', 18, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (16, 250.0000, N'Mobile Payment', 19, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (17, 250.0000, N'Online', 21, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (18, 400.0000, N'Mobile Payment', 22, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (19, 250.0000, N'Credit Card', 23, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (20, 250.0000, N'Mobile Payment', 25, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (21, 400.0000, N'Credit Card', 26, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (22, 250.0000, N'Online', 27, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (23, 400.0000, N'Mobile Payment', 28, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (24, 500.0000, N'Credit Card', 29, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (25, 400.0000, N'Online', 30, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2))
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp]) VALUES (26, 500.0000, N'Credit Card', 32, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
SET IDENTITY_INSERT [dbo].[Showings] ON 
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2, CAST(N'2025-11-08T14:30:00.0000000' AS DateTime2), 400.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (3, CAST(N'2025-11-08T17:00:00.0000000' AS DateTime2), 400.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (4, CAST(N'2025-11-08T20:15:00.0000000' AS DateTime2), 400.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (5, CAST(N'2025-11-08T15:00:00.0000000' AS DateTime2), 250.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (6, CAST(N'2025-11-08T18:30:00.0000000' AS DateTime2), 250.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (7, CAST(N'2025-11-08T21:45:00.0000000' AS DateTime2), 250.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (8, CAST(N'2025-11-08T16:15:00.0000000' AS DateTime2), 500.0000, 3, 5)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (9, CAST(N'2025-11-08T19:00:00.0000000' AS DateTime2), 500.0000, 3, 5)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (10, CAST(N'2025-11-08T22:30:00.0000000' AS DateTime2), 500.0000, 3, 5)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (11, CAST(N'2025-11-08T13:45:00.0000000' AS DateTime2), 250.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (12, CAST(N'2025-11-08T16:30:00.0000000' AS DateTime2), 250.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (13, CAST(N'2025-11-08T19:15:00.0000000' AS DateTime2), 250.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (14, CAST(N'2025-11-08T14:00:00.0000000' AS DateTime2), 250.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (15, CAST(N'2025-11-08T17:30:00.0000000' AS DateTime2), 250.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (16, CAST(N'2025-11-08T20:45:00.0000000' AS DateTime2), 250.0000, 5, 2)
GO
SET IDENTITY_INSERT [dbo].[Showings] OFF
GO
SET IDENTITY_INSERT [dbo].[Tickets] ON 
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (2, N'F7', N'booked', 2, 2)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (4, N'E4', N'booked', 2, 11)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (5, N'E5', N'booked', 2, 11)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (6, N'G8', N'booked', 4, 5)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (7, N'G9', N'booked', 3, 5)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (8, N'G8', N'booked', 4, 5)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (9, N'G9', N'booked', 4, 5)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (10, N'D5', N'booked', 5, 14)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (11, N'A1', N'booked', 6, 12)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (12, N'A2', N'booked', 7, 12)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (13, N'A3', N'booked', 7, 12)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (14, N'A4', N'booked', 6, 12)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (17, N'B7', N'booked', 2, 9)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (18, N'A10', N'booked', 4, 11)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (19, N'B7', N'booked', 3, 13)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (21, N'E8', N'booked', 6, 12)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (22, N'F8', N'booked', 6, 3)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (23, N'E3', N'booked', 3, 12)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (25, N'H2', N'booked', 6, 6)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (26, N'A6', N'booked', 7, 3)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (27, N'A4', N'booked', 2, 12)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (28, N'H8', N'booked', 5, 4)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (29, N'H10', N'booked', 4, 9)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (30, N'F10', N'booked', 4, 4)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID]) VALUES (32, N'A5', N'booked', 2, 10)
GO
SET IDENTITY_INSERT [dbo].[Tickets] OFF
GO
SET IDENTITY_INSERT [dbo].[Top10Movies] ON 
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (1, 1, 1, CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (2, 2, 2, CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (3, 3, 3, CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (4, 4, 4, CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (5, 5, 5, CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (6, 6, 6, CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (7, 7, 7, CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (8, 8, 8, CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (9, 9, 9, CAST(N'2025-11-03' AS Date))
GO
INSERT [dbo].[Top10Movies] ([TopMovieID], [MovieID], [RankOrder], [WeekOf]) VALUES (10, 10, 10, CAST(N'2025-11-03' AS Date))
GO
SET IDENTITY_INSERT [dbo].[Top10Movies] OFF
GO
SET IDENTITY_INSERT [dbo].[User_Campaigns] ON 
GO
INSERT [dbo].[User_Campaigns] ([UserCampaignID], [UserID], [CampaignID], [RedeemedDate]) VALUES (1, 4, 1, CAST(N'2025-11-08T20:16:40.6133333' AS DateTime2))
GO
INSERT [dbo].[User_Campaigns] ([UserCampaignID], [UserID], [CampaignID], [RedeemedDate]) VALUES (2, 5, 4, CAST(N'2025-11-08T20:16:40.6133333' AS DateTime2))
GO
INSERT [dbo].[User_Campaigns] ([UserCampaignID], [UserID], [CampaignID], [RedeemedDate]) VALUES (3, 4, 4, CAST(N'2025-11-08T20:16:40.6166667' AS DateTime2))
GO
SET IDENTITY_INSERT [dbo].[User_Campaigns] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive]) VALUES (1, N'Admin', N'User', N'admin@fivestar.com', N'jsbo2947naıwJE928', N'admin', NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive]) VALUES (2, N'Fadime', N'Yılmaz', N'fadimeY21@gmail.com', N'dskfhdks9246kjdka', N'customer', NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive]) VALUES (3, N'Ceyda', N'Kalkan', N'ceydaaa82@gmail.com', N'jhdsk832974nkds', N'customer', NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive]) VALUES (4, N'Ayşe', N'Yılmaz', N'ayse.yilmaz.88@gmail.com', N'dsjfkl7252nkds', N'customer', NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive]) VALUES (5, N'Mehmet', N'Öztürk', N'mehmet.ozturk.dev@outlook.com', N'12345678gsfwe', N'customer', NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive]) VALUES (6, N'Elif', N'Kaya', N'elif.kaya.art@gmail.com', N'dhk9748dkhs', N'customer', NULL, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive]) VALUES (7, N'Cem', N'Demir', N'cem.demir92@hotmail.com', N'dsf43t4fgd', N'customer', NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Genres_Name]    Script Date: 7.12.2025 00:03:59 ******/
ALTER TABLE [dbo].[Genres] ADD  CONSTRAINT [UQ_Genres_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Genres_Movies]    Script Date: 7.12.2025 00:03:59 ******/
ALTER TABLE [dbo].[Genres_Movies] ADD  CONSTRAINT [UQ_Genres_Movies] UNIQUE NONCLUSTERED 
(
	[GenreID] ASC,
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_User_Campaign]    Script Date: 7.12.2025 00:03:59 ******/
ALTER TABLE [dbo].[User_Campaigns] ADD  CONSTRAINT [UQ_User_Campaign] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[CampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Email]    Script Date: 7.12.2025 00:03:59 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (sysdatetime()) FOR [AddedAt]
GO
ALTER TABLE [dbo].[Movies] ADD  DEFAULT (N'Coming Soon') FOR [Status]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [PaymentTimestamp]
GO
ALTER TABLE [dbo].[Tickets] ADD  DEFAULT (N'booked') FOR [Status]
GO
ALTER TABLE [dbo].[User_Campaigns] ADD  DEFAULT (getdate()) FOR [RedeemedDate]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (N'customer') FOR [Role]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT (getdate()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Users] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Showings] FOREIGN KEY([ShowingID])
REFERENCES [dbo].[Showings] ([ShowingID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Showings]
GO
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Users]
GO
ALTER TABLE [dbo].[Genres_Movies]  WITH CHECK ADD FOREIGN KEY([GenreID])
REFERENCES [dbo].[Genres] ([GenreID])
GO
ALTER TABLE [dbo].[Halls]  WITH CHECK ADD FOREIGN KEY([CinemaID])
REFERENCES [dbo].[Cinemas] ([CinemaID])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([TicketID])
REFERENCES [dbo].[Tickets] ([TicketID])
GO
ALTER TABLE [dbo].[Showings]  WITH CHECK ADD FOREIGN KEY([HallID])
REFERENCES [dbo].[Halls] ([HallID])
GO
ALTER TABLE [dbo].[Showings]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([ShowingID])
REFERENCES [dbo].[Showings] ([ShowingID])
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Top10Movies]  WITH CHECK ADD FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[User_Campaigns]  WITH CHECK ADD  CONSTRAINT [FK_User_Campaigns_Campaigns] FOREIGN KEY([CampaignID])
REFERENCES [dbo].[Campaigns] ([CampaignID])
GO
ALTER TABLE [dbo].[User_Campaigns] CHECK CONSTRAINT [FK_User_Campaigns_Campaigns]
GO
ALTER TABLE [dbo].[User_Campaigns]  WITH CHECK ADD  CONSTRAINT [FK_User_Campaigns_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[User_Campaigns] CHECK CONSTRAINT [FK_User_Campaigns_Users]
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginUser]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[sp_LoginUser]
    @Email NVARCHAR(255),
    @PasswordHash NVARCHAR(512)
AS
BEGIN
    SELECT UserID, FirstName, LastName, Role
    FROM Users
    WHERE Email = @Email AND PasswordHash = @PasswordHash AND IsActive = 1;
END;
GO
/****** Object:  StoredProcedure [dbo].[sp_RegisterUser]    Script Date: 7.12.2025 00:03:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RegisterUser]
    @FirstName NVARCHAR(255),
    @LastName NVARCHAR(255),
    @Email NVARCHAR(255),
    @PasswordHash NVARCHAR(512)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE Email = @Email)
        THROW 50001, 'This email is already registered.', 1;

    INSERT INTO Users (FirstName, LastName, Email, PasswordHash, Role)
    VALUES (@FirstName, @LastName, @Email, @PasswordHash, 'Customer');
END;
GO
ALTER DATABASE [CinemaDB] SET  READ_WRITE 
GO
