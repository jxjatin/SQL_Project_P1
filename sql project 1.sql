use sq_project_p1;

create table retail_sales 
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
    )  ;  
    
ALTER TABLE retail_sales
CHANGE COLUMN quantiy quantity int;


select * from retail_sales; 

# DATA CLEANING CHECKING FOR ANY NULL VALUES IN THE DATA

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
    OR 	total_sale is null
    ;
    
    
# DATA EXPLORATION
#---- HOW MANY SALES WE HAVE ??
    
select COUNT(*) as Total_sales from retail_sales; 
    
# --- HOW MANY CUSTOMER WE HAVE??

select COUNT(DISTINCT customer_id) as Total_sales from retail_sales; 

# --- HOW MANY CATEGORY WE HAVE??

select COUNT(DISTINCT category) as Total_sales from retail_sales; 

# DATA ANALYSIS & KEY BUSINESS PROBLEMS / MY ANALYSIS
# ___ Q-1. SALES FOR A SPECIFIC DATA LIKE '2022-12-16'

SELECT * FROM retail_sales
WHERE sale_date = '2022-12-16';


# __ Q-2. ALL THE TRANSACTIONS WHERE CATEGORY IS CLOTHING AND THE QUANTITY SOLD IS MORE THAN 3 FOR THE MONTH OF NOV-2022

SELECT * FROM retail_sales
WHERE 
	category= 'Clothing'
	AND
	quantiy >= 3
    AND
	sale_date >= '2022-11-01'
	AND 
	sale_date < '2022-12-01';
    
# __ Q-3. CALCULATING THE TOTAL SALES (total_sale) FOR EACH CATEGORY

SELECT  
	category,
    sum(total_sale) AS Total_sales,
    count(*)  AS Total_orders
FROM 
	retail_sales
GROUP BY
	category;
    
# ___ Q-4. AVERAGE AGE OF THE CUSTOMERS WHO HAVE PURCHASED THE ITEMS FROM CATEGORY 'beauty'

SELECT  
	category,
    round(AVG(age),2) As average_age
FROM  
	retail_sales
WHERE 
	category = 'beauty';

# ___ Q-5. ALL THE TRANSACTIONS WHERE TOTAL SALES IS GREATER THAN 1000

SELECT * FROM  retail_sales
WHERE total_sale > 1000;


# ___ Q-6. NUMBER OF TRANSASCTION DONE BY THE GENDER IN EACH CATEGORY 

SELECT  
	category, gender ,count(*) AS Total_transactoins
FROM 
	retail_sales
GROUP BY 
	category, gender
ORDER BY 
	category ;

# ___ Q-7. CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND THE BEST SELLING MONTH OF THE YEAR

SELECT * FROM
	(SELECT 
		YEAR(sale_date) AS YEAR,
		MONTHNAME(sale_date) AS MONTH,
		round(AVG(total_sale),2) AS avg_sale,
		RANK() 
		OVER (PARTITION BY YEAR(sale_date) 
		ORDER BY AVG(total_sale) DESC) 
		AS RANK_NO
	FROM 
		retail_sales
	GROUP BY 
		YEAR,MONTH) AS T1
WHERE 
	RANK_NO = 1 ;
			
# ___ Q-8. TOP 5 CUSTOMERS BASED ON THE HIGHEST TOTAL SALES
        
SELECT 
	customer_id,
    sum(total_Sale) AS Total_Sale	
FROM  
	retail_sales
GROUP BY 
	customer_id 
ORDER BY 
	total_sale DESC 
LIMIT 5 ;

# ___ Q-9. NO OF UNIQUE CUSTOMER WHO HAVE PURCHASED FORM EACH CATEGORY



SELECT 
	category,
	count(distinct customer_id) AS unique_customer
FROM  
	retail_sales
GROUP BY
	category;
    
# ___ Q-10. SHIFT WISE SALES COUNT (here we will create a new column 'shift' MORNING <12 , AFTERNOON BETWEEN 12 & 17 , ELSE EVENING >17)

WITH hourly_sales AS (
    SELECT *,
           CASE
               WHEN HOUR(sale_time) < 12 THEN 'MORNING SHIFT'
               WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON SHIFT'
               ELSE 'EVENING SHIFT'
           END AS shift
    FROM retail_sales
)
SELECT shift,
       COUNT(*) AS sales_count
FROM hourly_sales
GROUP BY shift;

# ___ Q-11. TOTAL SALE FOR BOTH THE YEAR  

SELECT 
	year(sale_date) AS YEAR,
    sum(total_sale) AS NET_SALE
FROM
	retail_sales
GROUP BY
	YEAR

# --  END OF THE PROJECT
