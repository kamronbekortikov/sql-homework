1. SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id 
        ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS running_total
FROM sales_data;
2. SELECT 
    product_category,
    COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;
3. SELECT 
    product_category,
    MAX(total_amount) AS max_amount
FROM sales_data
GROUP BY product_category;
4. SELECT 
    product_category,
    MIN(unit_price) AS min_price
FROM sales_data
GROUP BY product_category;
5. SELECT 
    order_date,
    total_amount,
    AVG(total_amount) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg
FROM sales_data;
6. SELECT 
    region,
    SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;
7. SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spending,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_by_spending
FROM sales_data
GROUP BY customer_id, customer_name;
8. SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id ORDER BY order_date
    ) AS diff_prev_sale
FROM sales_data;
9. SELECT *
FROM (
    SELECT 
        product_category,
        product_name,
        unit_price,
        RANK() OVER (
            PARTITION BY product_category 
            ORDER BY unit_price DESC
        ) AS rnk
    FROM sales_data
) t
WHERE rnk <= 3;
10. SELECT 
    region,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY region ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_sales
FROM sales_data;
11. SELECT 
    product_category,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY product_category ORDER BY order_date
        ROWS UNBOUNDED PRECEDING
    ) AS cumulative_revenue
FROM sales_data;
12. SELECT 
    Value,
    SUM(Value) OVER (
        ORDER BY (SELECT NULL) ROWS UNBOUNDED PRECEDING
    ) AS SumPreValues
FROM OneColumn;
13. SELECT 
    customer_id,
    customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;
14. WITH RegionalAvg AS (
    SELECT 
        region,
        customer_id,
        customer_name,
        SUM(total_amount) AS total_spent,
        AVG(SUM(total_amount)) OVER (PARTITION BY region) AS regional_avg
    FROM sales_data
    GROUP BY region, customer_id, customer_name
)
SELECT *
FROM RegionalAvg
WHERE total_spent > regional_avg;
15. SELECT 
    region,
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spent,
    RANK() OVER (
        PARTITION BY region ORDER BY SUM(total_amount) DESC
    ) AS region_rank
FROM sales_data
GROUP BY region, customer_id, customer_name;
16. SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id ORDER BY order_date
    ) AS cumulative_sales
FROM sales_data;
17. WITH MonthlySales AS (
    SELECT 
        FORMAT(order_date, 'yyyy-MM') AS month,
        SUM(total_amount) AS monthly_total
    FROM sales_data
    GROUP BY FORMAT(order_date, 'yyyy-MM')
)
SELECT 
    month,
    monthly_total,
    LAG(monthly_total) OVER (ORDER BY month) AS prev_month_total,
    CAST((monthly_total - LAG(monthly_total) OVER (ORDER BY month)) * 100.0
         / NULLIF(LAG(monthly_total) OVER (ORDER BY month),0) AS DECIMAL(10,2)) AS growth_rate
FROM MonthlySales;
18. SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS last_order,
    CASE 
        WHEN total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) 
        THEN 'Higher' ELSE 'Not Higher' 
    END AS comparison
FROM sales_data;
19. SELECT 
    product_name,
    product_category,
    unit_price
FROM sales_data
WHERE unit_price > (SELECT AVG(unit_price) FROM sales_data);
20. SELECT 
    Id, 
    Grp, 
    Val1, 
    Val2,
    CASE 
        WHEN ROW_NUMBER() OVER (PARTITION BY Grp ORDER BY Id) = 1 
        THEN SUM(Val1 + Val2) OVER (PARTITION BY Grp) 
    END AS Tot
FROM MyData;
21. SELECT 
    ID,
    SUM(Cost) AS Cost,
    SUM(Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;
22. SELECT 
    s1.SeatNumber + 1 AS GapStart,
    s2.SeatNumber - 1 AS GapEnd
FROM Seats s1
JOIN Seats s2 
    ON s1.SeatNumber < s2.SeatNumber
WHERE NOT EXISTS (
    SELECT 1 
    FROM Seats s3 
    WHERE s3.SeatNumber BETWEEN s1.SeatNumber+1 AND s2.SeatNumber-1
)
AND s2.SeatNumber - s1.SeatNumber > 1
ORDER BY GapStart;

