-- Question: Write a solution to find all dates' Id with higher temperatures compared to its previous dates (yesterday).
-- Video: https://www.youtube.com/watch?v=_gZF4c8AGB0

Create table If Not Exists Weather (id int, recordDate date, temperature int);
Truncate table Weather;
insert into Weather (id, recordDate, temperature) values 
 (1, '2015-01-01', 10)
,(2, '2015-01-02', 25)
,(3, '2015-01-03', 20)
,(4, '2015-01-04', 30)
,(5, '2015-01-06', 40);

*** Approach 1: Self Join *** 
select w2.id
from Weather w1 
inner join Weather w2 
on w2.recordDate = date_add(w1.recordDate, interval 1 day)
and w2.temperature > w1.temperature; 

*** Approach 2: LEAD(), the Windows function *** 
with all_data_source as (
select id, recordDate, temperature
,lag(recordDate, 1) over(order by recordDate) as prev_recordDate
,lag(temperature, 1) over(order by recordDate) as prev_day_temp
from Weather )
select id 
from all_data_source 
where temperature > prev_Day_temp 
and recordDate = date_add(prev_recordDate, interval 1 day)
