-- Question: Find NUM which has atleast 3 consecutive IDs

# English Video: https://www.youtube.com/watch?v=l3UJ37gki9w
# Tamil Video: https://www.youtube.com/watch?v=xpvrWWHwSGA

Create table Logs (id int, num int);
Truncate table Logs;
insert into Logs (id, num) values 
 (1, 1)
,(2, 1)
,(3, 1)
,(4, 2)
,(5, 1)
,(6, 2)
,(7, 2);

-- dataset with more than three consecutive records 
Truncate table Logs;
insert into Logs (id, num) values 
 (1, 1)
,(2, 1)
,(3, 1)
,(4, 2)
,(5, 1)
,(6, 2)
,(7, 2)
,(8, 3)
,(9, 3)
,(10, 3)
,(11, 3);

-- Approach 1: Self Join but not scalable 
select distinct l1.num as ConsecutiveNums
       from Logs l1 
 inner join Logs l2
         on l2.num = l1.num 
        and l2.id = l1.id + 1 
 inner join Logs l3 
         on l3.num = l2.num 
        and l3.id = l2.id + 1;

-- Approach 2: Using LEAD() and LAG() windows function 
with consecutive_num as (
select id, num 
      ,lead(num,1) over(partition by num order by num, id) as num1
      ,lag(num,1) over(partition by num order by num, id) as num0

      ,lead(id,1) over(partition by num order by num, id) as id1
      ,lag(id,1) over(partition by num order by num, id) as id0
      from Logs l )
select distinct num as ConsecutiveNums 
       from consecutive_num
      where num0 is not null and num1 is not null 
        and id = id0+1 and id+1 = id1 ;

-- Approach 3: Using ROW_NUMBER() windows function 
with consecutive_nums as (
select id, num 
      ,row_number() over(partition by num order by num, id) as rnum 
      from Logs )
select num as ConsecutiveNums
       from consecutive_nums
    group by num, id - rnum 
      having count(*) > 2;

-- Approach 4: Using only LEAD() windows function 
with consecutive_nums as (
select id, num 
      ,lead(num, 1) over(order by id) as num2
      ,lead(num, 2) over(order by id) as num3 
      from Logs )
select distinct num as ConsecutiveNums
      from consecutive_nums 
     where num = num2 and num = num3;


