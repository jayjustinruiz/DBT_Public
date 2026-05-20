{% snapshot walmart_snapshot %}

{{
    config
    (
        target_database='WALMART_DB',
        target_schema='SNAPSHOTS',
        strategy = 'check',
        unique_key = 'Date_Id',
        check_cols = [
            'Weekly_Sales',
            'IsHoliday',
            'Temperature',
            'Fuel_Price',
            'CPI',
            'Unemployment'
        ]
    )
}}


select * from {{ ref('Fact_Transform') }}



{% endsnapshot %}