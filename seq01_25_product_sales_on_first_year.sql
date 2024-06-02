-- Question: determine the product sales on the first year of each product started to sell

-- English Video: https://www.youtube.com/watch?v=ZKo802J1TCI
-- Tamil Video: Pending 

-- *** Approach 1: subquery/cte table *** 
with first_sale_year as (
select product_id, min(year) as first_year 
       from Sales group by 1 )
select f.product_id, f.first_year, sum(quantity * price) as sale_amount 
       from first_sale_year f 
 inner join Sales s 
         on s.product_id = f.product_id
        and s.year = f.first_year 
   group by 1, 2;

-- *** Approach 2: Windows function *** 
with first_sale_year as (
select s.product_id, s.year as first_year, quantity, price
   -- ,row_number() over(partition by product_id order by product_id, year) as rnum
      ,rank() over(partition by product_id order by product_id, year) as rnk
      from Sales s )
select f.product_id, f.first_year, sum(quantity * price) as sale_amount 
       from first_sale_year f 
      where rnk = 1 
   group by 1,2;

-- *** Approach 3: using IN clause 
select s.product_id, s.year as first_year, sum(quantity * price) as sale_amount
       from Sales s 
      where (product_id, year) in (select product_id, min(year) as year from Sales group by 1)
   group by 1,2
