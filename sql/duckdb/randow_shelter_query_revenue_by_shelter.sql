-- sql/duckdb/randow_shelter_query_revenue_by_shelter.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Answer a key performance question:
-- "Which shelters are generating the most adoption revenue?"
--
-- This query JOINS shelter and adoption tables.
--
-- WHY:
-- - Connects financial performance back to each shelter location
-- - Helps answer: "Are larger capacity shelters generating more revenue?"

SELECT s.shelter_name,
       s.city,
       s.capacity,
       COUNT(a.adoption_id) AS total_adoptions,
       SUM(a.fee)           AS total_revenue
FROM shelter s
LEFT JOIN adoption a ON s.shelter_id = a.shelter_id
GROUP BY s.shelter_id, s.shelter_name, s.city, s.capacity
ORDER BY total_revenue DESC;
