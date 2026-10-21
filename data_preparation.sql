USE hdb_resale;

DROP TABLE IF EXISTS resale;

-- create table

CREATE TABLE resale (
    month                VARCHAR(7),     
    town                 VARCHAR(50),
    flat_type            VARCHAR(20),
    block                VARCHAR(10),
    street_name          VARCHAR(100),
    storey_range         VARCHAR(20),    
    floor_area_sqm       DECIMAL(6,1),
    flat_model           VARCHAR(50),
    lease_commence_date  INT,
    remaining_lease      VARCHAR(30),   
    resale_price         DECIMAL(12,2)
);

-- verify loaded data

SELECT COUNT(*) AS total_rows FROM resale;

SELECT * FROM resale LIMIT 10;

SELECT MIN(month) AS first_month, MAX(month) AS last_month FROM resale;

SELECT DISTINCT remaining_lease FROM resale LIMIT 20;

SELECT COUNT(*) AS null_prices FROM resale WHERE resale_price IS NULL;

-- data quality checks

-- check nulls
-- Nulls or blanks across all key columns in one pass
SELECT
    SUM(month IS NULL OR TRIM(month) = '')                     AS missing_month,
    SUM(town IS NULL OR TRIM(town) = '')                       AS missing_town,
    SUM(flat_type IS NULL OR TRIM(flat_type) = '')             AS missing_flat_type,
    SUM(block IS NULL OR TRIM(block) = '')                     AS missing_block,
    SUM(street_name IS NULL OR TRIM(street_name) = '')         AS missing_street,
    SUM(storey_range IS NULL OR TRIM(storey_range) = '')       AS missing_storey,
    SUM(floor_area_sqm IS NULL)                                AS missing_area,
    SUM(flat_model IS NULL OR TRIM(flat_model) = '')           AS missing_model,
    SUM(lease_commence_date IS NULL)                           AS missing_lease_year,
    SUM(remaining_lease IS NULL OR TRIM(remaining_lease) = '') AS missing_remaining_lease,
    SUM(resale_price IS NULL)                                  AS missing_price
FROM resale;

-- check validity of numeric columns
SELECT
    MIN(resale_price) AS min_price,   MAX(resale_price) AS max_price,
    MIN(floor_area_sqm) AS min_area,  MAX(floor_area_sqm) AS max_area,
    MIN(lease_commence_date) AS min_lease_year, MAX(lease_commence_date) AS max_lease_year
FROM resale;

-- zero or negative area/price
SELECT COUNT(*) AS invalid_rows
FROM resale
WHERE floor_area_sqm <= 0 OR resale_price <= 0;

-- lease commenced after the sale 
SELECT COUNT(*) AS lease_after_sale
FROM resale
WHERE lease_commence_date > CAST(SUBSTRING(month, 1, 4) AS UNSIGNED);
