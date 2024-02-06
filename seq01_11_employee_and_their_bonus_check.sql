-- Question: select all employee's name and bonus details of whose bonus is < 1000.
-- Video: https://www.youtube.com/watch?v=Pv6zc-5AQ18

Create table Employee (empId int, name varchar(255), supervisor int, salary int);
Truncate table Employee;
insert into Employee (empId, name, supervisor, salary) values 
 (3, 'Brad'  , Null, 4000)
,(1, 'John'  ,    3, 1000)
,(2, 'Dan'   ,    3, 2000)
,(4, 'Thomas',    3, 4000);

Create table Bonus (empId int, bonus int);
Truncate table Bonus;
insert into Bonus (empId, bonus) values 
 (2, 500 )
,(4, 2000);

-- *** Approach 1: Basic OR condition *** 
select e.name, b.bonus
from Employee e 
left join Bonus b 
on b.empid = e.empid 
where b.bonus < 1000 or b.bonus is null ;

-- *** Approach 2: Using COALESCE() Function *** 
select e.name, b.bonus 
from Employee e 
left join Bonus b 
on b.empid = e.empid 
where coalesce(b.bonus,0) < 1000; 
