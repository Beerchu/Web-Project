SELECT h.HallID, h.HallType, h.Capacity,
       COUNT(s.SeatID) AS ActualSeats
FROM dbo.Halls h
LEFT JOIN dbo.Seats s ON s.HallID = h.HallID AND s.IsActive = 1
GROUP BY h.HallID, h.HallType, h.Capacity
ORDER BY h.HallID;
