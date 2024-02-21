-- Question: Report the Percentage of Users Attended a Contest, rounded to 2 digits.
-- Video: https://www.youtube.com/watch?v=9VsWEx54qaE
Create table Users (user_id int, user_name varchar(20));
Truncate table Users;
insert into Users (user_id, user_name) values 
 (6, 'Alice')
,(2, 'Bob')
,(7, 'Alex');

Create table Register (contest_id int, user_id int);
Truncate table Register;
insert into Register (contest_id, user_id) values 
 (207, 2)
,(208, 2)
,(208, 6)
,(208, 7)
,(209, 2)
,(209, 6)
,(209, 7)
,(210, 2)
,(210, 6)
,(210, 7)
,(215, 6)
,(215, 7);

-- SQL 1: Sub query table 
select r.contest_id, round(count(distinct r.user_id) * 100.0/max(total_users),2) as percentage
      from Register r 
inner join (select count(user_id) as total_users from Users) u
        on 1 = 1 
  group by 1 order by 2 desc, 1;

-- SQL 2: using CTE Table 
with total_users as (select count(user_id) as total_users from Users)
select r.contest_id, round(count(distinct r.user_id) * 100.0/max(total_users),2) as percentage
      from Register r 
inner join total_users u
        on 1 = 1 
  group by 1 order by 2 desc, 1; 

-- SQL 3: all in Subquery table 
select r.contest_id, r.registered_users / u.total_users * 100.0 as percentage
      from (select r.contest_id, count(distinct r.user_id) as registered_users  from Register r group by 1) r  
inner join (select count(user_id) as total_users from Users) u
        on 1 = 1 
  order by 2 desc, 1 ; 
