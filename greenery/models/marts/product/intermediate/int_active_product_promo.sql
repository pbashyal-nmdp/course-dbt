{{
    config(
        materialized = 'table'
    )
}}


select products.PRODUCT_ID, NAME, PROMO_ID, DISCOUNT, PRICE
from {{ ref("stg_postgres__products")}} as products
         join
     {{ ref("stg_postgres__promos")}} as promos
where status = 'active'