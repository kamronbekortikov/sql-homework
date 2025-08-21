1. SELECT 
    SaleID, ProductName, SaleDate, SaleAmount,
    ROW_NUMBER() OVER (ORDER BY SaleDate) AS RowNum
FROM ProductSales;
2. SELECT 
    ProductName,
    SUM(Quantity) AS TotalQty,
    DENSE_RANK() OVER (ORDER BY SUM(Quantity) DESC) AS RankQty
FROM ProductSales
GROUP BY ProductName;
3. SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY CustomerID ORDER BY SaleAmount DESC) AS rn
    FROM ProductSales
) t
WHERE rn = 1;
4. SELECT 
    SaleID, SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSale
FROM ProductSales;
5. SELECT 
    SaleID, SaleAmount,
    LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSale
FROM ProductSales;
6. SELECT *
FROM (
    SELECT SaleID, SaleAmount,
           LAG(SaleAmount) OVER (ORDER BY SaleDate) AS PrevSale
    FROM ProductSales
) t
WHERE SaleAmount > PrevSale;
7. SELECT 
    SaleID, ProductName, SaleAmount,
    SaleAmount - LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromPrev
FROM ProductSales;
8. SELECT 
    SaleID, SaleAmount,
    LEAD(SaleAmount) OVER (ORDER BY SaleDate) AS NextSale,
    ( (LEAD(SaleAmount) OVER (ORDER BY SaleDate) - SaleAmount) * 100.0 / SaleAmount ) AS PercChange
FROM ProductSales;
9. SELECT 
    SaleID, ProductName, SaleAmount,
    CAST(SaleAmount AS DECIMAL(10,2)) /
    NULLIF(LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate), 0) AS RatioToPrev
FROM ProductSales;
10. SELECT 
    SaleID, ProductName, SaleAmount,
    SaleAmount - FIRST_VALUE(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS DiffFromFirst
FROM ProductSales;
11. SELECT SaleID, ProductName, SaleDate, SaleAmount
FROM (
    SELECT *,
           LAG(SaleAmount) OVER (PARTITION BY ProductName ORDER BY SaleDate) AS PrevSale
    FROM ProductSales
) t
WHERE SaleAmount > PrevSale;
12. SELECT 
    SaleID, SaleAmount,
    SUM(SaleAmount) OVER (ORDER BY SaleDate ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM ProductSales;
13. SELECT 
    SaleID, SaleAmount,
    AVG(SaleAmount) OVER (ORDER BY SaleDate ROWS 2 PRECEDING) AS MovingAvg3
FROM ProductSales;
14. SELECT 
    SaleID, SaleAmount,
    SaleAmount - AVG(SaleAmount) OVER () AS DiffFromAvg
FROM ProductSales;
15. SELECT 
    EmployeeID, Name, Department, Salary,
    DENSE_RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees1;
16. SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rnk
    FROM Employees1
) t
WHERE rnk <= 2;
17. SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
    FROM Employees1
) t
WHERE rn = 1;
18. SELECT 
    Department, Name, Salary,
    SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate ROWS UNBOUNDED PRECEDING) AS RunningTotal
FROM Employees1;
19. SELECT 
    Department, Name, Salary,
    SUM(Salary) OVER (PARTITION BY Department) AS DeptTotal
FROM Employees1;
20. SELECT 
    Department, Name, Salary,
    AVG(Salary) OVER (PARTITION BY Department) AS DeptAvg
FROM Employees1;
21. SELECT 
    EmployeeID, Name, Department, Salary,
    Salary - AVG(Salary) OVER (PARTITION BY Department) AS DiffFromDeptAvg
FROM Employees1;
22. SELECT 
    EmployeeID, Name, Department, Salary,
    AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg3
FROM Employees1;
23. SELECT SUM(Salary) AS Last3HireSum
FROM (
    SELECT Salary
    FROM Employees1
    ORDER BY HireDate DESC
    OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY
) t;

