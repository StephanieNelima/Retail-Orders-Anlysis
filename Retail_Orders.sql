/* find top 10 highest revenue genersting products*/
SELECT product_id, SUM(sale_price) AS sales
FROM df_orders
GROUP BY product_id
ORDER BY sales DESC
LIMIT 10;


/*top 5 highest selling products in each region*/
SELECT region, product_id, SUM(sale_price) AS sales
FROM df_orders
GROUP BY region, product_id
ORDER BY region, sales DESC
LIMIT 10;

/*find month vs month growth comparison for 2022 and 2023*/
SELECT YEAR(order_date) AS order_year, MONTH(order_date) AS order_month,
SUM(sale_price) AS sales,
FROM df_orders
GROUP BY order_year, order_month
ORDER BY YEAR(order_date), MONTH(order_date);

/*compare sales between in 2022 and 2023*/
WITH CTE AS (
    SELECT
        YEAR(order_date)  AS order_year,
        MONTH(order_date) AS order_month,
        SUM(sale_price)   AS sales
    FROM df_orders
    GROUP BY YEAR(order_date), MONTH(order_date)
)
SELECT
    order_month,
    SUM(CASE WHEN order_year = 2022 THEN sales ELSE 0 END) AS sales_2022,
    SUM(CASE WHEN order_year = 2023 THEN sales ELSE 0 END) AS sales_2023    
FROM cte
GROUP BY order_month
ORDER BY order_month;




/*Highest sales*/
SELECT 
    category,
    DATE_FORMAT(order_date, '%Y%m') AS order_year_month,
    SUM(sale_price) AS sales
FROM df_orders
GROUP BY category, DATE_FORMAT(order_date, '%Y%m')
ORDER BY category, DATE_FORMAT(order_date, '%Y%m');

