-- Question: Find the daily active user count for a period of 31 days ending 2024-01-31 inclusively

-- English Video: https://www.youtube.com/watch?v=aAgoeCxyXW0
-- Tamil Video: Pending 

Create table Activity (
  user_id int
 ,session_id int
 ,activity_date date
 ,activity_type ENUM('open_session', 'end_session', 'scroll_down', 'send_message'));
Truncate table Activity;
insert into Activity (user_id, session_id, activity_date, activity_type) values 
 (1, 1, '2024-01-20', 'open_session')
,(1, 1, '2024-01-20', 'scroll_down')
,(1, 1, '2024-01-20', 'end_session')
,(2, 4, '2024-01-20', 'open_session')
,(2, 4, '2024-01-21', 'send_message')
,(2, 4, '2024-01-21', 'end_session')
,(3, 2, '2024-01-21', 'open_session')
,(3, 2, '2024-01-21', 'send_message')
,(3, 2, '2024-01-21', 'end_session')
,(4, 3, '2023-12-31', 'open_session')
,(4, 3, '2023-12-31', 'end_session');

-- Basic Group By Function 
select activity_date as day, count(distinct user_id) as active_users
       from Activity 
      where activity_date between date_add('2024-01-31', interval -31 day) and '2024-01-31'
   group by 1; 
