1. SELECT 
    p.firstName,
    p.lastName,
    a.city,
    a.state
FROM Person p
LEFT JOIN Address a
    ON p.personId = a.personId;
2. SELECT e.name AS Employee
FROM Employee e
JOIN Employee m
    ON e.managerId = m.id
WHERE e.salary > m.salary;
3. SELECT email
FROM Person
GROUP BY email
HAVING COUNT(*) > 1;
4. DELETE p
FROM Person p
JOIN (
    SELECT email, MIN(id) AS min_id
    FROM Person
    GROUP BY email
) t
    ON p.email = t.email
WHERE p.id > t.min_id;
5. SELECT DISTINCT g.ParentName
FROM girls g
WHERE g.ParentName NOT IN (
    SELECT DISTINCT ParentName FROM boys
);
6. SELECT 
    o.custid,
    SUM(o.freight) AS TotalSalesOver50,
    MIN(o.freight) AS LeastWeight
FROM Sales.Orders o
WHERE o.freight > 50
GROUP BY o.custid;
7. SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
    ON c.id = o.customerId
WHERE o.id IS NULL;
8. SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o
    ON c.id = o.customerId
WHERE o.id IS NULL;
9. SELECT 
    s.student_id,
    s.student_name,
    subj.subject_name,
    COUNT(e.subject_name) AS attended_exams
FROM Students s
CROSS JOIN Subjects subj
LEFT JOIN Examinations e
    ON s.student_id = e.student_id
   AND subj.subject_name = e.subject_name
GROUP BY s.student_id, s.student_name, subj.subject_name
ORDER BY s.student_id, subj.subject_name;

