-- E-Commerce Sales & Customer Analytics
-- PostgreSQL 15+
-- Creates a staging table for the UCI Online Retail dataset and analytics tables.

DROP SCHEMA IF EXISTS ecommerce CASCADE;
CREATE SCHEMA ecommerce;
SET search_path TO ecommerce;

CREATE TABLE stg_online_retail (
    invoice_no      TEXT,
    stock_code      TEXT,
    description     TEXT,
    quantity        INTEGER,
    invoice_date    TIMESTAMP,
    unit_price      NUMERIC(12,2),
    customer_id     TEXT,
    country         TEXT
);

CREATE TABLE fact_sales (
    sales_line_id   BIGSERIAL PRIMARY KEY,
    invoice_no      TEXT NOT NULL,
    stock_code      TEXT NOT NULL,
    description     TEXT,
    quantity        INTEGER NOT NULL,
    invoice_date    TIMESTAMP NOT NULL,
    unit_price      NUMERIC(12,2) NOT NULL,
    customer_id     TEXT,
    country         TEXT NOT NULL,
    line_revenue    NUMERIC(14,2) NOT NULL,
    is_merchandise  BOOLEAN NOT NULL,
    order_date      DATE NOT NULL,
    order_month     DATE NOT NULL
);

CREATE INDEX idx_fact_sales_invoice   ON fact_sales(invoice_no);
CREATE INDEX idx_fact_sales_customer  ON fact_sales(customer_id);
CREATE INDEX idx_fact_sales_date      ON fact_sales(order_date);
CREATE INDEX idx_fact_sales_month     ON fact_sales(order_month);
CREATE INDEX idx_fact_sales_country   ON fact_sales(country);
CREATE INDEX idx_fact_sales_stock     ON fact_sales(stock_code);
