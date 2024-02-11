-- Question: Find the confirmation rate of each user
-- Video: https://www.youtube.com/watch?v=LylInkWFL4E

Create table If Not Exists Signups 
(user_id int, time_stamp datetime);
Truncate table Signups;
insert into Signups (user_id, time_stamp) values 
 (3, '2020-03-21 10:16:13')
,(7, '2020-01-04 13:57:59')
,(2, '2020-07-29 23:09:44')
,(6, '2020-12-09 10:39:37');

Create table If Not Exists Confirmations 
(user_id int, time_stamp datetime, action ENUM('confirmed','timeout'));
Truncate table Confirmations;
insert into Confirmations (user_id, time_stamp, action) values 
 (3, '2021-01-06 03:30:46', 'timeout')
,(3, '2021-07-14 14:00:00', 'timeout')
,(7, '2021-06-12 11:57:29', 'confirmed')
,(7, '2021-06-13 12:58:28', 'confirmed')
,(7, '2021-06-14 13:59:27', 'confirmed')
,(2, '2021-01-22 00:00:00', 'confirmed')
,(2, '2021-02-28 23:59:59', 'timeout');

-- SQL 
select s.user_id
      ,round(if (c.user_id is null, 0, sum(if (c.action = 'confirmed' , 1 , 0 )) /count(c.user_id)),2) as total 
      from Signups s 
 left join Confirmations c 
        on c.user_id = s.user_id
  group by 1
  order by 2,1;
