{{ config(
    materialized='table',
    alias='Walmart_Fact_Table',
    database='Walmart_DB',
    schema='SILVER'
) }}

WITH base_join AS (
    SELECT 
        a.Store,
        a.Dept,
        a.Date,
        a.Weekly_Sales,
        a.IsHoliday,
        CONCAT(a.Store, a.Dept, REPLACE(a.Date, '-', '')) AS Date_ID,
        b.Size
    FROM {{ source('WalmartBronze','Departments_Raw') }} a
    LEFT JOIN {{ source('WalmartBronze','Stores_Raw') }} b
        ON a.Store = b.Store
),

fact_join AS (
    SELECT 
        a.Store as Store_ID,
        a.Dept as Dept_Id,
        a.Date_ID,
        a.Date::Date as Date,
        a.Size as Store_size,
        a.Weekly_Sales::DECIMAL(28,4) as Store_weekly_sales,
        a.IsHoliday::Boolean as IsHoliday,
        b.Temperature::DECIMAL(28,4) as Temperature,
        b.Fuel_Price::DECIMAL(28,4) as Fuel_Price,
        b.Unemployment,
        b.CPI,
        b.Markdown1,
        b.Markdown2,
        b.Markdown3,
        b.Markdown4,
        b.Markdown5 
    FROM base_join a
    LEFT JOIN {{ source('WalmartBronze','Facts_Raw') }} b
        ON a.Store = b.Store
        AND a.date = b.date::Date
        AND a.IsHoliday = b.IsHoliday
)

SELECT *
FROM fact_join