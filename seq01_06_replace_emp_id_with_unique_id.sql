-- Question: showcase the unique ID of each user, and if a user doesn't have a unique ID, we gracefully handle it by displaying null.
-- Video: https://www.youtube.com/watch?v=GLd6kgRgVg0
Create table Employees (id int, name varchar(20));
Truncate table Employees;
insert into Employees (id, name) values 
 (1, 'Alice')
,(7, 'Bob')
,(11, 'Meir')
,(90, 'Winston')
,(3, 'Jonathan');

Create table EmployeeUNI (id int, unique_id int);
Truncate table EmployeeUNI;
insert into EmployeeUNI (id, unique_id) values 
 (3, 1)
,(11, 2)
,(90, 3);

-- SQL to get the Unique ID 
select u.unique_id, e.name 
       from Employees e 
  left join EmployeeUNI u 
         on u.id = e.id ;
