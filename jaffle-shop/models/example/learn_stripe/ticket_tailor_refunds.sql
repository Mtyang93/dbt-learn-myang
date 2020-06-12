with source as (

    select * from {{ source('learn_stripe', 'refunds') }}

),

renamed as (

    select
        id,
        charge_id,
        currency,
        created,
        status

    from source

)

select * from renamed
