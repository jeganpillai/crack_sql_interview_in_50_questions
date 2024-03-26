-- Question: find the last person to fit in the bus
-- Video: https://youtu.be/n1K0y4QxfsM

Create table Queue (person_id int, person_name varchar(30), weight int, turn int);
Truncate table Queue;
insert into Queue (person_id, person_name, weight, turn) values 
 (5, 'Alice'    , 250, 1)
,(4, 'Bob'      , 175, 5)
,(3, 'Alex'     , 350, 2)
,(6, 'John Cena', 400, 3)
,(1, 'Winston'  , 500, 6)
,(2, 'Marie'    , 200, 4);

-- *** Approach 1: Self Join *** 
select q1.turn 
      ,q1.person_name
      ,sum(q2.weight)
      from Queue q1
inner join Queue q2 
        on q2.turn <= q1.turn 
  group by 1,2
    having sum(q2.weight) <= 1000
  order by q1.turn desc limit 1 ; 

-- *** Using Windows function 
with cumulative_weight as (
select person_id, person_name, weight, turn 
,sum(weight) over(order by turn) as cum_weight 
from Queue )
select person_name 
from cumulative_weight
where cum_weight <= 1000 
order by cum_weight desc limit 1;

-- *** Replace LIMIT function with additional subquery 
with cumulative_weight as (
select person_id, person_name, weight, turn 
,sum(weight) over(order by turn) as cum_weight 
from Queue )
select person_name 
from cumulative_weight
where cum_weight <= 1000 
and cum_weight = (select max(cum_weight) from cumulative_weight where cum_weight <= 1000);

