#1)Retrieve the total number of orders placed.
Select count(order_id)
as Total_Orders from orders;


#2)Calculate the total revenue generated from pizza sales.
Select 
round(sum(order_details.quantity*pizzas.price),2) as Total_Revenue
from order_details join pizzas
on pizzas.pizza_id = order_details.pizza_id;


#3)Identify the highest-priced pizza.
Select pizza_types.name,pizzas.price
from pizzas join pizza_types
on pizzas.pizza_type_id = pizza_types.pizza_type_id
order by pizzas.price desc limit 1;


#4)Identify the most common pizza size ordered.
Select count(order_details.quantity) as pizza_sales,pizzas.size
from pizzas join order_details
where pizzas.pizza_id = order_details.pizza_id
group by pizzas.size 
order by pizza_sales desc;



#5)List the top 5 most ordered pizza types along with their quantities.
Select pizza_types.name,sum(order_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join order_details
on order_details.pizza_id = pizzas.pizza_id
group by pizza_types.name 
order by quantity desc limit 5;

