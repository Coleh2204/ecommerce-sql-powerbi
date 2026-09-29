# Power BI Build Guide

## Data source
Preferred: connect Power BI Desktop to PostgreSQL and import `ecommerce.vw_sales_detail`.
Optional supporting views: `vw_monthly_sales`, `vw_country_sales`, `vw_product_sales`, `vw_customer_sales`.

## Model
Use a star-style model:

- **Fact:** `vw_sales_detail`
- **Date dimension:** create with `Date_Table_DAX.txt`
- Country, product, and customer can initially remain attributes in the fact table; for a more advanced version, create dedicated dimensions with Power Query references.

Relationship:
`Date[Date] (1) -> vw_sales_detail[order_date] (*)`

## Page 1 — Executive Overview
**Cards**
- Total Revenue
- Units Sold
- Total Orders
- Average Order Value
- UK Revenue Share

**Visuals**
1. Line chart: Date[Year-Month] vs Total Revenue
2. Clustered column chart: Date[Year-Month] vs Total Orders
3. Bar chart: Country vs Total Revenue (Top 10)
4. Slicer: Country
5. Slicer: Date[Year-Month]

**Callouts based on the validated analysis**
- Revenue nearly doubled from Aug to Nov 2011 (+98.8%).
- September revenue increased ~39.4% month over month.
- November 2011 was the strongest full month at ~£1.51M.
- December 2011 is partial (Dec 1–9), so do not compare it directly to full months.

## Page 2 — Product Performance
**Visuals**
1. Bar chart: Product vs Merchandise Revenue, Top 10
2. Bar chart: Product vs Units Sold, Top 10
3. Scatter: Units Sold (X) vs Revenue (Y), Product as details
4. Table: Product, Revenue, Units Sold, Orders, Product Revenue Rank
5. Slicer: Country

Filter `is_merchandise = TRUE` for merchandise rankings.

## Page 3 — Customer Analytics
**Visuals**
1. Cards: Identified Customers, Repeat Customers, Repeat Customer Rate
2. Bar chart: Customer ID vs Total Revenue, Top 15
3. Histogram-style column chart: customer order-count bands
4. Table: Customer ID, Orders, Revenue, Last Order Date
5. Optional RFM segmentation table from `05_customer_rfm.sql`

## Page 4 — Geographic Analysis
**Visuals**
1. Filled map or bubble map: Country vs Total Revenue
2. Bar chart: Top 12 countries by revenue
3. Matrix: Country / Revenue / Units / Orders / AOV
4. Card: UK Revenue Share

## Formatting
- Currency: GBP (£), 2 decimals for tables; display units Auto/Millions for cards.
- Percentages: 1 decimal.
- Keep consistent page titles and visual spacing.
- Use tooltips that show Revenue, Orders, Units Sold, and AOV.
- Add a small note on every time-trend page: `Dec 2011 includes Dec 1–9 only.`

## Portfolio screenshots
Export one PNG screenshot of each page and place them in `docs/screenshots/` before publishing the repo.
