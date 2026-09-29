# Project Completion Checklist

## Already included
- SQL schema, staging, cleaning, KPI, RFM, and reporting-view scripts
- Validated summary outputs from the existing portfolio analysis
- Power BI date-table DAX and KPI measures
- Four dashboard page specifications
- Data dictionary and business rules
- Interview talking points
- Supporting Excel portfolio workbook
- Dashboard wireframe

## Final local Power BI steps
1. Download the raw UCI workbook and export its data sheet to CSV.
2. Run the SQL scripts in PostgreSQL in numbered order.
3. Connect Power BI Desktop to `ecommerce.vw_sales_detail`.
4. Add the Date table and DAX measures from `/powerbi`.
5. Build the four report pages from the build guide.
6. Save the report as `powerbi/Ecommerce_Sales_Customer_Analytics.pbix`.
7. Export page screenshots into `docs/screenshots/` before publishing to GitHub.

The `.pbix` itself is not generated in this package because Power BI Desktop is required to author and save that proprietary file format.
