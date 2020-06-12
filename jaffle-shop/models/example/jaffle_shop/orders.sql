with orders as (

    select * from {{ ref('stg_orders') }}

),

order_total as (
    select
        orders.customer_id,
        sum(payments.amount) as life_time_value
    from orders
    left join {{ ref('stg_payments') }} as payments
    on orders.order_id = payments.order_id
    where payments.status != 'fail'
    group by 1
)

select* from order_total