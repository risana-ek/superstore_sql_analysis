CREATE DATABASE sales_project;
USE sales_project;
CREATE TABLE superstoreorders (
    Row_ID INT,
    Order_ID VARCHAR(50),
    Order_Date DATE,
    Ship_Date DATE,
    Ship_Mode VARCHAR(50),
    Customer_ID VARCHAR(50),
    Customer_Name VARCHAR(100),
    Segment VARCHAR(50),
    Country VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(50),
    Postal_Code VARCHAR(20),
    Region VARCHAR(50),
    Product_ID VARCHAR(50),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50),
    Product_Name VARCHAR(255),
    Sales DECIMAL(10,2),
    Quantity INT,
    Discount DECIMAL(4,2),
    Profit DECIMAL(10,2)
);
USE sales_project;

SELECT COUNT(*) FROM superstoreorders;

SELECT SUM(Sales) AS Total_Sales
FROM superstoreorders;

SELECT SUM(Profit) AS Total_Profit
FROM superstoreorders;

SELECT Customer_Name, SUM(Sales) AS Total_Sales
FROM superstoreorders
GROUP BY Customer_Name
ORDER BY Total_Sales DESC
LIMIT 5;

SELECT Category, SUM(Sales) AS Total_Sales
FROM superstoreorders
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT Product_Name, SUM(Profit) AS Total_Profit
FROM superstoreorders
GROUP BY Product_Name
HAVING SUM(Profit) < 0;

SELECT Product_Name, SUM(Profit) AS Total_Profit
FROM superstoreorders
GROUP BY Product_Name
ORDER BY Total_Profit DESC
LIMIT 5;

SELECT Category,
       SUM(Sales) AS Total_Sales,
       SUM(Profit) AS Total_Profit
FROM superstoreorders
GROUP BY Category
ORDER BY Total_Sales DESC;
SELECT Category,
       SUM(Sales) AS Total_Sales,
       SUM(Profit) AS Total_Profit,
       (SUM(Profit)/SUM(Sales))*100 AS Profit_Margin_Percent
FROM superstoreorders
GROUP BY Category
ORDER BY Profit_Margin_Percent DESC;

SELECT State,
       SUM(Sales) AS Total_Sales
FROM superstoreorders
GROUP BY State
ORDER BY Total_Sales DESC
LIMIT 5;

SELECT MONTH(Order_Date) AS Month,
       SUM(Sales) AS Monthly_Sales
FROM superstoreorders
GROUP BY MONTH(Order_Date)
ORDER BY Month;

SELECT 
    YEAR(Order_Date) AS Year,
    MONTH(Order_Date) AS Month,
    SUM(Sales) AS Monthly_Sales
FROM superstoreorders
GROUP BY YEAR(Order_Date), MONTH(Order_Date)
ORDER BY Year, Month;

SELECT Customer_Name,
       SUM(Profit) AS Total_Profit
FROM superstoreorders
GROUP BY Customer_Name
ORDER BY Total_Profit DESC
LIMIT 5;

DESCRIBE superstoreorders;
SELECT 
    COUNT(DISTINCT ï»¿order_id) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Sales) / COUNT(DISTINCT ï»¿order_id) AS Avg_Order_Value
FROM superstoreorders;

SELECT 
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    (SUM(Profit) / SUM(Sales)) * 100 AS Profit_Margin_Percent
FROM superstoreorders;

SELECT 
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    (SUM(Profit)/SUM(Sales))*100 AS Profit_Margin
FROM superstoreorders
GROUP BY Category
ORDER BY Total_Sales DESC;

SELECT 
    Category,
    SUM(Profit) AS Total_Profit
FROM superstoreorders
GROUP BY Category
HAVING SUM(Profit) < 0;
SELECT 
    Product_Name,
    SUM(Sales) AS Total_Sales
FROM superstoreorders
GROUP BY Product_Name
ORDER BY Total_Sales DESC
LIMIT 10;

SELECT 
    customer_name,
    SUM(Sales) AS Total_Sales,
    RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
FROM superstoreorders
GROUP BY customer_name;

SELECT *
FROM (
    SELECT 
        customer_name,
        SUM(Sales) AS Total_Sales,
        RANK() OVER (ORDER BY SUM(Sales) DESC) AS Sales_Rank
    FROM superstoreorders
    GROUP BY customer_name
) ranked_customers
WHERE Sales_Rank <= 5;

SELECT 
    customer_name,
    COUNT(DISTINCT ï»¿order_id) AS Total_Orders
FROM superstoreorders
GROUP BY customer_name
HAVING COUNT(DISTINCT ï»¿order_id) > 1
ORDER BY Total_Orders DESC;

SELECT 
    YEAR(order_date) AS Year,
    MONTH(order_date) AS Month,
    SUM(Profit) AS Monthly_Profit
FROM superstoreorders
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY Year, Month;

SELECT 
    Category,
    SUM(Profit) AS Total_Profit
FROM superstoreorders
GROUP BY Category
ORDER BY Total_Profit DESC
LIMIT 1;

SELECT 
    Product_Name,
    SUM(Profit) AS Total_Loss
FROM superstoreorders
GROUP BY Product_Name
HAVING SUM(Profit) < 0
ORDER BY Total_Loss ASC
LIMIT 5;

SELECT 
    COUNT(DISTINCT ï»¿order_id) AS Total_Orders,
    COUNT(DISTINCT customer_name) AS Total_Customers,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    (SUM(Profit)/SUM(Sales))*100 AS Profit_Margin
FROM superstoreorders;

SHOW TABLES;
SET SQL_SAFE_UPDATES = 0;


UPDATE superstoreorders
SET order_date = 
CASE
    WHEN order_date LIKE '%/%' 
        THEN STR_TO_DATE(order_date, '%m/%d/%Y')
    WHEN order_date LIKE '%-%' 
        THEN STR_TO_DATE(order_date, '%d-%m-%Y')
END;
ALTER TABLE superstoreorders
MODIFY order_date DATE;

SELECT order_date FROM superstoreorders LIMIT 10;

ALTER TABLE superstoreorders 
CHANGE COLUMN `ï»¿order_id` order_id VARCHAR(50);
SELECT 
    COUNT(DISTINCT order_id) AS Total_Orders,
    COUNT(DISTINCT customer_name) AS Total_Customers,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    (SUM(Profit)/SUM(Sales))*100 AS Profit_Margin
FROM superstoreorders;

SELECT 
    COUNT(DISTINCT order_id) AS Total_Orders,
    SUM(Sales) AS Total_Sales,
    SUM(Sales) / COUNT(DISTINCT order_id) AS Avg_Order_Value
FROM superstoreorders;
