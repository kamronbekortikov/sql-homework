1. WITH Numbers AS (
    SELECT 1 AS Num
    UNION ALL
    SELECT Num + 1
    FROM Numbers
    WHERE Num < 1000
)
SELECT Num
FROM Numbers
OPTION (MAXRECURSION 1000);
2. SELECT e.EmployeeID, e.FirstName, e.LastName, t.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID
) t ON e.EmployeeID = t.EmployeeID;
3. WITH AvgSalary AS (
    SELECT AVG(Salary) AS AvgSal
    FROM Employees
)
SELECT AvgSal FROM AvgSalary;
4. SELECT p.ProductID, p.ProductName, t.MaxSale
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS MaxSale
    FROM Sales
    GROUP BY ProductID
) t ON p.ProductID = t.ProductID;
5. WITH Doubles AS (
    SELECT 1 AS Num
    UNION ALL
    SELECT Num * 2
    FROM Doubles
    WHERE Num * 2 < 1000000
)
SELECT Num FROM Doubles
OPTION (MAXRECURSION 1000);
6. WITH SalesCount AS (
    SELECT EmployeeID, COUNT(*) AS SaleCount
    FROM Sales
    GROUP BY EmployeeID
)
SELECT e.EmployeeID, e.FirstName, e.LastName, SaleCount
FROM SalesCount sc
JOIN Employees e ON sc.EmployeeID = e.EmployeeID
WHERE sc.SaleCount > 5;
7. WITH ProductSales AS (
    SELECT ProductID, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY ProductID
)
SELECT p.ProductName, ps.TotalSales
FROM ProductSales ps
JOIN Products p ON ps.ProductID = p.ProductID
WHERE ps.TotalSales > 500;
8. WITH AvgSal AS (
    SELECT AVG(Salary) AS AvgSalary FROM Employees
)
SELECT e.EmployeeID, e.FirstName, e.LastName, e.Salary
FROM Employees e
CROSS JOIN AvgSal a
WHERE e.Salary > a.AvgSalary;
9. SELECT TOP 5 e.EmployeeID, e.FirstName, e.LastName, t.OrderCount
FROM Employees e
JOIN (
    SELECT EmployeeID, COUNT(*) AS OrderCount
    FROM Sales
    GROUP BY EmployeeID
) t ON e.EmployeeID = t.EmployeeID
ORDER BY t.OrderCount DESC;
10. SELECT p.CategoryID, SUM(s.SalesAmount) AS TotalSales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
GROUP BY p.CategoryID;
11. WITH FactorialCTE AS (
    SELECT Number, CAST(Number AS BIGINT) AS Fact, Number AS N
    FROM Numbers1
    WHERE Number = 1

    UNION ALL

    SELECT n.Number, f.Fact * n.N, n.N - 1
    FROM FactorialCTE f
    JOIN Numbers1 n ON f.Number = n.Number
    WHERE f.N > 1
)
SELECT Number, MAX(Fact) AS Factorial
FROM FactorialCTE
GROUP BY Number;
12. WITH Rec AS (
    SELECT Id, String, 1 AS Pos, SUBSTRING(String,1,1) AS CharVal
    FROM Example
    UNION ALL
    SELECT Id, String, Pos+1, SUBSTRING(String, Pos+1,1)
    FROM Rec
    WHERE Pos < LEN(String)
)
SELECT Id, CharVal
FROM Rec
ORDER BY Id, Pos
OPTION (MAXRECURSION 1000);
13. WITH MonthlySales AS (
    SELECT YEAR(SaleDate) AS Yr, MONTH(SaleDate) AS Mn, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY YEAR(SaleDate), MONTH(SaleDate)
)
SELECT Yr, Mn,
       TotalSales,
       TotalSales - LAG(TotalSales) OVER (ORDER BY Yr, Mn) AS DiffWithPrevMonth
FROM MonthlySales;
14. SELECT e.EmployeeID, e.FirstName, e.LastName, t.Qtr, t.TotalSales
FROM Employees e
JOIN (
    SELECT EmployeeID, DATEPART(QUARTER, SaleDate) AS Qtr, SUM(SalesAmount) AS TotalSales
    FROM Sales
    GROUP BY EmployeeID, DATEPART(QUARTER, SaleDate)
) t ON e.EmployeeID = t.EmployeeID
WHERE t.TotalSales > 45000;
15. WITH Fibonacci (n, a, b) AS (
    SELECT 1, 0, 1
    UNION ALL
    SELECT n+1, b, a+b
    FROM Fibonacci
    WHERE n < 20
)
SELECT n, a AS FibonacciNumber
FROM Fibonacci;
16. SELECT *
FROM FindSameCharacters
WHERE Vals IS NOT NULL
  AND LEN(Vals) > 1
  AND LEN(LTRIM(RTRIM(REPLACE(Vals, LEFT(Vals,1), '')))) = 0;
17. WITH Seq AS (
    SELECT 1 AS n, CAST('1' AS VARCHAR(MAX)) AS NumStr
    UNION ALL
    SELECT n+1, NumStr + CAST(n+1 AS VARCHAR)
    FROM Seq
    WHERE n < 5
)
SELECT * FROM Seq;
18. SELECT TOP 1 e.EmployeeID, e.FirstName, e.LastName, SUM(s.SalesAmount) AS TotalSales
FROM Sales s
JOIN Employees e ON s.EmployeeID = e.EmployeeID
WHERE s.SaleDate >= DATEADD(MONTH, -6, GETDATE())
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC;

