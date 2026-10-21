USE hdb_resale;

DROP TABLE IF EXISTS resale_raw;

CREATE TABLE resale_raw (
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

SELECT COUNT(*) AS total_rows FROM resale_raw;

SELECT * FROM resale_raw LIMIT 10;

SELECT MIN(month) AS first_month, MAX(month) AS last_month FROM resale_raw;

SELECT DISTINCT remaining_lease FROM resale_raw LIMIT 20;

SELECT COUNT(*) AS null_prices FROM resale_raw WHERE resale_price IS NULL;
