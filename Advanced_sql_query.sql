-- Advanced:
-- 11)Calculate the percentage contribution of each pizza type to total revenue.
Select
pizza_types.category,sum(pizzas.price*order_details.quantity) /
(Select 
round(sum(order_details.quantity*pizzas.price),2) 
as Total_Revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id)*100 as Revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.category
order by Revenue desc;


-- 12)Analyze the cumulative revenue generated over time.
Select order_date,
sum(revenue) over(order by order_date) as cum_revenue
from
(Select orders.order_date,sum(order_details.quantity*pizzas.price) as revenue
from orders join order_details
on orders.order_id = order_details.order_id
join pizzas
on order_details.pizza_id = pizzas.pizza_id
group by orders.order_date) as sales;


-- 13) Determine the top 3 most ordered pizza types based on revenue for each pizza category.
Select name,revenue from
(Select category,name, revenue,rank() 
over(partition by category order by revenue desc) as rn
from
(select pizza_types.category,pizza_types.name,sum(order_details.quantity*pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.category, pizza_types.name) as a) as b
where rn <= 3;