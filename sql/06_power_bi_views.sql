SET search_path TO ecommerce;

CREATE OR REPLACE VIEW vw_sales_detail AS
SELECT
    sales_line_id,
    invoice_no,
    stock_code,
    description,
    quantity,
    invoice_date,
    unit_price,
    customer_id,
    country,
    line_revenue,
    is_merchandise,
    order_date,
    order_month
FROM fact_sales;

CREATE OR REPLACE VIEW vw_monthly_sales AS
SELECT
    order_month,
    ROUND(SUM(line_revenue),2) AS revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS orders,
    ROUND(SUM(line_revenue)/NULLIF(COUNT(DISTINCT invoice_no),0),2) AS avg_order_value
FROM fact_sales
GROUP BY order_month;

CREATE OR REPLACE VIEW vw_country_sales AS
SELECT
    country,
    ROUND(SUM(line_revenue),2) AS revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS orders
FROM fact_sales
GROUP BY country;

CREATE OR REPLACE VIEW vw_product_sales AS
SELECT
    stock_code,
    MAX(description) AS product,
    ROUND(SUM(line_revenue),2) AS revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS orders
FROM fact_sales
WHERE is_merchandise = TRUE
GROUP BY stock_code;

CREATE OR REPLACE VIEW vw_customer_sales AS
SELECT
    customer_id,
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    COUNT(DISTINCT invoice_no) AS orders,
    ROUND(SUM(line_revenue),2) AS revenue,
    SUM(quantity) AS units_purchased
FROM fact_sales
WHERE customer_id IS NOT NULL
GROUP BY customer_id;
