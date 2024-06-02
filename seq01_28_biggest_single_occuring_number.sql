-- Question: Find the biggest single occuring number

-- English Video: https://www.youtube.com/watch?v=1dS8m88EuMU
-- Tamil Video: https://www.youtube.com/watch?v=DWjz90pQESs 

Create table MyNumbers (num int);
Truncate table MyNumbers;
insert into MyNumbers (num) values 
 (8)
,(8)
,(3)
,(3)
,(1)
,(4)
,(5)
,(6);

-- *** Approach 1: using basic subquery *** 
with single_numbers as (
select num from MyNumbers group by 1 having count(*) = 1)
select max(num) as num from single_numbers ;

-- *** Approach 2: using IN function *** 
select max(num) as num from MyNumbers
where num in (select num from MyNumbers group by 1 having count(*) = 1)

-- *** Approach 3: using NOT IN function *** 
select max(num) as num from MyNumbers
where num not in (select num from MyNumbers group by 1 having count(*) > 1)

-- *** Approach 4: using CASE statement 
select case when count(num) = 1 then num end as num from MyNumbers 
group by num
order by 1 desc limit 1

-- *** Approach 5: using IF statement *** 
select if (count(num) = 1 , num, null) as num from MyNumbers 
group by num
order by 1 desc limit 1

-- *** Approach 6: using Windows function *** 
with single_numbers as (
select num 
,max(num) over(order by num desc) as total_num 
from MyNumbers group by 1 having count(*) = 1)
select distinct total_num as num from single_numbers ;
