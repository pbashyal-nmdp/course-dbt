{% macro unique_purchases() %}
where EVENT_TYPE = 'checkout' group by SESSION_ID
{% endmacro %}