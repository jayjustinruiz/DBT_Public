{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='Date_ID',
    merge_exclude_columns=['INSERT_DTS'],
    alias='Walmart_Date_Dim',
    database='Walmart_DB',
    schema='SILVER'
) }}

WITH Date_Dim AS(
SELECT 
    CONCAT(Store, Dept, REPLACE(Date, '-', '')) AS Date_ID
    ,Date::Date AS Date
    ,IsHoliday::Boolean AS Is_Holiday
    ,CURRENT_TIMESTAMP AS INSERT_DTS
    ,CURRENT_TIMESTAMP as UPDATE_DTS
FROM {{source('WalmartBronze','Departments_Raw')}}
)

SELECT *
FROM Date_Dim
