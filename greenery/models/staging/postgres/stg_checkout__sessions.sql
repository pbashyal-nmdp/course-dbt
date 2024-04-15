{{
    config(materialized = 'view')
}}


-- not complete yet, the event needs to be joined to order and product
select events.PRODUCT_ID, products.name, count(distinct SESSION_ID) as views
from {{ ref("stg_postgres__events") }} events
        join {{ ref("stg_postgres__order_items") }} order_items
            on events.order_ID = order_items.order_ID,
        join {{ ref("stg_postgres__products") }} products
            on events.PRODUCT_ID = products.PRODUCT_ID,
where EVENT_TYPE = 'checkout'
group by events.PRODUCT_ID, products.name, events.EVENT_TYPE