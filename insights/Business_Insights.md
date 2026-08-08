# Jingga Kopi — Business Insights

## 1. Project Overview

**Jingga Kopi** is a fictional Indonesian coffee business dataset created to demonstrate an end-to-end SQL Data Analytics workflow using PostgreSQL.

As the Data Analyst, the objective of this project is to transform raw customer, product, city, and transaction data into business insights that can support decisions related to:

- Sales performance
- Product demand
- Customer behavior
- City-level performance
- Revenue efficiency
- Monthly revenue trends
- Market potential

### Analytical Workflow

```text
CSV Data
   ↓
01_Database_Schema.sql
   ↓
01.1_Table_Mapping.pgerd
   ↓
02_Data_Validation.sql
   ↓
03_Analysis.sql
   ↓
Query Results
   ↓
Business Insights & Recommendations
```

Every insight in this document is linked to a specific analysis in `03_Analysis.sql`.

---

# 2. Dataset Overview

| Dataset | Records | Description |
|---|---:|---|
| Cities | 14 | Indonesian cities with population, estimated rent, and city ranking |
| Customers | 497 | Customer records linked to cities |
| Products | 28 | Products offered by Jingga Kopi |
| Sales | 10,388 | Individual sales transactions |

The analysis covers transactions from **January 2024 to October 2025**.

### Important Assumptions

- Estimated coffee consumers are calculated using **25% of city population**.
- Estimated rent is a **dummy business-cost assumption** for analytical purposes.
- Product IDs **1–14** are treated as coffee products in the customer analysis.
- Revenue-to-rent ratio is used as a **screening indicator**, not as a profitability metric.

---

# 3. Executive Summary

The SQL analysis identifies several important patterns across Jingga Kopi's cities, products, and customers.

**Bandung** generated the highest total revenue at approximately **IDR 71.86 million**, followed by **Surabaya at IDR 54.72 million** and **Jakarta at IDR 49.57 million**.

At the product level, **Americano, Espresso, and Kopi Susu** recorded the highest transaction volumes, indicating strong demand for core coffee beverages.

Customer analysis shows that **Yogyakarta and Medan** have the largest numbers of unique customers purchasing the defined coffee-product segment. However, **Bandung, Surabaya, and Jakarta** generate substantially higher average revenue per customer.

When revenue is compared with estimated rent, **Bandung has the strongest revenue-to-rent ratio** among the analyzed cities. This makes it an attractive city for further evaluation, although the ratio should not be interpreted as profitability.

---

# 4. Business Insights

## 4.1 City Market Size

**SQL Source: `03_Analysis.sql — Q1 & Q5`**

The analysis estimates the number of coffee consumers in each city using a 25% population assumption.

The largest estimated coffee-consumer markets are:

| Rank | City | Estimated Coffee Consumers |
|---:|---|---:|
| 1 | Jakarta | 2.67M |
| 2 | Surabaya | 0.75M |
| 3 | Bandung | 0.69M |
| 4 | Medan | 0.63M |
| 5 | Depok | 0.53M |

### Key Insight

**Jakarta has the largest theoretical coffee-consumer market**, based on the population-based assumption.

However, Q2 and Q10 show that the largest potential population does not automatically result in the highest actual revenue.

### Business Implication

Market size should therefore be evaluated together with actual sales performance, customer value, and estimated operating costs.

---

# 5. Quarter 4 2024 Sales Performance by City

**SQL Source: `03_Analysis.sql — Q2`**

Q2 analyzes revenue generated during **Quarter 4 2024** by city.

The highest-performing cities were:

| Rank | City | Quarter 4 2024 Revenue |
|---:|---|---:|
| 1 | Bandung | IDR 15.30M |
| 2 | Surabaya | IDR 11.28M |
| 3 | Jakarta | IDR 9.87M |
| 4 | Yogyakarta | IDR 9.33M |
| 5 | Medan | IDR 8.23M |

### Key Insight

**Bandung was the strongest revenue contributor during Quarter 4 2024**, generating approximately IDR 15.30 million.

### Business Implication

Bandung demonstrated strong sales performance despite having a smaller population than Jakarta.

This indicates that **population size alone does not determine revenue performance**.

### Recommendation

Investigate the factors behind Bandung's performance, including customer spending, product preferences, and transaction frequency, and evaluate whether similar strategies can be applied to other cities.

---

# 6. Product Transaction Performance

**SQL Source: `03_Analysis.sql — Q3`**

Q3 ranks products based on transaction volume.

The highest-volume products were:

| Rank | Product | Transactions |
|---:|---|---:|
| 1 | Americano | 1,326 |
| 2 | Espresso | 1,271 |
| 3 | Kopi Susu | 1,226 |
| 4 | Kopi Susu Gula Aren | 1,218 |
| 5 | Cold Brew Bottle | 776 |

### Key Insight

**Americano is the highest-volume product**, followed by Espresso and Kopi Susu.

These products appear to be important drivers of transaction activity.

### Business Implication

High-volume products can be treated as core products for maintaining customer demand and generating repeat purchases.

### Recommendation

Maintain strong availability of high-volume products and use them as potential entry products for cross-selling and upselling.

---

# 7. Average Revenue per Customer

**SQL Source: `03_Analysis.sql — Q4`**

Q4 calculates average revenue per unique customer by city using:

- `SUM(s.total)` for total revenue
- `COUNT(DISTINCT customer_id)` for unique customers

The highest average revenue per customer was:

| Rank | City | Average Revenue per Customer |
|---:|---|---:|
| 1 | Bandung | IDR 1.38M |
| 2 | Surabaya | IDR 1.30M |
| 3 | Jakarta | IDR 1.27M |
| 4 | Yogyakarta | IDR 668K |
| 5 | Medan | IDR 605K |

### Key Insight

**Bandung has the highest average revenue per customer**, followed by Surabaya and Jakarta.

### Business Implication

These cities demonstrate stronger customer monetization than cities with lower average revenue per customer.

### Recommendation

Prioritize customer retention, loyalty programs, and targeted offers in high-value cities to increase customer lifetime value.

---

# 8. Population vs. Estimated Coffee Consumers

**SQL Source: `03_Analysis.sql — Q5`**

Q5 compares city population with the estimated coffee-consumer population.

### Key Insight

The estimated coffee-consumer population follows the size of the overall population because the analysis applies a fixed 25% assumption.

Therefore, **the estimated coffee-consumer metric should be interpreted as an addressable-market proxy rather than an observed customer count**.

### Business Implication

A large theoretical market provides an opportunity, but it does not guarantee sales performance.

This is demonstrated by the difference between Jakarta's large estimated market and Bandung's stronger observed revenue performance.

---

# 9. Top 3 Products by City

**SQL Source: `03_Analysis.sql — Q6`**

Q6 uses `DENSE_RANK()` with `PARTITION BY city` to identify the top three products within each city.

### Key Insight

Product preferences vary by city, so a single national product strategy may not be optimal.

The query identifies the strongest products within each individual city rather than ranking products across the entire business.

### Business Implication

Jingga Kopi can use city-level product rankings to identify local demand patterns.

### Recommendation

Use the city-level product ranking to support:

- Localized promotions
- Product assortment decisions
- Inventory planning
- City-specific marketing campaigns

---

# 10. Unique Coffee Customers by City

**SQL Source: `03_Analysis.sql — Q7`**

Q7 counts unique customers purchasing products classified as coffee products in the dataset.

The cities with the highest unique-customer counts were:

| Rank | City | Unique Coffee Customers |
|---:|---|---:|
| 1 | Yogyakarta | 69 |
| 2 | Medan | 68 |
| 3 | Bandung | 52 |
| 4 | Surabaya | 42 |
| 5 | Jakarta | 39 |

### Key Insight

**Yogyakarta and Medan have the largest observed customer bases for the defined coffee-product segment.**

However, these cities have lower average revenue per customer than Bandung, Surabaya, and Jakarta.

### Business Implication

There is an opportunity to increase revenue without relying entirely on acquiring new customers.

### Recommendation

Focus on increasing customer value through:

- Product bundling
- Upselling
- Premium-product recommendations
- Loyalty programs
- Cross-selling

---

# 11. Revenue vs. Estimated Rent

**SQL Source: `03_Analysis.sql — Q8`**

Q8 compares average revenue per customer with estimated rent per customer.

The overall city-level revenue-to-rent comparison indicates that:

| Rank | City | Total Revenue | Estimated Rent | Revenue / Rent |
|---:|---|---:|---:|---:|
| 1 | Bandung | IDR 71.86M | IDR 18.00M | 3.99x |
| 2 | Yogyakarta | IDR 46.06M | IDR 12.00M | 3.84x |
| 3 | Medan | IDR 41.15M | IDR 16.00M | 2.57x |
| 4 | Surabaya | IDR 54.72M | IDR 22.00M | 2.49x |
| 5 | Jakarta | IDR 49.57M | IDR 35.00M | 1.42x |

### Key Insight

**Bandung has the highest revenue-to-estimated-rent ratio**, followed by Yogyakarta.

### Business Implication

These cities appear attractive when comparing observed revenue against the estimated rental cost included in the dataset.

### Recommendation

Use Bandung and Yogyakarta as priority cities for **further expansion evaluation**.

However, this should not be treated as a profitability conclusion because the dataset does not include all operating costs.

---

# 12. Month-over-Month Revenue Growth

**SQL Source: `03_Analysis.sql — Q9`**

Q9 uses:

- CTE
- `LAG()`
- `PARTITION BY`
- Year/month ordering

to calculate monthly revenue and month-over-month revenue growth by city.

### Key Insight

The analysis identifies substantial month-over-month fluctuations, including a major revenue increase in **September 2024** across multiple cities.

Several cities experienced very large increases during this period, including:

- Semarang: approximately +855.6%
- Yogyakarta: approximately +606.9%
- Medan: approximately +592.7%
- Palembang: approximately +573.3%
- Surabaya: approximately +570.0%
- Bandung: approximately +536.2%

### Business Interpretation

Because the increase occurred across multiple cities at approximately the same time, it should be investigated before being interpreted as sustainable organic growth.

### Recommendation

Investigate potential causes such as:

- Promotions
- Seasonal demand
- Product launches
- Bulk transactions
- Data-generation patterns

The business should distinguish between **temporary revenue spikes and sustainable growth** before making long-term decisions.

---

# 13. Top Cities by Revenue

**SQL Source: `03_Analysis.sql — Q10`**

Q10 ranks cities using `DENSE_RANK()` based on total revenue.

The top three cities are:

| Rank | City | Total Revenue |
|---:|---|---:|
| 1 | Bandung | IDR 71.86M |
| 2 | Surabaya | IDR 54.72M |
| 3 | Jakarta | IDR 49.57M |

### Key Insight

**Bandung is the highest-revenue city in the dataset**, followed by Surabaya and Jakarta.

### Business Interpretation

The three cities have different characteristics:

- **Bandung:** Highest revenue and strongest revenue-to-rent ratio.
- **Surabaya:** Strong revenue and high revenue per customer.
- **Jakarta:** Largest estimated market size but higher estimated rent.

### Recommendation

Use these three cities as priority markets for deeper business evaluation, while applying different strategies based on each city's characteristics.

---

# 14. Cross-Analysis: What the SQL Results Tell Us

The individual queries become more valuable when their results are interpreted together.

### Bandung

From **Q2, Q4, Q8, and Q10**:

- Strong Q4 2024 revenue
- Highest average revenue per customer
- Highest revenue-to-rent ratio
- Highest overall revenue

**Interpretation:** Bandung is the strongest-performing city across several analyzed metrics.

---

### Jakarta

From **Q1, Q4, Q8, and Q10**:

- Largest estimated coffee-consumer market
- High average revenue per customer
- Third-highest overall revenue
- Lowest revenue-to-rent ratio among the top five cities

**Interpretation:** Jakarta has strong market potential but requires careful cost management.

---

### Yogyakarta

From **Q7 and Q8**:

- Highest number of unique coffee customers
- Strong revenue-to-rent ratio

**Interpretation:** Yogyakarta has an attractive combination of customer base and estimated cost efficiency, although average revenue per customer remains below Bandung, Surabaya, and Jakarta.

---

### Medan

From **Q7 and Q4**:

- Second-highest unique coffee-customer count
- Lower average revenue per customer

**Interpretation:** Medan may have an opportunity to increase customer monetization rather than focusing only on customer acquisition.

---

# 15. Business Recommendations

Based directly on the results of `03_Analysis.sql`, the following actions are recommended:

### 1. Strengthen Bandung

**Evidence:** Q2, Q4, Q8, Q10

Bandung consistently performs strongly across revenue, customer value, and revenue-to-rent efficiency.

**Action:** Prioritize customer retention, loyalty initiatives, and product availability.

---

### 2. Evaluate Yogyakarta for Expansion

**Evidence:** Q7, Q8

Yogyakarta has a large unique-customer base and a strong revenue-to-rent ratio.

**Action:** Evaluate the city as a potential expansion or marketing-investment opportunity.

---

### 3. Maintain Jakarta as a Strategic Market

**Evidence:** Q1, Q4, Q8, Q10

Jakarta has the largest estimated market size and strong revenue per customer, but its estimated rent is relatively high.

**Action:** Focus on high-value customers and premium products while monitoring operating costs.

---

### 4. Increase Customer Value in Medan and Yogyakarta

**Evidence:** Q4, Q7

Both cities have relatively large customer bases but lower average revenue per customer than the top-performing cities.

**Action:** Use bundling, upselling, and loyalty programs to increase spending per customer.

---

### 5. Protect High-Volume Products

**Evidence:** Q3 and Q6

Americano, Espresso, Kopi Susu, and Kopi Susu Gula Aren are among the strongest transaction-volume products.

**Action:** Maintain availability and use these products as anchors for promotional and cross-selling strategies.

---

### 6. Investigate Revenue Spikes

**Evidence:** Q9

September 2024 shows unusually high month-over-month growth across multiple cities.

**Action:** Investigate the underlying cause before treating the increase as sustainable growth.

---

# 16. Analytical Limitations

This project uses a **dummy dataset**, so the findings demonstrate an analytical methodology rather than actual Jingga Kopi business performance.

Important limitations:

1. The estimated coffee-consumer market is based on a fixed 25% population assumption.
2. Estimated rent is a dummy assumption and does not represent verified Indonesian commercial rental prices.
3. Revenue-to-rent ratio is not a profitability metric.
4. Product IDs 1–14 are classified as coffee products based on the dataset structure.
5. The analysis does not include operating costs such as ingredients, labor, utilities, marketing, taxes, or logistics.
6. September 2024 contains an unusually large revenue increase that requires further investigation.
7. October 2025 is an incomplete month in the dataset and should not be directly compared with complete months.
8. Customer satisfaction/rating data is available in the dataset but is outside the scope of the current `03_Analysis.sql`.

---

# 17. Conclusion

The SQL analysis demonstrates an end-to-end Data Analyst workflow:

```text
Data Modeling
      ↓
Data Validation
      ↓
Business Questions
      ↓
SQL Analysis
      ↓
Query Results
      ↓
Business Insights
      ↓
Recommendations
```

The strongest findings are:

- **Bandung is the strongest overall revenue-performing city.**
- **Americano is the highest-volume product.**
- **Yogyakarta and Medan have relatively large coffee-product customer bases.**
- **Bandung has the strongest revenue-to-estimated-rent ratio.**
- **Jakarta has the largest estimated coffee-consumer market but also higher estimated rent.**
- **September 2024 shows an unusual revenue spike that should be investigated before being interpreted as sustainable growth.**

The key analytical principle behind this project is:

> **Every business insight is supported by an analytical result from `03_Analysis.sql`.**

This ensures that the recommendations are traceable from raw data to SQL analysis and finally to business decision-making.
