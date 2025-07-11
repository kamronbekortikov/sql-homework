-- 1. Products × Suppliers (All combinations)
SELECT ProductName, SupplierName
FROM Products, Suppliers;

-- 2. Departments × Employees (All combinations)
SELECT DepartmentName, Name AS EmployeeName
FROM Departments, Employees;

-- 3. Suppliers supplying the product
SELECT S.SupplierName, P.ProductName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID;

-- 4. Customer names and their order IDs
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, O.OrderID
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID;

-- 5. Students × Courses (All combinations)
SELECT S.Name AS StudentName, C.CourseName
FROM Students S, Courses C;

-- 6. Products and orders where ProductID matches
SELECT P.ProductName, O.OrderID
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID;

-- 7. Employees with matching DepartmentID
SELECT E.Name, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 8. Student names and their enrolled Course IDs
SELECT S.Name, E.CourseID
FROM Enrollments E
JOIN Students S ON S.StudentID = E.StudentID;

-- 9. Orders with matching payments
SELECT O.OrderID, P.Amount
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID;

-- 10. Orders where product price > 100
SELECT O.OrderID, P.ProductName, P.Price
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
WHERE P.Price > 100;

-- 🟡 MEDIUM (10 puzzles)

-- 11. Mismatched employee-department combinations
SELECT E.Name, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID <> D.DepartmentID;

-- 12. Ordered quantity > stock
SELECT O.OrderID, P.ProductName, O.Quantity, P.StockQuantity
FROM Orders O
JOIN Products P ON O.ProductID = P.ProductID
WHERE O.Quantity > P.StockQuantity;

-- 13. Customers with sales ≥ 500
SELECT C.FirstName + ' ' + C.LastName AS CustomerName, S.ProductID, S.SaleAmount
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE S.SaleAmount >= 500;

-- 14. Students and course names they’re enrolled in
SELECT S.Name AS StudentName, C.CourseName
FROM Enrollments E
JOIN Students S ON E.StudentID = S.StudentID
JOIN Courses C ON E.CourseID = C.CourseID;

-- 15. Products and supplier names where name contains “Tech”
SELECT P.ProductName, S.SupplierName
FROM Products P
JOIN Suppliers S ON P.SupplierID = S.SupplierID
WHERE S.SupplierName LIKE '%Tech%';

-- 16. Payments < total amount
SELECT O.OrderID, O.TotalAmount, P.Amount
FROM Orders O
JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.Amount < O.TotalAmount;

-- 17. Department name for each employee
SELECT E.Name, D.DepartmentName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID;

-- 18. Products in Electronics or Furniture
SELECT ProductName
FROM Products P
JOIN Categories C ON P.Category = C.CategoryID
WHERE C.CategoryName IN ('Electronics', 'Furniture');

-- 19. Sales from customers in USA
SELECT S.*
FROM Sales S
JOIN Customers C ON S.CustomerID = C.CustomerID
WHERE C.Country = 'USA';

-- 20. Orders by German customers with total > 100
SELECT O.OrderID, C.FirstName + ' ' + C.LastName AS CustomerName, O.TotalAmount
FROM Orders O
JOIN Customers C ON O.CustomerID = C.CustomerID
WHERE C.Country = 'Germany' AND O.TotalAmount > 100;

-- 🔴 HARD (5 puzzles)

-- 21. All employee pairs from different departments
SELECT E1.Name AS Emp1, E2.Name AS Emp2
FROM Employees E1
JOIN Employees E2 ON E1.EmployeeID < E2.EmployeeID
WHERE E1.DepartmentID <> E2.DepartmentID;

-- 22. Payment details where Amount ≠ Quantity × Price
SELECT Pay.PaymentID, Pay.OrderID, Pay.Amount, O.Quantity, P.Price
FROM Payments Pay
JOIN Orders O ON Pay.OrderID = O.OrderID
JOIN Products P ON O.ProductID = P.ProductID
WHERE Pay.Amount <> O.Quantity * P.Price;

-- 23. Students not enrolled in any course
SELECT S.Name
FROM Students S
LEFT JOIN Enrollments E ON S.StudentID = E.StudentID
WHERE E.StudentID IS NULL;

-- 24. Managers earning ≤ employee they manage
SELECT M.Name AS ManagerName, E.Name AS EmployeeName, M.Salary AS ManagerSalary, E.Salary AS EmployeeSalary
FROM Employees E
JOIN Employees M ON E.ManagerID = M.EmployeeID
WHERE M.Salary <= E.Salary;

-- 25. Customers with order but no payment
SELECT DISTINCT C.FirstName + ' ' + C.LastName AS CustomerName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
LEFT JOIN Payments P ON O.OrderID = P.OrderID
WHERE P.OrderID IS NULL;
