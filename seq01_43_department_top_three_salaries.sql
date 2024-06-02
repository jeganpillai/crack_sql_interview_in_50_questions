-- Question: Department Top Three Salaries

-- English Video: https://www.youtube.com/watch?v=W8De25Sd_JI
-- Tamil Video: https://www.youtube.com/watch?v=MUmDKdgRJ2Y

Create table Employee (id int, name varchar(255), salary int, departmentId int);
Truncate table Employee;
insert into Employee (id, name, salary, departmentId) values 
 (1, 'Joe'  , 85000, 1)
,(2, 'Henry', 80000, 2)
,(3, 'Sam'  , 60000, 2)
,(4, 'Max'  , 90000, 1)
,(5, 'Janet', 69000, 1)
,(6, 'Randy', 85000, 1)
,(7, 'Will' , 70000, 1);

Create table Department (id int, name varchar(255));
Truncate table Department;
insert into Department (id, name) values 
 (1, 'IT')
,(2, 'Sales');

-- Approach 1: Using Correlated Subquery 
select d.name as Department
      ,e.name as Employee 
      ,e.salary as Salary
      from Employee e 
inner join Department d 
        on d.id = e.departmentId
       and 3 >= (select count(distinct ee.salary) from Employee ee 
                       where ee.departmentId = e.departmentId
                         and ee.salary >= e.salary);

-- Approach 2: Using Window Function 
with all_employees as (
select e.name as Employee 
      ,e.salary as Salary
      ,d.name as Department
--      ,rank() over(partition by e.departmentId order by e.salary desc) as rnk 
      ,dense_rank() over(partition by e.departmentId order by e.salary desc) as drnk 
      from Employee e 
inner join Department d 
        on d.id = e.departmentId)
select Department, Employee, Salary 
      from all_employees 
     where drnk <= 3;
