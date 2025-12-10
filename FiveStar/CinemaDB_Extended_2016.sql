
/****** Object:  Table [dbo].[Users]    Script Date: 10.12.2025 22:41:35 ******/
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
	[ProfileImagePath] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 10.12.2025 22:41:35 ******/
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
	[Description] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Showings]    Script Date: 10.12.2025 22:41:35 ******/
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
/****** Object:  Table [dbo].[Campaigns]    Script Date: 10.12.2025 22:41:35 ******/
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
	[IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cinemas]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cinemas](
	[CinemaID] [int] IDENTITY(1,1) NOT NULL,
	[CinemaName] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](255) NULL,
	[City] [nvarchar](100) NULL,
	[District] [nvarchar](100) NULL,
	[PhoneNumber] [nvarchar](20) NULL,
PRIMARY KEY CLUSTERED 
(
	[CinemaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Halls]    Script Date: 10.12.2025 22:41:35 ******/
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
/****** Object:  Table [dbo].[Payments]    Script Date: 10.12.2025 22:41:35 ******/
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
	[OrderID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[PaymentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 10.12.2025 22:41:35 ******/
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
	[OrderID] [int] NULL,
	[SeatID] [int] NULL,
	[ReservationID] [int] NULL,
	[PurchaseDate] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NOT NULL,
	[CreatedAt] [datetime2](2) NOT NULL,
	[TotalAmount] [money] NOT NULL,
	[Status] [nvarchar](20) NULL,
	[CampaignID] [int] NULL,
	[DiscountAmount] [money] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_UserTickets]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_UserTickets]
AS
SELECT
    t.TicketID,
    t.UserID,
    u.FirstName,
    u.LastName,
    u.Email,

    -- Seans / film / salon / sinema
    s.ShowingID,
    s.ShowTime,
    s.TicketPrice,
    m.MovieID,
    m.Title        AS MovieTitle,
    h.HallID,
    h.HallType,
    c.CinemaID,
    c.CinemaName,
    c.District,

    -- Koltuk & ticket durumu
    t.SeatNumber,
    t.Status       AS TicketStatus,

    -- Sipariş
    o.OrderID,
    o.TotalAmount,
    o.DiscountAmount,
    o.CampaignID,

    -- Kampanya (varsa)
    camp.Title     AS CampaignTitle,
    camp.IsActive  AS CampaignIsActive,

    -- Ödeme (order'a bağlı tek ödeme varsayımıyla)
    p.PaymentID,
    p.Amount       AS PaymentAmount,
    p.PaymentMethod,
    p.PaymentTimestamp
FROM dbo.Tickets    AS t
JOIN dbo.Users      AS u    ON t.UserID    = u.UserID
JOIN dbo.Showings   AS s    ON t.ShowingID = s.ShowingID
JOIN dbo.Movies     AS m    ON s.MovieID   = m.MovieID
JOIN dbo.Halls      AS h    ON s.HallID    = h.HallID
JOIN dbo.Cinemas    AS c    ON h.CinemaID  = c.CinemaID
LEFT JOIN dbo.Orders    AS o    ON t.OrderID     = o.OrderID
LEFT JOIN dbo.Campaigns AS camp ON o.CampaignID  = camp.CampaignID
LEFT JOIN dbo.Payments  AS p    ON o.OrderID     = p.OrderID;
GO
/****** Object:  Table [dbo].[User_Campaigns]    Script Date: 10.12.2025 22:41:35 ******/
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
/****** Object:  View [dbo].[vw_UserCampaigns]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_UserCampaigns]
AS
SELECT
    uc.UserID,
    u.FirstName,
    u.LastName,
    u.Email,
    uc.CampaignID,
    c.Title        AS CampaignTitle,
    c.Description  AS CampaignDescription,
    c.DurationText,
    c.IsActive     AS CampaignIsActive,
    uc.RedeemedDate
FROM dbo.User_Campaigns AS uc
JOIN dbo.Users          AS u ON uc.UserID     = u.UserID
JOIN dbo.Campaigns      AS c ON uc.CampaignID = c.CampaignID;
GO
/****** Object:  View [dbo].[vw_CinemasByDistrict]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_CinemasByDistrict]
AS
SELECT
    c.CinemaID,
    c.CinemaName,
    c.Address,
    c.City,
    c.District,
    c.PhoneNumber,
    COUNT(h.HallID) AS HallCount
FROM dbo.Cinemas AS c
LEFT JOIN dbo.Halls AS h
    ON c.CinemaID = h.CinemaID
GROUP BY
    c.CinemaID,
    c.CinemaName,
    c.Address,
    c.City,
    c.District,
    c.PhoneNumber;
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 10.12.2025 22:41:35 ******/
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
	[SeatID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[CartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Seats]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Seats](
	[SeatID] [int] IDENTITY(1,1) NOT NULL,
	[HallID] [int] NOT NULL,
	[RowLabel] [nvarchar](5) NULL,
	[SeatNumber] [int] NOT NULL,
	[SeatType] [nvarchar](20) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Seats] PRIMARY KEY CLUSTERED 
(
	[SeatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ShowingSeatStatus]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ShowingSeatStatus]
AS
SELECT
    sh.ShowingID,
    h.HallID,
    se.SeatID,
    se.RowLabel,
    se.SeatNumber,
    se.SeatType,

    -- Bu koltuk için ticket var mı?
    CASE 
        WHEN t.TicketID IS NOT NULL THEN 1 
        ELSE 0 
    END AS IsBooked,

    -- Bu koltuk için sepette satır var mı?
    CASE 
        WHEN c.CartID IS NOT NULL THEN 1 
        ELSE 0 
    END AS IsInCart
FROM dbo.Showings AS sh
JOIN dbo.Halls  AS h
    ON sh.HallID = h.HallID
JOIN dbo.Seats  AS se
    ON se.HallID = h.HallID
LEFT JOIN dbo.Tickets AS t
    ON t.ShowingID = sh.ShowingID
   AND t.SeatID    = se.SeatID
   AND t.Status    = 'booked'   -- sadece satılmış olanları dolu say
LEFT JOIN dbo.Cart AS c
    ON c.ShowingID = sh.ShowingID
   AND c.SeatID    = se.SeatID;
GO
/****** Object:  View [dbo].[vw_UserCartDetails]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_UserCartDetails] AS
SELECT 
    c.CartID,
    c.UserID,
    u.Email,
    m.Title,
    s.ShowTime,
    c.SeatNumber,
    c.AddedAt
FROM dbo.Cart c
JOIN dbo.Users    u ON c.UserID    = u.UserID
JOIN dbo.Showings s ON c.ShowingID = s.ShowingID
JOIN dbo.Movies   m ON s.MovieID   = m.MovieID;
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 10.12.2025 22:41:35 ******/
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
/****** Object:  Table [dbo].[Genres_Movies]    Script Date: 10.12.2025 22:41:35 ******/
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
/****** Object:  Table [dbo].[Reservations]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reservations](
	[ReservationID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[MovieID] [int] NOT NULL,
	[ShowingID] [int] NULL,
	[CampaignID] [int] NULL,
	[SeatCount] [int] NOT NULL,
	[BaseTotal] [money] NOT NULL,
	[DiscountAmount] [money] NOT NULL,
	[FinalTotal] [money] NOT NULL,
	[Status] [nvarchar](20) NOT NULL,
	[CreatedAt] [datetime2](7) NOT NULL,
	[PaymentDate] [datetime2](7) NULL,
	[CustomerName] [nvarchar](255) NULL,
	[CustomerEmail] [nvarchar](255) NULL,
 CONSTRAINT [PK_Reservations] PRIMARY KEY CLUSTERED 
(
	[ReservationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Top10Movies]    Script Date: 10.12.2025 22:41:35 ******/
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
SET IDENTITY_INSERT [dbo].[Campaigns] ON 
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText], [IsActive]) VALUES (1, N'Student Discount 20%', N'Student Discount 20%', N'images/campaign_pic1.jpg', N'30 DAYS', 1)
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText], [IsActive]) VALUES (2, N'Family Package: Buy 4 Pay for 3', N'Family Package: Buy 4 Pay for 3', N'images/campaign_pic2.jpg', N'LIMITED', 1)
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText], [IsActive]) VALUES (3, N'Tuesday Cinema: 60 TL', N'Tuesday Cinema: 60 TL', N'images/campaign_pic3.jpg', N'WEEKLY', 1)
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText], [IsActive]) VALUES (4, N'Popcorn Special', N'Popcorn Special', N'images/campaign_pic4.jpg', N'15 DAYS', 1)
GO
INSERT [dbo].[Campaigns] ([CampaignID], [Title], [Description], [ImageUrl], [DurationText], [IsActive]) VALUES (5, N'Couple Ticket', N'Couple Ticket', N'images/campaign_pic5.jpg', N'VALENTINE', 1)
GO
SET IDENTITY_INSERT [dbo].[Campaigns] OFF
GO
SET IDENTITY_INSERT [dbo].[Cart] ON 
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (3, 2, 2, N'A5', CAST(N'2025-11-09T18:30:45.1381170' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (4, 3, 3, N'B1', CAST(N'2025-11-09T18:30:45.1381170' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (5, 4, 4, N'C2', CAST(N'2025-11-09T18:30:45.1381170' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (6, 2, 2, N'A5', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (7, 3, 2, N'B1', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (8, 4, 2, N'C2', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (9, 2, 3, N'A5', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (10, 3, 3, N'B1', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (11, 4, 3, N'C2', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (12, 2, 4, N'A5', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (13, 3, 4, N'B1', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2), NULL)
GO
INSERT [dbo].[Cart] ([CartID], [UserID], [ShowingID], [SeatNumber], [AddedAt], [SeatID]) VALUES (14, 4, 4, N'C2', CAST(N'2025-11-09T18:31:32.9492826' AS DateTime2), NULL)
GO
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO
SET IDENTITY_INSERT [dbo].[Cinemas] ON 
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (1, N'Cinema Ataköy', N'Ataköy 1. Kısım, 34158 Bakırköy/İstanbul', N'İstanbul', N'Bakırköy', N'0 (212) 555 10 10')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (2, N'Cinema A Plus', N'Ataköy AVM, Adnan Kahveci Blv. No:1, 34158 Bakırköy/İstanbul', N'İstanbul', N'Bakırköy', N'0 (212) 555 20 20')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (3, N'Levent Paribu Cineverse (Kanyon)', N'Kanyon AVM K-1, Büyükdere Cad. No:185 Levent, Beşiktaş/İstanbul', N'İstanbul', N'Beşiktaş', N'0 (850) 220 09 67')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (4, N'Levent ÖzdilekPark Cinetime', N'Esentepe Mah., ÖzdilekPark İstanbul AVM, Büyükdere Cd. No:181, 34394 Şişli/İstanbul', N'İstanbul', N'Şişli', N'0 (212) 388 88 80')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (5, N'Beyoğlu Atlas 1948 Sineması', N'Kuloğlu Mah., İstiklal Cd. Atlas Pasajı No:131, 34433 Beyoğlu/İstanbul', N'İstanbul', N'Beyoğlu', N'0 (212) 252 85 76')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (6, N'Eyüp Paribu Cineverse (Axis İstanbul)', N'Axis İstanbul AVM, Topçular Mah., Osman Gazi Cad. No:2, Eyüpsultan/İstanbul', N'İstanbul', N'Eyüpsultan', N'0 (850) 220 09 67')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (7, N'Sarıyer Paribu Cineverse (İstinyePark)', N'İstinyePark AVM, İstinye Bayırı Cad., İstinye, Sarıyer/İstanbul', N'İstanbul', N'Sarıyer', N'0 (850) 220 09 67')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (8, N'Kadıköy Paribu Cineverse (Nautilus)', N'Tepe Nautilus AVM, Fatih Cad. No:1, Kadıköy/İstanbul', N'İstanbul', N'Kadıköy', N'0 (850) 220 09 67')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (9, N'Kadıköy Kadıköy Sineması', N'Osmanağa Mah., Bahariye Cad., Kadıköy Pasajı No:25, 34714 Kadıköy/İstanbul', N'İstanbul', N'Kadıköy', N'0 (216) 337 74 00')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (10, N'Altunizade Capitol Spectrum Cineplex', N'Mahir İz Cad., Aksoy Sok., Capitol AVM K:3, Altunizade, Üsküdar/İstanbul', N'İstanbul', N'Üsküdar', N'0 (216) 554 77 70')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (11, N'Maltepe Paribu Cineverse (Piazza)', N'Cevizli Mah., Tugay Yolu Cd. No:71, Piazza AVM, 34846 Maltepe/İstanbul', N'İstanbul', N'Maltepe', N'0 (850) 220 09 67')
GO
INSERT [dbo].[Cinemas] ([CinemaID], [CinemaName], [Address], [City], [District], [PhoneNumber]) VALUES (12, N'Ümraniye Paribu Cineverse (Metrogarden)', N'Necip Fazıl Mah., Alemdağ Cad. Metrogarden AVM No:940, Ümraniye/İstanbul', N'İstanbul', N'Ümraniye', N'0 (850) 220 09 67')
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
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (11, N'Standard', 120, 3)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (12, N'IMAX', 80, 3)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (13, N'Standard', 100, 4)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (14, N'VIP', 40, 4)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (15, N'Standard', 60, 5)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (16, N'Standard', 80, 6)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (17, N'Standard', 120, 7)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (18, N'VIP', 60, 7)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (19, N'Standard', 100, 8)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (20, N'Standard', 60, 9)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (21, N'Standard', 80, 10)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (22, N'Standard', 80, 11)
GO
INSERT [dbo].[Halls] ([HallID], [HallType], [Capacity], [CinemaID]) VALUES (23, N'Standard', 70, 12)
GO
SET IDENTITY_INSERT [dbo].[Halls] OFF
GO
SET IDENTITY_INSERT [dbo].[Movies] ON 
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (1, N'Avatar: The Way of Water', 192, N'images/now1.jpg', CAST(7.8 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'On the distant world of Pandora, Jake and Neytiri try to protect their family when humans return with a new and dangerous threat.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (2, N'John Wick: Chapter 4', 169, N'images/now2.jpg', CAST(8.5 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'John Wick fights his way across the globe as he seeks freedom from the High Table and faces powerful new enemies.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (3, N'Oppenheimer', 180, N'images/now3.jpg', CAST(8.9 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'A biographical drama about J. Robert Oppenheimer, the physicist who led the development of the atomic bomb and struggled with its consequences.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (4, N'Spider-Man: Across the Spider-Verse', 140, N'images/now4.jpg', CAST(9.2 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'Miles Morales reunites with Gwen and a team of Spider-People from across the multiverse to face a new and dangerous threat.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (5, N'The Batman', 176, N'images/now5.jpg', CAST(9.0 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'In his second year as Gotham’s vigilante, Batman investigates a series of murders that expose the city’s deep corruption.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (6, N'Interstellar', 169, N'images/movie1.jpg', CAST(8.7 AS Decimal(3, 1)), N'Archived', CAST(N'2025-12-04' AS Date), N'A group of astronauts travels through a wormhole in search of a new home for humanity as Earth slowly becomes uninhabitable.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (7, N'F1 Movie', 120, N'images/movie2.jpg', CAST(7.3 AS Decimal(3, 1)), N'Archived', CAST(N'2025-12-03' AS Date), N'A high-speed drama set in the world of Formula 1, following a talented rookie and a veteran driver as they battle on and off the track.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (8, N'Avengers: Infinity War', 149, N'images/movie_thumbnail_3.jpg', CAST(8.4 AS Decimal(3, 1)), N'Archived', CAST(N'2025-12-02' AS Date), N'The Avengers face their most powerful enemy yet, Thanos, who seeks the Infinity Stones to wipe out half of all life in the universe.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (9, N'Barbie: The Movie', 114, N'images/movie_thumbnail_4.jpg', CAST(6.8 AS Decimal(3, 1)), N'Archived', CAST(N'2025-12-01' AS Date), N'Barbie leaves her perfect pink world and enters the real world, confronting what it means to be human, imperfect, and free.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (10, N'Demon Slayer: Infinity Castle', 120, N'images/movie_thumbnail_5.jpg', CAST(7.8 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-30' AS Date), N'Tanjiro and his friends confront terrifying new demons as the battle reaches the Infinity Castle, where the fate of the Demon Slayer Corps will be decided.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (11, N'How to Train Your Dragon', 98, N'images/movie_thumbnail_6.jpg', CAST(8.1 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-29' AS Date), N'A timid Viking boy befriends an injured dragon and discovers that dragons are not monsters, changing his village forever.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (12, N'Deadpool & Wolverine', 128, N'images/coming_soon_1.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-21' AS Date), N'Deadpool teams up with Wolverine for an ultra-violent, foul-mouthed adventure that breaks timelines, universes, and the fourth wall.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (13, N'Joker: Folie a Deux', 138, N'images/coming_soon_2.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-23' AS Date), N'Arthur Fleck returns as the Joker, navigating madness, love, and fame in a musical-tinged story about chaos and identity.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (14, N'Moana 2', 100, N'images/coming_soon_3.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-27' AS Date), N'Moana embarks on a new ocean voyage that pushes her beyond the reef once more as she answers a mysterious call from the sea.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (15, N'Mufasa: The Lion King', 118, N'images/coming_soon_4.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-29' AS Date), N'A prequel that follows Mufasa''s rise from an orphaned cub to the wise and beloved king of the Pride Lands.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (16, N'Avatar 3', 190, N'images/coming_soon_5.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-01-05' AS Date), N'The saga on Pandora continues as new regions and species are explored, and the Na''vi face an even greater threat from humans.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (17, N'Dune: Part Two', 166, N'images/last_week_1.jpg', CAST(8.7 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-28' AS Date), N'As the war for Arrakis intensifies, Paul Atreides unites the Fremen to fight for revenge and the future of the desert planet.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (18, N'Godzilla x Kong', 115, N'images/last_week_2.jpg', CAST(7.2 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-27' AS Date), N'Godzilla and Kong must put aside their rivalry and face a colossal new threat that could wipe out both titans and humanity.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (19, N'Kung Fu Panda 4', 94, N'images/last_week_3.jpg', CAST(6.8 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-26' AS Date), N'Po faces his next big challenge as he tries to choose a successor and confronts a new villain who can steal the powers of kung fu masters.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (20, N'Ghostbusters 4', 115, N'images/last_week_4.jpg', CAST(6.5 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-25' AS Date), N'A new team of Ghostbusters suits up to face a powerful ancient spirit that threatens to plunge the world into supernatural chaos.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (21, N'Bob Marley: One Love', 107, N'images/last_week_5.jpg', CAST(6.7 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-24' AS Date), N'A musical biopic that traces the life, struggles, and legacy of reggae legend Bob Marley, from hardship to worldwide fame.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (22, N'The Matrix', 136, N'images/movie_7.jpg', CAST(9.3 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-23' AS Date), N'A hacker named Neo discovers that reality is a simulated world controlled by machines and joins a rebellion to free humanity.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (23, N'Charlie and the Chocolate Factory', 115, N'images/movie_8.jpg', CAST(9.1 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-22' AS Date), N'Young Charlie wins a golden ticket to visit Willy Wonka''s magical chocolate factory, where strange tests await the children.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (24, N'Mission: Impossible', 148, N'images/movie_10.jpg', CAST(8.5 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-21' AS Date), N'Elite agent Ethan Hunt undertakes an impossible mission filled with double crosses, breathtaking stunts, and global conspiracies.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (25, N'The Greatest Showman', 150, N'images/movie_9.jpg', CAST(7.1 AS Decimal(3, 1)), N'Archived', CAST(N'2025-11-20' AS Date), N'Showman P.T. Barnum builds a dazzling circus from nothing, celebrating outsiders and the power of imagination and spectacle.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (26, N'Inside Out 2', 96, N'images/now6.jpg', CAST(8.1 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'Riley is now a teenager, and a new set of emotions arrives to handle the chaos of high school and growing up.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (27, N'Guardians of the Galaxy Vol. 3', 150, N'images/now7.jpg', CAST(7.9 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'The Guardians face their most emotional mission yet as they race across the galaxy to save Rocket from his creator.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (28, N'Frozen II', 103, N'images/now8.jpg', CAST(6.8 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'Elsa and Anna journey beyond Arendelle to discover the origin of Elsa''s powers and the truth about their family''s past.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (29, N'Inception', 148, N'images/now9.jpg', CAST(8.8 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'A thief who invades people''s dreams is hired to plant an idea inside a powerful heir using a risky shared dream heist.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (30, N'Tenet', 150, N'images/now10.jpg', CAST(7.3 AS Decimal(3, 1)), N'Now Showing', CAST(N'2025-12-10' AS Date), N'An agent known as the Protagonist fights a time-bending plot that could trigger World War III using inverted time technology.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (31, N'Zootopia 2', 108, N'images/coming1.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-22' AS Date), N'Judy and Nick team up again in a new case that tests their partnership and the city of Zootopia.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (32, N'Wicked: For Good', 137, N'images/coming2.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-23' AS Date), N'The story of Elphaba and Glinda reaches its emotional conclusion in this musical fantasy sequel.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (33, N'K-Pop Demon Hunters', 95, N'images/coming3.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-24' AS Date), N'A K-pop girl group secretly fights demons while trying to keep their idol career alive.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (34, N'Now You See Me: Now You Don''t', 113, N'images/coming4.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-25' AS Date), N'The Four Horsemen return for a new heist full of illusions, misdirection, and impossible magic.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (35, N'Ne Zha 2', 144, N'images/coming5.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-26' AS Date), N'The rebellious child-god Ne Zha faces an even greater destiny in this epic fantasy sequel.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (36, N'Havoc', 107, N'images/coming6.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-27' AS Date), N'A bruised detective fights through the criminal underworld to rescue a politician''s son.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (37, N'Ballerina (From the World of John Wick)', 125, N'images/coming7.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-28' AS Date), N'A young assassin trained in the Ruska Roma seeks revenge within the deadly world of John Wick.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (38, N'Sitaare Zameen Par', 102, N'images/coming8.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-29' AS Date), N'A group of ordinary friends discover they have extraordinary talents that could change their lives.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (39, N'Mission: Impossible - The Final Reckoning', 170, N'images/coming9.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2025-12-30' AS Date), N'Ethan Hunt faces his last and most dangerous mission in a race against a global AI threat.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (40, N'The Old Guard 2', 107, N'images/coming10.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-01-10' AS Date), N'Immortal warriors reunite to confront a new enemy that threatens their secret and the world.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (41, N'Companion', 110, N'images/coming11.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-01-14' AS Date), N'A seemingly perfect friend slowly reveals a dark side in this psychological thriller.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (42, N'Snow White', 105, N'images/coming12.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-01-18' AS Date), N'A live-action reimagining of the Snow White fairy tale with a modern twist.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (43, N'Until Dawn', 103, N'images/coming13.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-02-01' AS Date), N'A group of friends trapped in a deadly time loop must survive the night to break the curse.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (44, N'Thunderbolts*', 127, N'images/coming14.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-02-05' AS Date), N'A team of anti-heroes and reformed villains is assembled for a dangerous government mission.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (45, N'The Ugly Stepsister', 102, N'images/coming15.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-02-09' AS Date), N'A dark comedy about jealousy and rivalry between step-siblings in the same household.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (46, N'Play Dirty', 114, N'images/coming16.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-02-12' AS Date), N'A crew plans the perfect heist, but every member is hiding a trick up their sleeve.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (47, N'The Odyssey', 165, N'images/coming17.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-07-17' AS Date), N'A grand retelling of Odysseus'' long journey home after the Trojan War.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (48, N'Frankenstein (2025)', 150, N'images/coming18.jpg', CAST(0.0 AS Decimal(3, 1)), N'Coming Soon', CAST(N'2026-03-07' AS Date), N'A gothic reimagining of Victor Frankenstein and the tragic creature he brings to life.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (49, N'How the Grinch Stole Christmas', 104, N'images/grinch.jpg', CAST(6.4 AS Decimal(3, 1)), N'Archived', CAST(N'2000-11-17' AS Date), N'A grumpy creature tries to steal Christmas from the cheerful Whos in Whoville.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (50, N'Ayla: The Daughter of War', 125, N'images/ayla.jpg', CAST(8.2 AS Decimal(3, 1)), N'Archived', CAST(N'2017-10-27' AS Date), N'A Turkish sergeant cares for an orphaned Korean girl during the Korean War.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (51, N'Miracle in Cell No. 7', 132, N'images/miracle7.jpg', CAST(8.2 AS Decimal(3, 1)), N'Archived', CAST(N'2019-10-11' AS Date), N'A mentally challenged father is jailed unfairly and fights to see his daughter again.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (52, N'Cinayet Süsü', 112, N'images/cinayetsusu.jpg', CAST(7.0 AS Decimal(3, 1)), N'Archived', CAST(N'2019-10-25' AS Date), N'A homicide bureau team tries to solve a strange serial murder case with dark humor.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (53, N'Yan Yana', 148, N'images/yanyana.jpg', CAST(7.0 AS Decimal(3, 1)), N'Archived', CAST(N'2025-03-08' AS Date), N'Two women from different worlds form an unexpected friendship in a conservative town.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (54, N'Ne Zha 2', 144, N'images/nezha2.jpg', CAST(7.5 AS Decimal(3, 1)), N'Archived', CAST(N'2025-08-22' AS Date), N'Ne Zha faces new threats and destiny in a big scale Chinese fantasy adventure.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (55, N'New Gods: Yang Jian', 127, N'images/yangjian.jpg', CAST(6.7 AS Decimal(3, 1)), N'Archived', CAST(N'2022-08-19' AS Date), N'Fallen god Yang Jian works as a bounty hunter and is pulled into a family conflict.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (56, N'It', 135, N'images/it.jpg', CAST(7.3 AS Decimal(3, 1)), N'Archived', CAST(N'2017-09-08' AS Date), N'A group of children fights an ancient evil that appears as a creepy clown.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (57, N'The Old Guard', 118, N'images/oldguard.jpg', CAST(6.7 AS Decimal(3, 1)), N'Archived', CAST(N'2020-07-10' AS Date), N'A secret team of immortal fighters struggles with their endless lives and a new member.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (58, N'Polite Society', 104, N'images/politesociety.jpg', CAST(7.0 AS Decimal(3, 1)), N'Archived', CAST(N'2023-04-28' AS Date), N'A martial arts fan tries to stop her sister from marrying a very suspicious man.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (59, N'No Time to Die', 163, N'images/notimetodie.jpg', CAST(7.3 AS Decimal(3, 1)), N'Archived', CAST(N'2021-09-30' AS Date), N'James Bond returns from retirement for one last mission against a dangerous villain.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (60, N'Predator', 107, N'images/predator.jpg', CAST(7.8 AS Decimal(3, 1)), N'Archived', CAST(N'1987-06-12' AS Date), N'An elite commando team is hunted in the jungle by an invisible alien warrior.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (61, N'Parasite', 132, N'images/parasite.jpg', CAST(8.6 AS Decimal(3, 1)), N'Archived', CAST(N'2019-05-30' AS Date), N'A poor family slowly enters the life of a rich household with shocking results.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (62, N'Starlight Sonata', 90, N'images/starlightsonata.jpg', CAST(7.0 AS Decimal(3, 1)), N'Archived', CAST(N'2019-03-09' AS Date), N'A dreamy romantic fantasy about love, music and second chances under the stars.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (63, N'The Bad Guys', 100, N'images/badguys.jpg', CAST(6.9 AS Decimal(3, 1)), N'Archived', CAST(N'2022-04-22' AS Date), N'A crew of animal criminals pretends to be good and starts to like the hero life.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (64, N'Everything Everywhere All at Once', 139, N'images/eeaao.jpg', CAST(8.0 AS Decimal(3, 1)), N'Archived', CAST(N'2022-03-25' AS Date), N'A laundromat owner is thrown into a multiverse fight that makes her face her regrets.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (65, N'No Hard Feelings', 103, N'images/nohardfeelings.jpg', CAST(6.3 AS Decimal(3, 1)), N'Archived', CAST(N'2023-06-23' AS Date), N'A woman is paid to help a very shy teenager gain confidence before college.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (66, N'The Crow', 102, N'images/crow.jpg', CAST(7.5 AS Decimal(3, 1)), N'Archived', CAST(N'1994-05-11' AS Date), N'A murdered musician returns from the dead to take revenge on violent criminals.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (67, N'Free Guy', 115, N'images/freeguy.jpg', CAST(7.1 AS Decimal(3, 1)), N'Archived', CAST(N'2021-08-13' AS Date), N'A background character in a video game becomes aware and decides to be a hero.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (68, N'Love and Monsters', 109, N'images/loveandmonsters.jpg', CAST(7.0 AS Decimal(3, 1)), N'Archived', CAST(N'2020-10-16' AS Date), N'A young man crosses a monster filled world to reunite with his girlfriend.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (69, N'Dayı: Bir Adamın Hikâyesi', 125, N'images/dayi.jpg', CAST(6.2 AS Decimal(3, 1)), N'Archived', CAST(N'2021-12-10' AS Date), N'The life story of a legendary Istanbul man who rises from the streets to power.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (70, N'Bohemian Rhapsody', 134, N'images/bohemian.jpg', CAST(7.9 AS Decimal(3, 1)), N'Archived', CAST(N'2018-10-24' AS Date), N'A biographical film about Freddie Mercury and the rock band Queen.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (71, N'Puss in Boots: The Last Wish', 102, N'images/pusslastwish.jpg', CAST(7.8 AS Decimal(3, 1)), N'Archived', CAST(N'2022-12-21' AS Date), N'Puss in Boots must face his limited lives and search for a magical last wish.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (72, N'Shazam! Fury of the Gods', 130, N'images/shazam2.jpg', CAST(6.0 AS Decimal(3, 1)), N'Archived', CAST(N'2023-03-17' AS Date), N'Teen heroes with magic powers must fight angry ancient gods.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (73, N'Cinderella', 113, N'images/cinderella2021.jpg', CAST(4.2 AS Decimal(3, 1)), N'Archived', CAST(N'2021-09-03' AS Date), N'A modern musical version of the classic Cinderella fairy tale.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (74, N'Madame Web', 116, N'images/madameweb.jpg', CAST(3.8 AS Decimal(3, 1)), N'Archived', CAST(N'2024-02-14' AS Date), N'A paramedic gains visions of the future that link her to young spider themed heroes.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (75, N'Warriors of Future', 100, N'images/warriorsoffuture.jpg', CAST(5.6 AS Decimal(3, 1)), N'Archived', CAST(N'2022-08-05' AS Date), N'Soldiers race to stop an alien plant from destroying a polluted future Earth.')
GO
INSERT [dbo].[Movies] ([MovieID], [Title], [Duration_min], [PosterUrl], [Ratings], [Status], [ReleaseDate], [Description]) VALUES (76, N'Encanto', 102, N'images/encanto.jpg', CAST(7.2 AS Decimal(3, 1)), N'Archived', CAST(N'2021-11-24' AS Date), N'In a magical family in Colombia one girl seems normal but must save them all.')
GO
SET IDENTITY_INSERT [dbo].[Movies] OFF
GO
SET IDENTITY_INSERT [dbo].[Orders] ON 
GO
INSERT [dbo].[Orders] ([OrderID], [UserID], [CreatedAt], [TotalAmount], [Status], [CampaignID], [DiscountAmount]) VALUES (1, 2, CAST(N'2025-12-10T05:13:10.3300000' AS DateTime2), 1150.0000, N'Paid', NULL, 50.0000)
GO
SET IDENTITY_INSERT [dbo].[Orders] OFF
GO
SET IDENTITY_INSERT [dbo].[Payments] ON 
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (3, 250.0000, N'Online', 4, CAST(N'2025-11-08T16:11:58.6200000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (4, 250.0000, N'Online', 5, CAST(N'2025-11-08T16:11:58.6300000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (5, 250.0000, N'Credit Card', 6, CAST(N'2025-11-08T16:13:40.2300000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (6, 250.0000, N'Credit Card', 7, CAST(N'2025-11-08T16:13:40.2300000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (7, 250.0000, N'Credit Card', 8, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (8, 250.0000, N'Credit Card', 9, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (9, 250.0000, N'Mobile Payment', 10, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (10, 250.0000, N'Credit Card', 11, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (11, 250.0000, N'Credit Card', 12, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (12, 250.0000, N'Credit Card', 13, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (13, 250.0000, N'Credit Card', 14, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (14, 500.0000, N'Credit Card', 17, CAST(N'2025-11-08T16:14:36.8900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (15, 250.0000, N'Online', 18, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (16, 250.0000, N'Mobile Payment', 19, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (17, 250.0000, N'Online', 21, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (18, 400.0000, N'Mobile Payment', 22, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (19, 250.0000, N'Credit Card', 23, CAST(N'2025-11-08T16:15:16.4800000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (20, 250.0000, N'Mobile Payment', 25, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (21, 400.0000, N'Credit Card', 26, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (22, 250.0000, N'Online', 27, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (23, 400.0000, N'Mobile Payment', 28, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (24, 500.0000, N'Credit Card', 29, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (25, 400.0000, N'Online', 30, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (26, 500.0000, N'Credit Card', 32, CAST(N'2025-11-08T16:15:16.4900000' AS DateTime2), NULL)
GO
INSERT [dbo].[Payments] ([PaymentID], [Amount], [PaymentMethod], [TicketID], [PaymentTimestamp], [OrderID]) VALUES (27, 1150.0000, N'CreditCard', NULL, CAST(N'2025-12-10T05:13:10.3300000' AS DateTime2), 1)
GO
SET IDENTITY_INSERT [dbo].[Payments] OFF
GO
SET IDENTITY_INSERT [dbo].[Seats] ON 
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (1, 3, N'A', 1, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (2, 3, N'A', 2, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (3, 3, N'A', 3, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (4, 3, N'A', 4, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (5, 3, N'A', 5, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (6, 3, N'A', 6, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (7, 3, N'A', 7, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (8, 3, N'A', 8, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (9, 3, N'A', 9, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (10, 3, N'A', 10, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (11, 3, N'B', 1, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (12, 3, N'B', 2, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (13, 3, N'B', 3, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (14, 3, N'B', 4, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (15, 3, N'B', 5, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (16, 3, N'B', 6, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (17, 3, N'B', 7, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (18, 3, N'B', 8, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (19, 3, N'B', 9, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (20, 3, N'B', 10, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (21, 3, N'C', 1, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (22, 3, N'C', 2, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (23, 3, N'C', 3, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (24, 3, N'C', 4, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (25, 3, N'C', 5, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (26, 3, N'C', 6, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (27, 3, N'C', 7, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (28, 3, N'C', 8, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (29, 3, N'C', 9, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (30, 3, N'C', 10, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (31, 3, N'D', 1, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (32, 3, N'D', 2, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (33, 3, N'D', 3, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (34, 3, N'D', 4, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (35, 3, N'D', 5, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (36, 3, N'D', 6, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (37, 3, N'D', 7, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (38, 3, N'D', 8, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (39, 3, N'D', 9, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (40, 3, N'D', 10, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (41, 3, N'E', 1, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (42, 3, N'E', 2, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (43, 3, N'E', 3, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (44, 3, N'E', 4, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (45, 3, N'E', 5, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (46, 3, N'E', 6, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (47, 3, N'E', 7, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (48, 3, N'E', 8, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (49, 3, N'E', 9, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (50, 3, N'E', 10, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (51, 3, N'F', 1, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (52, 3, N'F', 2, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (53, 3, N'F', 3, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (54, 3, N'F', 4, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (55, 3, N'F', 5, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (56, 3, N'F', 6, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (57, 3, N'F', 7, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (58, 3, N'F', 8, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (59, 3, N'F', 9, N'Standard', 1)
GO
INSERT [dbo].[Seats] ([SeatID], [HallID], [RowLabel], [SeatNumber], [SeatType], [IsActive]) VALUES (60, 3, N'F', 10, N'Standard', 1)
GO
SET IDENTITY_INSERT [dbo].[Seats] OFF
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
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (17, CAST(N'2025-12-20T14:00:00.0000000' AS DateTime2), 400.0000, 1, 11)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (18, CAST(N'2025-12-20T17:00:00.0000000' AS DateTime2), 400.0000, 1, 11)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (19, CAST(N'2025-12-20T20:30:00.0000000' AS DateTime2), 400.0000, 1, 11)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (20, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 500.0000, 1, 12)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (21, CAST(N'2025-12-20T18:15:00.0000000' AS DateTime2), 500.0000, 1, 12)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (22, CAST(N'2025-12-20T21:45:00.0000000' AS DateTime2), 500.0000, 1, 12)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (23, CAST(N'2025-12-20T13:30:00.0000000' AS DateTime2), 350.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (24, CAST(N'2025-12-20T16:30:00.0000000' AS DateTime2), 350.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (25, CAST(N'2025-12-20T19:45:00.0000000' AS DateTime2), 350.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (26, CAST(N'2025-12-20T14:15:00.0000000' AS DateTime2), 320.0000, 3, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (27, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 320.0000, 3, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (28, CAST(N'2025-12-20T13:45:00.0000000' AS DateTime2), 370.0000, 4, 17)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (29, CAST(N'2025-12-20T17:15:00.0000000' AS DateTime2), 370.0000, 4, 17)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (30, CAST(N'2025-12-20T20:40:00.0000000' AS DateTime2), 370.0000, 4, 17)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (31, CAST(N'2025-12-20T15:30:00.0000000' AS DateTime2), 360.0000, 5, 19)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (32, CAST(N'2025-12-20T18:45:00.0000000' AS DateTime2), 360.0000, 5, 19)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (33, CAST(N'2025-12-20T22:00:00.0000000' AS DateTime2), 360.0000, 5, 19)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1017, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1018, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1019, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1020, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1021, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1022, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1023, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1024, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1025, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1026, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1027, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1028, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1029, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1030, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1031, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1032, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1033, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1034, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1035, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1036, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1037, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1038, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1039, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1040, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1041, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1042, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1043, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1044, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1045, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1046, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1047, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1048, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1049, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1050, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1051, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1052, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1053, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1054, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1055, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1056, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1057, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1058, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1059, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1060, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1061, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1062, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1063, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1064, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1065, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1066, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1067, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1068, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1069, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1070, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1071, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1072, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1073, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1074, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1075, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1076, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1077, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1078, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1079, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1080, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1081, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1082, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1083, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1084, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1085, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1086, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1087, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1088, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1089, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1090, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1091, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1092, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1093, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1094, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1095, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1096, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1097, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1098, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1099, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1100, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1101, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1102, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1103, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1104, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1105, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1106, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1107, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1108, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1109, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1110, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1111, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1112, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1113, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1114, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1115, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1116, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1117, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1118, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1119, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1120, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1121, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1122, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1123, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1124, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1125, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1126, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1127, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1128, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1129, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1130, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1131, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1132, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1133, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1134, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1135, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1136, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1137, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1138, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1139, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1140, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1141, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1142, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1143, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1144, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1145, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1146, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1147, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1148, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1149, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1150, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1151, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1152, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1153, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1154, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1155, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1156, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1157, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1158, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1159, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1160, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1161, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1162, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1163, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1164, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1165, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1166, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1167, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1168, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1169, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1170, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1171, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1172, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1173, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1174, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1175, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1176, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1177, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1178, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1179, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1180, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1181, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1182, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1183, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1184, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1185, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1186, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1187, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1188, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1189, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1190, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1191, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1192, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1193, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1194, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1195, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1196, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1197, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1198, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1199, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1200, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1201, CAST(N'2025-12-12T21:00:00.0000000' AS DateTime2), 220.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1202, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1203, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1204, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1205, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1206, CAST(N'2025-12-12T18:00:00.0000000' AS DateTime2), 200.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1207, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1208, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1209, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1210, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1211, CAST(N'2025-12-12T15:00:00.0000000' AS DateTime2), 200.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1212, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1213, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1214, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1215, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1216, CAST(N'2025-12-12T12:00:00.0000000' AS DateTime2), 180.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1217, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1218, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1219, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1220, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1221, CAST(N'2025-12-11T21:00:00.0000000' AS DateTime2), 220.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1222, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1223, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1224, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1225, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1226, CAST(N'2025-12-11T18:00:00.0000000' AS DateTime2), 200.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1227, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1228, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1229, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1230, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1231, CAST(N'2025-12-11T15:00:00.0000000' AS DateTime2), 200.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1232, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1233, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1234, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1235, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1236, CAST(N'2025-12-11T12:00:00.0000000' AS DateTime2), 180.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1237, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1238, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1239, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1240, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1241, CAST(N'2025-12-10T21:00:00.0000000' AS DateTime2), 220.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1242, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1243, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1244, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1245, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1246, CAST(N'2025-12-10T18:00:00.0000000' AS DateTime2), 200.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1247, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1248, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1249, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1250, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1251, CAST(N'2025-12-10T15:00:00.0000000' AS DateTime2), 200.0000, 2, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1252, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 4, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1253, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 5, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1254, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 3, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1255, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 29, 4)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1256, CAST(N'2025-12-10T12:00:00.0000000' AS DateTime2), 180.0000, 2, 4)
GO
SET IDENTITY_INSERT [dbo].[Showings] OFF
GO
SET IDENTITY_INSERT [dbo].[Tickets] ON 
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (2, N'F7', N'booked', 2, 2, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (4, N'E4', N'booked', 2, 11, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (5, N'E5', N'booked', 2, 11, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (6, N'G8', N'booked', 4, 5, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (7, N'G9', N'booked', 3, 5, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (8, N'G8', N'booked', 4, 5, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (9, N'G9', N'booked', 4, 5, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (10, N'D5', N'booked', 5, 14, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (11, N'A1', N'booked', 6, 12, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (12, N'A2', N'booked', 7, 12, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (13, N'A3', N'booked', 7, 12, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (14, N'A4', N'booked', 6, 12, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (17, N'B7', N'booked', 2, 9, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (18, N'A10', N'booked', 4, 11, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (19, N'B7', N'booked', 3, 13, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (21, N'E8', N'booked', 6, 12, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (22, N'F8', N'booked', 6, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (23, N'E3', N'booked', 3, 12, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (25, N'H2', N'booked', 6, 6, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (26, N'A6', N'booked', 7, 3, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (27, N'A4', N'booked', 2, 12, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (28, N'H8', N'booked', 5, 4, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (29, N'H10', N'booked', 4, 9, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (30, N'F10', N'booked', 4, 4, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (32, N'A5', N'booked', 2, 10, NULL, NULL, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (33, N'A1', N'booked', 2, 2, 1, 1, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (34, N'A2', N'booked', 2, 2, 1, 2, NULL, NULL)
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (35, N'A3', N'booked', 2, 2, 1, 3, NULL, NULL)
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
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (1, N'Admin', N'User', N'admin@fivestar.com', N'jsbo2947naıwJE928', N'admin', CAST(N'2025-12-10T04:26:21.0280319' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (2, N'Fadime', N'Yılmaz', N'fadimeY21@gmail.com', N'dskfhdks9246kjdka', N'customer', CAST(N'2025-12-10T04:26:21.0280319' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (3, N'Ceyda', N'Kalkan', N'ceydaaa82@gmail.com', N'jhdsk832974nkds', N'customer', CAST(N'2025-12-10T04:26:21.0280319' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (4, N'Ayşe', N'Yılmaz', N'ayse.yilmaz.88@gmail.com', N'dsjfkl7252nkds', N'customer', CAST(N'2025-12-10T04:26:21.0280319' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (5, N'Mehmet', N'Öztürk', N'mehmet.ozturk.dev@outlook.com', N'12345678gsfwe', N'customer', CAST(N'2025-12-10T04:26:21.0280319' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (6, N'Elif', N'Kaya', N'elif.kaya.art@gmail.com', N'dhk9748dkhs', N'customer', CAST(N'2025-12-10T04:26:21.0280319' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (7, N'Cem', N'Demir', N'cem.demir92@hotmail.com', N'dsf43t4fgd', N'customer', CAST(N'2025-12-10T04:26:21.0280319' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (8, N'Aylin', N'Kara', N'aylin.kara@example.com', N'P@ssw0rd1', N'customer', CAST(N'2025-12-10T05:51:29.6000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (9, N'Mert', N'Demir', N'mert.demir@example.com', N'P@ssw0rd2', N'customer', CAST(N'2025-12-10T05:51:29.6000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (10, N'Elif', N'Yıldız', N'elif.yildiz@example.com', N'P@ssw0rd3', N'customer', CAST(N'2025-12-10T05:51:29.6000000' AS DateTime2), 1, N'/images/users/elif.png')
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (11, N'Can', N'Aksoy', N'can.aksoy@example.com', N'P@ssw0rd4', N'customer', CAST(N'2025-12-10T05:51:29.6000000' AS DateTime2), 1, NULL)
GO
INSERT [dbo].[Users] ([UserID], [FirstName], [LastName], [Email], [PasswordHash], [Role], [CreatedAt], [IsActive], [ProfileImagePath]) VALUES (12, N'Zeynep', N'Admin', N'admin2@fivestar.com', N'Admin!234', N'admin', CAST(N'2025-12-10T05:51:29.6000000' AS DateTime2), 1, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Genres_Name]    Script Date: 10.12.2025 22:41:35 ******/
ALTER TABLE [dbo].[Genres] ADD  CONSTRAINT [UQ_Genres_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Genres_Movies]    Script Date: 10.12.2025 22:41:35 ******/
ALTER TABLE [dbo].[Genres_Movies] ADD  CONSTRAINT [UQ_Genres_Movies] UNIQUE NONCLUSTERED 
(
	[GenreID] ASC,
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Seats_Hall_Row_Seat]    Script Date: 10.12.2025 22:41:35 ******/
ALTER TABLE [dbo].[Seats] ADD  CONSTRAINT [UQ_Seats_Hall_Row_Seat] UNIQUE NONCLUSTERED 
(
	[HallID] ASC,
	[RowLabel] ASC,
	[SeatNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_User_Campaign]    Script Date: 10.12.2025 22:41:35 ******/
ALTER TABLE [dbo].[User_Campaigns] ADD  CONSTRAINT [UQ_User_Campaign] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[CampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Email]    Script Date: 10.12.2025 22:41:35 ******/
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [UQ_Users_Email] UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Campaigns] ADD  CONSTRAINT [DF_Campaigns_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Cart] ADD  DEFAULT (sysdatetime()) FOR [AddedAt]
GO
ALTER TABLE [dbo].[Movies] ADD  DEFAULT (N'Coming Soon') FOR [Status]
GO
ALTER TABLE [dbo].[Payments] ADD  DEFAULT (getdate()) FOR [PaymentTimestamp]
GO
ALTER TABLE [dbo].[Reservations] ADD  DEFAULT ((0)) FOR [DiscountAmount]
GO
ALTER TABLE [dbo].[Reservations] ADD  DEFAULT ('Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Reservations] ADD  DEFAULT (sysdatetime()) FOR [CreatedAt]
GO
ALTER TABLE [dbo].[Seats] ADD  DEFAULT ((1)) FOR [IsActive]
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
ALTER TABLE [dbo].[Cart]  WITH CHECK ADD  CONSTRAINT [FK_Cart_Seats] FOREIGN KEY([SeatID])
REFERENCES [dbo].[Seats] ([SeatID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Seats]
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
ALTER TABLE [dbo].[Genres_Movies]  WITH CHECK ADD  CONSTRAINT [FK_Genres_Movies_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Genres_Movies] CHECK CONSTRAINT [FK_Genres_Movies_Movies]
GO
ALTER TABLE [dbo].[Halls]  WITH CHECK ADD FOREIGN KEY([CinemaID])
REFERENCES [dbo].[Cinemas] ([CinemaID])
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Campaigns] FOREIGN KEY([CampaignID])
REFERENCES [dbo].[Campaigns] ([CampaignID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Campaigns]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD FOREIGN KEY([TicketID])
REFERENCES [dbo].[Tickets] ([TicketID])
GO
ALTER TABLE [dbo].[Payments]  WITH CHECK ADD  CONSTRAINT [FK_Payments_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Payments] CHECK CONSTRAINT [FK_Payments_Orders]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Campaigns] FOREIGN KEY([CampaignID])
REFERENCES [dbo].[Campaigns] ([CampaignID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Campaigns]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Movies] FOREIGN KEY([MovieID])
REFERENCES [dbo].[Movies] ([MovieID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Movies]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Showings] FOREIGN KEY([ShowingID])
REFERENCES [dbo].[Showings] ([ShowingID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Showings]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [FK_Reservations_Users] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [FK_Reservations_Users]
GO
ALTER TABLE [dbo].[Seats]  WITH CHECK ADD  CONSTRAINT [FK_Seats_Halls] FOREIGN KEY([HallID])
REFERENCES [dbo].[Halls] ([HallID])
GO
ALTER TABLE [dbo].[Seats] CHECK CONSTRAINT [FK_Seats_Halls]
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
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Orders]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Reservations] FOREIGN KEY([ReservationID])
REFERENCES [dbo].[Reservations] ([ReservationID])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Reservations]
GO
ALTER TABLE [dbo].[Tickets]  WITH CHECK ADD  CONSTRAINT [FK_Tickets_Seats] FOREIGN KEY([SeatID])
REFERENCES [dbo].[Seats] ([SeatID])
GO
ALTER TABLE [dbo].[Tickets] CHECK CONSTRAINT [FK_Tickets_Seats]
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
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [CK_Reservations_Amounts] CHECK  (([BaseTotal]>=(0) AND [DiscountAmount]>=(0) AND [FinalTotal]>=(0)))
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [CK_Reservations_Amounts]
GO
ALTER TABLE [dbo].[Reservations]  WITH CHECK ADD  CONSTRAINT [CK_Reservations_Status] CHECK  (([Status]=N'Converted' OR [Status]=N'Cancelled' OR [Status]=N'Confirmed' OR [Status]=N'Pending'))
GO
ALTER TABLE [dbo].[Reservations] CHECK CONSTRAINT [CK_Reservations_Status]
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginUser]    Script Date: 10.12.2025 22:41:35 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RegisterUser]    Script Date: 10.12.2025 22:41:35 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_RegisterUser]
    @FirstName     NVARCHAR(255),
    @LastName      NVARCHAR(255),
    @Email         NVARCHAR(255),
    @PasswordHash  NVARCHAR(512)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Users WHERE Email = @Email)
        THROW 50001, 'This email is already registered.', 1;

    -- Role, CreatedAt, IsActive default'tan gelsin
    INSERT INTO Users (FirstName, LastName, Email, PasswordHash)
    VALUES (@FirstName, @LastName, @Email, @PasswordHash);
END;
GO
