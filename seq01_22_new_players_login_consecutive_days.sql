-- Question: Find the new players who logged in two consecutive days.

-- English Video: https://www.youtube.com/watch?v=qyh5xqbP6lM
-- Tamil Video: Pending 

Create table Activity (player_id int, device_id int, event_date date, games_played int);
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values 
 (1, 2, '2024-03-01', 5)
,(1, 2, '2024-03-02', 6)
,(2, 3, '2024-06-25', 1)
,(3, 1, '2024-03-02', 0)
,(3, 4, '2024-07-03', 5);

-- Approach 1: SQL using CTE table 
with first_login_Dates as (
select player_id, min(event_date) as first_event_date 
       from Activity 
   group by 1 )
select count(distinct case when a.player_id is not null then a.player_id end) / count(distinct src.player_id) as fraction 
       from first_login_Dates src  
  left join Activity a 
         on a.player_id = src.player_id
        and date_add(src.first_event_date, interval 1 day) = a.event_date; 

-- Approach 2: using WINDOWS function 
with source_data as (
select player_id, device_id, event_date, games_played
      ,lead(event_date, 1) over(partition by player_id order by player_id, event_date) as next_event_date
      ,row_number() over(partition by player_id order by player_id, event_date) as rnum 
      from Activity )
select round(count(distinct case when date_add(event_date, interval 1 day) = next_event_date then player_id end) * 1.00/count(distinct player_id),2) as fraction
       from source_data
      where rnum = 1;


-- Additional data for validation
Truncate table Activity;
insert into Activity (player_id, device_id, event_date, games_played) values 
 (1, 2,'2024-02-29',5)
,(1, 2,'2024-03-01',6)
,(2, 3,'2024-06-25',1)
,(3, 1,'2024-03-02',0)
,(3, 4,'2024-07-03',5)
,(3, 4,'2024-07-04',5);
