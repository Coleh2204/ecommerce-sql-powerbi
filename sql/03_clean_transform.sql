-- Cleaning logic mirrors the portfolio analysis:
-- 1) Exclude cancelled invoices (InvoiceNo beginning with C)
-- 2) Exclude non-positive quantity
-- 3) Exclude non-positive price
-- 4) Retain missing CustomerID for aggregate sales analysis
-- 5) Flag postage/manual lines so they can be excluded from merchandise rankings

SET search_path TO ecommerce;
TRUNCATE TABLE fact_sales RESTART IDENTITY;

INSERT INTO fact_sales (
    invoice_no, stock_code, description, quantity, invoice_date,
    unit_price, customer_id, country, line_revenue, is_merchandise,
    order_date, order_month
)
SELECT
    TRIM(invoice_no),
    TRIM(stock_code),
    NULLIF(TRIM(description), ''),
    quantity,
    invoice_date,
    unit_price,
    NULLIF(TRIM(customer_id), ''),
    TRIM(country),
    ROUND(quantity * unit_price, 2) AS line_revenue,
    CASE
        WHEN UPPER(COALESCE(description,'')) IN ('POSTAGE','DOTCOM POSTAGE','MANUAL') THEN FALSE
        ELSE TRUE
    END AS is_merchandise,
    invoice_date::date AS order_date,
    DATE_TRUNC('month', invoice_date)::date AS order_month
FROM stg_online_retail
WHERE invoice_no IS NOT NULL
  AND invoice_no !~* '^C'
  AND quantity > 0
  AND unit_price > 0;

-- Core QA checks
SELECT COUNT(*) AS cleaned_transaction_lines FROM fact_sales;
SELECT COUNT(*) AS cancelled_invoices_remaining
FROM fact_sales WHERE invoice_no ~* '^C';
SELECT COUNT(*) AS nonpositive_quantity_remaining
FROM fact_sales WHERE quantity <= 0;
SELECT COUNT(*) AS nonpositive_price_remaining
FROM fact_sales WHERE unit_price <= 0;
SELECT COUNT(*) AS rows_missing_customer_id
FROM fact_sales WHERE customer_id IS NULL;
