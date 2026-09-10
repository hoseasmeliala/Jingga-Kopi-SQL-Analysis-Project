# ☕ Jingga Kopi — SQL Data Analysis Project

An end-to-end **SQL Data Analysis project** using PostgreSQL to analyze sales, customers, products, and city-level business performance for a fictional Indonesian coffee business, **Jingga Kopi**.

The project demonstrates a complete Data Analyst workflow: starting from relational database design and data validation, continuing with SQL-based business analysis, and finally translating query results into actionable business insights and recommendations.

---

# 📑 Table of Contents

- [📌 Project Overview](#-project-overview)
- [🎯 Business Problem](#-business-problem)
- [🎯 Business Objective](#-business-objective)
- [📂 Dataset Information](#-dataset-information)
- [🔍 Scope of Analysis](#-scope-of-analysis)
- [🛠 Tools & Techniques](#-tools--techniques)
- [🔄 Project Workflow](#-project-workflow)
- [📌 Key Findings](#-key-findings)
- [📈 Business Insights](#-business-insights)
- [💡 Business Recommendations](#-business-recommendations)
- [🎯 Project Outcomes](#-project-outcomes)
- [📁 Repository Structure](#-repository-structure)
- [🚀 Possible Future Improvements](#-possible-future-improvements)
- [👤 About the Author](#-about-the-author)

---

## 📌 Project Overview

**Jingga Kopi** is a fictional coffee business dataset designed to simulate a realistic business environment in Indonesia.

As a Data Analyst, I used PostgreSQL to analyze four related datasets:

- City information
- Customer information
- Product information
- Sales transactions

The project follows an end-to-end analytical workflow:

> **Database Design → Data Import → Data Validation → SQL Analysis → Business Insights → Recommendations**

The analysis focuses on understanding sales performance, product demand, customer value, city-level performance, revenue efficiency, and potential market opportunities. Market potential is treated as a theoretical estimate based on the assumptions documented in the project.

### Dataset at a Glance

| Dataset | Records | Description |
|---|---:|---|
| Cities | 14 | Indonesian cities with population and estimated rental cost |
| Customers | 497 | Customers linked to their respective cities |
| Products | 28 | Coffee and related products with selling prices |
| Sales | 10,388 | Individual sales transactions |

**Analysis period:** January 2024 – October 2025

**Total Revenue:** IDR 341.05 million  
**Total Transactions:** 10,388  
**Average Transaction Value:** approximately IDR 32,831

> **Note:** This is a dummy dataset created for portfolio and analytical practice purposes. Population-based coffee-consumer estimates and rental costs are assumptions used for analysis and do not represent verified market data.

---

## 🎯 Business Problem

Jingga Kopi has transaction data across multiple Indonesian cities but needs a structured way to understand its business performance.

The key business questions are:

1. Which cities have the largest estimated coffee-consumer markets?
2. Which cities generated the highest revenue during Q4 2024?
3. Which products have the highest transaction volume?
4. Which cities generate the highest average revenue per customer?
5. How does population compare with estimated coffee-consumer potential?
6. Which products perform best within each city?
7. Which cities have the largest coffee-product customer bases?
8. How does revenue compare with estimated rental costs?
9. How does monthly revenue change from one month to the next?
10. Which cities rank highest by overall revenue?

---

## 🎯 Business Objective

The main objective is to use SQL to transform raw transactional data into **evidence-based business insights**.

Specifically, this project aims to:

- Build a structured relational database using PostgreSQL.
- Validate data quality before performing analysis.
- Analyze sales and product performance.
- Measure customer value by city.
- Compare market potential across Indonesian cities.
- Identify city-level product preferences.
- Analyze month-over-month revenue changes.
- Compare revenue with estimated rental costs.
- Translate SQL results into business recommendations.

A key principle throughout the project is:

> **Every business insight should be traceable to an analytical result from `03_Analysis.sql`.**

---

## 📂 Dataset Information

The project contains four CSV files.

### 1. `city.csv`

Contains city-level information used for market and location analysis.

Key fields include:

| Column | Description |
|---|---|
| `city_id` | Unique city identifier |
| `city_name` | City name |
| `population` | Estimated population |
| `estimated_rent` | Estimated monthly rental cost |

---

### 2. `customers.csv`

Contains customer master data.

Key fields include:

| Column | Description |
|---|---|
| `customer_id` | Unique customer identifier |
| `customer_name` | Customer name |
| `city_id` | Customer's city |

---

### 3. `products.csv`

Contains product information.

Key fields include:

| Column | Description |
|---|---|
| `product_id` | Unique product identifier |
| `product_name` | Product name |
| `price` | Product selling price |

---

### 4. `sales.csv`

Contains individual sales transactions.

Key fields include:

| Column | Description |
|---|---|
| `sale_id` | Unique transaction identifier |
| `sale_date` | Transaction date |
| `customer_id` | Customer identifier |
| `product_id` | Product identifier |
| `total` | Transaction revenue |

---

## 🔍 Scope of Analysis

The analysis in `03_Analysis.sql` contains **10 business-oriented SQL analyses**.

| Analysis | Business Question | Main SQL Concepts |
|---|---|---|
| Q1 | Estimated coffee-consumer market by city | Aggregation, calculation |
| Q2 | Q4 2024 sales performance by city | Date filtering, JOIN, GROUP BY |
| Q3 | Product transaction performance | LEFT JOIN, aggregation |
| Q4 | Average revenue per customer | `COUNT(DISTINCT)`, aggregation |
| Q5 | Population vs. estimated coffee consumers | Calculation, comparison |
| Q6 | Top 3 products by city | `DENSE_RANK()`, `PARTITION BY` |
| Q7 | Unique coffee customers by city | Filtering, `COUNT(DISTINCT)` |
| Q8 | Revenue vs. estimated rent | CTE, calculation |
| Q9 | Month-over-month revenue growth | CTE, `LAG()`, window functions |
| Q10 | Top cities by overall revenue | CTE, `DENSE_RANK()` |

---

## 🛠 Tools & Techniques

### Tools

- **PostgreSQL** — relational database and SQL analysis
- **Git / GitHub** — project version control and portfolio presentation
- **CSV** — source data format

### SQL Techniques

The project demonstrates:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `INNER JOIN`
- `LEFT JOIN`
- `COUNT()`
- `COUNT(DISTINCT)`
- `SUM()`
- `ROUND()`
- `EXTRACT()`
- Common Table Expressions (`CTE`)
- Window Functions
- `DENSE_RANK()`
- `LAG()`
- `PARTITION BY`
- Date-based analysis
- Data validation
- Referential integrity checks
---

## 🔄 Project Workflow

### Step 1 — Database Schema

The relational database was designed using:

`01_Database_Schema.sql`

The schema establishes relationships between:

```text
CITY
  │
  └── CUSTOMERS
          │
          └── SALES ─── PRODUCTS
```

Primary keys and foreign keys are used to maintain relational integrity.

---

### Step 2 — Data Import

The four CSV files are imported into PostgreSQL in dependency order:

```text
1. city.csv
2. customers.csv
3. products.csv
4. sales.csv
```

This order ensures that referenced records exist before dependent sales transactions are loaded.

---

### Step 3 — Data Validation

Before analysis, `02_Data_Validation.sql` is used to check:

- Record counts
- Duplicate IDs
- Missing values
- Foreign key consistency
- Negative or invalid values
- Date ranges
- Business consistency between transaction totals and product prices

This step ensures that the analysis is based on valid and consistent data.

---

### Step 4 — Business Analysis

`03_Analysis.sql` translates business questions into SQL queries.

The analysis moves from basic aggregation to more advanced SQL techniques such as:

```text
JOIN
   ↓
GROUP BY
   ↓
CTE
   ↓
Window Functions
   ↓
LAG()
   ↓
DENSE_RANK()
```

---

### Step 5 — Business Insights

The results from `03_Analysis.sql` are interpreted in:

[`insights/Business_Insights.md`](insights/Business_Insights.md)

The insight document follows:

```text
SQL Query
   ↓
Query Result
   ↓
Key Finding
   ↓
Business Interpretation
   ↓
Recommendation
```

This ensures that recommendations are evidence-based and traceable to the SQL analysis.

---


## 📌 Key Findings

The key findings below are directly supported by the results of `03_Analysis.sql`.

### 1. Bandung is the highest-revenue city

**SQL Source:** `03_Analysis.sql — Q10`

Bandung generated approximately:

**IDR 71.86 million**

in total revenue, ranking first among the analyzed cities.

---

### 2. Americano is the highest-volume product

**SQL Source:** `03_Analysis.sql — Q3`

Americano recorded:

**1,326 transactions**

making it the highest-volume product in the dataset.

---

### 3. Bandung has the highest average revenue per customer

**SQL Source:** `03_Analysis.sql — Q4`

Bandung generated approximately:

**IDR 1.38 million revenue per unique customer**

which was the highest among the analyzed cities.

---

### 4. Yogyakarta has the largest coffee-product customer base

**SQL Source:** `03_Analysis.sql — Q7`

Yogyakarta recorded:

**69 unique customers**

for the defined coffee-product segment, followed closely by Medan with 68 customers.

---

### 5. Jakarta has the largest estimated coffee-consumer market

**SQL Source:** `03_Analysis.sql — Q1 & Q5`

Using the project's 25% population assumption, Jakarta has an estimated:

**2.67 million coffee consumers**

This represents theoretical market size rather than observed customers.

---

### 6. Bandung has the strongest revenue-to-rent position

**SQL Source:** `03_Analysis.sql — Q8`

Over the same **22-month analysis period (January 2024 – October 2025)**, Bandung recorded:

**0.18x revenue-to-estimated-rent ratio**

This is the highest ratio among the analyzed cities.

> A ratio of 0.18x means cumulative revenue is 0.18 times the estimated rental cost over the same period. It is a screening indicator, not a profitability measure.

> **Important:** Estimated rent is a dummy assumption and does not include other operating costs such as ingredients, labor, utilities, marketing, taxes, or logistics.

---

### 7. September 2024 shows an unusual revenue spike

**SQL Source:** `03_Analysis.sql — Q9`

Multiple cities recorded significant month-over-month revenue increases in September 2024.

Examples:

| City | Previous Revenue | Current Revenue | Growth |
|---|---:|---:|---:|
| Semarang | IDR 225K | IDR 2.15M | +855.6% |
| Yogyakarta | IDR 1.32M | IDR 9.33M | +606.9% |
| Medan | IDR 1.39M | IDR 9.63M | +592.7% |
| Palembang | IDR 1.20M | IDR 8.05M | +573.3% |
| Surabaya | IDR 1.64M | IDR 11.00M | +570.0% |
| Bandung | IDR 2.41M | IDR 15.30M | +536.2% |

The unusually high percentages should **not automatically be interpreted as sustainable business growth**.

For example, Semarang's **+855.6%** increase is partly driven by its relatively low previous-month revenue baseline.

Because multiple cities experienced substantial increases during the same period, **September 2024 should be treated as a revenue spike or potential anomaly requiring further investigation**.

---

## 📈 Business Insights

The detailed business interpretation is available in:

👉 [`Business_Insights.md`](insights/Business_Insights.md)

The main cross-analysis conclusions are:

### Bandung

Bandung performs strongly across multiple dimensions:

- Highest overall revenue
- Highest average revenue per customer
- Strong Q4 2024 performance
- Highest revenue-to-estimated-rent ratio

**Interpretation:** Bandung is currently the strongest-performing market in the dataset.

---

### Jakarta

Jakarta has:

- Largest estimated coffee-consumer market
- High average revenue per customer
- Strong overall revenue
- Higher estimated rental cost

**Interpretation:** Jakarta represents a large market opportunity but requires careful cost management.

---

### Yogyakarta

Yogyakarta has:

- Highest unique coffee-product customer count
- Strong revenue-to-estimated-rent position
- Lower average revenue per customer than Bandung, Surabaya, and Jakarta

**Interpretation:** Yogyakarta combines a relatively large observed customer base with a stronger revenue-to-estimated-rent position, while still having room to improve customer value.

---

### Medan

Medan has:

- Second-highest unique coffee-product customer count
- Lower average revenue per customer

**Interpretation:** The opportunity in Medan may be more focused on increasing spending per existing customer rather than only acquiring new customers.

---

## 💡 Business Recommendations

### 1. Strengthen Bandung as a Core Market

**Evidence:** Q2, Q4, Q8, Q10

Prioritize customer retention, loyalty initiatives, and product availability in Bandung.

---

### 2. Evaluate Yogyakarta for Further Expansion

**Evidence:** Q4, Q7, Q8

Yogyakarta combines a relatively large observed coffee-product customer base with a strong revenue-to-estimated-rent position, while average revenue per customer remains below the strongest cities.

The city should be considered for further expansion evaluation, with emphasis on increasing customer value.

---

### 3. Maintain Jakarta as a Strategic Market

**Evidence:** Q1, Q4, Q8, Q10

Jakarta has the largest theoretical coffee market, but its higher estimated rent requires careful cost management.

---

### 4. Increase Customer Value in Yogyakarta and Medan

**Evidence:** Q4, Q7

Both cities have relatively large observed customer bases but lower average revenue per customer than Bandung, Surabaya, and Jakarta.

Potential actions include:

- Bundling
- Upselling
- Loyalty programs
- Premium product recommendations
- Cross-selling

---

### 5. Protect High-Volume Products

**Evidence:** Q3, Q6

Americano, Espresso, Kopi Susu, and Kopi Susu Gula Aren are important high-volume products.

Maintaining availability and using these products as promotional anchors may help support transaction volume.

---

### 6. Investigate the September 2024 Revenue Spike

**Evidence:** Q9

The unusually large month-over-month increase should be investigated before it is used as evidence of sustainable growth.

Potential areas of investigation include:

- Promotions
- Seasonal demand
- Product launches
- Bulk transactions
- Data-generation patterns

---

## 🎯 Project Outcomes

Through this project, I demonstrated an end-to-end SQL Data Analyst workflow:

### Technical Outcomes

- Designed a relational database schema.
- Applied primary keys and foreign keys.
- Imported and validated CSV data.
- Performed data quality checks.
- Used multiple table joins.
- Applied aggregation and filtering.
- Used `COUNT(DISTINCT)` for unique-customer analysis.
- Applied CTEs for multi-step analysis.
- Used window functions such as `LAG()` and `DENSE_RANK()`.
- Performed time-series and city-level analysis.

### Analytical Outcomes

The project goes beyond writing SQL queries by translating query results into business-oriented conclusions.

The analytical chain is:

> **Raw Data → SQL → Evidence → Insight → Recommendation**

This demonstrates the ability to connect technical SQL skills with business decision-making.

---

## 📁 Repository Structure

```text
Jingga-Kopi-SQL-Analysis-Project/
│
├── README.md
│
├── data/
│   ├── city.csv
│   ├── customers.csv
│   ├── products.csv
│   └── sales.csv
│
├── sql/
│   ├── 01_Database_Schema.sql
│   ├── 01.1_Table_Mapping.pgerd        
│   ├── 02_Data_Validation.sql
│   └── 03_Analysis.sql
│
├── insights/
│   └── Business_Insights.md
│
│
└── visuals/
    ├── data_model.png
    ├── q3_product_performance.png
    ├── q6_top_products_by_city.png
    ├── q8_revenue_vs_rent.png
    ├── q9_monthly_revenue_growth.png
    └── q10_city_revenue_ranking.png

```
### File Description

| File | Purpose |
|---|---|
| `README.md` | Project documentation, methodology, and portfolio overview |
| `data/city.csv` | City-level data including population and estimated rental cost |
| `data/customers.csv` | Customer information and city relationship |
| `data/products.csv` | Product information and pricing |
| `data/sales.csv` | Sales transaction records |
| `sql/01_Database_Schema.sql` | Database and table structure with primary and foreign keys |
| `sql/02_Data_Validation.sql` | Data quality, consistency, and referential integrity checks |
| `sql/03_Analysis.sql` | Business questions and SQL-based analysis |
| `insights/Business_Insights.md` | Key findings, business interpretation, and recommendations |
| `visuals/data_model.png` | Database relationship visualization |
| `visuals/q3_product_performance.png` | Product transaction performance visualization |
| `visuals/q6_top_products_by_city.png` | Top product performance by city |
| `visuals/q8_revenue_vs_rent.png` | Revenue-to-rent comparison by city |
| `visuals/q9_monthly_revenue_growth.png` | Monthly revenue growth analysis |
| `visuals/q10_city_revenue_ranking.png` | City revenue ranking visualization |
---

## 🚀 Possible Future Improvements

The current project focuses on SQL analysis. Future improvements could include:

### 1. Interactive Dashboard

Build a Power BI or Tableau dashboard containing:

- Revenue KPI
- Transaction KPI
- Revenue by city
- Product performance
- Customer performance
- Monthly revenue trend
- City market opportunity

### 2. Customer Satisfaction Analysis

The dataset contains customer rating information. Future analysis could examine:

- Average rating by city
- Rating by product
- Relationship between rating and revenue
- Low-rated products requiring improvement

---

## 👤 About the Author

**Hosea Meliala**

Aspiring **Data Analyst** with a focus on turning data into actionable business insights.

### Core Skills

- Microsoft Excel
- SQL / PostgreSQL
- Power BI 
- Data Cleaning
- Data Validation
- Data Visualization
- Business Analysis

### Portfolio Focus

I am interested in applying data analytics to solve real-world business problems by combining:

> **Technical Data Skills + Analytical Thinking + Business Understanding**

---

## ⭐ Project Summary

This project demonstrates that SQL is not only about writing queries.

The goal is to understand the complete analytical process:

> **Ask the right business question → analyze the data → validate the evidence → interpret the result → recommend an action.**

