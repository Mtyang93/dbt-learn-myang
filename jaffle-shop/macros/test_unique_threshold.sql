{% macro test_unique_threshold(model) %}

{% set column_name = kwargs.get('column_name', kwargs.get('arg')) %}

select count(*) as validation_errors
from (

    select
        {{ column_name }}

    from {{ model }}
    where {{ column_name }} is not null
    group by {{ column_name }}
    having count(*) > 1

) validation_errors

{% endmacro %}