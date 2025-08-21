1. ;WITH Regions AS (
    SELECT DISTINCT Region FROM #RegionSales
),
Distributors AS (
    SELECT DISTINCT Distributor FROM #RegionSales
),
AllCombos AS (
    SELECT r.Region, d.Distributor
    FROM Regions r
    CROSS JOIN Distributors d
)
SELECT 
    a.Region,
    a.Distributor,
    ISNULL(rs.Sales, 0) AS Sales
FROM AllCombos a
LEFT JOIN #RegionSales rs
    ON a.Region = rs.Region
   AND a.Distributor = rs.Distributor
ORDER BY a.Distributor, a.Region;
2. SELECT e.name
FROM Employee e
JOIN (
    SELECT managerId
    FROM Employee
    WHERE managerId IS NOT NULL
    GROUP BY managerId
    HAVING COUNT(*) >= 5
) m ON e.id = m.managerId;
3. SELECT p.product_name, SUM(o.unit) AS unit
FROM Products p
JOIN Orders o ON p.product_id = o.product_id
WHERE o.order_date >= '2020-02-01' AND o.order_date < '2020-03-01'
GROUP BY p.product_name
HAVING SUM(o.unit) >= 100;
4. ;WITH VendorCounts AS (
    SELECT CustomerID, Vendor, COUNT(*) AS OrderCount
    FROM Orders
    GROUP BY CustomerID, Vendor
),
Ranked AS (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY OrderCount DESC) AS rn
    FROM VendorCounts
)
SELECT CustomerID, Vendor
FROM Ranked
WHERE rn = 1;
5. DECLARE @Check_Prime INT = 91, @i INT = 2, @IsPrime BIT = 1;

WHILE @i <= SQRT(@Check_Prime)
BEGIN
    IF @Check_Prime % @i = 0
    BEGIN
        SET @IsPrime = 0;
        BREAK;
    END
    SET @i += 1;
END

IF @IsPrime = 1
    PRINT 'This number is prime';
ELSE
    PRINT 'This number is not prime';
6. ;WITH LocationCount AS (
    SELECT Device_id, Locations, COUNT(*) AS cnt
    FROM Device
    GROUP BY Device_id, Locations
),
Ranked AS (
    SELECT Device_id, Locations, cnt,
           ROW_NUMBER() OVER (PARTITION BY Device_id ORDER BY cnt DESC) AS rn
    FROM LocationCount
)
SELECT 
    lc.Device_id,
    (SELECT COUNT(DISTINCT Locations) FROM Device d WHERE d.Device_id = lc.Device_id) AS no_of_location,
    r.Locations AS max_signal_location,
    (SELECT COUNT(*) FROM Device d WHERE d.Device_id = lc.Device_id) AS no_of_signals
FROM LocationCount lc
JOIN Ranked r ON lc.Device_id = r.Device_id AND r.rn = 1
GROUP BY lc.Device_id, r.Locations;
7. SELECT EmpID, EmpName, Salary
FROM Employee e
WHERE Salary > (
    SELECT AVG(Salary)
    FROM Employee
    WHERE DeptID = e.DeptID
);
8. ;WITH TicketMatch AS (
    SELECT t.TicketID, COUNT(DISTINCT t.Number) AS matched
    FROM Tickets t
    JOIN Numbers n ON t.Number = n.Number
    GROUP BY t.TicketID
),
TotalWinning AS (
    SELECT SUM(CASE WHEN matched = (SELECT COUNT(*) FROM Numbers) THEN 100
                    WHEN matched > 0 THEN 10
                    ELSE 0 END) AS TotalPrize
    FROM TicketMatch
)
SELECT TotalPrize
FROM TotalWinning;
9. ;WITH UserSpend AS (
    SELECT User_id, Spend_date,
           SUM(CASE WHEN Platform = 'Mobile' THEN Amount ELSE 0 END) AS MobileSpend,
           SUM(CASE WHEN Platform = 'Desktop' THEN Amount ELSE 0 END) AS DesktopSpend
    FROM Spending
    GROUP BY User_id, Spend_date
)
SELECT ROW_NUMBER() OVER (ORDER BY Spend_date, Platform) AS Row,
       Spend_date,
       Platform,
       SUM(Amount) AS Total_Amount,
       COUNT(DISTINCT User_id) AS Total_users
FROM (
    SELECT Spend_date, User_id, 'Mobile' AS Platform, MobileSpend AS Amount
    FROM UserSpend WHERE MobileSpend > 0 AND DesktopSpend = 0
    UNION ALL
    SELECT Spend_date, User_id, 'Desktop', DesktopSpend
    FROM UserSpend WHERE DesktopSpend > 0 AND MobileSpend = 0
    UNION ALL
    SELECT Spend_date, User_id, 'Both', MobileSpend + DesktopSpend
    FROM UserSpend WHERE MobileSpend > 0 AND DesktopSpend > 0
) x
GROUP BY Spend_date, Platform;
10. ;WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL
    SELECT n+1 FROM Numbers WHERE n < (SELECT MAX(Quantity) FROM Grouped)
)
SELECT g.Product, 1 AS Quantity
FROM Grouped g
JOIN Numbers n ON n.n <= g.Quantity
OPTION (MAXRECURSION 0);

