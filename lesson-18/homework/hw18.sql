1. -- Drop if already exists
IF OBJECT_ID('tempdb..#MonthlySales') IS NOT NULL
    DROP TABLE #MonthlySales;

SELECT 
    p.ProductID,
    SUM(s.Quantity) AS TotalQuantity,
    SUM(s.Quantity * p.Price) AS TotalRevenue
INTO #MonthlySales
FROM Sales s
JOIN Products p ON s.ProductID = p.ProductID
WHERE YEAR(s.SaleDate) = YEAR(GETDATE())
  AND MONTH(s.SaleDate) = MONTH(GETDATE())
GROUP BY p.ProductID;

-- Return results
SELECT * FROM #MonthlySales;
2. CREATE OR ALTER VIEW vw_ProductSalesSummary AS
SELECT 
    p.ProductID,
    p.ProductName,
    p.Category,
    ISNULL(SUM(s.Quantity), 0) AS TotalQuantitySold
FROM Products p
LEFT JOIN Sales s ON p.ProductID = s.ProductID
GROUP BY p.ProductID, p.ProductName, p.Category;
3. CREATE OR ALTER FUNCTION fn_GetTotalRevenueForProduct(@ProductID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(18,2);

    SELECT @TotalRevenue = SUM(s.Quantity * p.Price)
    FROM Sales s
    JOIN Products p ON s.ProductID = p.ProductID
    WHERE p.ProductID = @ProductID;

    RETURN ISNULL(@TotalRevenue, 0);
END;
SELECT dbo.fn_GetTotalRevenueForProduct(1) AS TotalRevenue;

4. CREATE OR ALTER FUNCTION fn_GetSalesByCategory(@Category VARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantity,
        SUM(s.Quantity * p.Price) AS TotalRevenue
    FROM Products p
    LEFT JOIN Sales s ON p.ProductID = s.ProductID
    WHERE p.Category = @Category
    GROUP BY p.ProductName
);
SELECT * FROM dbo.fn_GetSalesByCategory('Electronics');
5. CREATE OR ALTER FUNCTION dbo.fn_IsPrime(@Number INT)
RETURNS VARCHAR(3)
AS
BEGIN
    IF @Number <= 1 RETURN 'No';

    DECLARE @i INT = 2;
    WHILE @i <= SQRT(@Number)
    BEGIN
        IF @Number % @i = 0
            RETURN 'No';
        SET @i = @i + 1;
    END
    RETURN 'Yes';
END;
SELECT dbo.fn_IsPrime(7); -- Yes
SELECT dbo.fn_IsPrime(8); -- No
6. CREATE OR ALTER FUNCTION fn_GetNumbersBetween(@Start INT, @End INT)
RETURNS @Numbers TABLE (Number INT)
AS
BEGIN
    DECLARE @i INT = @Start;
    WHILE @i <= @End
    BEGIN
        INSERT INTO @Numbers VALUES (@i);
        SET @i = @i + 1;
    END
    RETURN;
END;
SELECT * FROM dbo.fn_GetNumbersBetween(5, 10);
7. CREATE OR ALTER FUNCTION getNthHighestSalary(@N INT)
RETURNS INT
AS
BEGIN
    DECLARE @Result INT;

    WITH DistinctSalaries AS (
        SELECT DISTINCT salary
        FROM Employee
    )
    SELECT @Result = salary
    FROM (
        SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
        FROM DistinctSalaries
    ) t
    WHERE rnk = @N;

    RETURN @Result;
END;
SELECT dbo.getNthHighestSalary(2) AS HighestNSalary;
8. SELECT TOP 1 id, COUNT(*) AS num
FROM (
    SELECT requester_id AS id, accepter_id AS friend_id
    FROM RequestAccepted
    UNION ALL
    SELECT accepter_id AS id, requester_id AS friend_id
    FROM RequestAccepted
) t
GROUP BY id
ORDER BY num DESC;
9. CREATE OR ALTER VIEW vw_CustomerOrderSummary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS total_orders,
    ISNULL(SUM(o.amount),0) AS total_amount,
    MAX(o.order_date) AS last_order_date
FROM Customers c
LEFT JOIN Orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.name;
10. SELECT 
    g.RowNumber,
    COALESCE(g.TestCase, 
             (SELECT TOP 1 TestCase 
              FROM Gaps g2 
              WHERE g2.RowNumber <= g.RowNumber 
                AND g2.TestCase IS NOT NULL
              ORDER BY g2.RowNumber DESC)) AS Workflow
FROM Gaps g
ORDER BY g.RowNumber;

