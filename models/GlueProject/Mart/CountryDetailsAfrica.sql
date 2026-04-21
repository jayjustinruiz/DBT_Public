{{
config
({
"materialized":'table',
"schema": 'MART'
})
}}

 

WITH country_details_africa AS
(
SELECT
*
FROM
{{ ref('CountryDetailsTransform') }}
WHERE UPPER(COUNTRY_CONTINENT_NAME) = 'AFRICA'
)
SELECT
*
FROM country_details_africa