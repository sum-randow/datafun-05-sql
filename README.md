# datafun-05-sql

[![Workflow Guide](https://img.shields.io/badge/Pro--Guide-pro--analytics--02-green)](https://denisecase.github.io/pro-analytics-02/workflow-b-apply-example-project/)
[![Python 3.14](https://img.shields.io/badge/python-3.14%2B-blue?logo=python)](./pyproject.toml)
[![MIT](https://img.shields.io/badge/license-see%20LICENSE-yellow.svg)](./LICENSE)

> Professional Python project: relational data and SQL analytics.

Data analytics requires a variety of skills.
This course builds capabilities through working projects.

In the age of generative AI, durable skills are grounded in real work:
setting up a professional environment,
reading and running code,
understanding the logic,
and pushing work to a shared repository.
Each project follows the structure of professional Python projects.
We learn by doing.

## This Project

This project introduces **relational data and SQL** used when storing structured data in tables.
Analysts are typically highly skilled at both SQL and Python.

Sample datasets are provided in the `data/raw` folder
across several topic domains:

- **retail** - a store records many sales (the worked example)
- **library** - a library branch manages many checkouts
- **shelter** - a shelter manages many animal adoptions
- **civic_event** - an event manages many attendees

Each domain has two related tables in a 1-to-many relationship.
You will run the retail example, then implement the same pipeline for a domain you choose.

## Working Files

You'll work with just these areas:

- **data/raw/\*** - raw CSV input files
- **data/processed/** - processed data outputs, if created
- **artifacts/** - generated database files, logs, or reports
- **docs/** - the project narrative and documentation
- **sql/** - SQL query files
- **src/datafun/** - Python orchestration scripts
- **pyproject.toml** - update project metadata
- **zensical.toml** - update documentation site metadata

## Instructions (pro-analytics-02)

Follow the
[step-by-step workflow guide](https://denisecase.github.io/pro-analytics-02/workflow-b-apply-example-project/)
to complete:

1. Phase 1. **Start & Run**
2. Phase 2. **Change Authorship**
3. Phase 3. **Read & Understand**
4. Phase 4. **Modify**
5. Phase 5. **Apply**

## Challenges

Challenges are expected.
Sometimes instructions may not quite match your operating system.
When issues occur, share screenshots, error messages, and details about what you tried.
Working through issues is part of implementing professional projects.

## Success

After completing Phase 1. **Start & Run**, you'll have your own GitHub project,
running on your machine.

Running the examples should create generated database files in `artifacts/`.

A new file `project.log` will appear in the root project folder
and you should see:

```shell
========================
Executed successfully!
========================
```

A new file `project.log` will appear in the root project folder.

## Command Reference

The commands below are used in the workflow guide above.
They are provided here for convenience.

Follow the guide for the **full instructions**.

<details>
<summary>Show command reference</summary>

### In a machine terminal (open in your `Repos` folder)

After you get a copy of this repo in your own GitHub account,
open a machine terminal in your `Repos` folder:

```shell
git clone https://github.com/sum-randow/datafun-05-sql

cd datafun-05-sql
code .
```

### In a VS Code terminal

These are listed for convenience.
For best results, follow the detailed instructions in
[pro-analytics-02 guide](https://denisecase.github.io/pro-analytics-02/).

```shell
uv self update
uv python pin 3.14
uv lock --upgrade
uv sync --extra dev --extra docs --upgrade

uvx pre-commit install

git add -A
uvx pre-commit run --all-files
# repeat if changes were made
uvx pre-commit run --all-files

# run the example pipelines (duckdb and sqlite)
uv run python -m datafun.app_retail_duckdb_case
uv run python -m datafun.app_retail_sqlite_case
# run the Technical Modification pipeline (sqlite)
uv run python -m datafun.app_retail_sqlite_sum-randow
# run the Custom Project pipeline (sqlite)
uv run python -m datafun.app_shelter_duckdb_randow

# do chores
uv run ruff format .
uv run ruff check . --fix
uv run python -m pyright
uv run python -m pytest
uv run python -m zensical build

# save progress
git add -A
git commit -m "update"
git push -u origin main
```

</details>

## Notes

- Use the **UP ARROW** and **DOWN ARROW** in the terminal to scroll through past commands.
- Use `CTRL+f` to find (and replace) text within a file.
- You do not need to add to or modify `tests/`. They are provided for example only.
- Many files are silent helpers. Explore as you like, but nothing is required.
- You do NOT not to understand everything; understanding builds naturally over time.

## Troubleshooting >>>

If you see something like this in your terminal: `>>>` or `...`
You accidentally started Python interactive mode.
It happens.
Press `Ctrl+c` (both keys together) or `Ctrl+Z` then `Enter` on Windows.

## SQLite Example Output - Technical Modification

```shell
| INFO | P05 | ====================================
| INFO | P05 | randow_retail_query_top_products.sql
| INFO | P05 | ====================================
| INFO | P05 | product_category, total_sales
| INFO | P05 | Outdoors, 3200.0
| INFO | P05 | Clothing, 1375.0
| INFO | P05 | Food, 652.0
| INFO | P05 |
| INFO | P05 | RUN SQL query: /Users/shackleton/datafun-05-sql/sql/sqlite/case_retail_query_kpi_revenue.sql
| INFO | P05 | ====================================
| INFO | P05 | case_retail_query_kpi_revenue.sql
| INFO | P05 | ====================================
| INFO | P05 | store_id, store_name, city, region, sale_count, total_revenue, avg_sale_amount
| INFO | P05 | S003, Central Plaza, Mankato, South, 10, 1868.0, 186.8
| INFO | P05 | S001, North Market, Duluth, North, 10, 1834.0, 183.4
| INFO | P05 | S002, Lakeside Shop, Ely, North, 10, 1525.0, 152.5
| INFO | P05 | ========================
| INFO | P05 | Executed successfully!
| INFO | P05 | ========================
| INFO | P05 | END main()
```
## Phase 5: Custom Project — Shelter Domain (DuckDB)

### Domain Overview
This project implements a data pipeline for the **shelter domain**,
modeling animal shelters and their adoption outcomes.

**Two entities and their relationship:**
- **Shelter** (parent) — represents a physical animal shelter location
  with attributes: `shelter_id`, `shelter_name`, `city`, and `capacity`
- **Adoption** (child) — represents a single animal outcome at a shelter
  with attributes: `adoption_id`, `shelter_id`, `animal_type`, `outcome`,
  `fee`, and `adopt_date`
- **Relationship:** 1-to-many — one shelter can have many adoptions,
  but each adoption belongs to exactly one shelter, enforced via the
  `shelter_id` foreign key

---

### Files Created

**SQL files in `sql/duckdb/`:**
- `randow_shelter_bootstrap.sql` — drops, recreates, and loads both tables from CSV
- `randow_shelter_clean.sql` — validates data quality (orphaned records, missing values, negative fees)
- `randow_shelter_query_shelter_count.sql` — lists all shelters and their capacities
- `randow_shelter_query_adoptions_by_type.sql` — counts adoptions and revenue by animal type
- `randow_shelter_query_revenue_by_shelter.sql` — joins shelter and adoption to compare revenue by location

**Python script:**
- `src/datafun/app_shelter_duckdb_randow.py` — orchestrates the full pipeline: bootstrap, clean, and run queries

**Generated database:**
- `artifacts/duckdb/shelter.duckdb`

---

### Custom Query
```sql
-- Which cities have the highest average adoption fee?
SELECT s.city,
       AVG(a.fee)          AS avg_fee,
       COUNT(a.adoption_id) AS total_adoptions
FROM shelter s
JOIN adoption a ON s.shelter_id = a.shelter_id
WHERE a.outcome = 'Adoption'
GROUP BY s.city
ORDER BY avg_fee DESC;
```
This query answers: *"Are adoption fees consistent across cities,
or do some markets charge more?"*

---

### When SQL is Better Than Pandas
SQL is the better tool for this domain because the data lives across
two related tables that need to be joined. SQL is purpose-built for
joining, filtering, and aggregating relational data directly in the
database — efficiently and without loading everything into memory.
When the question involves relationships between tables, SQL is almost
always the cleaner and faster choice.
