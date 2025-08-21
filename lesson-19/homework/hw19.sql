1. CREATE OR ALTER PROCEDURE GetEmployeeBonus
AS
BEGIN
    -- Create temp table
    CREATE TABLE #EmployeeBonus (
        EmployeeID INT,
        FullName NVARCHAR(100),
        Department NVARCHAR(50),
        Salary DECIMAL(10,2),
        BonusAmount DECIMAL(10,2)
    );

    -- Insert data with Bonus calculation
    INSERT INTO #EmployeeBonus (EmployeeID, FullName, Department, Salary, BonusAmount)
    SELECT 
        e.EmployeeID,
        e.FirstName + ' ' + e.LastName AS FullName,
        e.Department,
        e.Salary,
        e.Salary * db.BonusPercentage / 100
    FROM Employees e
    JOIN DepartmentBonus db
        ON e.Department = db.Department;

    -- Return results
    SELECT * FROM #EmployeeBonus;
END;
GO

-- Run
EXEC GetEmployeeBonus;
2. CREATE OR ALTER PROCEDURE UpdateDepartmentSalary
    @Dept NVARCHAR(50),
    @IncreasePercent DECIMAL(5,2)
AS
BEGIN
    -- Update salaries
    UPDATE Employees
    SET Salary = Salary + (Salary * @IncreasePercent / 100)
    WHERE Department = @Dept;

    -- Return updated employees
    SELECT * 
    FROM Employees
    WHERE Department = @Dept;
END;
GO

-- Run Example
EXEC UpdateDepartmentSalary 'Sales', 5;
3. MERGE INTO Products_Current AS target
USING Products_New AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN
    UPDATE SET target.ProductName = source.ProductName,
               target.Price = source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Price)
    VALUES (source.ProductID, source.ProductName, source.Price)
WHEN NOT MATCHED BY SOURCE THEN
    DELETE;

-- Final result
SELECT * FROM Products_Current;
4. SELECT 
    id,
    CASE 
        WHEN p_id IS NULL THEN 'Root'
        WHEN id IN (SELECT p_id FROM Tree WHERE p_id IS NOT NULL) THEN 'Inner'
        ELSE 'Leaf'
    END AS type
FROM Tree
ORDER BY id;
5. SELECT 
    s.user_id,
    CAST(
        ISNULL(SUM(CASE WHEN c.action = 'confirmed' THEN 1 ELSE 0 END), 0) * 1.0 /
        NULLIF(COUNT(c.user_id), 0)
        AS DECIMAL(3,2)
    ) AS confirmation_rate
FROM Signups s
LEFT JOIN Confirmations c
    ON s.user_id = c.user_id
GROUP BY s.user_id
ORDER BY s.user_id;
6. SELECT id, name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
7. CREATE OR ALTER PROCEDURE GetProductSalesSummary
    @ProductID INT
AS
BEGIN
    SELECT 
        p.ProductName,
        SUM(s.Quantity) AS TotalQuantitySold,
        SUM(s.Quantity * p.Price) AS TotalSalesAmount,
        MIN(s.SaleDate) AS FirstSaleDate,
        MAX(s.SaleDate) AS LastSaleDate
    FROM Products p
    LEFT JOIN Sales s
        ON p.ProductID = s.ProductID
    WHERE p.ProductID = @ProductID
    GROUP BY p.ProductName;
END;
GO

-- Example Run
EXEC GetProductSalesSummary 1;

