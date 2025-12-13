USE [CinemaDB_Extended]
GO
/****** Object:  StoredProcedure [dbo].[sp_RegisterUser]    Script Date: 13.12.2025 03:47:40 ******/
DROP PROCEDURE [dbo].[sp_RegisterUser]
GO
/****** Object:  StoredProcedure [dbo].[sp_LoginUser]    Script Date: 13.12.2025 03:47:40 ******/
DROP PROCEDURE [dbo].[sp_LoginUser]
GO
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [CK_Reservations_Status]
GO
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [CK_Reservations_Amounts]
GO
ALTER TABLE [dbo].[User_Campaigns] DROP CONSTRAINT [FK_User_Campaigns_Users]
GO
ALTER TABLE [dbo].[User_Campaigns] DROP CONSTRAINT [FK_User_Campaigns_Campaigns]
GO
ALTER TABLE [dbo].[Top10Movies] DROP CONSTRAINT [FK__Top10Movi__Movie__6383C8BA]
GO
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_Tickets_Seats]
GO
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_Tickets_Reservations]
GO
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK_Tickets_Orders]
GO
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK__Tickets__UserID__628FA481]
GO
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [FK__Tickets__Showing__619B8048]
GO
ALTER TABLE [dbo].[Showings] DROP CONSTRAINT [FK__Showings__MovieI__60A75C0F]
GO
ALTER TABLE [dbo].[Showings] DROP CONSTRAINT [FK__Showings__HallID__5FB337D6]
GO
ALTER TABLE [dbo].[Seats] DROP CONSTRAINT [FK_Seats_Halls]
GO
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [FK_Reservations_Users]
GO
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [FK_Reservations_Showings]
GO
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [FK_Reservations_Movies]
GO
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [FK_Reservations_Campaigns]
GO
ALTER TABLE [dbo].[Payments] DROP CONSTRAINT [FK_Payments_Orders]
GO
ALTER TABLE [dbo].[Payments] DROP CONSTRAINT [FK__Payments__Ticket__5EBF139D]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Users]
GO
ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK_Orders_Campaigns]
GO
ALTER TABLE [dbo].[Halls] DROP CONSTRAINT [FK__Halls__CinemaID__5DCAEF64]
GO
ALTER TABLE [dbo].[Genres_Movies] DROP CONSTRAINT [FK_Genres_Movies_Movies]
GO
ALTER TABLE [dbo].[Genres_Movies] DROP CONSTRAINT [FK__Genres_Mo__Genre__5CD6CB2B]
GO
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT [FK_Cart_Users]
GO
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT [FK_Cart_Showings]
GO
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT [FK_Cart_Seats]
GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [DF__Users__IsActive__59FA5E80]
GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [DF__Users__CreatedAt__59063A47]
GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [DF__Users__Role__5812160E]
GO
ALTER TABLE [dbo].[User_Campaigns] DROP CONSTRAINT [DF__User_Camp__Redee__571DF1D5]
GO
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [DF__Tickets__Status__5629CD9C]
GO
ALTER TABLE [dbo].[Seats] DROP CONSTRAINT [DF__Seats__IsActive__6C190EBB]
GO
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [DF__Reservati__Creat__17F790F9]
GO
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [DF__Reservati__Statu__17036CC0]
GO
ALTER TABLE [dbo].[Reservations] DROP CONSTRAINT [DF__Reservati__Disco__160F4887]
GO
ALTER TABLE [dbo].[Payments] DROP CONSTRAINT [DF__Payments__Paymen__5535A963]
GO
ALTER TABLE [dbo].[Movies] DROP CONSTRAINT [DF__Movies__Status__5441852A]
GO
ALTER TABLE [dbo].[Cart] DROP CONSTRAINT [DF__Cart__AddedAt__534D60F1]
GO
ALTER TABLE [dbo].[Campaigns] DROP CONSTRAINT [DF_Campaigns_IsActive]
GO
/****** Object:  Index [UQ_Users_Email]    Script Date: 13.12.2025 03:47:40 ******/
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [UQ_Users_Email]
GO
/****** Object:  Index [UQ_User_Campaign]    Script Date: 13.12.2025 03:47:40 ******/
ALTER TABLE [dbo].[User_Campaigns] DROP CONSTRAINT [UQ_User_Campaign]
GO
/****** Object:  Index [UQ_Tickets_Showing_Seat]    Script Date: 13.12.2025 03:47:40 ******/
ALTER TABLE [dbo].[Tickets] DROP CONSTRAINT [UQ_Tickets_Showing_Seat]
GO
/****** Object:  Index [UQ_Showings_Hall_ShowTime]    Script Date: 13.12.2025 03:47:40 ******/
ALTER TABLE [dbo].[Showings] DROP CONSTRAINT [UQ_Showings_Hall_ShowTime]
GO
/****** Object:  Index [UQ_Seats_Hall_Row_Seat]    Script Date: 13.12.2025 03:47:40 ******/
ALTER TABLE [dbo].[Seats] DROP CONSTRAINT [UQ_Seats_Hall_Row_Seat]
GO
/****** Object:  Index [UQ_Genres_Movies]    Script Date: 13.12.2025 03:47:40 ******/
ALTER TABLE [dbo].[Genres_Movies] DROP CONSTRAINT [UQ_Genres_Movies]
GO
/****** Object:  Index [UQ_Genres_Name]    Script Date: 13.12.2025 03:47:40 ******/
ALTER TABLE [dbo].[Genres] DROP CONSTRAINT [UQ_Genres_Name]
GO
/****** Object:  Table [dbo].[Top10Movies]    Script Date: 13.12.2025 03:47:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Top10Movies]') AND type in (N'U'))
DROP TABLE [dbo].[Top10Movies]
GO
/****** Object:  Table [dbo].[Reservations]    Script Date: 13.12.2025 03:47:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Reservations]') AND type in (N'U'))
DROP TABLE [dbo].[Reservations]
GO
/****** Object:  Table [dbo].[Genres_Movies]    Script Date: 13.12.2025 03:47:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Genres_Movies]') AND type in (N'U'))
DROP TABLE [dbo].[Genres_Movies]
GO
/****** Object:  Table [dbo].[Genres]    Script Date: 13.12.2025 03:47:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Genres]') AND type in (N'U'))
DROP TABLE [dbo].[Genres]
GO
/****** Object:  View [dbo].[vw_UserCartDetails]    Script Date: 13.12.2025 03:47:40 ******/
DROP VIEW [dbo].[vw_UserCartDetails]
GO
/****** Object:  View [dbo].[vw_ShowingSeatStatus]    Script Date: 13.12.2025 03:47:40 ******/
DROP VIEW [dbo].[vw_ShowingSeatStatus]
GO
/****** Object:  Table [dbo].[Seats]    Script Date: 13.12.2025 03:47:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Seats]') AND type in (N'U'))
DROP TABLE [dbo].[Seats]
GO
/****** Object:  Table [dbo].[Cart]    Script Date: 13.12.2025 03:47:40 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cart]') AND type in (N'U'))
DROP TABLE [dbo].[Cart]
GO
/****** Object:  View [dbo].[vw_CinemasByDistrict]    Script Date: 13.12.2025 03:47:40 ******/
DROP VIEW [dbo].[vw_CinemasByDistrict]
GO
/****** Object:  View [dbo].[vw_UserCampaigns]    Script Date: 13.12.2025 03:47:40 ******/
DROP VIEW [dbo].[vw_UserCampaigns]
GO
/****** Object:  Table [dbo].[User_Campaigns]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[User_Campaigns]') AND type in (N'U'))
DROP TABLE [dbo].[User_Campaigns]
GO
/****** Object:  View [dbo].[vw_UserTickets]    Script Date: 13.12.2025 03:47:41 ******/
DROP VIEW [dbo].[vw_UserTickets]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Orders]') AND type in (N'U'))
DROP TABLE [dbo].[Orders]
GO
/****** Object:  Table [dbo].[Tickets]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Tickets]') AND type in (N'U'))
DROP TABLE [dbo].[Tickets]
GO
/****** Object:  Table [dbo].[Payments]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Payments]') AND type in (N'U'))
DROP TABLE [dbo].[Payments]
GO
/****** Object:  Table [dbo].[Halls]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Halls]') AND type in (N'U'))
DROP TABLE [dbo].[Halls]
GO
/****** Object:  Table [dbo].[Cinemas]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Cinemas]') AND type in (N'U'))
DROP TABLE [dbo].[Cinemas]
GO
/****** Object:  Table [dbo].[Campaigns]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Campaigns]') AND type in (N'U'))
DROP TABLE [dbo].[Campaigns]
GO
/****** Object:  Table [dbo].[Showings]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Showings]') AND type in (N'U'))
DROP TABLE [dbo].[Showings]
GO
/****** Object:  Table [dbo].[Movies]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Movies]') AND type in (N'U'))
DROP TABLE [dbo].[Movies]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 13.12.2025 03:47:41 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Users]') AND type in (N'U'))
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Movies]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Showings]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Campaigns]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Cinemas]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Halls]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Payments]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Tickets]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Orders]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  View [dbo].[vw_UserTickets]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[User_Campaigns]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  View [dbo].[vw_UserCampaigns]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  View [dbo].[vw_CinemasByDistrict]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Cart]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Seats]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  View [dbo].[vw_ShowingSeatStatus]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  View [dbo].[vw_UserCartDetails]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Genres]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Genres_Movies]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Reservations]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  Table [dbo].[Top10Movies]    Script Date: 13.12.2025 03:47:41 ******/
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
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1957, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 199.0000, 26, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1958, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 205.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1959, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 152.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1960, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 241.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1961, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 200.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1962, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 235.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1963, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 179.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1964, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 184.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1965, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 223.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1966, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 182.0000, 3, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1967, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 199.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1968, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 160.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1969, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 170.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1970, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 249.0000, 2, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1971, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 173.0000, 2, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1972, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 193.0000, 30, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1973, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 184.0000, 30, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1974, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 204.0000, 30, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1975, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 236.0000, 30, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1976, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 158.0000, 30, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1977, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 237.0000, 27, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1978, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 174.0000, 27, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1979, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 183.0000, 27, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1980, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 228.0000, 27, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1981, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 227.0000, 28, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1982, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 169.0000, 28, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1983, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 237.0000, 28, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1984, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 191.0000, 1, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1985, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 241.0000, 1, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1986, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 180.0000, 29, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1987, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 150.0000, 1, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1988, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 215.0000, 29, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1989, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 161.0000, 29, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1990, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 183.0000, 28, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1991, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 161.0000, 28, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1992, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 196.0000, 30, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1993, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 196.0000, 30, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1994, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 151.0000, 3, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1995, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 234.0000, 3, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1996, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 237.0000, 5, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1997, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 239.0000, 29, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1998, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 190.0000, 2, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (1999, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 186.0000, 30, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2000, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 227.0000, 4, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2001, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 150.0000, 26, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2002, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 182.0000, 4, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2003, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 191.0000, 28, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2004, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 157.0000, 1, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2005, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 216.0000, 29, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2006, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 230.0000, 2, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2007, CAST(N'2025-12-13T12:00:00.0000000' AS DateTime2), 173.0000, 1, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2008, CAST(N'2025-12-13T15:00:00.0000000' AS DateTime2), 200.0000, 28, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2009, CAST(N'2025-12-13T18:00:00.0000000' AS DateTime2), 163.0000, 30, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2010, CAST(N'2025-12-13T21:00:00.0000000' AS DateTime2), 191.0000, 2, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2011, CAST(N'2025-12-13T23:30:00.0000000' AS DateTime2), 181.0000, 26, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2012, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 186.0000, 26, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2013, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 183.0000, 26, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2014, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 183.0000, 26, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2015, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 228.0000, 26, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2016, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 182.0000, 26, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2017, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 171.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2018, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 191.0000, 5, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2019, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 247.0000, 5, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2020, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 209.0000, 5, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2021, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 187.0000, 4, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2022, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 160.0000, 4, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2023, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 196.0000, 4, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2024, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 211.0000, 3, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2025, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 246.0000, 3, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2026, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 199.0000, 2, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2027, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 227.0000, 30, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2028, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 224.0000, 27, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2029, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 231.0000, 27, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2030, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 233.0000, 28, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2031, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 157.0000, 28, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2032, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 181.0000, 28, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2033, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 154.0000, 1, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2034, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 170.0000, 1, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2035, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 154.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2036, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 171.0000, 1, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2037, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 199.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2038, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 178.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2039, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 187.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2040, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 232.0000, 29, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2041, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 168.0000, 29, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2042, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 228.0000, 1, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2043, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 177.0000, 5, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2044, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 216.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2045, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 163.0000, 2, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2046, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 192.0000, 26, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2047, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 153.0000, 26, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2048, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 170.0000, 4, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2049, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 167.0000, 4, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2050, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 239.0000, 27, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2051, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 204.0000, 27, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2052, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 196.0000, 5, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2053, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 220.0000, 27, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2054, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 237.0000, 3, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2055, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 224.0000, 28, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2056, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 192.0000, 1, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2057, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 183.0000, 3, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2058, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 221.0000, 27, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2059, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 175.0000, 26, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2060, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 217.0000, 30, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2061, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 222.0000, 5, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2062, CAST(N'2025-12-14T12:00:00.0000000' AS DateTime2), 178.0000, 3, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2063, CAST(N'2025-12-14T15:00:00.0000000' AS DateTime2), 202.0000, 29, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2064, CAST(N'2025-12-14T18:00:00.0000000' AS DateTime2), 179.0000, 4, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2065, CAST(N'2025-12-14T21:00:00.0000000' AS DateTime2), 214.0000, 27, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2066, CAST(N'2025-12-14T23:30:00.0000000' AS DateTime2), 175.0000, 5, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2067, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 170.0000, 26, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2068, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 218.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2069, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 191.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2070, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 246.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2071, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 171.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2072, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 180.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2073, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 150.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2074, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 191.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2075, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 241.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2076, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 171.0000, 3, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2077, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 163.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2078, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 203.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2079, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 161.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2080, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 200.0000, 2, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2081, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 207.0000, 2, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2082, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 233.0000, 30, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2083, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 197.0000, 30, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2084, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 236.0000, 30, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2085, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 191.0000, 30, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2086, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 189.0000, 30, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2087, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 243.0000, 27, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2088, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 174.0000, 27, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2089, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 247.0000, 27, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2090, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 152.0000, 27, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2091, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 153.0000, 28, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2092, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 249.0000, 28, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2093, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 194.0000, 28, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2094, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 229.0000, 1, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2095, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 153.0000, 1, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2096, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 241.0000, 29, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2097, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 155.0000, 1, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2098, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 195.0000, 29, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2099, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 182.0000, 29, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2100, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 237.0000, 28, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2101, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 205.0000, 28, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2102, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 238.0000, 30, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2103, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 225.0000, 30, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2104, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 228.0000, 3, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2105, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 248.0000, 3, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2106, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 218.0000, 5, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2107, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 222.0000, 29, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2108, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 187.0000, 2, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2109, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 197.0000, 30, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2110, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 169.0000, 4, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2111, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 232.0000, 26, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2112, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 169.0000, 4, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2113, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 192.0000, 28, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2114, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 171.0000, 1, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2115, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 219.0000, 29, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2116, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 186.0000, 2, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2117, CAST(N'2025-12-15T12:00:00.0000000' AS DateTime2), 193.0000, 1, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2118, CAST(N'2025-12-15T15:00:00.0000000' AS DateTime2), 162.0000, 28, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2119, CAST(N'2025-12-15T18:00:00.0000000' AS DateTime2), 191.0000, 30, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2120, CAST(N'2025-12-15T21:00:00.0000000' AS DateTime2), 169.0000, 2, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2121, CAST(N'2025-12-15T23:30:00.0000000' AS DateTime2), 157.0000, 26, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2122, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 213.0000, 26, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2123, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 249.0000, 26, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2124, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 179.0000, 26, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2125, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 188.0000, 26, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2126, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 191.0000, 26, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2127, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 222.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2128, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 218.0000, 5, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2129, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 203.0000, 5, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2130, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 212.0000, 5, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2131, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 171.0000, 4, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2132, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 224.0000, 4, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2133, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 232.0000, 4, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2134, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 199.0000, 3, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2135, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 188.0000, 3, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2136, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 189.0000, 2, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2137, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 238.0000, 30, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2138, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 217.0000, 27, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2139, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 178.0000, 27, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2140, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 211.0000, 28, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2141, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 225.0000, 28, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2142, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 220.0000, 28, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2143, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 164.0000, 1, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2144, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 194.0000, 1, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2145, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 247.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2146, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 191.0000, 1, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2147, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 226.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2148, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 245.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2149, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 168.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2150, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 186.0000, 29, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2151, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 205.0000, 29, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2152, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 188.0000, 1, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2153, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 178.0000, 5, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2154, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 184.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2155, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 208.0000, 2, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2156, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 212.0000, 26, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2157, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 220.0000, 26, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2158, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 192.0000, 4, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2159, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 154.0000, 4, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2160, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 233.0000, 27, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2161, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 244.0000, 27, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2162, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 166.0000, 5, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2163, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 220.0000, 27, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2164, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 228.0000, 3, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2165, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 186.0000, 28, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2166, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 226.0000, 1, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2167, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 176.0000, 3, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2168, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 160.0000, 27, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2169, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 219.0000, 26, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2170, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 219.0000, 30, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2171, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 200.0000, 5, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2172, CAST(N'2025-12-16T12:00:00.0000000' AS DateTime2), 165.0000, 3, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2173, CAST(N'2025-12-16T15:00:00.0000000' AS DateTime2), 158.0000, 29, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2174, CAST(N'2025-12-16T18:00:00.0000000' AS DateTime2), 242.0000, 4, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2175, CAST(N'2025-12-16T21:00:00.0000000' AS DateTime2), 196.0000, 27, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2176, CAST(N'2025-12-16T23:30:00.0000000' AS DateTime2), 207.0000, 5, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2177, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 199.0000, 26, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2178, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 197.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2179, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 203.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2180, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 186.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2181, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 210.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2182, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 186.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2183, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 212.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2184, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 228.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2185, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 241.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2186, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 160.0000, 3, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2187, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 203.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2188, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 248.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2189, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 195.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2190, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 166.0000, 2, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2191, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 182.0000, 2, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2192, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 212.0000, 30, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2193, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 222.0000, 30, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2194, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 182.0000, 30, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2195, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 197.0000, 30, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2196, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 220.0000, 30, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2197, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 202.0000, 27, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2198, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 201.0000, 27, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2199, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 188.0000, 27, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2200, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 242.0000, 27, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2201, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 206.0000, 28, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2202, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 162.0000, 28, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2203, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 205.0000, 28, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2204, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 185.0000, 1, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2205, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 151.0000, 1, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2206, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 203.0000, 29, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2207, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 248.0000, 1, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2208, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 179.0000, 29, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2209, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 223.0000, 29, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2210, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 216.0000, 28, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2211, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 200.0000, 28, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2212, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 197.0000, 30, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2213, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 212.0000, 30, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2214, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 197.0000, 3, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2215, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 181.0000, 3, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2216, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 212.0000, 5, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2217, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 215.0000, 29, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2218, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 223.0000, 2, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2219, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 230.0000, 30, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2220, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 195.0000, 4, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2221, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 203.0000, 26, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2222, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 204.0000, 4, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2223, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 187.0000, 28, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2224, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 172.0000, 1, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2225, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 229.0000, 29, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2226, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 164.0000, 2, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2227, CAST(N'2025-12-17T12:00:00.0000000' AS DateTime2), 225.0000, 1, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2228, CAST(N'2025-12-17T15:00:00.0000000' AS DateTime2), 156.0000, 28, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2229, CAST(N'2025-12-17T18:00:00.0000000' AS DateTime2), 176.0000, 30, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2230, CAST(N'2025-12-17T21:00:00.0000000' AS DateTime2), 180.0000, 2, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2231, CAST(N'2025-12-17T23:30:00.0000000' AS DateTime2), 160.0000, 26, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2232, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 193.0000, 26, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2233, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 244.0000, 26, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2234, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 224.0000, 26, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2235, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 224.0000, 26, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2236, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 215.0000, 26, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2237, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 231.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2238, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 166.0000, 5, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2239, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 163.0000, 5, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2240, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 244.0000, 5, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2241, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 185.0000, 4, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2242, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 216.0000, 4, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2243, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 216.0000, 4, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2244, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 189.0000, 3, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2245, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 230.0000, 3, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2246, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 169.0000, 2, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2247, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 181.0000, 30, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2248, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 242.0000, 27, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2249, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 168.0000, 27, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2250, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 179.0000, 28, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2251, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 240.0000, 28, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2252, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 170.0000, 28, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2253, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 199.0000, 1, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2254, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 232.0000, 1, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2255, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 170.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2256, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 185.0000, 1, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2257, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 150.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2258, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 227.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2259, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 201.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2260, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 197.0000, 29, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2261, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 150.0000, 29, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2262, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 225.0000, 1, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2263, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 224.0000, 5, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2264, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 229.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2265, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 197.0000, 2, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2266, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 225.0000, 26, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2267, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 203.0000, 26, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2268, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 165.0000, 4, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2269, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 198.0000, 4, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2270, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 221.0000, 27, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2271, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 179.0000, 27, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2272, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 185.0000, 5, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2273, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 221.0000, 27, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2274, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 161.0000, 3, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2275, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 246.0000, 28, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2276, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 182.0000, 1, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2277, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 187.0000, 3, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2278, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 175.0000, 27, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2279, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 215.0000, 26, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2280, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 152.0000, 30, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2281, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 197.0000, 5, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2282, CAST(N'2025-12-18T12:00:00.0000000' AS DateTime2), 187.0000, 3, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2283, CAST(N'2025-12-18T15:00:00.0000000' AS DateTime2), 235.0000, 29, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2284, CAST(N'2025-12-18T18:00:00.0000000' AS DateTime2), 159.0000, 4, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2285, CAST(N'2025-12-18T21:00:00.0000000' AS DateTime2), 203.0000, 27, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2286, CAST(N'2025-12-18T23:30:00.0000000' AS DateTime2), 216.0000, 5, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2287, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 191.0000, 26, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2288, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 204.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2289, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 231.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2290, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 167.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2291, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 172.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2292, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 186.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2293, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 204.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2294, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 164.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2295, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 205.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2296, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 203.0000, 3, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2297, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 162.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2298, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 185.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2299, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 232.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2300, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 230.0000, 2, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2301, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 180.0000, 2, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2302, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 169.0000, 30, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2303, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 213.0000, 30, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2304, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 187.0000, 30, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2305, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 198.0000, 30, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2306, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 236.0000, 30, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2307, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 232.0000, 27, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2308, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 168.0000, 27, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2309, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 209.0000, 27, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2310, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 206.0000, 27, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2311, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 210.0000, 28, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2312, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 153.0000, 28, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2313, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 182.0000, 28, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2314, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 155.0000, 1, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2315, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 154.0000, 1, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2316, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 188.0000, 29, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2317, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 214.0000, 1, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2318, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 248.0000, 29, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2319, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 186.0000, 29, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2320, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 247.0000, 28, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2321, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 170.0000, 28, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2322, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 240.0000, 30, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2323, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 187.0000, 30, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2324, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 159.0000, 3, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2325, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 168.0000, 3, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2326, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 173.0000, 5, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2327, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 169.0000, 29, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2328, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 199.0000, 2, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2329, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 163.0000, 30, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2330, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 203.0000, 4, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2331, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 243.0000, 26, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2332, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 163.0000, 4, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2333, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 197.0000, 28, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2334, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 155.0000, 1, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2335, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 229.0000, 29, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2336, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 193.0000, 2, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2337, CAST(N'2025-12-19T12:00:00.0000000' AS DateTime2), 243.0000, 1, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2338, CAST(N'2025-12-19T15:00:00.0000000' AS DateTime2), 220.0000, 28, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2339, CAST(N'2025-12-19T18:00:00.0000000' AS DateTime2), 181.0000, 30, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2340, CAST(N'2025-12-19T21:00:00.0000000' AS DateTime2), 226.0000, 2, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2341, CAST(N'2025-12-19T23:30:00.0000000' AS DateTime2), 170.0000, 26, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2342, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 215.0000, 26, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2343, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 236.0000, 26, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2344, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 172.0000, 26, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2345, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 150.0000, 26, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2346, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 196.0000, 26, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2347, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 178.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2348, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 204.0000, 5, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2349, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 193.0000, 5, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2350, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 217.0000, 5, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2351, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 161.0000, 4, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2352, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 183.0000, 4, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2353, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 187.0000, 4, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2354, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 218.0000, 3, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2355, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 172.0000, 3, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2356, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 208.0000, 2, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2357, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 170.0000, 30, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2358, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 224.0000, 27, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2359, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 182.0000, 27, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2360, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 194.0000, 28, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2361, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 202.0000, 28, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2362, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 193.0000, 28, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2363, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 176.0000, 1, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2364, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 184.0000, 1, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2365, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 222.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2366, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 230.0000, 1, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2367, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 170.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2368, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 193.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2369, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 221.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2370, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 154.0000, 29, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2371, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 155.0000, 29, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2372, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 191.0000, 1, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2373, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 163.0000, 5, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2374, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 198.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2375, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 201.0000, 2, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2376, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 154.0000, 26, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2377, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 248.0000, 26, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2378, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 178.0000, 4, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2379, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 156.0000, 4, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2380, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 242.0000, 27, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2381, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 195.0000, 27, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2382, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 186.0000, 5, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2383, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 221.0000, 27, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2384, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 234.0000, 3, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2385, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 190.0000, 28, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2386, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 226.0000, 1, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2387, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 225.0000, 3, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2388, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 194.0000, 27, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2389, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 173.0000, 26, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2390, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 184.0000, 30, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2391, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 220.0000, 5, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2392, CAST(N'2025-12-20T12:00:00.0000000' AS DateTime2), 162.0000, 3, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2393, CAST(N'2025-12-20T15:00:00.0000000' AS DateTime2), 199.0000, 29, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2394, CAST(N'2025-12-20T18:00:00.0000000' AS DateTime2), 187.0000, 4, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2395, CAST(N'2025-12-20T21:00:00.0000000' AS DateTime2), 247.0000, 27, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2396, CAST(N'2025-12-20T23:30:00.0000000' AS DateTime2), 225.0000, 5, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2397, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 180.0000, 26, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2398, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 229.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2399, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 169.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2400, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 155.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2401, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 181.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2402, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 188.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2403, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 236.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2404, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 181.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2405, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 247.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2406, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 235.0000, 3, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2407, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 221.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2408, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 177.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2409, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 245.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2410, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 183.0000, 2, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2411, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 229.0000, 2, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2412, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 222.0000, 30, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2413, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 227.0000, 30, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2414, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 243.0000, 30, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2415, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 211.0000, 30, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2416, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 248.0000, 30, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2417, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 180.0000, 27, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2418, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 248.0000, 27, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2419, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 228.0000, 27, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2420, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 185.0000, 27, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2421, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 243.0000, 28, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2422, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 247.0000, 28, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2423, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 197.0000, 28, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2424, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 228.0000, 1, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2425, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 192.0000, 1, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2426, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 158.0000, 29, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2427, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 168.0000, 1, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2428, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 236.0000, 29, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2429, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 152.0000, 29, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2430, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 170.0000, 28, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2431, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 214.0000, 28, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2432, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 156.0000, 30, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2433, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 175.0000, 30, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2434, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 242.0000, 3, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2435, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 165.0000, 3, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2436, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 237.0000, 5, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2437, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 234.0000, 29, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2438, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 246.0000, 2, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2439, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 230.0000, 30, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2440, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 246.0000, 4, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2441, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 240.0000, 26, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2442, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 230.0000, 4, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2443, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 227.0000, 28, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2444, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 188.0000, 1, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2445, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 189.0000, 29, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2446, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 167.0000, 2, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2447, CAST(N'2025-12-21T12:00:00.0000000' AS DateTime2), 245.0000, 1, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2448, CAST(N'2025-12-21T15:00:00.0000000' AS DateTime2), 186.0000, 28, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2449, CAST(N'2025-12-21T18:00:00.0000000' AS DateTime2), 249.0000, 30, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2450, CAST(N'2025-12-21T21:00:00.0000000' AS DateTime2), 157.0000, 2, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2451, CAST(N'2025-12-21T23:30:00.0000000' AS DateTime2), 217.0000, 26, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2452, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 167.0000, 26, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2453, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 184.0000, 26, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2454, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 162.0000, 26, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2455, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 178.0000, 26, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2456, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 215.0000, 26, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2457, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 242.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2458, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 167.0000, 5, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2459, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 185.0000, 5, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2460, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 239.0000, 5, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2461, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 166.0000, 4, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2462, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 159.0000, 4, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2463, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 159.0000, 4, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2464, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 175.0000, 3, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2465, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 201.0000, 3, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2466, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 225.0000, 2, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2467, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 210.0000, 30, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2468, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 186.0000, 27, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2469, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 225.0000, 27, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2470, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 204.0000, 28, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2471, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 150.0000, 28, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2472, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 172.0000, 28, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2473, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 237.0000, 1, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2474, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 172.0000, 1, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2475, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 243.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2476, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 211.0000, 1, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2477, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 177.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2478, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 244.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2479, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 165.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2480, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 179.0000, 29, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2481, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 172.0000, 29, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2482, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 164.0000, 1, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2483, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 192.0000, 5, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2484, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 207.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2485, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 213.0000, 2, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2486, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 153.0000, 26, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2487, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 239.0000, 26, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2488, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 168.0000, 4, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2489, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 164.0000, 4, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2490, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 203.0000, 27, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2491, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 227.0000, 27, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2492, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 243.0000, 5, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2493, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 153.0000, 27, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2494, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 222.0000, 3, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2495, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 235.0000, 28, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2496, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 236.0000, 1, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2497, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 179.0000, 3, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2498, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 168.0000, 27, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2499, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 172.0000, 26, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2500, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 228.0000, 30, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2501, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 181.0000, 5, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2502, CAST(N'2025-12-22T12:00:00.0000000' AS DateTime2), 218.0000, 3, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2503, CAST(N'2025-12-22T15:00:00.0000000' AS DateTime2), 185.0000, 29, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2504, CAST(N'2025-12-22T18:00:00.0000000' AS DateTime2), 217.0000, 4, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2505, CAST(N'2025-12-22T21:00:00.0000000' AS DateTime2), 203.0000, 27, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2506, CAST(N'2025-12-22T23:30:00.0000000' AS DateTime2), 150.0000, 5, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2507, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 239.0000, 26, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2508, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 216.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2509, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 213.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2510, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 185.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2511, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 237.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2512, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 173.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2513, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 179.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2514, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 239.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2515, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 175.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2516, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 186.0000, 3, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2517, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 245.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2518, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 187.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2519, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 172.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2520, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 230.0000, 2, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2521, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 165.0000, 2, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2522, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 175.0000, 30, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2523, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 178.0000, 30, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2524, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 221.0000, 30, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2525, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 212.0000, 30, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2526, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 247.0000, 30, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2527, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 157.0000, 27, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2528, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 200.0000, 27, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2529, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 195.0000, 27, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2530, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 229.0000, 27, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2531, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 224.0000, 28, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2532, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 248.0000, 28, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2533, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 206.0000, 28, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2534, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 249.0000, 1, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2535, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 152.0000, 1, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2536, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 205.0000, 29, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2537, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 200.0000, 1, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2538, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 179.0000, 29, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2539, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 221.0000, 29, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2540, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 169.0000, 28, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2541, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 177.0000, 28, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2542, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 247.0000, 30, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2543, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 177.0000, 30, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2544, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 153.0000, 3, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2545, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 240.0000, 3, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2546, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 204.0000, 5, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2547, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 240.0000, 29, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2548, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 159.0000, 2, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2549, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 191.0000, 30, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2550, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 234.0000, 4, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2551, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 162.0000, 26, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2552, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 247.0000, 4, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2553, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 230.0000, 28, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2554, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 217.0000, 1, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2555, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 152.0000, 29, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2556, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 205.0000, 2, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2557, CAST(N'2025-12-23T12:00:00.0000000' AS DateTime2), 208.0000, 1, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2558, CAST(N'2025-12-23T15:00:00.0000000' AS DateTime2), 230.0000, 28, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2559, CAST(N'2025-12-23T18:00:00.0000000' AS DateTime2), 220.0000, 30, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2560, CAST(N'2025-12-23T21:00:00.0000000' AS DateTime2), 164.0000, 2, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2561, CAST(N'2025-12-23T23:30:00.0000000' AS DateTime2), 238.0000, 26, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2562, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 180.0000, 26, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2563, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 240.0000, 26, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2564, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 243.0000, 26, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2565, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 177.0000, 26, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2566, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 226.0000, 26, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2567, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 217.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2568, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 162.0000, 5, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2569, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 247.0000, 5, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2570, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 183.0000, 5, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2571, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 246.0000, 4, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2572, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 175.0000, 4, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2573, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 176.0000, 4, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2574, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 166.0000, 3, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2575, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 168.0000, 3, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2576, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 197.0000, 2, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2577, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 150.0000, 30, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2578, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 178.0000, 27, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2579, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 221.0000, 27, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2580, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 173.0000, 28, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2581, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 157.0000, 28, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2582, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 200.0000, 28, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2583, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 184.0000, 1, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2584, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 248.0000, 1, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2585, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 235.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2586, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 184.0000, 1, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2587, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 219.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2588, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 230.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2589, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 175.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2590, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 200.0000, 29, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2591, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 228.0000, 29, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2592, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 165.0000, 1, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2593, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 207.0000, 5, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2594, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 231.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2595, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 161.0000, 2, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2596, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 175.0000, 26, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2597, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 209.0000, 26, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2598, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 178.0000, 4, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2599, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 198.0000, 4, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2600, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 174.0000, 27, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2601, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 188.0000, 27, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2602, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 201.0000, 5, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2603, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 222.0000, 27, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2604, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 227.0000, 3, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2605, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 191.0000, 28, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2606, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 195.0000, 1, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2607, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 158.0000, 3, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2608, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 244.0000, 27, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2609, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 247.0000, 26, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2610, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 204.0000, 30, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2611, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 182.0000, 5, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2612, CAST(N'2025-12-24T12:00:00.0000000' AS DateTime2), 242.0000, 3, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2613, CAST(N'2025-12-24T15:00:00.0000000' AS DateTime2), 247.0000, 29, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2614, CAST(N'2025-12-24T18:00:00.0000000' AS DateTime2), 153.0000, 4, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2615, CAST(N'2025-12-24T21:00:00.0000000' AS DateTime2), 237.0000, 27, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2616, CAST(N'2025-12-24T23:30:00.0000000' AS DateTime2), 230.0000, 5, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2617, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 193.0000, 26, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2618, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 200.0000, 5, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2619, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 229.0000, 5, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2620, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 195.0000, 4, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2621, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 190.0000, 4, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2622, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 204.0000, 4, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2623, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 228.0000, 3, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2624, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 236.0000, 3, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2625, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 172.0000, 3, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2626, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 171.0000, 3, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2627, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 160.0000, 2, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2628, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 204.0000, 2, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2629, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 240.0000, 2, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2630, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 222.0000, 2, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2631, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 223.0000, 2, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2632, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 183.0000, 30, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2633, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 180.0000, 30, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2634, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 186.0000, 30, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2635, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 210.0000, 30, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2636, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 184.0000, 30, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2637, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 228.0000, 27, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2638, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 235.0000, 27, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2639, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 246.0000, 27, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2640, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 150.0000, 27, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2641, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 153.0000, 28, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2642, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 194.0000, 28, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2643, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 241.0000, 28, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2644, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 188.0000, 1, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2645, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 174.0000, 1, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2646, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 230.0000, 29, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2647, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 238.0000, 1, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2648, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 192.0000, 29, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2649, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 195.0000, 29, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2650, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 237.0000, 28, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2651, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 201.0000, 28, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2652, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 220.0000, 30, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2653, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 169.0000, 30, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2654, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 217.0000, 3, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2655, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 187.0000, 3, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2656, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 158.0000, 5, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2657, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 210.0000, 29, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2658, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 243.0000, 2, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2659, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 151.0000, 30, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2660, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 237.0000, 4, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2661, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 178.0000, 26, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2662, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 225.0000, 4, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2663, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 227.0000, 28, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2664, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 189.0000, 1, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2665, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 197.0000, 29, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2666, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 181.0000, 2, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2667, CAST(N'2025-12-25T12:00:00.0000000' AS DateTime2), 163.0000, 1, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2668, CAST(N'2025-12-25T15:00:00.0000000' AS DateTime2), 181.0000, 28, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2669, CAST(N'2025-12-25T18:00:00.0000000' AS DateTime2), 241.0000, 30, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2670, CAST(N'2025-12-25T21:00:00.0000000' AS DateTime2), 211.0000, 2, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2671, CAST(N'2025-12-25T23:30:00.0000000' AS DateTime2), 236.0000, 26, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2672, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 246.0000, 26, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2673, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 196.0000, 26, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2674, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 227.0000, 26, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2675, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 215.0000, 26, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2676, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 209.0000, 26, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2677, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 197.0000, 5, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2678, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 159.0000, 5, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2679, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 196.0000, 5, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2680, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 226.0000, 5, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2681, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 193.0000, 4, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2682, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 226.0000, 4, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2683, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 196.0000, 4, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2684, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 210.0000, 3, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2685, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 185.0000, 3, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2686, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 248.0000, 2, 8)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2687, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 223.0000, 30, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2688, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 214.0000, 27, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2689, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 175.0000, 27, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2690, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 182.0000, 28, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2691, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 170.0000, 28, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2692, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 165.0000, 28, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2693, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 227.0000, 1, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2694, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 239.0000, 1, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2695, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 210.0000, 1, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2696, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 224.0000, 1, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2697, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 186.0000, 29, 1)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2698, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 245.0000, 29, 2)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2699, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 205.0000, 29, 3)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2700, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 222.0000, 29, 6)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2701, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 162.0000, 29, 7)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2702, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 211.0000, 1, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2703, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 176.0000, 5, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2704, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 218.0000, 2, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2705, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 151.0000, 2, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2706, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 237.0000, 26, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2707, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 200.0000, 26, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2708, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 225.0000, 4, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2709, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 154.0000, 4, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2710, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 192.0000, 27, 13)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2711, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 171.0000, 27, 14)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2712, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 184.0000, 5, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2713, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 238.0000, 27, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2714, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 170.0000, 3, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2715, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 198.0000, 28, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2716, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 190.0000, 1, 15)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2717, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 190.0000, 3, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2718, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 168.0000, 27, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2719, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 196.0000, 26, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2720, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 247.0000, 30, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2721, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 180.0000, 5, 20)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2722, CAST(N'2025-12-26T12:00:00.0000000' AS DateTime2), 239.0000, 3, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2723, CAST(N'2025-12-26T15:00:00.0000000' AS DateTime2), 198.0000, 29, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2724, CAST(N'2025-12-26T18:00:00.0000000' AS DateTime2), 197.0000, 4, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2725, CAST(N'2025-12-26T21:00:00.0000000' AS DateTime2), 234.0000, 27, 21)
GO
INSERT [dbo].[Showings] ([ShowingID], [ShowTime], [TicketPrice], [MovieID], [HallID]) VALUES (2726, CAST(N'2025-12-26T23:30:00.0000000' AS DateTime2), 216.0000, 5, 21)
GO
SET IDENTITY_INSERT [dbo].[Showings] OFF
GO
SET IDENTITY_INSERT [dbo].[Tickets] ON 
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1033, N'E1', N'booked', 2, 1962, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1034, N'E1', N'booked', 2, 1965, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1035, N'E1', N'booked', 2, 1969, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1036, N'E1', N'booked', 2, 1973, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1037, N'E1', N'booked', 2, 1977, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1038, N'E1', N'booked', 2, 2032, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1039, N'E1', N'booked', 2, 2035, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1040, N'E1', N'booked', 2, 2039, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1041, N'E1', N'booked', 2, 2013, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1042, N'E1', N'booked', 2, 2017, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1043, N'E1', N'booked', 2, 2072, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1044, N'E1', N'booked', 2, 2075, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1045, N'E1', N'booked', 2, 2079, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1046, N'E1', N'booked', 2, 2083, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1047, N'E1', N'booked', 2, 2087, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1048, N'E1', N'booked', 2, 2142, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1049, N'E1', N'booked', 2, 2145, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1050, N'E1', N'booked', 2, 2149, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1051, N'E1', N'booked', 2, 2123, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1052, N'E1', N'booked', 2, 2127, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1053, N'E1', N'booked', 2, 2182, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1054, N'E1', N'booked', 2, 2185, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1055, N'E1', N'booked', 2, 2189, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1056, N'E1', N'booked', 2, 2193, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1057, N'E1', N'booked', 2, 2197, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1058, N'E1', N'booked', 2, 2252, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1059, N'E1', N'booked', 2, 2255, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1060, N'E1', N'booked', 2, 2259, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1061, N'E1', N'booked', 2, 2233, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1062, N'E1', N'booked', 2, 2237, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1063, N'E1', N'booked', 2, 2292, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1064, N'E1', N'booked', 2, 2295, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1065, N'E1', N'booked', 2, 2299, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1066, N'E1', N'booked', 2, 2303, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1067, N'E1', N'booked', 2, 2307, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1068, N'E1', N'booked', 2, 2362, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1069, N'E1', N'booked', 2, 2365, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1070, N'E1', N'booked', 2, 2369, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1071, N'E1', N'booked', 2, 2343, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1072, N'E1', N'booked', 2, 2347, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1073, N'E1', N'booked', 2, 2402, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1074, N'E1', N'booked', 2, 2405, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1075, N'E1', N'booked', 2, 2409, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1076, N'E1', N'booked', 2, 2413, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1077, N'E1', N'booked', 2, 2417, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1078, N'E1', N'booked', 2, 2472, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1079, N'E1', N'booked', 2, 2475, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1080, N'E1', N'booked', 2, 2479, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1081, N'E1', N'booked', 2, 2453, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1082, N'E1', N'booked', 2, 2457, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1083, N'E1', N'booked', 2, 2512, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1084, N'E1', N'booked', 2, 2515, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1085, N'E1', N'booked', 2, 2519, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1086, N'E1', N'booked', 2, 2523, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1087, N'E1', N'booked', 2, 2527, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1088, N'E1', N'booked', 2, 2582, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1089, N'E1', N'booked', 2, 2585, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1090, N'E1', N'booked', 2, 2589, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1091, N'E1', N'booked', 2, 2563, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1092, N'E1', N'booked', 2, 2567, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1093, N'E1', N'booked', 2, 2622, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1094, N'E1', N'booked', 2, 2625, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1095, N'E1', N'booked', 2, 2629, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1096, N'E1', N'booked', 2, 2633, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1097, N'E1', N'booked', 2, 2637, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1098, N'E1', N'booked', 2, 2692, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1099, N'E1', N'booked', 2, 2695, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1100, N'E1', N'booked', 2, 2699, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1101, N'E1', N'booked', 2, 2673, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
GO
INSERT [dbo].[Tickets] ([TicketID], [SeatNumber], [Status], [UserID], [ShowingID], [OrderID], [SeatID], [ReservationID], [PurchaseDate]) VALUES (1102, N'E1', N'booked', 2, 2677, NULL, 41, NULL, CAST(N'2025-12-13T02:55:32.7033333' AS DateTime2))
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
/****** Object:  Index [UQ_Genres_Name]    Script Date: 13.12.2025 03:47:41 ******/
ALTER TABLE [dbo].[Genres] ADD  CONSTRAINT [UQ_Genres_Name] UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Genres_Movies]    Script Date: 13.12.2025 03:47:41 ******/
ALTER TABLE [dbo].[Genres_Movies] ADD  CONSTRAINT [UQ_Genres_Movies] UNIQUE NONCLUSTERED 
(
	[GenreID] ASC,
	[MovieID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Seats_Hall_Row_Seat]    Script Date: 13.12.2025 03:47:41 ******/
ALTER TABLE [dbo].[Seats] ADD  CONSTRAINT [UQ_Seats_Hall_Row_Seat] UNIQUE NONCLUSTERED 
(
	[HallID] ASC,
	[RowLabel] ASC,
	[SeatNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Showings_Hall_ShowTime]    Script Date: 13.12.2025 03:47:41 ******/
ALTER TABLE [dbo].[Showings] ADD  CONSTRAINT [UQ_Showings_Hall_ShowTime] UNIQUE NONCLUSTERED 
(
	[HallID] ASC,
	[ShowTime] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_Tickets_Showing_Seat]    Script Date: 13.12.2025 03:47:41 ******/
ALTER TABLE [dbo].[Tickets] ADD  CONSTRAINT [UQ_Tickets_Showing_Seat] UNIQUE NONCLUSTERED 
(
	[ShowingID] ASC,
	[SeatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [UQ_User_Campaign]    Script Date: 13.12.2025 03:47:41 ******/
ALTER TABLE [dbo].[User_Campaigns] ADD  CONSTRAINT [UQ_User_Campaign] UNIQUE NONCLUSTERED 
(
	[UserID] ASC,
	[CampaignID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ_Users_Email]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_LoginUser]    Script Date: 13.12.2025 03:47:41 ******/
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
/****** Object:  StoredProcedure [dbo].[sp_RegisterUser]    Script Date: 13.12.2025 03:47:41 ******/
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
