{{
    config(materialized = 'view')
}}

with numerator as (select count(distinct SESSION_ID) as purchase_count
                   from {{ ref("stg_postgres__events") }}
                   {{ unique_purchases() }}),
     denominator as (select count(*) as total_count
                     from {{ ref("stg_postgres__events") }}
                     group by SESSION_ID)

select {{ conversion_rate(purchase_count, total_count) }} as overall_conversion_rate
from numerator, denominator