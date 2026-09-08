# Jingga Kopi — Business Insights

## Project Overview

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

## Dataset Overview

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

## Executive Summary

The SQL analysis identifies several important patterns across Jingga Kopi's cities, products, and customers.

**Bandung** generated the highest total revenue at approximately **IDR 71.86 million**, followed by **Surabaya at IDR 54.72 million** and **Jakarta at IDR 49.57 million**.

At the product level, **Americano, Espresso, and Kopi Susu** recorded the highest transaction volumes, indicating strong demand for core coffee beverages.

Customer analysis shows that **Yogyakarta and Medan** have the largest numbers of unique customers purchasing the defined coffee-product segment. However, **Bandung, Surabaya, and Jakarta** generate substantially higher average revenue per customer.

When cumulative revenue is compared with estimated rental costs over the same **22-month period**, **Bandung has the strongest revenue-to-rent ratio at 0.18x** among the analyzed cities. This ratio is a relative screening indicator and should not be interpreted as profitability.

---

# Business Insights

## 1. City Market Size

**SQL Source: `03_Analysis.sql — Q1`**

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

## 2. Quarter 4 2024 Sales Performance by City

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

## 3. Product Transaction Performance

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

## 4. Average Revenue per Customer

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

## 5. Population vs. Estimated Coffee Consumers

**SQL Source: `03_Analysis.sql — Q5`**

Q5 compares city population with the estimated coffee-consumer population.

### Key Insight

The estimated coffee-consumer population follows the size of the overall population because the analysis applies a fixed 25% assumption.

Therefore, **the estimated coffee-consumer metric should be interpreted as an addressable-market proxy rather than an observed customer count**.

### Business Implication

A large theoretical market provides an opportunity, but it does not guarantee sales performance.

This is demonstrated by the difference between Jakarta's large estimated market and Bandung's stronger observed revenue performance.

---

## 6. Top 3 Products by City

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

## 7. Unique Coffee Customers by City

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

However, their average revenue per customer is lower than in Bandung, Surabaya, and Jakarta. This suggests that a larger customer base does not necessarily translate into higher customer value.

### Business Implication

The results suggest an opportunity to increase revenue by improving spending and engagement among existing customers, rather than relying entirely on new customer acquisition.

### Recommendation

Focus on increasing customer value through:

- Product bundling
- Upselling
- Premium-product recommendations
- Loyalty programs
- Cross-selling

---

## 8. Revenue vs. Estimated Rent

**SQL Source: `03_Analysis.sql — Q8`**

Q8 compares cumulative revenue with estimated rental costs over the same **22-month analysis period (January 2024 – October 2025)**.

The analysis calculates:

- **Total Revenue** — cumulative revenue during the analysis period
- **Estimated Rent — 22 Months** — estimated monthly rent × 22 months
- **Revenue-to-Rent Ratio** — cumulative revenue ÷ estimated rental cost over the same period

The revenue-to-rent ratio is used as a **screening indicator**, not as a measure of profitability.

> **Interpretation note:** A ratio of 0.18x means cumulative revenue is 0.18 times the estimated rental cost over the same 22-month period. It does not mean the business generated 18% profit.

| Rank | City | Total Revenue | Estimated Rent — 22 Months | Revenue / Rent |
|---:|---|---:|---:|---:|
| 1 | Bandung | IDR 71.86M | IDR 396.00M | **0.18x** |
| 2 | Yogyakarta | IDR 46.06M | IDR 264.00M | **0.17x** |
| 3 | Medan | IDR 41.15M | IDR 352.00M | **0.12x** |
| 4 | Surabaya | IDR 54.72M | IDR 484.00M | **0.11x** |
| 5 | Jakarta | IDR 49.57M | IDR 770.00M | **0.06x** |

### Key Insight

**Bandung has the highest revenue-to-estimated-rent ratio at 0.18x**, followed by Yogyakarta at 0.17x and Medan at 0.12x.

Although Jakarta generates substantial cumulative revenue, its higher estimated rental cost results in a lower revenue-to-rent ratio of 0.06x.

### Business Implication

Bandung and Yogyakarta demonstrate relatively stronger cumulative revenue performance compared with their estimated rental costs over the analysis period.

Jakarta shows strong absolute revenue but requires greater rental expenditure, indicating that high revenue alone does not necessarily translate into a stronger revenue-to-rent position.

### Recommendation

Use **Bandung and Yogyakarta as priority cities for further expansion evaluation**, while maintaining a more cautious approach toward high-rent locations such as Jakarta.

However, this ratio should **not be interpreted as profitability**, because the analysis does not include other operating costs such as cost of goods sold, employee salaries, utilities, marketing, taxes, and other business expenses.

The estimated rent is also an assumed monthly cost and should therefore be treated as a **screening indicator rather than an actual financial performance measure**.

---
## 9. Month-over-Month Revenue Changes

**SQL Source: `03_Analysis.sql — Q9`**

Q9 uses:

- CTE
- `LAG()`
- `PARTITION BY`
- Year/month ordering

to calculate **current monthly revenue, previous monthly revenue, and month-over-month revenue growth by city**.

### Key Insight

The analysis identifies substantial month-over-month fluctuations, including a major revenue increase in **September 2024** across multiple cities.

Several cities experienced very large percentage increases during this period:

| City | Previous Revenue | Current Revenue | Growth |
|---|---:|---:|---:|
| Semarang | IDR 225K | IDR 2.15M | **+855.6%** |
| Yogyakarta | IDR 1.32M | IDR 9.33M | **+606.9%** |
| Medan | IDR 1.39M | IDR 9.63M | **+592.7%** |
| Palembang | IDR 1.20M | IDR 8.05M | **+573.3%** |
| Surabaya | IDR 1.64M | IDR 11.00M | **+570.0%** |
| Bandung | IDR 2.41M | IDR 15.30M | **+536.2%** |

The percentage increases should be interpreted together with the underlying revenue values. For example, Semarang's **+855.6% growth** is partly driven by its relatively low previous-month revenue baseline.

### Business Interpretation

Because the increase occurred across multiple cities at approximately the same time, the September 2024 spike should be investigated before being interpreted as sustainable organic growth.

The unusually high growth percentages may reflect a combination of a low previous-month baseline and a substantial increase in current-month revenue.

Therefore, the analysis identifies the event as a **revenue anomaly or spike requiring further investigation**, rather than automatically classifying it as sustainable business growth.

### Recommendation

Investigate potential causes such as:

- Promotions
- Seasonal demand
- Product launches
- Bulk transactions
- Unusual customer activity
- Data-generation patterns

The business should distinguish between **temporary revenue spikes and sustainable growth** before making long-term decisions.

---

## 10. Top Cities by Revenue

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

# Cross-Analysis: What the SQL Results Tell Us

The individual queries become more valuable when their results are interpreted together.

## Bandung

From **Q2, Q4, Q8, and Q10**:

- Strong Q4 2024 revenue
- Highest average revenue per customer
- Highest revenue-to-rent ratio
- Highest overall revenue

**Interpretation:** Bandung is the strongest-performing city across several analyzed metrics.

---

## Jakarta

From **Q1, Q4, Q8, and Q10**:

- Largest estimated coffee-consumer market
- High average revenue per customer
- Third-highest overall revenue
- Lowest revenue-to-rent ratio among the top five cities

**Interpretation:** Jakarta has strong market potential but requires careful cost management.

---

## Yogyakarta

From **Q4, Q7, and Q8**:

- Highest number of unique coffee customers
- Strong revenue-to-rent ratio
- Lower average revenue per customer than Bandung, Surabaya, and Jakarta

**Interpretation:** Yogyakarta combines a relatively large observed customer base with a stronger revenue-to-rent position, while still having room to improve customer value.

---

## Medan

From **Q4 and Q7**:

- Second-highest unique coffee-customer count
- Lower average revenue per customer

**Interpretation:** Medan may have an opportunity to increase customer monetization rather than focusing only on customer acquisition.

---

# Business Recommendations

Based directly on the results of `03_Analysis.sql`, the following actions are recommended:

## 1. Strengthen Bandung

**Evidence:** Q2, Q4, Q8, Q10

Bandung consistently performs strongly across revenue, customer value, and revenue-to-rent efficiency.

**Action:** Prioritize customer retention, loyalty initiatives, and product availability.

---

## 2. Evaluate Yogyakarta for Further Expansion

**Evidence:** Q4, Q7, Q8

Yogyakarta combines a relatively large observed coffee-product customer base with a strong revenue-to-rent position, while average revenue per customer remains below the strongest cities.

**Action:** Evaluate Yogyakarta for further expansion or targeted marketing investment, with emphasis on increasing customer value.

---

## 3. Maintain Jakarta as a Strategic Market

**Evidence:** Q1, Q4, Q8, Q10

Jakarta has the largest estimated market size and strong revenue per customer, but its estimated rent is relatively high.

**Action:** Focus on high-value customers and premium products while monitoring operating costs.

---

## 4. Increase Customer Value in Yogyakarta and Medan

**Evidence:** Q4, Q7

Both cities have relatively large observed customer bases but lower average revenue per customer than Bandung, Surabaya, and Jakarta.

**Action:** Use bundling, upselling, premium-product recommendations, and loyalty programs to increase spending per customer.

---

## 5. Protect High-Volume Products

**Evidence:** Q3 and Q6

Americano, Espresso, Kopi Susu, and Kopi Susu Gula Aren are among the strongest transaction-volume products.

**Action:** Maintain availability and use these products as anchors for promotional and cross-selling strategies.

---

## 6. Investigate Revenue Spikes

**Evidence:** Q9

September 2024 shows unusually high month-over-month growth across multiple cities.

**Action:** Investigate the underlying cause before treating the increase as sustainable growth.

---

## Analytical Limitations

This project uses a **dummy dataset**, so the findings demonstrate an analytical methodology rather than actual Jingga Kopi business performance.

Important limitations:

1. The estimated coffee-consumer market is based on a fixed 25% population assumption and therefore represents a theoretical addressable-market proxy, not observed customers.
2. Estimated rent is a dummy assumption and does not represent verified Indonesian commercial rental prices.
3. Revenue-to-rent ratio is a screening indicator and is not a profitability metric because other operating costs are excluded.
4. Product IDs 1–14 are classified as coffee products based on the current dataset structure; this classification would be more robust if a product category field were used directly.
5. The analysis does not include operating costs such as ingredients, labor, utilities, marketing, taxes, or logistics.
6. September 2024 contains an unusually large revenue increase that requires further investigation and should not automatically be interpreted as sustainable growth.
7. October 2025 is an incomplete month in the dataset and should not be directly compared with complete months.
8. Customer satisfaction/rating data is available in the raw dataset but is outside the scope of the current `03_Analysis.sql`.

---

## Conclusion

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
- **Yogyakarta and Medan have relatively large observed customer bases for the defined coffee-product segment.**
- **Bandung has the strongest revenue-to-estimated-rent position over the 22-month analysis period.**
- **Jakarta has the largest estimated coffee-consumer market but also higher estimated rent.**
- **September 2024 shows an unusual revenue spike that should be investigated before being interpreted as sustainable growth.**

The key analytical principle behind this project is:

> **Every business insight is supported by an analytical result from `03_Analysis.sql`.**

This ensures that the recommendations are traceable from raw data to SQL analysis and finally to business decision-making.
