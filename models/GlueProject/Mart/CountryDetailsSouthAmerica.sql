{{
config
({
"materialized":'table',
"schema": 'MART'
})
}}

 

WITH country_details_south_america AS
(
SELECT
*
FROM
{{ ref('CountryDetailsTransform') }}
WHERE UPPER(COUNTRY_CONTINENT_NAME) = 'SOUTH AMERICA'
)
SELECT
*
FROM country_details_south_america