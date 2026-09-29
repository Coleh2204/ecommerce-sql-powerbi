SET search_path TO ecommerce;

-- RFM segmentation using identified customers only.
WITH customer_stats AS (
    SELECT
        customer_id,
        MAX(order_date) AS last_purchase_date,
        COUNT(DISTINCT invoice_no) AS frequency,
        SUM(line_revenue) AS monetary
    FROM fact_sales
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
), scored AS (
    SELECT
        customer_id,
        (DATE '2011-12-10' - last_purchase_date) AS recency_days,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY (DATE '2011-12-10' - last_purchase_date) DESC) AS r_score,
        NTILE(5) OVER (ORDER BY frequency) AS f_score,
        NTILE(5) OVER (ORDER BY monetary) AS m_score
    FROM customer_stats
)
SELECT
    customer_id,
    recency_days,
    frequency,
    ROUND(monetary,2) AS monetary,
    r_score,
    f_score,
    m_score,
    CASE
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 4 THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'New / Promising'
        WHEN r_score <= 2 AND f_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 THEN 'Hibernating'
        ELSE 'Middle Segment'
    END AS customer_segment
FROM scored
ORDER BY monetary DESC;

-- Repeat-customer behavior
WITH customer_orders AS (
    SELECT customer_id, COUNT(DISTINCT invoice_no) AS order_count
    FROM fact_sales
    WHERE customer_id IS NOT NULL
    GROUP BY customer_id
)
SELECT
    COUNT(*) AS identified_customers,
    COUNT(*) FILTER (WHERE order_count > 1) AS repeat_customers,
    ROUND(100.0 * COUNT(*) FILTER (WHERE order_count > 1) / NULLIF(COUNT(*),0),2) AS repeat_customer_pct
FROM customer_orders;
