-- Question: Find how much the customer paid in a seven days window

-- English Video: 
-- Tamil Video: 

Create table Customer (customer_id int, name varchar(20), visited_on date, amount int);
Truncate table Customer;
insert into Customer (customer_id, name, visited_on, amount) values 
 (1, 'Jhon'   , '2024-04-01', 100)
,(2, 'Daniel' , '2024-04-02', 110)
,(3, 'Jade'   , '2024-04-03', 120)
,(4, 'Khaled' , '2024-04-04', 130)
,(5, 'Winston', '2024-04-05', 110)
,(6, 'Elvis'  , '2024-04-06', 140)
,(7, 'Anna'   , '2024-04-07', 150)
,(8, 'Maria'  , '2024-04-08', 80 )
,(9, 'Jaze'   , '2024-04-09', 110)
,(1, 'Jhon'   , '2024-04-10', 130)
,(3, 'Jade'   , '2024-04-10', 150);

-- Approach 1: Self Join 
with agg_customer as (
select visited_on, sum(amount) as amount from Customer group by 1)
select c.visited_on
      ,sum(c2.amount) as amount 
      ,round(sum(c2.amount)/7.0, 2) as average_amount 
      ,count(distinct c2.visited_on) as chk 
      from agg_customer c 
inner join agg_customer c2 
        on 1 = 1 
       and c2.visited_on between date_add(c.visited_on, interval -6 day) and c.visited_on 
--       and c2.visited_on between date_sub(c.visited_on, interval 6 day) and c.visited_on 
  group by 1 having count(distinct c2.visited_on) = 7 order by 1;

-- Approach 2: Using Row Level Windows function 
with agg_customer as (
select visited_on, sum(amount) as amount from Customer group by 1)
,overall_visits as (
select visited_on
      ,sum(amount) over(order by visited_on rows between 6 preceding and current row) as amount
      ,round(avg(amount) over(order by visited_on rows between 6 preceding and current row),2) as average_amount 
      ,count(amount) over(order by visited_on rows between 6 preceding and current row) as cnt  
from agg_customer )
select visited_on  
      ,amount
      ,average_amount  
      from overall_visits 
     where cnt = 7;

-- Approach 3: Using Range Level Windows Function 
with overall_visit as (
select distinct visited_on
      ,sum(amount) over(order by visited_on range between interval 6 day preceding and current row) as amount
      ,round(sum(amount) over(order by visited_on range between interval 6 day preceding and current row)/7.0, 2) as average_amount  
      ,count(visited_on) over(order by visited_on rows between 6 preceding and current row) as cnt  
from Customer)
select visited_on
      ,amount 
      ,average_amount 
    from overall_visit 
    where cnt = 7;

