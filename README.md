# E-Commerce Sales & Customer Analytics — SQL + Power BI

A portfolio project that turns the UCI Online Retail transactional dataset into a reproducible PostgreSQL analytics pipeline and a four-page Power BI reporting model.

## Business questions
1. How much revenue did the business generate, and how did it trend over time?
2. Was late-2011 growth driven by higher order volume, larger baskets, or both?
3. Which countries and products generated the most revenue?
4. How concentrated is the business geographically?
5. Which customers are most valuable, and how can they be segmented using RFM behavior?

## Dataset
**Source:** UCI Machine Learning Repository — Online Retail  
**Coverage:** Dec 1, 2010 through Dec 9, 2011  
**Raw rows:** 541,909  
**License:** CC BY 4.0  
**Source page:** https://archive.ics.uci.edu/dataset/352/online+retail

The dataset contains invoice, product, quantity, transaction date, price, customer, and country fields for a UK-based non-store retailer.

## Tech stack
- PostgreSQL 15+
- SQL: CTEs, aggregation, window functions, views, indexing, RFM segmentation
- Power BI Desktop
- DAX
- Excel (supporting validation workbook)

## Data cleaning decisions
Completed-sales analysis excludes:
- Invoice numbers beginning with `C` (cancellations)
- Quantity <= 0
- UnitPrice <= 0

Missing CustomerID rows are **retained for aggregate sales** because the transactions still contribute to revenue, but they are excluded from customer-level analysis.

`POSTAGE`, `DOTCOM POSTAGE`, and `Manual` lines remain in total revenue but are excluded from merchandise product rankings.

## Validated headline results
- **Total revenue:** £10.67M
- **Units sold:** 5.59M
- **Orders:** 19,960
- **Average order value:** £534.40
- **UK share of revenue:** 84.6%
- Revenue increased from about **£759K in Aug 2011 to £1.51M in Nov 2011** (+98.8%).
- **September 2011 revenue grew ~39.4% MoM**, largely due to higher transaction volume.
- **November 2011** was the strongest full month in the dataset.
- December 2011 contains only Dec 1–9 and is treated as a partial month.

## Repository structure
```text
Ecommerce_SQL_PowerBI_Portfolio/
├── README.md
├── sql/
│   ├── 01_create_schema.sql
│   ├── 02_load_staging.sql
│   ├── 03_clean_transform.sql
│   ├── 04_kpi_analysis.sql
│   ├── 05_customer_rfm.sql
│   └── 06_power_bi_views.sql
├── powerbi/
│   ├── DAX_Measures.txt
│   ├── Date_Table_DAX.txt
│   ├── PowerBI_Build_Guide.md
│   └── model_diagram.md
├── data/
│   └── summary/
│       ├── executive_kpis.csv
│       ├── monthly_performance.csv
│       ├── top_countries.csv
│       ├── top_products.csv
│       └── data_quality.csv
├── docs/
│   ├── data_dictionary.md
│   └── interview_talking_points.md
└── source_files/
    └── Online_Retail_Portfolio_Polished.xlsx
```

## How to reproduce
### 1. Get the raw data
Download `Online Retail.xlsx` from the UCI source page and export the data sheet to `online_retail.csv`.

### 2. Build the PostgreSQL layer
Run scripts in order:
1. `01_create_schema.sql`
2. Load the CSV using the `\copy` command shown in `02_load_staging.sql`
3. `03_clean_transform.sql`
4. `04_kpi_analysis.sql`
5. `05_customer_rfm.sql`
6. `06_power_bi_views.sql`

### 3. Validate
The transformed outputs should reconcile closely with the validated portfolio metrics in `data/summary/` and the supporting workbook. Differences usually indicate date parsing, cancellation handling, zero-price rules, or inclusion/exclusion of non-merchandise lines.

### 4. Connect Power BI
In Power BI Desktop:
1. **Get Data → PostgreSQL database**
2. Select `ecommerce.vw_sales_detail`
3. Create the Date table from `powerbi/Date_Table_DAX.txt`
4. Add the measures from `powerbi/DAX_Measures.txt`
5. Build the pages in `powerbi/PowerBI_Build_Guide.md`

## Power BI file note
The repository includes the complete Power BI model specification, DAX, validated outputs, and page-by-page build instructions. The proprietary `.pbix` file must be created/saved in Power BI Desktop; this package therefore stops at the reproducible build layer rather than pretending a non-Power-BI-generated file is valid.

## Dashboard pages
### Executive Overview
Revenue, units, orders, AOV, UK revenue share, monthly revenue, order trend, top countries.

### Product Performance
Top products by revenue and units, product scatter analysis, ranking table.

### Customer Analytics
Customer revenue, repeat purchasing, order frequency, and optional RFM segments.

### Geographic Analysis
Revenue concentration by country, map, country-level KPIs, and UK dependence.

## Key analytical takeaway
The late-2011 acceleration was primarily a **volume story** rather than a large increase in order value. September revenue rose sharply while AOV moved only modestly, and the business remained heavily concentrated in the United Kingdom. That creates two actionable questions: how to retain the higher order cadence and how to diversify revenue geographically.

## Portfolio use
This project is designed to demonstrate an end-to-end analyst workflow: business framing, data-quality rules, relational SQL, reusable reporting views, DAX, dashboard design, and communication of business implications.

## Attribution
Chen, D. (2015). *Online Retail* [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5BW33
