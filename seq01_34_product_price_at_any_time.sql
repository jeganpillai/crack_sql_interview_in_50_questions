-- Question: Find the Product price at a given date

# English Video: https://www.youtube.com/watch?v=Z8gybEqJV6U
# Tamil Video: https://www.youtube.com/watch?v=0TLVxTfI8cY
 
Create table Products (product_id int, new_price int, change_date date);
Truncate table Products;
insert into Products (product_id, new_price, change_date) values 
 (1, 20, '2024-04-14')
,(1, 30, '2024-04-15')
,(1, 35, '2024-04-16')
,(2, 50, '2024-04-14')
,(2, 65, '2024-04-17')
,(3, 20, '2024-04-18');

-- Approach 1: General approach
with max_change_date as (
select product_id, max(change_date) as change_date 
      from Products 
     where change_date <= '2024-04-16' 
  group by 1 )
,matching_products as (
select p.product_id
      ,p.new_price as price 
      from Products p 
inner join max_change_date m 
        on m.product_id = p.product_id
       and m.change_date = p.change_date) 
select p.product_id , 10 as price 
      from Products p 
left join max_change_date m 
       on m.product_id = p.product_id
      and m.change_date = p.change_date
    where m.product_id is null 
      and p.product_id not in (select product_id from matching_products)
union all 
select product_id, price from matching_products

-- Approach 2: Simplified the final merge statement 
  
with max_change_date as (
select product_id, max(change_date) as change_date 
      from Products 
     where change_date <= '2024-04-16' 
  group by 1 )
,matching_products as (
select p.product_id
      ,p.new_price as price 
      from Products p 
inner join max_change_date m 
        on m.product_id = p.product_id
       and m.change_date = p.change_date) 
select distinct p.product_id, coalesce(m.price, 10) as price  
      from (select product_id from Products) p 
 left join matching_products as m 
        on m.product_id = p.product_id
