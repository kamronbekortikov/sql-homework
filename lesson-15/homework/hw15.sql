1. SELECT id, name, salary
FROM employees
WHERE salary = (SELECT MIN(salary) FROM employees);
2. SELECT id, product_name, price
FROM products
WHERE price > (SELECT AVG(price) FROM products);
3. SELECT id, name, department_id
FROM employees
WHERE department_id = (
    SELECT id
    FROM departments
    WHERE department_name = 'Sales'
);
4. SELECT customer_id, name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM orders
);
5. SELECT p.id, p.product_name, p.price, p.category_id
FROM products p
WHERE p.price = (
    SELECT MAX(price)
    FROM products
    WHERE category_id = p.category_id
);
6. SELECT id, name, salary, department_id
FROM employees
WHERE department_id = (
    SELECT TOP 1 department_id
    FROM employees
    GROUP BY department_id
    ORDER BY AVG(salary) DESC
);
7. SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(salary)
    FROM employees
    WHERE department_id = e.department_id
);
8. SELECT s.student_id, s.name, g.course_id, g.grade
FROM students s
JOIN grades g ON s.student_id = g.student_id
WHERE g.grade = (
    SELECT MAX(grade)
    FROM grades
    WHERE course_id = g.course_id
);
9. SELECT p.id, p.product_name, p.price, p.category_id
FROM products p
WHERE 2 = (
    SELECT COUNT(DISTINCT p2.price)
    FROM products p2
    WHERE p2.category_id = p.category_id
      AND p2.price > p.price
);
10. SELECT e.id, e.name, e.salary, e.department_id
FROM employees e
WHERE e.salary > (SELECT AVG(salary) FROM employees)
  AND e.salary < (
      SELECT MAX(salary)
      FROM employees
      WHERE department_id = e.department_id
  );

