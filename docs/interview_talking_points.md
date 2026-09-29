# Interview Talking Points

## 30-second project explanation
I rebuilt an e-commerce sales analysis as an end-to-end SQL and Power BI project using the UCI Online Retail dataset. I staged and cleaned more than 500,000 transaction lines in PostgreSQL, created reusable views for reporting, wrote KPI and customer-segmentation queries, and designed a four-page Power BI dashboard covering executive performance, products, customers, and geography.

## What was challenging?
The dataset mixes completed sales with cancellations, returns/non-positive quantities, missing customer identifiers, and non-merchandise charges. I separated business rules by use case instead of deleting every imperfect row: unidentified customers remain valid for aggregate revenue, while customer analysis excludes them.

## Strong findings to discuss
- Cleaned analysis produced ~£10.67M in revenue across 19,960 orders.
- September 2011 revenue rose about 39.4% month over month, with the increase driven primarily by order/volume growth rather than a major AOV change.
- Revenue rose from roughly £759K in Aug 2011 to £1.51M in Nov 2011.
- The UK contributed ~84.6% of revenue, highlighting geographic concentration.
- Product rankings deliberately exclude postage/manual transaction lines.
- December 2011 is partial through Dec 9 and is not treated as a comparable full month.

## SQL skills demonstrated
- Staging and transformation workflow
- Filtering and data-quality rules
- Aggregations and conditional aggregation
- CTEs
- Window functions (`LAG`, `NTILE`, `RANK` patterns)
- Views
- Indexing
- RFM customer segmentation

## Power BI skills demonstrated
- Data modeling
- Date table
- DAX measures
- KPI cards
- Time-series analysis
- Geographic analysis
- Product/customer ranking
- Slicers and cross-filtering
- Business-oriented dashboard design
