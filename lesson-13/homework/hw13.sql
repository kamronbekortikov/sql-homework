1. SELECT CAST(EMPLOYEE_ID AS VARCHAR) + '-' + FIRST_NAME + ' ' + LAST_NAME AS EmployeeInfo
FROM Employees
WHERE EMPLOYEE_ID = 100;
2. UPDATE Employees
SET PHONE_NUMBER = REPLACE(PHONE_NUMBER, '124', '999');
3. SELECT FIRST_NAME AS FirstName,
       LEN(FIRST_NAME) AS NameLength
FROM Employees
WHERE FIRST_NAME LIKE 'A%' 
   OR FIRST_NAME LIKE 'J%' 
   OR FIRST_NAME LIKE 'M%'
ORDER BY FIRST_NAME;
4. SELECT MANAGER_ID,
       SUM(SALARY) AS TotalSalary
FROM Employees
GROUP BY MANAGER_ID;
5. SELECT Year,
       (SELECT MAX(v) 
        FROM (VALUES (Max1), (Max2), (Max3)) AS ValueList(v)) AS MaxValue
FROM TestMax;
6. SELECT *
FROM cinema
WHERE Id % 2 = 1
  AND description <> 'boring';
7. SELECT *
FROM SingleOrder
ORDER BY CASE WHEN Id = 0 THEN 1 ELSE 0 END, Id;
8. SELECT COALESCE(column1, column2, column3, column4) AS FirstNonNull
FROM person;
9. SELECT PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
       PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
       PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM Students;
10. SELECT *
FROM Orders o
WHERE o.CustomerID IN (
    SELECT CustomerID
    FROM Orders
    WHERE DeliveryState = 'California'
)
AND o.DeliveryState = 'Texas';
11. SELECT STRING_AGG(ValueColumn, ', ') AS ConcatenatedValues
FROM DMLTable;
12. SELECT *
FROM Employees
WHERE LEN(FIRST_NAME + LAST_NAME) - LEN(REPLACE(LOWER(FIRST_NAME + LAST_NAME), 'a', '')) >= 3;
13. SELECT DEPARTMENT_ID,
       COUNT(*) AS TotalEmployees,
       100.0 * SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) / COUNT(*) AS PercentOver3Years
FROM Employees
GROUP BY DEPARTMENT_ID;
14. SELECT JobDescription,
       MAX_BY(SpacemanID, Experience) AS MostExperienced,
       MIN_BY(SpacemanID, Experience) AS LeastExperienced
FROM Personal
GROUP BY JobDescription;
15. WITH chars AS (
    SELECT value AS ch
    FROM STRING_SPLIT('tf56sd#%OqH', '')
    WHERE value <> ''
)
SELECT STRING_AGG(CASE WHEN ch LIKE '[A-Z]' THEN ch END, '') AS Uppercase,
       STRING_AGG(CASE WHEN ch LIKE '[a-z]' THEN ch END, '') AS Lowercase,
       STRING_AGG(CASE WHEN ch LIKE '[0-9]' THEN ch END, '') AS Numbers,
       STRING_AGG(CASE WHEN ch NOT LIKE '[A-Za-z0-9]' THEN ch END, '') AS Others
FROM chars;
16. SELECT Id,
       Value,
       SUM(Value) OVER (ORDER BY Id) AS RunningTotal
FROM Students;
17. -- Assuming column = Equation (e.g. '2+3+5')
SELECT Equation,
       (SELECT SUM(CAST(value AS INT)) 
        FROM STRING_SPLIT(Equation, '+')) AS Result
FROM Equations;
18. SELECT s1.StudentID, s1.Name, s1.BirthDate
FROM Students s1
JOIN Students s2
  ON s1.BirthDate = s2.BirthDate
 AND s1.StudentID <> s2.StudentID;

