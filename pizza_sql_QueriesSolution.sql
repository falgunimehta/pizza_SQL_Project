create database pizza;
use pizza;
select * from pizzas;
select * from pizza_types;
select * from orders;
select * from order_details;

-- task1 Retrieve the total number of orders placed.
select count(order_id) from orders; 

-- task2 Calculate the total revenue generated from pizza sales.
select sum(od.quantity*p.price) 
from order_details od join pizzas p
on od.pizza_id = p.pizza_id;

-- task3 Identify the highest-priced pizza.
select pt.name,p.price from pizza_types pt join pizzas p
on pt.pizza_type_id=p.pizza_id
group by pt.name,p.price
order by p.price desc 
limit 1;

-- task4 Identify the most common pizza size ordered.
select p.size,od.quantity,count(od.order_details_id) from pizzas p join 
order_details od
on p.pizza_id= od.pizza_id
group by 1,2
order by 3 desc;

-- task5 List the top 5 most ordered pizza types along with their quantities.
select p.pizza_type_id,count(od.quantity) from pizzas p join order_details od
on p.pizza_id= od.pizza_id
group by 1
order by 2 desc
limit 5;

-- task6 Join the necessary tables to find the total quantity of each pizza category ordered.
select pt.category,count(od.quantity) from pizza_types pt join pizzas p
on pt.pizza_type_id=p.pizza_type_id
join order_details od
on p.pizza_id= od.pizza_id
group by 1;

-- task7 Determine the distribution of orders by hour of the day.
select hour(time),count(order_id) from orders
group by 1;

-- task8 Join relevant tables to find the category-wise distribution of pizzas.
select category,count(name) from pizza_types
group by 1;

-- task9 Group the orders by date and calculate the average number of pizzas ordered per day.
alter table orders
rename column date to 
order_date;

select avg(q) from 
(select o.order_date,sum(od.quantity) as q from orders o join order_details od
on o.order_id= od.order_id
group by 1) as order_quantity;

-- task10 Determine the top 3 most ordered pizza types based on revenue.

select p.pizza_type_id, (p.price*od.quantity) from pizzas p join order_details od
on p.pizza_id = od.pizza_id
group by 1,2
order by 2 desc
limit 3;

-- task11 Calculate the percentage contribution of each pizza type to total revenue.

select pt.category, sum(p.price*od.quantity)/(select (sum(p.price*od.quantity)) 
from pizzas p join order_details od
on p.pizza_id=od.pizza_id)*100
from pizza_types pt join pizzas p 
on pt.pizza_type_id=p.pizza_type_id
join order_details od
on p.pizza_id = od.pizza_id
group by 1;

-- task12 Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select pt.category,pt.pizza_type_id,pt.name, sum(p.price*od.quantity)
from pizza_types pt join pizzas p 
on pt.pizza_type_id=p.pizza_type_id
join order_details od
on p.pizza_id = od.pizza_id
group by 1,2,3
order by 4 desc
limit 3;
