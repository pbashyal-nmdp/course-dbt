{% macro unique_purchases(event_table) %}

select count(distinct SESSION_ID) as purchase_count
                   from {{ ref(event_table) }}
                    where EVENT_TYPE = 'checkout' group by SESSION_ID
{% endmacro %}