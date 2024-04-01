
{{
    config(
        materialized = 'table'
    )
}}

with orders_cohort as (
    select user_id
        , count (distinct order_id) as user_orders 
    from {{ ref("stg_postgres__events")}}
    group by 1
    )
    , users_bucket as (
        select user_id
        , (user_orders = 1) ::int as has_one_purchases
        , (user_orders = 2) ::int as has_two_purchases
        , (user_orders = 3)::int as has_three_purchases
        , (user_orders >= 2)::int as has_two_plus_purchases
        from orders_cohort
)

select
    sum(has_one_purchases) as one_purchase
    , sum(has_two_purchases) as two_purchases
    , sum(has_three_purchases) as three_purchases 
    , sum(has_two_plus_purchases) as two_plus_purchases
    , count(distinct user_id) as num_users_w_purchase
    , div0(two_plus_purchases, num_users_w_purchase) as repeat_rate
    from users_bucket