{% macro unique_purchase_sessions(event_table) %}
select distinct SESSION_ID as purchase_session
                   from {{ ref(event_table) }}
                   where EVENT_TYPE = 'checkout'
                   group by SESSION_ID
{% endmacro %}                   