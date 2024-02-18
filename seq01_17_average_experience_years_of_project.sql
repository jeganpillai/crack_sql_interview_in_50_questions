-- Question: calculates the average experience years for each project
-- Video: https://www.youtube.com/watch?v=QtjyIsYNgW8

Create table Project (project_id int, employee_id int);
Truncate table Project;
insert into Project (project_id, employee_id) values 
 (1, 1)
,(1, 2)
,(1, 3)
,(2, 1)
,(2, 4);

Create table Employee (employee_id int, name varchar(10), experience_years int);
Truncate table Employee;
insert into Employee (employee_id, name, experience_years) values 
 (1, 'Khaled', 3)
,(2, 'Ali'   , 2)
,(3, 'John'  , 1)
,(4, 'Doe'   , 2);

-- Basic SQL without getting clarification Questions 
select p.project_id 
      ,round(avg(e.experience_years),2) as average_years
      from Project p 
inner join Employee e 
        on e.employee_id = p.employee_id
  group by 1;

insert into Project (project_id, employee_id) values (9, 9);
insert into Employee (employee_id, name, experience_years) values (5, 'Ahmed', 3);

select coalesce(p.project_id,0) as project_id
      ,coalesce (round (avg (experience_years),2),0) as avg_exp
      from Employee e 
 left join Project p
        on e. employee_id = p. employee_id
     where p.project_id is null group by 1;
