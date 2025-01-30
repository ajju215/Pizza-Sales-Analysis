-- Intermediate:
-- 6)Join the necessary tables to find the total quantity of each pizza ordered.
select pizza_types.name,sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name;


-- 7)Determine the distribution of orders by hour of the day.
Select hour(order_time) as hour,count(order_id) as order_count
from orders
group by hour(order_time)
order by order_count desc;



-- 8)Join relevant tables to find the category-wise distribution of pizzas.
Select category, count(name) from pizza_types
group by category;

-- 9)Group the orders by date and calculate the average number of pizzas ordered per day.
Select round(avg(quantity),0) as avg_pizza_order_per_day from
(Select orders.order_date,sum(order_details.quantity) as quantity
from orders join order_details
on orders.order_id = order_details.order_id
group by orders.order_date) as order_quantity;



-- 10)Determine the top 3 most ordered pizza types based on revenue.
Select pizza_types.name,sum(pizzas.price*order_details.quantity) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name
order by revenue desc limit 3;
