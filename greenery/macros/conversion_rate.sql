{% macro conversion_rate(purchase_count, total_count) %}
    (sum(purchase_count) / sum(total_count)) * 100 
{% endmacro %}