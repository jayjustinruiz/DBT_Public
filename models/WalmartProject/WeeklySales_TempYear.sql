{{ config(
    materialized='table',
    alias='WeeklySales_TempYear',
    database='Walmart_DB',
    schema='Gold'
) }}

WITH sales_by_temp_year AS (
    SELECT
        EXTRACT(YEAR FROM Date) AS year,
        Temperature,
        SUM(Store_weekly_sales) AS total_weekly_sales,
        AVG(Store_weekly_sales) AS avg_weekly_sales,
        COUNT(*) AS num_records
    FROM {{ ref('Fact_Transform') }}
    GROUP BY
        EXTRACT(YEAR FROM Date),
        Temperature
)

SELECT *
FROM sales_by_temp_year
