-- Question: Find the primary department for each employee
-- Video: https://www.youtube.com/watch?v=bPAB7vXmb-Q

Create table Employee (employee_id int, department_id int, primary_flag ENUM('Y','N'));
Truncate table Employee;
insert into Employee (employee_id, department_id, primary_flag) values 
 (1, 1, 'N')
,(2, 1, 'Y')
,(2, 2, 'N')
,(3, 3, 'N')
,(4, 2, 'N')
,(4, 3, 'Y')
,(4, 4, 'N');

-- dataset-2 to show difference between UNION and UNION ALL 
Truncate table Employee;
insert into Employee (employee_id, department_id, primary_flag) values 
 (1, 59, 'N')
,(2, 44, 'N')
,(3, 27, 'N')
,(4, 29, 'N')
,(5, 40, 'Y');

-- dataset-3 to show if employee with more than one department with primary_flag = 'N'
Truncate table Employee;
insert into Employee (employee_id, department_id, primary_flag) values 
 (1, 1, 'N')
,(1, 2, 'N')
,(2, 1, 'Y')
,(2, 2, 'N')
,(3, 3, 'N')
,(4, 2, 'N')
,(4, 3, 'Y')
,(4, 4, 'N');

-- Approach 1: Basic CTE table 
with all_employees as 
(select employee_id, count(*) as cnt from Employee group by 1)
select e.employee_id, e.department_id 
      from Employee e 
inner join all_employees a 
        on a.employee_id = e.employee_id
       and a.cnt = 1
union all 
select e.employee_id, e.department_id 
      from Employee e 
inner join all_employees a 
        on a.employee_id = e.employee_id
       and a.cnt > 1
       and primary_flag = 'Y';

-- Approach 2: Replace CTE table and embed in SELECT statement itself 
select employee_id, department_id from Employee 
      where primary_flag = 'Y'
union -- UNION ALL will give duplicate data for dataset-2 
select employee_id, max(department_id)
      from Employee
  group by employee_id
    having count(employee_id) = 1;

-- Approach 3: Replace multiple SELECT and embed in one SELECT and OR condition
select employee_id, department_id from Employee 
      where primary_flag = 'Y' 
         or employee_id in (select employee_id from Employee group by 1 having count(*) = 1) ;

-- Approach 4: Using WINDOWS function COUNT()
with all_employees as (
select employee_id, department_id, primary_flag 
      ,count(employee_id) over(partition by employee_id) as rnum 
      from Employee )
select employee_id, department_id from all_employees 
      where rnum = 1 
union all 
select employee_id, department_id from all_employees 
      where rnum > 1 
        and primary_flag = 'Y';

-- Approach 5: Using WINDOWS function ROW_NUMBER()
with all_employees as (
select employee_id, department_id, primary_flag 
      ,row_number() over(partition by employee_id order by employee_id, primary_flag) as rnum 
      from Employee )
select employee_id, department_id from all_employees where rnum = 1; 
