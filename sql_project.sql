CREATE DATABASE sql_project; 

DROP TABLE IF EXISTS retail_sales; 
CREATE TABLE retail_sales(
transactions_id INT PRIMARY KEY, 
sale_date DATE,
sale_time TIME,
customer_id INT, 
gender VARCHAR(15), 
age INT, 
category VARCHAR(15), 
quantity INT, 
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);

SELECT * FROM sql_project.retail_sales;

SELECT * FROM sql_project.retail_sales
LIMIT 10; 

SELECT COUNT(*) FROM sql_project.retail_sales;

SELECT * FROM sql_project.retail_sales
WHERE transactions_id IS NULL; 

SELECT * FROM sql_project.retail_sales
WHERE sale_date IS NULL;

SELECT * FROM sql_project.retail_sales
WHERE sale_time IS NULL;

SELECT * FROM sql_project.retail_sales
WHERE transactions_id IS NULL
OR sale_date IS NULL
OR sale_time IS NULL 
OR customer_id IS NULL 
OR quantity IS NULL
OR cogs IS NULL 
OR total_sale IS NULL;  

SELECT COUNT(*) AS total_sale FROM sql_project.retail_sales; 

SELECT COUNT(DISTINCT customer_id) AS total_sale FROM sql_project.retail_sales; 

SELECT DISTINCT category FROM sql_project.retail_sales; 

SELECT *
FROM sql_project.retail_sales
WHERE sale_date = '2022-11-05';

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM sql_project.retail_sales
GROUP BY 1;

SELECT
    ROUND(AVG(age), 2) as avg_age
FROM sql_project.retail_sales
WHERE category = 'Beauty'; 

SELECT * FROM sql_project.retail_sales
WHERE total_sale > 1000;

SELECT 
    category,
    gender,
    COUNT(*) as total_trans
FROM sql_project.retail_sales
GROUP 
    BY 
    category,
    gender
ORDER BY 1;

SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM sql_project.retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5; 

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM sql_project.retail_sales
GROUP BY category;

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM sql_project.retail_sales
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift;
