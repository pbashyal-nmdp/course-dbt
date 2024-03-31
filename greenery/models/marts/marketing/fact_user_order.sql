{{
    config(
        materialized = 'table'
    )
}}

select
    users.user_id
     , users.first_name
     , users.last_name
     , count(*) number_of_orders
     , round(sum(orders.order_total), 2) as total
from
    {{ ref("stg_postgres__users") }} as users
        join
    {{ ref("stg_postgres__orders") }} as orders
    on
        users.user_id = orders.user_id
group by users.user_id, users.first_name, users.last_name
order by total desc