select 
order_id,
sum(amount) 
from 
{{ ref('fct_orders') }}
group by order_id
having sum(amount) < 0
