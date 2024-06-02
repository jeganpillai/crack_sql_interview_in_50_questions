-- Question: find the products that have at least 100 units ordered in Feb 2024 and their amount

-- English Video: https://www.youtube.com/watch?v=1BdYaCcjMSw
-- Tamil Video: https://www.youtube.com/watch?v=e5uwTqMPWG4

Create table Products (product_id int, product_name varchar(40), product_category varchar(40));
Truncate table Products;
insert into Products (product_id, product_name, product_category) values 
 (1, 'Grow With Data'       , 'Book'   )
,(2, 'Jewels of Stringology', 'Book'   )
,(3, 'HP'                   , 'Laptop' )
,(4, 'Lenovo'               , 'Laptop' )
,(5, 'Learning Kit'         , 'T-shirt');

Create table Orders (product_id int, order_date date, unit int);
Truncate table Orders;
insert into Orders (product_id, order_date, unit) values 
 (1, '2024-02-05', '60')
,(1, '2024-02-10', '70')
,(2, '2024-01-18', '30')
,(2, '2024-02-11', '80')
,(3, '2024-02-17', '2' )
,(3, '2024-02-24', '3' )
,(4, '2024-03-01', '20')
,(4, '2024-03-04', '30')
,(4, '2024-03-04', '60')
,(5, '2024-02-25', '50')
,(5, '2024-02-27', '50')
,(5, '2024-03-01', '50');

-- Approach 1: Using Common Table Expression (CTE) table 
with eligible_orders as (
select product_id, sum(unit) as unit 
       from Orders
--      where order_date between '2024-02-01' and '2024-02-29' 
--      where left(order_date,7) = '2024-02' 
--      where year(order_date) = 2024 and month(order_date) = 2
        where year(order_date) = '2024' and month(order_date) = '02'
   group by 1 
     having sum(unit) >= 100 )
select p.product_name, o.unit 
       from Products p 
 inner join eligible_orders o 
         on o.product_id = p.product_id ;

-- Approach 2: Simple Inner Join 
select p.product_name, sum(o.unit) as unit  
       from Products p 
 inner join Orders o 
         on o.product_id = p.product_id 
--      where order_date between '2024-02-01' and '2024-02-29' 
--      where left(order_date,7) = '2024-02' 
--      where year(order_date) = 2024 and month(order_date) = 2
        where year(order_date) = '2024' and month(order_date) = '02'
   group by 1 
     having sum(unit) >= 100;
