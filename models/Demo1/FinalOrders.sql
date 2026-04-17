{{
    config
    (
        materialized = 'table'
    )
}}
with clean_orders as
(
    select
    ORDER_ID,
    ORDER_DATE,
    CUSTOMER_ID,
    CUSTOMER_NAME,
    CREATED_AT,
    CURRENT_TIMESTAMP as INSERT_DTS
    from {{ ref('CleanOrders') }}
)
select * from clean_orders