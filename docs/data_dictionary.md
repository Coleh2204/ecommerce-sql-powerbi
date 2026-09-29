# Data Dictionary

| Field | Type | Meaning |
|---|---|---|
| InvoiceNo | text | Transaction identifier. Source values beginning with `C` denote cancellations. |
| StockCode | text | Product/item identifier. |
| Description | text | Product description. |
| Quantity | integer | Quantity on the transaction line. |
| InvoiceDate | timestamp | Date/time of transaction. |
| UnitPrice | numeric | Unit price in pounds sterling. |
| CustomerID | text | Customer identifier; may be missing in source data. |
| Country | text | Customer country. |
| LineRevenue | numeric | `Quantity * UnitPrice`. |
| IsMerchandise | boolean | False for POSTAGE, DOTCOM POSTAGE, and Manual lines used outside merchandise rankings. |
| OrderDate | date | Date portion of InvoiceDate. |
| OrderMonth | date | First day of transaction month for monthly grouping. |

## Cleaning rules
- Cancelled invoices are excluded from completed-sales analysis.
- Quantity <= 0 is excluded.
- UnitPrice <= 0 is excluded.
- Missing CustomerID rows are retained for total sales but excluded from customer-level analysis.
- POSTAGE / DOTCOM POSTAGE / Manual lines remain in total revenue but are excluded from merchandise product rankings.
