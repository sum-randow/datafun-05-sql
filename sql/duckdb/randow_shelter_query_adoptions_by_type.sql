-- sql/duckdb/randow_shelter_query_adoptions_by_type.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Answer a key performance question:
-- "Which animal types are adopted most frequently?"
--
-- This query operates only on the adoption table.
-- It does NOT require a join to the shelter table.
--
-- WHY:
-- - Identifies which animals move through the system fastest
-- - Helps shelters plan intake by animal type

SELECT animal_type,
       COUNT(*)        AS total_adoptions,
       SUM(fee)        AS total_revenue,
       AVG(fee)        AS avg_fee
FROM adoption
WHERE outcome = 'Adoption'
GROUP BY animal_type
ORDER BY total_adoptions DESC;
