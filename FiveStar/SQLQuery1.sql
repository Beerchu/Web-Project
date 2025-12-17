USE CinemaDB_Extended;
GO

;WITH N AS (
    SELECT TOP (5000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.all_objects a CROSS JOIN sys.all_objects b
),
HallStats AS (
    SELECT
        h.HallID,
        h.HallType,
        h.Capacity,
        ExistingCount = (
            SELECT COUNT(*)
            FROM dbo.Seats s
            WHERE s.HallID = h.HallID AND s.IsActive = 1
        ),
        ExistingMaxSeatNo = (
            SELECT MAX(s.SeatNumber)
            FROM dbo.Seats s
            WHERE s.HallID = h.HallID AND s.IsActive = 1
        )
    FROM dbo.Halls h
),
NeedFix AS (
    SELECT
        hs.HallID,
        hs.HallType,
        hs.Capacity,
        hs.ExistingCount,
        SeatsPerRow =
            CASE
                WHEN hs.ExistingMaxSeatNo IS NOT NULL THEN hs.ExistingMaxSeatNo
                ELSE
                    CASE
                        WHEN hs.HallType = 'VIP' AND hs.Capacity <= 60 THEN 10
                        WHEN hs.Capacity >= 120 THEN 20
                        WHEN hs.Capacity >= 100 THEN 20
                        WHEN hs.Capacity >= 80  THEN 16
                        WHEN hs.Capacity >= 60  THEN 12
                        ELSE 10
                    END
            END
    FROM HallStats hs
    WHERE hs.ExistingCount < hs.Capacity
),
HallRows AS (
    SELECT
        HallID,
        HallType,
        Capacity,
        SeatsPerRow,
        (Capacity + SeatsPerRow - 1) / SeatsPerRow AS [RowCount]
    FROM NeedFix
),
SeatGen AS (
    SELECT
        r.HallID,
        r.Capacity AS Capacity,                 -- ✅ BUNU EKLEDİK
        RowLabel   = CHAR(64 + rn.n),           -- A, B, C...
        SeatNumber = sn.n,                      -- 1..SeatsPerRow
        SeatType   = CASE WHEN r.HallType='VIP' THEN 'VIP' ELSE 'Standard' END,
        IsActive   = CAST(1 AS bit),
        SeatIndex  = ((rn.n - 1) * r.SeatsPerRow + sn.n)
    FROM HallRows r
    JOIN N rn ON rn.n <= r.[RowCount]
    JOIN N sn ON sn.n <= r.SeatsPerRow
)
INSERT INTO dbo.Seats (HallID, RowLabel, SeatNumber, SeatType, IsActive)
SELECT g.HallID, g.RowLabel, g.SeatNumber, g.SeatType, g.IsActive
FROM SeatGen g
WHERE g.SeatIndex <= g.Capacity
  AND NOT EXISTS (
      SELECT 1
      FROM dbo.Seats s
      WHERE s.HallID = g.HallID
        AND s.RowLabel = g.RowLabel
        AND s.SeatNumber = g.SeatNumber
        AND s.IsActive = 1
  );
GO

-- Kontrol
SELECT 
  h.HallID, h.HallType, h.Capacity,
  COUNT(s.SeatID) AS SeatCount
FROM dbo.Halls h
LEFT JOIN dbo.Seats s 
  ON s.HallID = h.HallID AND s.IsActive = 1
GROUP BY h.HallID, h.HallType, h.Capacity
ORDER BY h.HallID;
GO
