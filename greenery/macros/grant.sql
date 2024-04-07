{% macro grant(role) %}

    {% set sql %}
      GRANT USAGE ON SCHEMA {{ schema }} TO ROLE {{ role }};
      GRANT SELECT ON {{ this }} TO ROLE {{ role }};
    {% endset %}

    {% set table = run_query(sql) %}

    {% set msg = "Granted " + role  + " to schema: " + schema %}
    {{ dbt_utils.log_info(msg) }}

{% endmacro %}