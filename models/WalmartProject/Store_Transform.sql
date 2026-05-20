{{ config(
    materialized='table',
    alias='Walmart_Store_Dim',
    database='Walmart_DB',
    schema='SILVER'
) }}

WITH distinct_dept AS (
    SELECT DISTINCT
        Store,
        Dept
    FROM {{ source('WalmartBronze','Departments_Raw') }}
),

Store_Join AS (
    SELECT
        s.Store as Store_ID,
        s.Type as Store_Type,
        s.Size as Store_Size,
        d.Dept as Dept_ID
    FROM {{ source('WalmartBronze','Stores_Raw') }} s
    JOIN distinct_dept d
        ON s.Store = d.Store
)

SELECT *
FROM Store_Join
