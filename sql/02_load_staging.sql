-- Export the UCI workbook to CSV with this exact column order:
-- InvoiceNo,StockCode,Description,Quantity,InvoiceDate,UnitPrice,CustomerID,Country
-- Then update the path below.

SET search_path TO ecommerce;
TRUNCATE TABLE stg_online_retail;

-- psql example (run as a client-side command):
-- \copy ecommerce.stg_online_retail(invoice_no,stock_code,description,quantity,invoice_date,unit_price,customer_id,country)
-- FROM 'C:/path/to/online_retail.csv'
-- WITH (FORMAT csv, HEADER true, ENCODING 'UTF8');

-- Validation after load
SELECT COUNT(*) AS raw_rows FROM stg_online_retail;
SELECT MIN(invoice_date) AS first_transaction,
       MAX(invoice_date) AS last_transaction
FROM stg_online_retail;
