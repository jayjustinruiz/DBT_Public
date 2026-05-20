{{ config(
    materialized='table',
    alias='WeeklySales_StoreSize',
    database='Walmart_DB',
    schema='Gold'
) }}

WITH weekly_sales_by_size AS (
    SELECT
        Store_size,
        SUM(Store_weekly_sales) AS total_weekly_sales,
        AVG(Store_weekly_sales) AS avg_weekly_sales,
        COUNT(*) AS num_records
    FROM {{ ref('Fact_Transform') }}
    GROUP BY Store_size
)

SELECT *
FROM weekly_sales_by_size
