-- sql/duckdb/randow_shelter_bootstrap.sql
-- ============================================================
-- PURPOSE
-- ============================================================
-- Create the shelter domain tables and load data from CSV files.
--
-- Two tables:
--   shelter  (parent/independent)
--   adoption (child/dependent - many adoptions per shelter)
--
-- WHY:
-- - DuckDB supports native COPY-from-CSV so no Python loading needed
-- - Foreign key from adoption.shelter_id -> shelter.shelter_id

-- Drop tables if they exist (order matters - child table first)
DROP TABLE IF EXISTS adoption;
DROP TABLE IF EXISTS shelter;

CREATE TABLE shelter (
    shelter_id   TEXT PRIMARY KEY,
    shelter_name TEXT NOT NULL,
    city         TEXT,
    capacity     INTEGER
);

CREATE TABLE adoption (
    adoption_id  TEXT PRIMARY KEY,
    shelter_id   TEXT REFERENCES shelter(shelter_id),
    animal_type  TEXT,
    outcome      TEXT,
    fee          DECIMAL(10,2),
    adopt_date   DATE
);

COPY shelter  FROM 'data/raw/shelter/shelter.csv'  (HEADER TRUE);
COPY adoption FROM 'data/raw/shelter/adoption.csv' (HEADER TRUE);
