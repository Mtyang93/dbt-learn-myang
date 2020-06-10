
select
    orderid as order_id
    ,status
    ,ID as payment_id
    ,round(amount/100) as amount
from {{ source('stripe', 'payment') }}

