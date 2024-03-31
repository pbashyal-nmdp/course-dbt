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
	CREATED_AT,
	EVENT_TYPE,
	ORDER_ID,
	PRODUCT_ID
from {{ ref("stg_posgress__events")}}
where event_type = 'page_view'