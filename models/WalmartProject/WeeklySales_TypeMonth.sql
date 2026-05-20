{{ config(
    materialized='table',
    alias='WeeklySales_TypeMonth',
    database='Walmart_DB',
    schema='Gold'
) }}

WITH base AS (
    SELECT
        a.Store_ID,
        b.Type as Store_Type,
        a.Date,
        a.Store_weekly_sales
    FROM {{ ref('Fact_Transform') }} a
    LEFT JOIN {{ source('WalmartBronze','Stores_Raw') }}  b
        ON a.Store_ID = b.Store
),

weekly_sales_by_type_month AS (
    SELECT
        Store_Type,
        EXTRACT(YEAR FROM Date) AS Year,
        EXTRACT(MONTH FROM Date) AS Month,
        SUM(Store_weekly_sales) AS total_weekly_sales,
        AVG(Store_weekly_sales) AS avg_weekly_sales,
        COUNT(*) AS num_records
    FROM base
    GROUP BY
        Store_Type,
        Year,
        Month
)

SELECT *
FROM weekly_sales_by_type_month
