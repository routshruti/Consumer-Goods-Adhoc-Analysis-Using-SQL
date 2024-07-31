#1. Provide the list of markets in which customer "Atliq Exclusive" operates its business in the APAC region.

SELECT DISTINCT market
FROM dim_customer
WHERE customer= 'Atliq Exclusive'
AND region = 'APAC'

#2. What is the percentage of unique product increase in 2021 vs. 2020?

WITH cte1 AS
        (SELECT COUNT(DISTINCT product_code) AS unique_products_2020
         FROM fact_sales_monthly
         WHERE fiscal_year = 2020),
	 cte2 AS
        (SELECT COUNT(DISTINCT product_code) AS unique_products_2021
         FROM fact_sales_monthly
         WHERE fiscal_year = 2021)
SELECT 
    cte1.unique_products_2020,
    cte2.unique_products_2021,
    ROUND(((cte2.unique_products_2021 - cte1.unique_products_2020) / cte1.unique_products_2020) * 100,2) AS percentage_chg
FROM cte1, cte2

#3. Provide a report with all the unique product counts for each segment and sort them in descending order of product counts.

SELECT segment, COUNT(DISTINCT p.product_code) AS product_count
FROM dim_product as p
GROUP BY segment

#4. Which segment had the most increase in unique products in 2021 vs 2020?

WITH cte1 AS
        (SELECT segment AS A, COUNT(DISTINCT p.product_code) AS B
        FROM dim_product AS p
        JOIN fact_sales_monthly AS s
          ON p.product_code = s.product_code
        WHERE fiscal_year = 2020
        GROUP BY segment),
     cte2 AS
	    (SELECT segment AS A, COUNT(DISTINCT p.product_code) AS D
        FROM dim_product AS p
        JOIN fact_sales_monthly AS s
          ON p.product_code = s.product_code
        WHERE fiscal_year = 2021
        GROUP BY segment)
SELECT cte1.A AS segment, cte1.B AS product_count_2020, cte2.D product_count_2021, (cte2.D- cte1.B) AS difference
FROM cte1
JOIN cte2
  ON cte1.A = cte2.A

#5. Get the products that have the highest and lowest manufacturing costs.

SELECT p.product_code, product, manufacturing_cost
FROM dim_product AS p
JOIN fact_manufacturing_cost AS m
  ON p.product_code = m.product_code
WHERE manufacturing_cost IN 
                          (SELECT MAX(manufacturing_cost) 
                           FROM fact_manufacturing_cost
						   UNION
                           SELECT MIN(manufacturing_cost)
                           FROM fact_manufacturing_cost)
ORDER BY manufacturing_cost DESC
                           
#6. Generate a report which contains the top 5 customers who received an average high pre_invoice_discount_pct for the fiscal year 2021 and in the Indian market.

SELECT c.customer_code, customer, ROUND(AVG(pre_invoice_discount_pct),4) AS average_discount_percentage
FROM dim_customer AS c
JOIN fact_pre_invoice_deductions AS i
  ON c.customer_code = i.customer_code
WHERE fiscal_year = 2021
AND market = 'India'
GROUP BY c.customer_code, customer
ORDER BY average_discount_percentage DESC
LIMIT 5

#7. Get the complete report of the Gross sales amount for the customer “Atliq Exclusive” for each month.

SELECT MonthName(date) AS month, YEAR(date) AS year, CONCAT(ROUND(SUM(gross_price*sold_quantity)/1000000,2), ' M') AS gross_sales_amount
FROM fact_gross_price AS p
JOIN fact_sales_monthly AS s
USING (product_code)
JOIN dim_customer AS c
USING (customer_code)
WHERE customer = 'Atliq Exclusive'
GROUP BY month, year
ORDER BY year ASC

#8. In which quarter of 2020, got the maximum total_sold_quantity? 

SELECT QUARTER(date) AS quarter, SUM(sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly
WHERE YEAR(date) = 2020
GROUP BY quarter
ORDER BY total_sold_quantity

#9. Which channel helped to bring more gross sales in the fiscal year 2021 and the percentage of contribution?

SELECT channel, CONCAT(ROUND(SUM(gross_price * sold_quantity)/1000000,2), ' M') AS gross_sales_mln, 
ROUND(SUM(gross_price * sold_quantity)/(SELECT sum(gross_price * sold_quantity) AS total_sales
                                        FROM fact_gross_price AS p
                                        JOIN fact_sales_monthly AS s
                                          ON p.product_code = s.product_code
				        WHERE s.fiscal_year = 2021)*100,2) AS percentage
FROM dim_customer AS c
JOIN fact_sales_monthly AS s
  ON c.customer_code = s.customer_code
JOIN fact_gross_price AS p
  ON p.product_code = s.product_code
WHERE s.fiscal_year = 2021
GROUP BY channel
Order by percentage 

#10. Get the Top 3 products in each division that have a high total_sold_quantity in the fiscal_year 2021? 

WITH cte AS
       (SELECT division, p.product_code, product, SUM(sold_quantity) AS total_sold_quantity,
       rank() OVER(PARTITION BY division ORDER BY SUM(sold_quantity) DESC) AS rank_order
       FROM dim_product AS p
       JOIN fact_sales_monthly AS s
         ON p.product_code = s.product_code
       WHERE fiscal_year = 2021
       GROUP BY division, p.product_code, product)
SELECT *
FROM cte
WHERE rank_order < 4
  