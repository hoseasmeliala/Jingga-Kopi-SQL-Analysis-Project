# ☕ Jingga Kopi — SQL Data Analysis

![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?logo=postgresql&logoColor=white)
![SQL](https://img.shields.io/badge/Language-SQL-4479A1?logo=sql&logoColor=white)
![Data Analysis](https://img.shields.io/badge/Focus-Data%20Analysis-blue)
![Status](https://img.shields.io/badge/Project-Completed-success)

An end-to-end **SQL Data Analysis project** using PostgreSQL to analyze sales, customers, products, and city-level business performance for a fictional Indonesian coffee business, **Jingga Kopi**.

The project demonstrates how I approached a business problem as a Data Analyst: starting from relational database design and data validation, continuing with SQL-based business analysis, and finally translating query results into actionable business insights and recommendations.

---

# 📑 Table of Contents

- [📌 Project Overview](#-project-overview)
- [🎯 Business Problem](#-business-problem)
- [🎯 Business Objective](#-business-objective)
- [📂 Dataset Information](#-dataset-information)
- [🔍 Scope of Analysis](#-scope-of-analysis)
- [🛠 Tools & Techniques](#-tools--techniques)
- [🔄 Project Workflow](#-project-workflow)
- [📊 Dashboard Preview](#-dashboard-preview)
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

The analysis focuses on understanding sales performance, product demand, customer value, city-level performance, revenue efficiency, and potential market opportunities.

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

1. Which cities generate the highest revenue?
2. Which products have the highest transaction volume?
3. How much revenue is generated per customer?
4. Which cities have the largest potential coffee-consumer markets?
5. Which products perform best within each city?
6. Which cities have the largest coffee-product customer bases?
7. How does revenue compare with estimated rental costs?
8. How does revenue change month over month?
9. Which cities should receive greater attention for future growth?
10. What actions can the business take based on the analysis?

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
- Analyze month-over-month revenue growth.
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
| Q10 | City ranking by revenue / market potential | CTE, `DENSE_RANK()` |

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
- `HAVING`
- `ORDER BY`
- `INNER JOIN`
- `LEFT JOIN`
- `COUNT()`
- `COUNT(DISTINCT)`
- `SUM()`
- `ROUND()`
- `EXTRACT()`
- `CASE`
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

## 📊 Dashboard Preview

This project is intentionally focused on **PostgreSQL and SQL-based analysis**, so a Power BI/Tableau dashboard is not included in the current version.

Instead, the primary analytical output is the SQL analysis and the resulting business insight document.

### SQL Analysis Preview

The project demonstrates analytical outputs such as:

- City revenue ranking
- Product transaction ranking
- Average revenue per customer
- Unique customer counts
- Revenue-to-rent comparison
- Month-over-month revenue growth
- Top 3 products within each city

A dashboard can be added as a future improvement after the SQL analysis has been completed.

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

### 6. Bandung has the strongest revenue-to-rent ratio

**SQL Source:** `03_Analysis.sql — Q8`

Bandung generated approximately:

**3.99x revenue relative to estimated rent**

This is the highest ratio among the analyzed cities.

> This ratio is a screening indicator and should not be interpreted as profitability.

---

### 7. September 2024 shows an unusual revenue spike

**SQL Source:** `03_Analysis.sql — Q9`

Multiple cities recorded significant month-over-month revenue increases in September 2024.

This pattern should be investigated before being interpreted as sustainable organic growth.

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
- Strong revenue relative to estimated rent
- Lower average revenue per customer than Bandung, Surabaya, and Jakarta

**Interpretation:** Yogyakarta may provide an opportunity to increase customer monetization while maintaining relatively attractive cost efficiency.

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

**Evidence:** Q7, Q8

Yogyakarta combines a relatively large coffee-product customer base with a strong revenue-to-rent ratio.

The city should be considered for further expansion evaluation.

---

### 3. Maintain Jakarta as a Strategic Market

**Evidence:** Q1, Q4, Q8, Q10

Jakarta has the largest theoretical coffee market, but its higher estimated rent requires careful cost management.

---

### 4. Increase Customer Value in Yogyakarta and Medan

**Evidence:** Q4, Q7

Both cities have relatively large customer bases but lower average revenue per customer.

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
Jingga-Kopi-SQL-Analysis/
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
│   ├── 02_Data_Validation.sql
│   └── 03_Analysis.sql
│
└── insights/
    └── Business_Insights.md
```

### File Description

| File | Purpose |
|---|---|
| `README.md` | Project documentation and portfolio overview |
| `city.csv` | City-level dataset |
| `customers.csv` | Customer dataset |
| `products.csv` | Product dataset |
| `sales.csv` | Transaction dataset |
| `01_Database_Schema.sql` | Database and table structure |
| `02_Data_Validation.sql` | Data quality and consistency checks |
| `03_Analysis.sql` | Business questions and SQL analysis |
| `Business_Insights.md` | Findings, interpretation, and recommendations |

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

### 2. Profitability Analysis

Add:

- Cost of goods sold
- Labor cost
- Utilities
- Marketing cost
- Taxes
- Other operating expenses

This would allow the analysis to move from **revenue efficiency** to actual **profitability analysis**.

### 3. Customer Segmentation

Apply customer segmentation based on:

- Recency
- Frequency
- Monetary value

For example, using an RFM framework.

### 4. Customer Satisfaction Analysis

The dataset contains customer rating information. Future analysis could examine:

- Average rating by city
- Rating by product
- Relationship between rating and revenue
- Low-rated products requiring improvement

### 5. Advanced Sales Forecasting

Use historical transaction data to develop:

- Revenue forecasting
- Demand forecasting
- Seasonal trend analysis

---

## 👤 About the Author

**Hosea Meliala**

Aspiring **Data Analyst** with a focus on turning data into actionable business insights.

### Core Skills

- SQL / PostgreSQL
- Microsoft Excel
- Power BI
- Python
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

