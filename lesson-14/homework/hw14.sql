1. SELECT 
    Id,
    LTRIM(RTRIM(SUBSTRING(Name, 1, CHARINDEX(',', Name) - 1))) AS Name,
    LTRIM(RTRIM(SUBSTRING(Name, CHARINDEX(',', Name) + 1, LEN(Name)))) AS Surname
FROM TestMultipleColumns;
2. SELECT *
FROM TestPercent
WHERE Strs LIKE '%[%]%';
3. SELECT 
    Id,
    VALUE AS SplitPart
FROM Splitter
CROSS APPLY STRING_SPLIT(Vals, '.');
4. DECLARE @txt VARCHAR(100) = '1234ABC123456XYZ1234567890ADS';

SELECT REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
       REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(@txt,'0','X'),'1','X'),'2','X'),'3','X'),'4','X')
       ,'5','X'),'6','X'),'7','X'),'8','X'),'9','X') AS ReplacedString;
5. SELECT *
FROM testDots
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;
6. SELECT 
    texts,
    LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS SpaceCount
FROM CountSpaces;
7. SELECT e.Id, e.Name, e.Salary, e.ManagerId
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;
8. SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsOfService
FROM Employees
WHERE DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 15;
9. DECLARE @s VARCHAR(100) = 'rtcfvty34redt';

;WITH n AS (
    SELECT TOP (LEN(@s)) ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS n
    FROM sys.all_objects
),
chars AS (
    SELECT STRING_AGG(SUBSTRING(@s, n, 1), '') WITHIN GROUP (ORDER BY n) AS letters
    FROM n
    WHERE SUBSTRING(@s, n, 1) LIKE '[A-Za-z]'
),
digits AS (
    SELECT STRING_AGG(SUBSTRING(@s, n, 1), '') WITHIN GROUP (ORDER BY n) AS numbers
    FROM n
    WHERE SUBSTRING(@s, n, 1) LIKE '[0-9]'
)
SELECT letters AS OnlyChars, numbers AS OnlyDigits
FROM chars CROSS JOIN digits;
10. SELECT Id
FROM (
    SELECT 
        Id,
        Temperature,
        LAG(Temperature) OVER (ORDER BY RecordDate) AS PrevTemp,
        RecordDate
    FROM weather
) d
WHERE Temperature > PrevTemp;
11. SELECT player_id, MIN(event_date) AS first_login_date
FROM Activity
GROUP BY player_id;
12. -- apple,banana,orange,grape => third is 'orange'
SELECT PARSENAME(REPLACE(fruit_list, ',', '.'), 2) AS third_item
FROM fruits;
13. DECLARE @s2 VARCHAR(100) = 'sdgfhsdgfhs@121313131';

;WITH n AS (
    SELECT TOP (LEN(@s2)) ROW_NUMBER() OVER (ORDER BY (SELECT 1)) AS n
    FROM sys.all_objects
)
SELECT n AS pos, SUBSTRING(@s2, n, 1) AS ch
FROM n
ORDER BY n;
14. SELECT 
    p1.id,
    CASE WHEN p1.code = 0 THEN p2.code ELSE p1.code END AS code
FROM p1
JOIN p2 ON p2.id = p1.id;
15. SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE,
    DATEDIFF(YEAR, HIRE_DATE, GETDATE()) AS YearsWorked,
    CASE 
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) <= 20 THEN 'Senior'
        ELSE 'Veteran'
    END AS EmploymentStage
FROM Employees;
16. SELECT 
    Id,
    VALS,
    CASE 
        WHEN VALS IS NULL THEN NULL
        WHEN PATINDEX('[0-9]%', VALS) = 1 
             THEN TRY_CONVERT(INT, SUBSTRING(VALS, 1, NULLIF(PATINDEX('%[^0-9]%', VALS + ' '),0) - 1))
        ELSE NULL
    END AS LeadingInteger
FROM GetIntegers;
17. -- 'a,b,c' -> 'b,a,c' ; works for any length ≥ 2
SELECT 
    Id,
    Vals AS OriginalVals,
    CONCAT(
        SUBSTRING(Vals, CHARINDEX(',', Vals) + 1, CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1) - CHARINDEX(',', Vals) - 1), -- second token
        ',',
        LEFT(Vals, CHARINDEX(',', Vals) - 1), -- first token
        SUBSTRING(Vals, CHARINDEX(',', Vals, CHARINDEX(',', Vals) + 1), LEN(Vals)) -- the rest starting from second comma
    ) AS Swapped
FROM MultipleVals;
18. WITH ranked AS (
    SELECT 
        player_id,
        device_id,
        event_date,
        ROW_NUMBER() OVER (PARTITION BY player_id ORDER BY event_date, device_id) AS rn
    FROM Activity
)
SELECT player_id, device_id
FROM ranked
WHERE rn = 1;
19. WITH base AS (
    SELECT 
        Area,
        [Date],
        FinancialWeek,
        FinancialYear,
        [DayName],
        [DayOfWeek],
        COALESCE(SalesLocal, 0) + COALESCE(SalesRemote, 0) AS DaySales
    FROM WeekPercentagePuzzle
),
wk AS (
    SELECT 
        b.*,
        SUM(b.DaySales) OVER (
            PARTITION BY b.Area, b.FinancialYear, b.FinancialWeek
        ) AS WeekTotal
    FROM base b
)
SELECT
    Area,
    FinancialYear,
    FinancialWeek,
    [Date],
    [DayName],
    [DayOfWeek],
    DaySales,
    WeekTotal,
    CASE 
        WHEN WeekTotal = 0 OR WeekTotal IS NULL THEN 0.0
        ELSE CAST(100.0 * DaySales / WeekTotal AS DECIMAL(10,2))
    END AS DaySalesPctOfAreaWeek
FROM wk
ORDER BY Area, FinancialYear, FinancialWeek, [DayOfWeek], [Date];

