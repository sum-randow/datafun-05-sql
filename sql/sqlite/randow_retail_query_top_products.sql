-- sql/sqlite/randow_retail_query_top_products.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Answer a key performance question:
-- "Which product categories are generating the most revenue?"
--
-- This query operates only on the sale table.
-- It does NOT require a join to the store table.
--
-- WHY:
-- - Identifies the strongest performing product categories
-- - Provides context for inventory and purchasing decisions
-- - Helps answer questions like:
--   "Should we expand or reduce investment in specific categories?"


SELECT product_category, SUM(amount) AS total_sales
FROM sale
GROUP BY product_category
ORDER BY total_sales DESC
LIMIT 10;
