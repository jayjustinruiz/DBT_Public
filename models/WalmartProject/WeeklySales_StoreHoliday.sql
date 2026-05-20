{{ config(
    materialized='table',
    alias='WeeklySales_StoresHoliday',
    database='Walmart_DB',
    schema='Gold'
) }}

WITH WeeklySales_StoresHoliday AS (
    SELECT
        Store_ID,
        IsHoliday,
        SUM(Store_weekly_sales) AS total_sales,
        AVG(Store_weekly_sales) AS avg_weekly_sales,
        COUNT(*) AS num_records
    FROM {{ ref('Fact_Transform') }}
    GROUP BY
        Store_ID,
        IsHoliday
)

SELECT *
FROM WeeklySales_StoresHoliday