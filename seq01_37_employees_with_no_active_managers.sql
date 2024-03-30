-- Question: Find the Low Waged Employees who have inactive Managers, means 
-- 1. Find the employees whose salary is strictly less than $30000 and 
-- 2. whose manager left the company. 

English Video: https://www.youtube.com/watch?v=e5-TbAkNt54
Tamil Video: https://www.youtube.com/watch?v=MR6P9rLAxrE

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

-- Approach 2: Subquery
select e.employee_id 
      from Employees e 
     where e.manager_id is not null 
     and e.salary < 30000
     and e.manager_id not in (select employee_id from Employees)
     order by 1 ;

-- Approach 3: Correlated Subquery
select e.employee_id 
      from Employees e 
     where e.manager_id is not null 
     and e.salary < 30000
     and not exists (select 1 from Employees ee where ee.employee_id = e.manager_id)
     order by 1 ;
