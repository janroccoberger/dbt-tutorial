select
    id as order_id,
    customer as customer_id,
    ordered_at,
    store_id,
    subtotal,
    tax_paid,
    order_total

from `dbt-best-practices-dev`.jaffle_shop_raw.orders