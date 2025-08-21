1. SELECT 
    Id, 
    Dt,
    RIGHT('0' + CAST(MONTH(Dt) AS VARCHAR(2)), 2) AS MonthPrefixedWithZero
FROM Dates;
2. SELECT 
    COUNT(DISTINCT Id) AS Distinct_Ids,
    rID,
    SUM(MaxVal) AS TotalOfMaxVals
FROM (
    SELECT Id, rID, MAX(Vals) AS MaxVal
    FROM MyTabel
    GROUP BY Id, rID
) t
GROUP BY rID;
3. SELECT Id, Vals
FROM TestFixLengths
WHERE LEN(Vals) BETWEEN 6 AND 10;
4. SELECT t.ID, t.Item, t.Vals
FROM TestMaximum t
WHERE t.Vals = (
    SELECT MAX(Vals)
    FROM TestMaximum
    WHERE ID = t.ID
);
5. SELECT Id, SUM(MaxVal) AS SumofMax
FROM (
    SELECT Id, DetailedNumber, MAX(Vals) AS MaxVal
    FROM SumOfMax
    GROUP BY Id, DetailedNumber
) t
GROUP BY Id;
6. SELECT 
    Id, a, b,
    NULLIF(a - b, 0) AS OUTPUT
FROM TheZeroPuzzle;
7. SELECT SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales;
8. SELECT AVG(UnitPrice) AS AvgUnitPrice
FROM Sales;
9. SELECT COUNT(*) AS TotalTransactions
FROM Sales;
10. SELECT MAX(QuantitySold) AS MaxUnitsSold
FROM Sales;
11. SELECT Category, SUM(QuantitySold) AS TotalUnits
FROM Sales
GROUP BY Category;
12. SELECT Region, SUM(QuantitySold * UnitPrice) AS Revenue
FROM Sales
GROUP BY Region;
13. SELECT TOP 1 Product, SUM(QuantitySold * UnitPrice) AS TotalRevenue
FROM Sales
GROUP BY Product
ORDER BY TotalRevenue DESC;
14. SELECT 
    SaleDate,
    SUM(QuantitySold * UnitPrice) AS DailyRevenue,
    SUM(SUM(QuantitySold * UnitPrice)) OVER (ORDER BY SaleDate) AS RunningTotal
FROM Sales
GROUP BY SaleDate
ORDER BY SaleDate;
15. SELECT 
    Category,
    SUM(QuantitySold * UnitPrice) AS CategoryRevenue,
    CAST(100.0 * SUM(QuantitySold * UnitPrice) / 
         SUM(SUM(QuantitySold * UnitPrice)) OVER() AS DECIMAL(5,2)) AS ContributionPercent
FROM Sales
GROUP BY Category;
16. SELECT s.SaleID, s.Product, s.QuantitySold, s.UnitPrice, s.Region, c.CustomerName
FROM Sales s
JOIN Customers c ON s.CustomerID = c.CustomerID;
17. SELECT c.CustomerID, c.CustomerName
FROM Customers c
LEFT JOIN Sales s ON c.CustomerID = s.CustomerID
WHERE s.CustomerID IS NULL;
18. SELECT c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName;
19. SELECT TOP 1 c.CustomerName, SUM(s.QuantitySold * s.UnitPrice) AS TotalRevenue
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName
ORDER BY TotalRevenue DESC;
20. SELECT c.CustomerName, COUNT(s.SaleID) AS TotalSales
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerName;
21. SELECT DISTINCT p.ProductName
FROM Products p
JOIN Sales s ON p.ProductName = s.Product;
22. SELECT TOP 1 ProductName, SellingPrice
FROM Products
ORDER BY SellingPrice DESC;
23. SELECT ProductName, Category, SellingPrice
FROM Products p
WHERE SellingPrice > (
    SELECT AVG(SellingPrice)
    FROM Products
    WHERE Category = p.Category
);

