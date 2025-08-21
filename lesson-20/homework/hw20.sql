1. SELECT DISTINCT s.CustomerName
FROM #Sales s
WHERE EXISTS (
    SELECT 1
    FROM #Sales x
    WHERE x.CustomerName = s.CustomerName
      AND x.SaleDate >= '2024-03-01'
      AND x.SaleDate < '2024-04-01'
);
2. SELECT TOP 1 Product
FROM #Sales
GROUP BY Product
ORDER BY SUM(Quantity * Price) DESC;
3. SELECT MAX(SaleAmount) AS SecondHighestSale
FROM (
    SELECT DISTINCT Quantity * Price AS SaleAmount
    FROM #Sales
) t
WHERE SaleAmount < (SELECT MAX(Quantity * Price) FROM #Sales);
4. SELECT SaleMonth, SUM(TotalQty) AS TotalQuantity
FROM (
    SELECT MONTH(SaleDate) AS SaleMonth, Quantity AS TotalQty
    FROM #Sales
) t
GROUP BY SaleMonth;
5. SELECT DISTINCT s1.CustomerName
FROM #Sales s1
WHERE EXISTS (
    SELECT 1
    FROM #Sales s2
    WHERE s1.CustomerName <> s2.CustomerName
      AND s1.Product = s2.Product
);
6. SELECT Name,
       SUM(CASE WHEN Fruit = 'Apple' THEN 1 ELSE 0 END) AS Apple,
       SUM(CASE WHEN Fruit = 'Orange' THEN 1 ELSE 0 END) AS Orange,
       SUM(CASE WHEN Fruit = 'Banana' THEN 1 ELSE 0 END) AS Banana
FROM Fruits
GROUP BY Name;
7. WITH CTE AS (
    SELECT ParentId, ChildID
    FROM Family
    UNION ALL
    SELECT f.ParentId, c.ChildID
    FROM Family f
    JOIN CTE c ON f.ChildID = c.ParentId
)
SELECT DISTINCT ParentId AS PID, ChildID AS CHID
FROM CTE
ORDER BY PID, CHID;
8. SELECT o.CustomerID, o.OrderID, o.DeliveryState, o.Amount
FROM #Orders o
WHERE o.DeliveryState = 'TX'
  AND EXISTS (
      SELECT 1
      FROM #Orders x
      WHERE x.CustomerID = o.CustomerID
        AND x.DeliveryState = 'CA'
  );
9. UPDATE r
SET fullname = SUBSTRING(r.address, CHARINDEX('name=', r.address) + 5,
                         CHARINDEX(' ', r.address + ' ', CHARINDEX('name=', r.address) + 5) -
                         (CHARINDEX('name=', r.address) + 5))
FROM #residents r
WHERE r.fullname IS NULL OR r.fullname = '';
10. WITH Paths AS (
    SELECT RouteID, DepartureCity, ArrivalCity, Cost, 
           CAST(DepartureCity + ' - ' + ArrivalCity AS VARCHAR(200)) AS Route
    FROM #Routes
    WHERE DepartureCity = 'Tashkent'
    
    UNION ALL
    
    SELECT r.RouteID, p.DepartureCity, r.ArrivalCity, p.Cost + r.Cost,
           CAST(p.Route + ' - ' + r.ArrivalCity AS VARCHAR(200))
    FROM Paths p
    JOIN #Routes r ON p.ArrivalCity = r.DepartureCity
    WHERE p.ArrivalCity <> 'Khorezm'
)
SELECT Route, Cost
FROM Paths
WHERE ArrivalCity = 'Khorezm'
ORDER BY Cost;
11. SELECT ID, Vals,
       ROW_NUMBER() OVER (PARTITION BY grp ORDER BY ID) AS rn
FROM (
    SELECT *,
           SUM(CASE WHEN Vals='Product' THEN 1 ELSE 0 END) 
           OVER (ORDER BY ID) AS grp
    FROM #RankingPuzzle
) t;
12. SELECT e.EmployeeName, e.Department, e.SalesAmount
FROM #EmployeeSales e
WHERE e.SalesAmount > (
    SELECT AVG(x.SalesAmount)
    FROM #EmployeeSales x
    WHERE x.Department = e.Department
      AND x.SalesMonth = e.SalesMonth
      AND x.SalesYear = e.SalesYear
);
13. SELECT DISTINCT e.EmployeeName, e.SalesMonth, e.SalesYear
FROM #EmployeeSales e
WHERE EXISTS (
    SELECT 1
    FROM #EmployeeSales x
    WHERE x.SalesMonth = e.SalesMonth
      AND x.SalesYear = e.SalesYear
    GROUP BY x.SalesMonth, x.SalesYear
    HAVING e.SalesAmount = MAX(x.SalesAmount)
);
14. SELECT DISTINCT e.EmployeeName
FROM #EmployeeSales e
WHERE NOT EXISTS (
    SELECT DISTINCT SalesMonth
    FROM #EmployeeSales
    WHERE NOT EXISTS (
        SELECT 1
        FROM #EmployeeSales x
        WHERE x.EmployeeName = e.EmployeeName
          AND x.SalesMonth = #EmployeeSales.SalesMonth
          AND x.SalesYear = #EmployeeSales.SalesYear
    )
);
15. SELECT Name
FROM Products
WHERE Price > (SELECT AVG(Price) FROM Products);
16. SELECT Name
FROM Products
WHERE Stock < (SELECT MAX(Stock) FROM Products);
17. SELECT Name
FROM Products
WHERE Category = (SELECT Category FROM Products WHERE Name = 'Laptop');
18. SELECT Name
FROM Products
WHERE Price > (
    SELECT MIN(Price)
    FROM Products
    WHERE Category = 'Electronics'
);
19. SELECT p.Name, p.Category, p.Price
FROM Products p
WHERE p.Price > (
    SELECT AVG(x.Price)
    FROM Products x
    WHERE x.Category = p.Category
);
20. SELECT DISTINCT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID;
21. SELECT p.Name
FROM Products p
JOIN Orders o ON p.ProductID = o.ProductID
GROUP BY p.Name
HAVING SUM(o.Quantity) > (
    SELECT AVG(TotalQty)
    FROM (
        SELECT SUM(Quantity) AS TotalQty
        FROM Orders
        GROUP BY ProductID
    ) t
);

