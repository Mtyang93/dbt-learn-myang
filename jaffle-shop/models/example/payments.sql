{% set results_list = dbt_utils.get_column_values(ref('stg_payments'), 'payment_method') %}  

with payments as ( 
select *
    from {{ ref('stg_payments') }} 
)      
select
    order_id,
    {% for i in results_list -%} 
    sum(case when payment_method = '{{ i }}' then amount else 0 end) as {{ i }}_amount {%- if not loop.last %},{% endif %} 
    {% endfor -%} 
from payments 
group by 1 
