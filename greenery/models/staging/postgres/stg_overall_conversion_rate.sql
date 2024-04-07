{{
    config(materialized = 'view')
}}

with numerator as (select count(distinct SESSION_ID) as purchase_count
                   from {{ ref("stg_postgres__events") }}
                   where EVENT_TYPE = 'checkout'
                   group by SESSION_ID),
     denominator as (select count(*) as total_count
                     from {{ ref("stg_postgres__events") }}
                     group by SESSION_ID)

select (sum(purchase_count) / sum(total_count)) * 100 as overall_conversion_rate
from numerator, denominator