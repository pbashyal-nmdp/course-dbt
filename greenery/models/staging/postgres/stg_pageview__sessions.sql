{{
    config(materialized = 'view')
}}

select events.PRODUCT_ID, products.name, count(distinct SESSION_ID) as views
from {{ ref("stg_postgres__events") }} events
        join {{ ref("stg_postgres__products") }} products
            on events.PRODUCT_ID = products.PRODUCT_ID,
where EVENT_TYPE = 'page_view'
group by events.PRODUCT_ID, products.name, events.EVENT_TYPE