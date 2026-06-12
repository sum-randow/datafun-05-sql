"""app_shelter_duckdb_randow.py - Project script (shelter domain).

Author: Randow
Date: 2026-06

Purpose:
- Read csv files into a DuckDB database.
- DuckDB has a built-in COPY-from-CSV, so no Python CSV loading needed.
- Use Python to automate SQL scripts (stored in files).
- Log the pipeline process.

Paths (relative to repo root):
    SQL:  sql/duckdb/*.sql
    CSV:  data/raw/shelter/shelter.csv
    CSV:  data/raw/shelter/adoption.csv
    DB:   artifacts/duckdb/shelter.duckdb
"""

# === DECLARE IMPORTS ===

from pathlib import Path
from typing import Final

from datafun_toolkit.logger import get_logger, log_header
import duckdb

# === DECLARE CONSTANTS ===

LOG: Final = get_logger(__name__)

PROJECT_ROOT: Final = Path(__file__).resolve().parent.parent.parent
SQL_DIR: Final = PROJECT_ROOT / "sql" / "duckdb"
DB_PATH: Final = PROJECT_ROOT / "artifacts" / "duckdb" / "shelter.duckdb"

# === DEFINE FUNCTIONS ===


def read_sql(sql_path: Path) -> str:
    return sql_path.read_text(encoding="utf-8")


def run_sql_script(con, sql_path: Path) -> None:
    LOG.info(f"RUN SQL script: {sql_path}")
    con.execute(read_sql(sql_path))


def run_sql_query(con, sql_path: Path) -> None:
    LOG.info(f"RUN SQL query: {sql_path}")
    result = con.execute(read_sql(sql_path))
    df = result.fetchdf()
    LOG.info(f"\n{df.to_string(index=False)}\n")


# === MAIN ===


def main():
    log_header(LOG, "START: shelter DuckDB pipeline")

    DB_PATH.parent.mkdir(parents=True, exist_ok=True)

    con = duckdb.connect(str(DB_PATH))

    # ============================================================
    # STEP 1: CHANGE TO PROJECT ROOT (so CSV paths resolve correctly)
    # ============================================================
    import os

    os.chdir(PROJECT_ROOT)

    # ============================================================
    # STEP 2: BOOTSTRAP (create tables, load CSV data)
    # ============================================================
    run_sql_script(con, SQL_DIR / "randow_shelter_bootstrap.sql")
    con.commit()
    LOG.info("COMMIT: data load complete")

    # Verify row counts
    cursor = con.cursor()

    cursor.execute("SELECT COUNT(*) FROM shelter")
    LOG.info(f"Shelter rows loaded: {cursor.fetchone()[0]}")

    cursor.execute("SELECT COUNT(*) FROM adoption")
    LOG.info(f"Adoption rows loaded: {cursor.fetchone()[0]}")

    # ============================================================
    # STEP 3: CLEAN
    # ============================================================
    run_sql_script(con, SQL_DIR / "randow_shelter_clean.sql")

    # ============================================================
    # STEP 4: RUN QUERIES
    # ============================================================
    LOG.info("=" * 60)
    LOG.info("QUERY: Shelter Count & Capacity")
    LOG.info("=" * 60)
    run_sql_query(con, SQL_DIR / "randow_shelter_query_shelter_count.sql")

    LOG.info("=" * 60)
    LOG.info("QUERY: Adoptions by Animal Type")
    LOG.info("=" * 60)
    run_sql_query(con, SQL_DIR / "randow_shelter_query_adoptions_by_type.sql")

    LOG.info("=" * 60)
    LOG.info("QUERY: Revenue by Shelter")
    LOG.info("=" * 60)
    run_sql_query(con, SQL_DIR / "randow_shelter_query_revenue_by_shelter.sql")

    con.close()
    log_header(LOG, "DONE: shelter DuckDB pipeline")


if __name__ == "__main__":
    main()
