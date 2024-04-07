{{
    config(materialized = 'view')
}}

-- Conversion rate by product is defined as
-- the # of unique sessions with a purchase event of that product / total number of unique sessions that viewed that product
with purchases as (select distinct SESSION_ID as purchase_session
                   from {{ ref("stg_postgres__events") }}
                   where EVENT_TYPE = 'checkout'
                   group by SESSION_ID),
     numerator as (select events.PRODUCT_ID, count(distinct SESSION_ID) as purchases
                   from {{ ref("stg_postgres__events") }} events
                            join {{ ref("stg_postgres__products") }} products
                                 on events.PRODUCT_ID = products.PRODUCT_ID,
                        purchases
                   where SESSION_ID in (purchases.purchase_session)
                     and EVENT_TYPE = 'add_to_cart'
                   group by events.PRODUCT_ID, events.EVENT_TYPE),
     denomerator as (select events.PRODUCT_ID, count(distinct SESSION_ID) as views
                     from {{ ref("stg_postgres__events") }} events
                              join {{ ref("stg_postgres__products") }} products
                                   on events.PRODUCT_ID = products.PRODUCT_ID,
                          purchases
                     where SESSION_ID in (purchases.purchase_session) -- make sure they are purchased
                       and EVENT_TYPE = 'page_view'
                     group by events.PRODUCT_ID, events.EVENT_TYPE),
     product_conversion_rate as (select numerator.PRODUCT_ID, trunc((numerator.purchases / denomerator.views) * 100, 2) conversation_rate
                                 from numerator
                                          join denomerator on numerator.PRODUCT_ID = denomerator.PRODUCT_ID,
                                      {{ ref("stg_postgres__products") }} as products)

    select distinct(NAME), PRICE, conversation_rate 
    from product_conversion_rate join {{ ref("stg_postgres__products") }} as products
    on product_conversion_rate.PRODUCT_ID = products.PRODUCT_ID
    order by conversation_rate desc