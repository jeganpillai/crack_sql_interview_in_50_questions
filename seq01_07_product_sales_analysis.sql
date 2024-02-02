-- Question: find the sales based on Product Name, Sale Year and Sale Price. 
-- Then we finetune the sql to find Sales of all products, even if its not sold. If no sales, then show it as Zero sales. 
-- Then, we check, the product not sold in the year 2023.

-- Video: https://www.youtube.com/watch?v=cXV_-EBgwHA

  
Create table If Not Exists Sales 
(sale_id int, product_id int, year int, quantity int, price int);
Truncate table Sales;
insert into Sales (sale_id, product_id, year, quantity, price) values 
 (1, 100, 2023, 10, 5000)
,(3, 100, 2024, 12, 5000)
,(4, 200, 2023, 15, 9000);

Create table If Not Exists Product 
(product_id int, product_name varchar(10));
Truncate table Product;
insert into Product (product_id, product_name) values 
 (100, 'Nokia')
,(200, 'Apple')
,(300, 'Samsung');

-- sql 1: 
select p.product_name, s.year, s.price 
from Sales s 
inner join Product p 
on p.product_id = s.product_id;

Truncate table Sales;
insert into Sales (sale_id, product_id, year, quantity, price) values 
 (1, 100, 2023, 10, 5000)
,(2, 100, 2023, 15, 7500) 
,(3, 100, 2024, 12, 5000)
,(4, 200, 2023, 15, 9000);

-- sql 2: All products 
select p.product_name, s.year, coalesce(sum(s.price),0) as price 
from  Product p 
left join Sales s
on p.product_id = s.product_id
group by p.product_name, s.year

-- sql 3: only products not have a sales in 2023 
select p.product_name, s.year, coalesce(sum(s.price),0) as price 
from  Product p 
left join Sales s
on p.product_id = s.product_id
and s.year is null 
where s.year is null 
group by p.product_name, s.year;
