{{
    config(materialized = 'view')
}}

with numerator as ({{ unique_purchases("stg_postgres__events") }}),
     denominator as ({{ unique_sessions("stg_postgres__events")}})

select {{ conversion_rate(purchase_count, total_count) }} as overall_conversion_rate
from numerator, denominator