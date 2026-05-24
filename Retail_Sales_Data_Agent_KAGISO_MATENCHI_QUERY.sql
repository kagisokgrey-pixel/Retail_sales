-- Databricks notebook source
--Getting an overview of the data 
SELECT *
FROM retail2.schema_retail.retail_sales_dataset;

-- Overall Summary
SELECT 
    COUNT(*) as total_transactions,
    COUNT(DISTINCT `Customer ID`) as unique_customers,
    MIN(Date) as first_date,
    MAX(Date) as last_date,
    SUM(`Total Amount`) as total_revenue,
    AVG(`Total Amount`) as avg_order_value,
    AVG(Quantity) as avg_quantity
FROM retail2.schema_retail.retail_sales_dataset;

--  By Product Category
SELECT 
    `Product Category`,
    COUNT(*) as transactions,
    SUM(`Total Amount`) as revenue,
    AVG(`Total Amount`) as avg_order_value,
    AVG(Quantity) as avg_qty
FROM retail2.schema_retail.retail_sales_dataset
GROUP BY `Product Category`
ORDER BY revenue DESC;

-- 3. By Gender
SELECT 
    Gender,
    COUNT(*) as transactions,
    SUM(`Total Amount`) as revenue,
    AVG(Age) as avg_age
FROM retail2.schema_retail.retail_sales_dataset
GROUP BY Gender;

--Preparing a table --
SELECT 
    `Transaction ID`,
    Date,
    `Customer ID`,
    Gender,
    Age,
    `Product Category`,
    Quantity,
    `Price per Unit`,
    `Total Amount`,
    
    YEAR(Date) AS Year,
    MONTH(Date) AS Month,
    QUARTER(Date) AS Quarter,
    DAYOFWEEK(Date) AS Day_of_Week,
    `Total Amount` / Quantity AS Revenue_per_Unit,
    CASE 
    WHEN `Total Amount` > 1000 THEN 'Yes' ELSE 'No' END AS High_Value_Transaction
    
FROM retail2.schema_retail.retail_sales_dataset;   

--Validation --
-- 3 Validation Qustions --
--1.What was the total ravenue for the entire year 
SELECT SUM(`Total Amount`) AS Total_Ravenue
FROM retail2.schema_retail.retail_sales_data_for_a_data_agent_improved;
--2. Which product category generated the highest revenue 
SELECT 
    `Product Category`,
    SUM(`Total Amount`) AS Total_Revenue,
    COUNT(*) AS Transactions
FROM retail2.schema_retail.retail_sales_data_for_a_data_agent_improved
GROUP BY `Product Category`
ORDER BY Total_Revenue DESC;
-- 3. What is the average age of customers and is there a big difference in spending between Male And Female --
SELECT 
    AVG(Age) AS Average_Age,
    Gender,
    SUM(`Total Amount`) AS Total_Revenue,
    AVG(`Total Amount`) AS Avg_Order_Value,
    COUNT(*) AS Transactions
FROM retail2.schema_retail.retail_sales_data_for_a_data_agent_improved
GROUP BY Gender;

-- =============================================
--     PROJECT COMPLETION - THE END
-- =============================================

SELECT 
    '🎉 PROJECT SUCCESSFULLY COMPLETED! 🎉' AS Message,
    'Retail Sales Data Agent' AS Project_Name,
    'Step 10/10 - Submission Ready' AS Status,
    'Thank you for the journey!' AS Final_Note,
    'The End' AS The_End;

