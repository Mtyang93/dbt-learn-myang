with customers as (

    select * from {{ ref('stg_customers') }}

),

orders as (

    select * from {{ ref('stg_orders') }}

),

customer_orders as (

    select
        customer_id,

        min(order_date) as first_order_date,
        max(order_date) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),


final as (

    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        customer_orders.first_order_date,
        customer_orders.most_recent_order_date,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders

    from customers

    left join customer_orders using (customer_id)

),

order_total as (

    select
        orders.customer_id,
        sum(payments.amount) as life_time_value
    from orders
    left join {{ ref('payments') }}
    on orders.order_id = payments.order_id
    where payments.status != 'fail'
    group by 1

),

final_customers as (

    select
        final.*,
        coalesce(order_total.life_time_value, 0) as customer_life_time
    from final
    left join order_total
    on order_total.customer_id = final.customer_id

)

select* from final_customers