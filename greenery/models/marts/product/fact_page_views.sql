{{
    config(
        materialized = 'table'
    )
}}

select 
	EVENT_ID,
	SESSION_ID,
	USER_ID,
	PAGE_URL,
	ORDER_ID,
	PRODUCT_ID,
	CREATED_AT
from {{ ref("stg_postgres__events")}}
where event_type = 'page_view'