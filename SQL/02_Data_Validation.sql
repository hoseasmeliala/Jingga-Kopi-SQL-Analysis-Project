-- ============================================================
-- JINGGA KOPI
-- Sales & Customer Analysis
-- 02 - Data Validation
-- ============================================================
---------------------------------------------------------------

-- Author :
-- Hosea Meliala
-----------------

-- Project Role :
-- Data Analyst
-----------------

-- Project Objective:
-- Validated the dataset to ensure data completeness, 
-- uniqueness, referential integrity, and business consistency, 
-- Before performing the analysis
---------------------------------------------------------------


-- ============================================================
-- 1. RECORD COUNT
-- Check the number of records in each table
-- ============================================================

SELECT 'city' AS table_name, COUNT(*) AS total_records
FROM city

UNION ALL

SELECT 'customers', COUNT(*)
FROM customers

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'sales', COUNT(*)
FROM sales;


-- ============================================================
-- 2. PRIMARY KEY DUPLICATION
-- Check duplicate IDs in each table
-- ============================================================

-- City
SELECT
city_id,
COUNT(*) AS duplicate_count
FROM city
GROUP BY city_id
HAVING COUNT(*) > 1;

-- Customers
SELECT
customer_id,
COUNT(*) AS duplicate_count
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

-- Products
SELECT
product_id,
COUNT(*) AS duplicate_count
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

-- Sales
SELECT
sale_id,
COUNT(*) AS duplicate_count
FROM sales
GROUP BY sale_id
HAVING COUNT(*) > 1;


-- ============================================================
-- 3. NULL VALUE CHECK
-- Check missing values in important columns
-- ============================================================

-- City
SELECT *
FROM city
WHERE city_id IS NULL
OR city_name IS NULL
OR population IS NULL
OR estimated_rent IS NULL;

-- Customers
SELECT *
FROM customers
WHERE customer_id IS NULL
OR customer_name IS NULL
OR city_id IS NULL;

-- Products
SELECT *
FROM products
WHERE product_id IS NULL
OR product_name IS NULL
OR price IS NULL;

-- Sales
SELECT *
FROM sales
WHERE sale_id IS NULL
OR customer_id IS NULL
OR product_id IS NULL
OR sale_date IS NULL
OR total IS NULL;



-- ============================================================
-- 4. FOREIGN KEY VALIDATION
-- Check whether customer city_id exists in city table
-- ============================================================

SELECT
c.customer_id,
c.customer_name,
c.city_id
FROM customers as c
LEFT JOIN city as ci
ON c.city_id = ci.city_id
WHERE ci.city_id IS NULL;

-- Check whether sales customer_id exists in customers table
SELECT
s.sale_id,
s.customer_id
FROM sales as s
LEFT JOIN customers as c
ON s.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

-- Check whether sales product_id exists in products table
SELECT
s.sale_id,
s.product_id
FROM sales as s
LEFT JOIN products as p
ON s.product_id = p.product_id
WHERE p.product_id IS NULL;



-- ============================================================
-- 5. NUMERIC VALUE VALIDATION
-- Check for invalid negative values
-- ============================================================

-- Population should not be negative
SELECT *
FROM city
WHERE population < 0;

-- Estimated rent should not be negative
SELECT *
FROM city
WHERE estimated_rent < 0;

-- Product price should not be negative
SELECT *
FROM products
WHERE price < 0;

-- Sales total should not be negative
SELECT *
FROM sales
WHERE total < 0;

-- ============================================================
-- 6. TEXT DUPLICATION
-- Check duplicate city names
-- ============================================================

SELECT
LOWER(TRIM(city_name)) AS city_name,
COUNT(*) AS total
FROM city
GROUP BY LOWER(TRIM(city_name))
HAVING COUNT(*) > 1;

-- Check duplicate product names
SELECT
LOWER(TRIM(product_name)) AS product_name,
COUNT(*) AS total
FROM products
GROUP BY LOWER(TRIM(product_name))
HAVING COUNT(*) > 1;




-- ============================================================
-- 7. DATE VALIDATION
-- Check sales date range
-- ============================================================

SELECT
MIN(sale_date) AS earliest_sale_date,
MAX(sale_date) AS latest_sale_date
FROM sales;

-- Check future transactions
SELECT *
FROM sales
WHERE sale_date > CURRENT_DATE;




-- ============================================================
-- 8. DATA TYPE / BUSINESS LOGIC CHECK
-- Check unusual sales values
-- ============================================================

SELECT
MIN(total) AS minimum_sale,
MAX(total) AS maximum_sale,
AVG(total) AS average_sale
FROM sales;

-- Check products with zero price
SELECT *
FROM products
WHERE price = 0;

-- Check cities with zero population
SELECT *
FROM city
WHERE population = 0;

-- ============================================================
-- 9. SALES CONSISTENCY CHECK
-- Compare sales total with product price
-- ============================================================

SELECT
s.sale_id,
s.product_id,
p.product_name,
p.price,
s.total
FROM sales as s
JOIN products as p
ON s.product_id = p.product_id
WHERE s.total <> p.price;




-- ============================================================
-- 10. FINAL DATA QUALITY SUMMARY
-- ============================================================

SELECT
(SELECT COUNT(*) FROM city) AS total_city,
(SELECT COUNT(*) FROM customers) AS total_customer,
(SELECT COUNT(*) FROM products) AS total_product,
(SELECT COUNT(*) FROM sales) AS total_transaction;
