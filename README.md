# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sq_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sq_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sq_project_p1;

CREATE TABLE retail_sales
(
    transactions_id INT Primary key,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(15),
    age INT,
    category VARCHAR(20),
    quantiy INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);  
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select COUNT(*) as Total_sales from retail_sales; 

select COUNT(DISTINCT customer_id) as Customers_count from retail_sales; 

select COUNT(DISTINCT category) as Total_Categorey from retail_sales; 

select * from retail_sales
    where
        transactions_id is null
    OR 	sale_date is null
    OR 	sale_time is null
    OR 	customer_id is null
    OR	gender is null
    OR 	age is null
    OR 	category is null
    OR 	quantity  is null
    OR 	price_per_unit is null
    OR 	cogs is null
    OR 	total_sale is nulL ;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **SALES FOR A SPECIFIC DATA LIKE '2022-12-16'**.:
```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-12-16';
```

2. **ALL THE TRANSACTIONS WHERE CATEGORY IS CLOTHING AND THE QUANTITY SOLD IS >=3 FOR THE MONTH OF MAY-2022**.:
```sql
SELECT * FROM retail_sales
WHERE 
    category = 'Clothing'
    AND quantity >= 3
    AND sale_date >= '2022-05-01'
    AND sale_date < '2022-06-01';
```

3. ** CALCULATING THE TOTAL SALES (total_sale) AND TOTAL ORDERS FOR EACH CATEGORY.**:
```sql
SELECT  
    category,
    sum(total_sale) AS Total_sales,
    count(*)  AS Total_orders
FROM retail_sales
GROUP BY category;
```

4. **AVERAGE AGE OF THE CUSTOMERS WHO HAVE PURCHASED THE ITEMS FROM THE 'beauty' CATEGORY.**:
```sql
SELECT  
    category,
    round(AVG(age),2) As average_age
FROM retail_sales
WHERE category = 'beauty';
```

5. **ALL THE TRANSACTIONS WHERE THE TOTAL SALES IS GREATER THAN 1000.**:
```sql
SELECT * FROM  retail_sales
WHERE total_sale > 1000;
```

6. **TOTAL NUMBER OF TRANSASCTION MADE BY THE EACH GENDER IN EACH CATEGORY .**:
```sql
SELECT
    category,
    gender ,
    count(*) AS Total_transactoins
FROM retail_sales
GROUP BY category, gender
ORDER BY category ;
```

7. **CALCULATE THE AVERAGE SALE FOR EACH MONTH AND ALSO FIND THE BEST SELLING MONTH OF THE YEAR**:
```sql
SELECT * FROM
(
    SELECT 
	YEAR(sale_date) AS YEAR,
	MONTHNAME(sale_date) AS MONTH,
	round(AVG(total_sale),2) AS avg_sale,
	RANK() OVER (PARTITION BY YEAR(sale_date) 
	ORDER BY AVG(total_sale) DESC) 
	 AS RANK_NO
   FROM retail_sales
   GROUP BY YEAR,MONTH
)
AS table1
WHERE RANK_NO = 1 ;
```

8. **A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES**:
```sql
SELECT 
    customer_id,
    sum(total_Sale) AS Total_Sale	
FROM  retail_sales
GROUP BY customer_id 
ORDER BY total_sale DESC 
LIMIT 5 ;
```

9. **A SQL QUERY TO FIND NO OF UNIQUE CUSTOMER WHO HAVE PURCHASED FORM EACH CATEGORY.**:
```sql
SELECT 
	category,
	count(distinct customer_id) AS unique_CS
FROM retail_sales
GROUP BY category;
```

10. **A SQL QUERY TO FIND SHIFT WISE SALES COUNT (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
WITH hourly_sales AS
 (
    SELECT *,
           CASE
               WHEN HOUR(sale_time) < 12 THEN 'MORNING SHIFT'
               WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON SHIFT'
               ELSE 'EVENING SHIFT'
           END AS shift
    FROM retail_sales
)
SELECT
    shift,
    COUNT(*) AS sales_count
FROM hourly_sales
GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - JATIN THAKUR

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

### Social links to join

For more content on SQL, data analysis, and other data-related topics, make sure to follow me on social media and join our community:

- **LinkedIn**: [Connect with me professionally](www.linkedin.com/in/jatinthakur2004)
- **Discord**: [Connect with me on discord ](https://discord.com/channels/@me/1277548719750909982)

Thank you for your support, and I look forward to connecting with you!
