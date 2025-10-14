SELECT * FROM walmart_sales ;

-- View first 10 rows
SELECT * FROM walmart_sales LIMIT 10 ;

-- Find the date range in the dataset
SELECT MIN(date) AS start_date, MAX(date) AS end_date FROM walmart_sales ;

-- Total number of stores
SELECT COUNT(DISTINCT store) AS total_stores FROM walmart_sales ;

-- Average weekly sales overall
SELECT ROUND(AVG(weekly_sales),2) AS avg_weekly_sales FROM walmart_sales ;


-- Total sales per store
SELECT store, SUM(weekly_sales) AS total_sales
FROM walmart_sales
GROUP BY 1
ORDER BY 2 DESC ;

--Average weekly sales per store
SELECT store, ROUND(AVG(weekly_sales),2) AS avg_sales
FROM walmart_sales
GROUP BY store
ORDER BY avg_sales DESC ;

--Highest sales week for each store
SELECT store, date, weekly_sales
FROM walmart_sales ws
WHERE weekly_sales = (
SELECT MAX(weekly_sales) FROM walmart_sales
WHERE store = ws.store) ;

--Total sales by year
SELECT EXTRACT(YEAR FROM date) AS year, 
SUM(weekly_sales) AS total_sales
FROM walmart_sales
GROUP BY year
ORDER BY year ;

--Monthly average sales trend
SELECT EXTRACT(YEAR FROM date) AS year, EXTRACT(MONTH FROM date) AS month_number, 
TO_CHAR(date, 'Month') AS month, ROUND(AVG(weekly_sales),2) AS avg_sales
FROM walmart_sales
GROUP BY 1,2,3
ORDER BY 1,2 ;

--Compare holiday vs non-holiday sales
SELECT 
CASE WHEN holiday_flag = 1 THEN 'Holiday_week'
ELSE 'Regular_week'
END AS week_type,
SUM(weekly_sales) AS total_sales,
ROUND(AVG(weekly_sales),2) AS avg_sales
FROM walmart_sales
GROUP BY week_type ;

--Impact of external factors
--Average sales vs temperature bands
SELECT CASE
WHEN temperature < 40 THEN 'Cold'
WHEN temperature BETWEEN 40 AND 70 THEN 'Moderate'
ELSE 'Hot'
END AS temp_category,
ROUND(AVG(weekly_sales),2) AS avg_sales
FROM walmart_sales
GROUP BY temp_category
ORDER BY avg_sales DESC ;

--Average sales by fuel price range
SELECT CASE
WHEN fuel_price < 3 THEN 'low (<3)'
WHEN fuel_price BETWEEN 3 AND 3.5 THEN 'Medium (3-3.5)'
ELSE 'High (>3.5)'
END AS fuel_category,
ROUND(AVG(weekly_sales),2) AS avg_sales
FROM walmart_sales
GROUP BY fuel_category
ORDER BY avg_sales DESC
 
--Average sales vs unemployment rate
SELECT CASE
WHEN unemployment < 7 THEN 'Low'
WHEN unemployment BETWEEN 7 AND 9 THEN 'Moderate'
ELSE 'High'
END AS unemployment_category,
ROUND(AVG(weekly_sales),2) AS avg_sales
FROM walmart_sales
GROUP BY unemployment_category
ORDER BY avg_sales DESC

--Rank stores by total sales
SELECT store, SUM(weekly_sales) AS total_sales, 
RANK() OVER(ORDER BY SUM(weekly_sales) DESC) AS sales_rank
FROM walmart_sales
GROUP BY store

--Classify stores based on their performance
SELECT store, SUM(weekly_sales) AS total_sales,
CASE
WHEN SUM(weekly_sales) > 50000000 THEN 'Top Performing'
WHEN SUM(weekly_sales) BETWEEN 30000000 AND 50000000 THEN 'Average'
ELSE 'Low Performing'
END AS performance_category
FROM walmart_sales
GROUP BY store
ORDER BY total_sales DESC