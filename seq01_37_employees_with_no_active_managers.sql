-- Question: Find the Low Waged Managers who have inactive Managers, means 
-- 1. Find the employees whose salary is strictly less than $30000 and 
-- 2. whose manager left the company. 

English Video: 
Tamil Video: 

Create table Employees (employee_id int, name varchar(20), manager_id int, salary int);
Truncate table Employees;
insert into Employees (employee_id, name, manager_id, salary) values 
 ( 3, 'Mila'     , 9   , 60301)
,(12, 'Antonella', Null, 31000)
,(13, 'Emery'    , Null, 67084)
,( 1, 'Kalel'    , 11  , 21241)
,( 9, 'Mikaela'  , Null, 50937)
,(11, 'Josh'   , 6   , 28485);

-- Approach 1: Self Join
select e.employee_id
      from Employees e 
 left join Employees m 
        on m.employee_id = e.manager_id 
     where e.manager_id is not null 
       and m.employee_id is null 
       and e.salary < 30000
  order by 1;

Normally, for these kind of questions, Self join is the better option to use. But lets see few other simple approaches

We are going to see the Subquery option
-- Approach 2: Subquery
select e.employee_id 
      from Employees e 
     where e.manager_id is not null 
     and e.salary < 30000
     and e.manager_id not in (select employee_id from Employees)
     order by 1 ;

Same like Subquery, we can do this in Correlated subquery. We talked about this correlated subquery in couple of videos before and we can refresh our memory

-- Approach 3: Correlated Subquery
select e.employee_id 
      from Employees e 
     where e.manager_id is not null 
     and e.salary < 30000
     and not exists (select 1 from Employees ee where ee.employee_id = e.manager_id)
     order by 1 ;
