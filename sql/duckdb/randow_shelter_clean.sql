-- sql/duckdb/randow_shelter_clean.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Validate and flag data quality issues in the shelter domain.
--
-- WHY:
-- - Ensures no orphaned adoptions (missing shelter reference)
-- - Confirms no negative fees
-- - Checks for missing animal types

SELECT 'Adoptions with no matching shelter' AS check_name,
       COUNT(*) AS issue_count
FROM adoption a
LEFT JOIN shelter s ON a.shelter_id = s.shelter_id
WHERE s.shelter_id IS NULL

UNION ALL

SELECT 'Adoptions with negative fee',
       COUNT(*)
FROM adoption
WHERE fee < 0

UNION ALL

SELECT 'Adoptions missing animal type',
       COUNT(*)
FROM adoption
WHERE animal_type IS NULL OR animal_type = '';
