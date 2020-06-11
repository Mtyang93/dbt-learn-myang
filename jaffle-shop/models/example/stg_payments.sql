
select
    orderid as order_id
    ,status
    ,paymentmethod as payment_method
    ,ID as payment_id
    ,round(amount/100) as amount
from {{ source('stripe', 'payment') }}

