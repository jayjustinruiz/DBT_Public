{{ config(materialized="view") }}


with RawEmployee as
(
    select * from DBT_DATABASE.DBT_SCHEMA.EmployeeRaw
)
select * from RawEmployee
