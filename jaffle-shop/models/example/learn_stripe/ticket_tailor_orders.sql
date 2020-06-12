with source as (

    select * from {{ source('ticket_tailor', 'orders') }}

),

renamed as (

    select
        order_id,
        order_cancelled,
        event_id,
        event_name,
        event_start,
        event_end,
        order_items,
        tax_amount,
        tickets_checked_in,
        tickets_purchased,
        total_paid,
        transaction_id,
        transaction_type,
        order_date

    from source

)

select * from renamed
