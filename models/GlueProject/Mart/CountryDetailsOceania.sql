{{
config
({
"materialized":'table',
"schema": 'MART'
})
}}

 

WITH country_details_oceania AS
(
SELECT
*
FROM
{{ ref('CountryDetailsTransform') }}
WHERE UPPER(COUNTRY_CONTINENT_NAME) = 'OCEANIA'
)
SELECT
*
FROM country_details_oceania