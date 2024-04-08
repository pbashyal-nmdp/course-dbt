{% macro unique_sessions(event_table) %}
select count(*) as total_count
    from {{ ref(event_table) }}
    group by SESSION_ID
{% endmacro %}                     