{% macro bq_labels(node) %}
  {
    "dbt_node_id": "{{ node.unique_id }}"
  }
{% endmacro %}
