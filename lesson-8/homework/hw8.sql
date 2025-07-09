1. SELECT Category, COUNT(*) AS TotalProducts
FROM Products
GROUP BY Category;
2. SELECT AVG(Price) AS AvgElectronicsPrice
FROM Products
WHERE Category = 'Electronics';
3. SELECT *
FROM Customers
WHERE City LIKE 'L%';
4. SELECT ProductName
FROM Products
WHERE ProductName LIKE '%er';
5. SELECT *
FROM Customers
WHERE Country LIKE '%A';
6. SELECT MAX(Price) AS HighestPrice
FROM Products;
7. SELECT ProductName,
       StockQuantity,
       CASE 
           WHEN StockQuantity < 30 THEN 'Low Stock'
           ELSE 'Sufficient'
       END AS StockStatus
FROM Products;
8. SELECT Country, COUNT(*) AS TotalCustomers
FROM Customers
GROUP BY Country;
9. SELECT MIN(Quantity) AS MinQty, MAX(Quantity) AS MaxQty
FROM Orders;
10. SELECT DISTINCT o.CustomerID
FROM Orders o
WHERE OrderDate BETWEEN '2023-01-01' AND '2023-01-31'
AND o.CustomerID NOT IN (
    SELECT CustomerID FROM Invoices
    WHERE InvoiceDate BETWEEN '2023-01-01' AND '2023-01-31'
);
11. SELECT ProductName FROM Products
UNION ALL
SELECT ProductName FROM Products_Discounted;
12. SELECT ProductName FROM Products
UNION
SELECT ProductName FROM Products_Discounted;
13. SELECT YEAR(OrderDate) AS OrderYear, AVG(TotalAmount) AS AvgOrderAmount
FROM Orders
GROUP BY YEAR(OrderDate);
14. SELECT ProductName, Price,
       CASE 
           WHEN Price < 100 THEN 'Low'
           WHEN Price BETWEEN 100 AND 500 THEN 'Mid'
           ELSE 'High'
       END AS PriceGroup
FROM Products;
15. SELECT district_name, 
       [2012], [2013]
INTO Population_Each_Year
FROM (
    SELECT district_name, population, year
    FROM city_population
) AS SourceTable
PIVOT (
    SUM(population)
    FOR year IN ([2012], [2013])
) AS PivotTable;
16. SELECT ProductID, SUM(SaleAmount) AS TotalSales
FROM Sales
GROUP BY ProductID;
17. SELECT ProductName
FROM Products
WHERE ProductName LIKE '%oo%';
18. SELECT year, 
       [Bektemir], [Chilonzor], [Yakkasaroy]
INTO Population_Each_City
FROM (
    SELECT year, district_name, population
    FROM city_population
    WHERE district_name IN ('Bektemir', 'Chilonzor', 'Yakkasaroy')
) AS SourceTable
PIVOT (
    SUM(population)
    FOR district_name IN ([Bektemir], [Chilonzor], [Yakkasaroy])
) AS PivotResult;
19. SELECT TOP 3 CustomerID, SUM(TotalAmount) AS TotalSpent
FROM Invoices
GROUP BY CustomerID
ORDER BY TotalSpent DESC;
20. SELECT district_name, '2012' AS Year, [2012] AS Population
FROM Population_Each_Year
UNION ALL
SELECT district_name, '2013' AS Year, [2013] AS Population
FROM Population_Each_Year;
21. SELECT p.ProductName, COUNT(s.SaleID) AS TimesSold
FROM Products p
JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductName;
22. SELECT year, 'Bektemir' AS district_name, [Bektemir] AS population
FROM Population_Each_City
UNION ALL
SELECT year, 'Chilonzor', [Chilonzor]
FROM Population_Each_City
UNION ALL
SELECT year, 'Yakkasaroy', [Yakkasaroy]
FROM Population_Each_City;

