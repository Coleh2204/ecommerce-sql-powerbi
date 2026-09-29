SET search_path TO ecommerce;

-- Executive KPIs
SELECT
    ROUND(SUM(line_revenue),2) AS total_revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS orders,
    ROUND(SUM(line_revenue) / NULLIF(COUNT(DISTINCT invoice_no),0),2) AS avg_order_value,
    COUNT(DISTINCT customer_id) AS identified_customers
FROM fact_sales;

-- Monthly performance + MoM growth
WITH monthly AS (
    SELECT
        order_month,
        SUM(line_revenue) AS revenue,
        SUM(quantity) AS units_sold,
        COUNT(DISTINCT invoice_no) AS orders
    FROM fact_sales
    GROUP BY order_month
), calc AS (
    SELECT
        order_month,
        revenue,
        units_sold,
        orders,
        revenue / NULLIF(orders,0) AS avg_order_value,
        LAG(revenue) OVER (ORDER BY order_month) AS prior_month_revenue
    FROM monthly
)
SELECT
    order_month,
    ROUND(revenue,2) AS revenue,
    units_sold,
    orders,
    ROUND(avg_order_value,2) AS avg_order_value,
    ROUND((revenue-prior_month_revenue)/NULLIF(prior_month_revenue,0)*100,2) AS mom_growth_pct
FROM calc
ORDER BY order_month;

-- Country performance
SELECT
    country,
    ROUND(SUM(line_revenue),2) AS revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS orders,
    ROUND(SUM(line_revenue) / NULLIF(COUNT(DISTINCT invoice_no),0),2) AS avg_order_value
FROM fact_sales
GROUP BY country
ORDER BY revenue DESC;

-- Top merchandise products
SELECT
    stock_code,
    MAX(description) AS product,
    ROUND(SUM(line_revenue),2) AS revenue,
    SUM(quantity) AS units_sold,
    COUNT(DISTINCT invoice_no) AS orders
FROM fact_sales
WHERE is_merchandise = TRUE
GROUP BY stock_code
ORDER BY revenue DESC
LIMIT 25;

-- UK revenue concentration
SELECT
    ROUND(100.0 * SUM(line_revenue) FILTER (WHERE country='United Kingdom')
          / NULLIF(SUM(line_revenue),0),2) AS uk_revenue_share_pct
FROM fact_sales;
