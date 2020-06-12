
with source as (

    select * from {{ source('learn_stripe', 'charges') }}

),

renamed as (

    select
        id,
        captured,
        created,
        currency,
        description,
        failure_code,
        failure_message,
        fraud_details,
        livemode,
        object,
        paid,
        refunded,
        status

    from source

)

select * from renamed
