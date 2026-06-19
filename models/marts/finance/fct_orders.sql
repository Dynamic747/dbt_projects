with orders as (
    select 
        order_id,
        customer_id
from {{ ref('stg_jaffleshop__orders') }}
),

payments as (
    select
        order_id,
        amount
from {{ ref('stg_stripe__payments') }}
where order_status = 'success'
),

final as (
    select
        orders.order_id,
        orders.customer_id,
        coalesce(payments.amount,0) as amount
from orders
left join payments
on orders.order_id = payments.order_id
)

select * from final