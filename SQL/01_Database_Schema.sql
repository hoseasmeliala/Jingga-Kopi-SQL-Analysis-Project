-- ============================================================
-- JINGGA KOPI
-- Sales & Customer Analysis
-- 01 - Database Schema
-- ============================================================
---------------------------------------------------------------

-- Author :
-- Hosea Meliala
-----------------

-- Project Role :
-- Data Analyst
-----------------

-- Project Objective:
-- Build a relational database structure to support sales,
-- customer, product, and city-level business analysis.
-------------------------------------------------------

-- Database:
-- PostgreSQL
-------------


-- Tables:
--   1. city
--   2. customers
--   3. products
--   4. sales
-------------

-- Data Relationships:
--   city       1 ──── * customers
--   customers 1 ──── * sales
--   products  1 ──── * sales
-----------------------------


-- ============================================================


-- ============================================================
-- 1. CLEANUP
-- ============================================================
---------------------------------------------------------------

-- Drop existing tables before recreating the schema.
-- Tables are dropped in reverse dependency order to avoid
-- foreign key constraint conflicts.
-- ============================================================

DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS city;



-- ============================================================
-- 2. CITY TABLE
-- ============================================================
---------------------------------------------------------------

-- Purpose:
-- Stores city-level information used for geographic and
-- market potential analysis.
-----------------------------

-- Business Attributes:
--   population       : Total population of the city
--   estimated_rent   : Estimated rental cost for business
--   city_rank        : Relative city ranking in the dataset
------------------------------------------------------------

-- ============================================================

CREATE TABLE city (
	city_id         INTEGER PRIMARY KEY,
	city_name       VARCHAR(100) NOT NULL,
	population      BIGINT NOT NULL,
	estimated_rent  NUMERIC(15,2) NOT NULL,
	city_rank       INTEGER NOT NULL,
	
CONSTRAINT chk_city_population
    CHECK (population >= 0),

CONSTRAINT chk_city_rent
    CHECK (estimated_rent >= 0),

CONSTRAINT chk_city_rank
    CHECK (city_rank > 0)
);


-- ============================================================
-- 3. CUSTOMERS TABLE
-- ============================================================
---------------------------------------------------------------

-- Purpose:
-- Stores customer information and links each customer
-- to their city.
-----------------

-- Relationship:
-- city 1 ──── * customers
--------------------------

-- ============================================================

CREATE TABLE customers (
	customer_id     INTEGER PRIMARY KEY,
	customer_name   VARCHAR(150) NOT NULL,
	city_id         INTEGER NOT NULL,

CONSTRAINT fk_customer_city
    FOREIGN KEY (city_id)
    REFERENCES city(city_id)
);



-- ============================================================
-- 4. PRODUCTS TABLE
-- ============================================================
---------------------------------------------------------------

-- Purpose:
-- Stores the products offered by Jingga Kopi and their
-- respective selling prices.
-----------------------------

-- ============================================================

CREATE TABLE products (
	product_id      INTEGER PRIMARY KEY,
	product_name    VARCHAR(150) NOT NULL,
	price           NUMERIC(15,2) NOT NULL,
CONSTRAINT chk_product_price
    CHECK (price >= 0)
);



-- ============================================================
-- 5. SALES TABLE
-- ============================================================
---------------------------------------------------------------

-- Purpose:
-- Stores individual sales transactions.
----------------------------------------

-- Relationships:
-- customers 1 ──── * sales
-- products  1 ──── * sales
---------------------------

-- Each transaction is associated with:
--   - One customer
--   - One product
--   - One transaction date
--   - One transaction value
----------------------------

-- ============================================================

CREATE TABLE sales (
	sale_id         INTEGER PRIMARY KEY,
	customer_id     INTEGER NOT NULL,
	product_id      INTEGER NOT NULL,
	sale_date       DATE NOT NULL,
	total           NUMERIC(15,2) NOT NULL,
CONSTRAINT fk_sales_customer
    FOREIGN KEY (customer_id)
    REFERENCES customers(customer_id),

CONSTRAINT fk_sales_product
    FOREIGN KEY (product_id)
    REFERENCES products(product_id),

CONSTRAINT chk_sales_total
    CHECK (total >= 0)
);



-- ============================================================
-- 6. INDEXES
-- ============================================================
---------------------------------------------------------------

-- Indexes are created on frequently joined foreign key columns
-- to improve query performance when working with larger datasets.
------------------------------------------------------------------

-- ============================================================

CREATE INDEX idx_customers_city_id
	ON customers(city_id);

CREATE INDEX idx_sales_customer_id
	ON sales(customer_id);

CREATE INDEX idx_sales_product_id
	ON sales(product_id);

CREATE INDEX idx_sales_sale_date
	ON sales(sale_date);



-- ============================================================
-- 7. SCHEMA VALIDATION
-- ============================================================
---------------------------------------------------------------

-- Verify that the four main tables have been created.
-- ============================================================

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_name IN (
	'city',
	'customers',
	'products',
	'sales'
)
ORDER BY table_name;



-- ============================================================
-- END OF SCHEMA
-- ============================================================
---------------------------------------------------------------

-- The database is now ready for:
--   1. Data import
--   2. Data validation
--   3. Exploratory analysis
--   4. Business analysis
-------------------------

-- ============================================================
