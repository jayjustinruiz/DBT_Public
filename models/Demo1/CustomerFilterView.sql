{{ config(materialized="view") }}

select * from {{source('Snowflake','CUSTOMER_SRC')}}
where country= 'USA'