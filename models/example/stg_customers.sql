-- depends_on: {{ ref('stg2_customers') }}

{{
  config(
  materialized='view'
  )
}}

with customers as (

    select
        *

    from {{ref('stg2_customers')}}

),

orders as (

    select
        *

    from {{ref('stg2_orders')}}

),

customer_orders as (

    select
        customer_id,

        min(ordered_at) as first_order_date,
        max(ordered_at) as most_recent_order_date,
        count(order_id) as number_of_orders

    from orders

    group by 1

),

final as (

    select
        stg2_customers.id,
        stg2_customers.name,
        orders.ordered_at,
        coalesce(orders.order_total, 0) as number_of_orders

    from jaffle_shop.stg2_customers

    left join jaffle_shop_raw.orders using (id)

)

select * from final
