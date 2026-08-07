-- ============================================================
-- JINGGA KOPI
-- Sales & Customer Analysis
-- 03 - Analysis Using PostgreSQL
-- ============================================================
---------------------------------------------------------------

-- Author :
-- Hosea Meliala
-----------------

-- Project Role :
-- Data Analyst
-----------------

-- Project Objective:
-- Analyze sales performance, customer behavior, product demand,
-- monthly growth, and city-level market potential.
---------------------------------------------------

-- Main Tables:
--   city
--   customers
--   products
--   sales
----------

-- ============================================================

-- ============================================================
-- 0. DATA OVERVIEW
-- ============================================================

SELECT * FROM city;

SELECT * FROM products;

SELECT * FROM customers;

SELECT * FROM sales;




-- ============================================================
-- 1. ESTIMATED COFFEE CONSUMERS BY CITY
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- How many people are estimated to consume coffee in each city,
-- assuming that 25% of the total population are coffee consumers?
------------------------------------------------------------------

-- SQL Concepts:
-- Arithmetic operations, ROUND(), ORDER BY
-------------------------------------------

-- Assumption:
-- Estimated coffee consumers = 25% of city population.
-- ============================================================

SELECT
		city_name,
		ROUND((population * 0.25) / 1000000, 2)
		AS estimated_coffee_consumers_million,
		city_rank
FROM city
ORDER BY estimated_coffee_consumers_million DESC;





-- ============================================================
-- 2. Q4 2024 SALES PERFORMANCE BY CITY
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- How much revenue was generated during Q4 2024,
-- and which cities contributed the most revenue?
-------------------------------------------------

-- SQL Concepts:
-- EXTRACT(), JOIN, SUM(), GROUP BY
-- ============================================================

SELECT
		ci.city_name,
		SUM(s.total) AS total_revenue
		FROM sales AS s

JOIN customers AS c
ON s.customer_id = c.customer_id

JOIN city AS ci
ON c.city_id = ci.city_id

WHERE 
		EXTRACT(YEAR FROM s.sale_date) = 2024
		AND 
		EXTRACT(QUARTER FROM s.sale_date) = 4

GROUP BY ci.city_name
ORDER BY total_revenue DESC;





-- ============================================================
-- 3. PRODUCT SALES PERFORMANCE
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- Which products have the highest number of transactions?
----------------------------------------------------------

-- SQL Concepts:
-- LEFT JOIN, COUNT(), GROUP BY, ORDER BY
-----------------------------------------

-- LEFT JOIN is used to ensure that products with no sales
-- are still included in the result.
-- ============================================================

SELECT
		p.product_name,
		COUNT(s.sale_id) AS total_orders
		FROM products AS p

LEFT JOIN sales AS s
ON p.product_id = s.product_id

GROUP BY p.product_name
ORDER BY total_orders DESC;




-- ============================================================
-- 4. AVERAGE REVENUE PER CUSTOMER BY CITY
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- How much revenue is generated on average per unique customer
-- in each city?
----------------

-- Example:
-- If a city generates IDR 50 million from 5 unique customers,
-- the average revenue per customer is IDR 10 million.
------------------------------------------------------

-- SQL Concepts:
-- Multiple JOINs, SUM(), COUNT(DISTINCT), ROUND(), CAST
--------------------------------------------------------

-- COUNT(DISTINCT) prevents customers with multiple transactions
-- from being counted more than once.
-- ============================================================

SELECT
		ci.city_name,
		SUM(s.total) AS total_revenue,
		COUNT(DISTINCT c.customer_id) AS total_customers,


		ROUND
		(
		    SUM(s.total)::numeric
		    / COUNT(DISTINCT c.customer_id)::numeric,
		    2
		) AS avg_revenue_per_customer


FROM sales AS s

JOIN customers AS c
ON s.customer_id = c.customer_id

JOIN city AS ci
ON c.city_id = ci.city_id

GROUP BY ci.city_name
ORDER BY avg_revenue_per_customer DESC;




-- ============================================================
-- 5. CITY POPULATION AND ESTIMATED COFFEE CONSUMERS
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- What is the population of each city and its estimated
-- coffee consumer market?
--------------------------

-- Assumption:
-- 25% of the population is estimated to consume coffee.
-- ============================================================

SELECT
		city_name,
		population,
		ROUND((population * 0.25) / 1000000, 2) AS estimated_coffee_consumers_million
FROM city
ORDER BY population DESC;





-- ============================================================
-- 6. TOP 3 PRODUCTS BY CITY
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- What are the top 3 best-selling products in each city
-- based on the number of transactions?
---------------------------------------

-- SQL Concepts:
-- Multiple JOINs, GROUP BY, DENSE_RANK(), PARTITION BY
-------------------------------------------------------

-- DENSE_RANK() creates a ranking independently for each city.
-- PARTITION BY resets the ranking for every city.
-- ============================================================

WITH product_sales AS 
(

		SELECT 
		    ci.city_name,
		    p.product_name,
		    COUNT(s.sale_id) AS total_orders,
		
		    DENSE_RANK() OVER (
		        PARTITION BY ci.city_name
		        ORDER BY COUNT(s.sale_id) DESC
		    ) AS product_rank

	FROM sales AS s
	
	JOIN products AS p
	    ON s.product_id = p.product_id
	
	JOIN customers AS c
	    ON s.customer_id = c.customer_id
	
	JOIN city AS ci
	    ON c.city_id = ci.city_id
	
	GROUP BY
	    ci.city_name,
	    p.product_name
)

SELECT
	city_name,
	product_name,
	total_orders,
	product_rank
FROM product_sales
WHERE product_rank <= 3

ORDER BY city_name, product_rank;




-- ============================================================
-- 7. UNIQUE CUSTOMERS BY CITY
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- How many unique customers have purchased coffee products
-- in each city?
----------------

-- Business Rule:
-- Product IDs 1–14 are classified as coffee products
-- in this dataset.
-------------------

-- SQL Concepts:
-- COUNT(DISTINCT), JOIN, WHERE, GROUP BY
-- ============================================================

SELECT
		ci.city_name,
		COUNT(DISTINCT c.customer_id) AS unique_customers

FROM sales AS s

JOIN customers AS c
ON s.customer_id = c.customer_id

JOIN city AS ci
ON c.city_id = ci.city_id

WHERE s.product_id <= 14

GROUP BY ci.city_name
ORDER BY unique_customers DESC;





-- ============================================================
-- 8. REVENUE VS. ESTIMATED RENT BY CITY
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- How does average revenue per customer compare with
-- estimated rental cost per customer in each city?
---------------------------------------------------

-- SQL Concepts:
-- Aggregation, COUNT(DISTINCT), arithmetic operations, ROUND()
---------------------------------------------------------------

-- Note:
-- Estimated rent is treated as a monthly business cost
-- assumption for this dummy dataset.
-- ============================================================

SELECT
		ci.city_name,
		ci.estimated_rent,
		COUNT(DISTINCT c.customer_id) AS total_customers,


		ROUND
		(
		    SUM(s.total)::numeric
		    / COUNT(DISTINCT c.customer_id)::numeric,
		    2
		) AS avg_revenue_per_customer,


		ROUND
		(
		    ci.estimated_rent::numeric
		    / COUNT(DISTINCT c.customer_id)::numeric,
		    2
		) AS avg_rent_per_customer


FROM sales AS s

JOIN customers AS c
ON s.customer_id = c.customer_id

JOIN city AS ci
ON c.city_id = ci.city_id

GROUP BY
ci.city_name,
ci.estimated_rent

ORDER BY avg_revenue_per_customer DESC;




-- ============================================================
-- 9. MONTH-OVER-MONTH REVENUE GROWTH BY CITY
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- How does monthly revenue change from one month to the next
-- in each city?
----------------

-- SQL Concepts:
-- CTE, EXTRACT(), SUM(), LAG(), Window Function
------------------------------------------------

-- LAG() retrieves the previous month's revenue so that
-- month-over-month growth can be calculated.
-- ============================================================

WITH monthly_sales AS 
(
			SELECT
			    ci.city_name,
			    EXTRACT(YEAR FROM s.sale_date) AS year,
			    EXTRACT(MONTH FROM s.sale_date) AS month,
			    SUM(s.total) AS total_revenue

	FROM sales AS s
	
	JOIN customers AS c
	    ON s.customer_id = c.customer_id
	
	JOIN city AS ci
	    ON c.city_id = ci.city_id
	
	GROUP BY
	    ci.city_name,
	    EXTRACT(YEAR FROM s.sale_date),
	    EXTRACT(MONTH FROM s.sale_date)
),

revenue_growth AS 
(
		SELECT
		    city_name,
		    year,
		    month,
		    total_revenue AS current_month_revenue,
		
		    LAG(total_revenue) OVER (
		        PARTITION BY city_name
		        ORDER BY year, month
		    ) AS previous_month_revenue

FROM monthly_sales
)

SELECT
	city_name,
	year,
	month,
	current_month_revenue,
	previous_month_revenue,

	ROUND
	(
		((current_month_revenue - previous_month_revenue)
	        / previous_month_revenue )::numeric * 100, 2
	) AS revenue_growth_pct
	
FROM revenue_growth
WHERE previous_month_revenue IS NOT NULL

ORDER BY city_name, year, month;




-- ============================================================
-- 10. MARKET POTENTIAL & CITY EXPANSION ANALYSIS
-- ============================================================
---------------------------------------------------------------

-- Business Question:
-- Which cities show the strongest sales performance and
-- market potential based on revenue, customers, population,
-- and estimated rental cost?
-----------------------------

-- Metrics:
--   - Total revenue
--   - Estimated rent
--   - Unique customers
--   - Estimated coffee consumers
--   - Average revenue per customer
--   - Average rent per customer
--------------------------------

-- The final result identifies the top 3 cities by revenue.

-- SQL Concepts:
-- Aggregation, COUNT(DISTINCT), ROUND(), DENSE_RANK()
-- ============================================================

WITH city_analysis AS 
(
	SELECT
	    ci.city_name,
	    SUM(s.total) AS total_revenue,
	    ci.estimated_rent AS estimated_rent,
	
	    COUNT(DISTINCT c.customer_id) AS unique_customers,
	
	    ROUND(
	        (ci.population * 0.25) / 1000000, 3
	    ) AS estimated_coffee_consumers_million,
	
	    ROUND(
	        SUM(s.total)::numeric
	        / COUNT(DISTINCT c.customer_id)::numeric, 2
	    ) AS avg_revenue_per_customer,
	
	    ROUND(
	        ci.estimated_rent::numeric
	        / COUNT(DISTINCT c.customer_id)::numeric, 2
	    ) AS avg_rent_per_customer
	
	FROM sales AS s
	JOIN customers AS c
	    ON s.customer_id = c.customer_id
	JOIN city AS ci
	    ON c.city_id = ci.city_id
	GROUP BY
	    ci.city_name,
	    ci.estimated_rent,
	    ci.population
),

ranked_cities AS 
(
	SELECT
	    *, 		-- (*) take all column from city_analysis table
	    DENSE_RANK() OVER (ORDER BY total_revenue DESC) AS revenue_rank
	FROM city_analysis
)

SELECT
	city_name,
	total_revenue,
	estimated_rent,
	unique_customers,
	estimated_coffee_consumers_million,
	avg_revenue_per_customer,
	avg_rent_per_customer,
	revenue_rank

FROM ranked_cities
WHERE revenue_rank <= 3
ORDER BY revenue_rank;

