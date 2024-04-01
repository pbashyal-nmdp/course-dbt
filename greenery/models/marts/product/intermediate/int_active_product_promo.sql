{{
    config(
        materialized = 'table'
    )
}}


select products.PRODUCT_ID, NAME, PROMO_ID, DISCOUNT, PRICE
from {{ ref("STG_POSTGRES__products")}} as products
         join
     {{ ref("STG_POSTGRES__promos")}} as promos
where status = 'active'