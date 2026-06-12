-- sql/duckdb/randow_shelter_query_shelter_count.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Answer a simple structural question:
-- "How many shelters are in our system, and what are their capacities?"
--
-- This query does NOT involve the adoption table.
-- It operates only on the independent/parent table.
--
-- WHY:
-- - Establishes the size of the system
-- - Provides context for capacity planning

SELECT shelter_id, shelter_name, city, capacity
FROM shelter
ORDER BY capacity DESC;
