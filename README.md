# walmart-sales-sql-project
walmart sales database sql analysis 

Project Title: Walmart Sales Data Analysis using SQL
📅 Overview
This project analyzes Walmart’s weekly sales data across multiple stores to uncover sales trends, performance differences, and the impact of external factors like holidays, temperature, fuel price, CPI, and unemployment.
Objectives
Analyze total and average sales by store and year
Compare holiday vs. non-holiday sales
Study sales impact based on temperature and economic conditions
Rank stores based on performance

Dataset Information
Source: Kaggle – Walmart Sales Forecasting Dataset by Mikhail
Link -  https://www.kaggle.com/datasets/syedanwarafridi/vehicle-sales-data

Columns:
Column	Description
Store  -	                 Store number (1–45)
Date -	                 Week start date
Weekly_Sales - 	  Total sales for the week
Holiday_Flag -	  1 = holiday week, 0 = non-holiday
Temperature -	  Average temperature (°F)
Fuel_Price -	  Cost of fuel in the region
CPI -	                 Consumer Price Index
Unemployment - Unemployment rate (%)

SQL Setup
Database: PostgreSQL
Tool Used: pgAdmin

Create table:
CREATE TABLE walmart_sales (
    store INT,
    date DATE,
    weekly_sales NUMERIC(12,2),
    holiday_flag INT,
    temperature NUMERIC(5,2),
    fuel_price NUMERIC(5,2),
    cpi NUMERIC(8,2),
    unemployment NUMERIC(5,2)
);

Import CSV using pgAdmin “Import/Export” option.

 Key Analysis Questions
#	Business Question	                                                                         SQL Concept Used
1	What is the total sales per store?	                                          Aggregation
2	Which stores have the highest total sales?	                            GROUP BY + ORDER BY
3	How do holiday weeks compare to non-holiday weeks?	             CASE + GROUP BY
4	How do sales vary by temperature range?	                 CASE + Conditional Aggregation
5	What is the yearly sales trend?	                                                      EXTRACT (date functions)
6	Rank stores based on performance	                                       Window Functions / RANK()

Example Query
SELECT 
    CASE WHEN holiday_flag = 1 THEN 'Holiday Week' 
    ELSE 'Regular Week' END AS week_type,
    ROUND(AVG(weekly_sales),2) AS avg_sales
    FROM walmart_sales
    GROUP BY week_type;


Insight:
Holiday weeks had higher average sales, showing seasonal demand spikes around key events like Thanksgiving and Christmas.

Key Insights
Store #20 and Store #4 were the top-performing locations by total sales.
Average sales during holidays were 8–12% higher than non-holiday weeks.
Cold to Moderate temperature weeks (40–70°F) recorded better sales.
Stores with moderate local unemployment rates performed better on average.


🧑‍💻 Author
Rajat Neema
Aspiring Data Analyst | Skilled in SQL, Excel, and Power BI
📧 rajat23252207@gmail.com
LinkedIn Profile - www.linkedin.com/in/rajat-neema 
