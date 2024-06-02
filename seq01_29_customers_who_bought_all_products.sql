-- Question: Find the customers who bought all the products.

-- English Video: https://www.youtube.com/watch?v=pxjgY6idLyI
-- Tamil Video: https://www.youtube.com/watch?v=giaTRFlsA1M 

Create table Customer (customer_id int, product_key int);
Truncate table Customer;
insert into Customer (customer_id, product_key) values 
 (1, 5)
,(1, 6)
,(2, 6)
,(2, 6)
,(3, 5)
,(3, 6);

Create table Product (product_key int);
Truncate table Product;
insert into Product (product_key) values 
 (5)
,(6);

-- *** Approach 1: brute force method *** 
select customer_id, count(distinct product_key) as total_products 
       from Customer group by 1)
,overall_product_cnt as (
select count(product_key) as total_products from Product) 
select customer_id 
       from all_purchase a 
 inner join overall_product_cnt p 
         on p.total_products = a.total_products;

-- *** Approach 2: Using Case statement to compare the count *** 
with all_purchase as (
select customer_id 
      ,case when count(distinct product_key) = (select count(product_key) from Product) then 1 else 0 end as chk_flg
      from Customer c
  group by customer_id )
select customer_id from all_purchase where chk_flg = 1;

*** Approach 3: Using subquery *** 
select c.customer_id 
       from Customer c 
   group by c.customer_id having count(distinct product_key) = (select count(product_key) from Product);
