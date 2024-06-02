-- Question: Find managers with at least five direct reports.

-- English Video: https://www.youtube.com/watch?v=877fTBPT1gM
-- Tamil Video: Pending 

-- Table with emp_id as unique identifier 
Create table If Not Exists Employee 
(emp_id int, name varchar(255), department varchar(255), manager_id int);
Truncate table Employee;
insert into Employee (emp_id, name, department, manager_id) values 
 (101, 'John'     , 'A', NULL)
,(102, 'Dan'      , 'A', 101)
,(103, 'James'    , 'A', 101)
,(104, 'Amy'      , 'A', 101)
,(105, 'Anne'     , 'A', 101)
,(106, 'Ron'      , 'B', 101)
,(107, 'Kenny'    , 'B', 102)
,(108, 'Pandian'  , 'B', 102)
,(109, 'Ricky'    , 'B', 103);

-- Table with emp_id and Department as unique identifier 
Create table If Not Exists Employee 
(emp_id int, name varchar(255), department varchar(255), manager_id int);
Truncate table Employee;
insert into Employee (emp_id, name, department, manager_id) values 
 (101, 'John'     , 'A', NULL)
,(101, 'John'     , 'B', NULL)
,(102, 'Dan'      , 'A', 101)
,(103, 'James'    , 'A', 101)
,(104, 'Amy'      , 'A', 101)
,(105, 'Anne'     , 'A', 101)
,(106, 'Ron'      , 'B', 101)
,(107, 'Kenny'    , 'B', 102)
,(108, 'Pandian'  , 'B', 102)
,(109, 'Ricky'    , 'B', 103);

-- Table with more than one employee with same name 

Truncate table Employee;
insert into Employee (emp_id, name, department, manager_id) values 
 (101, 'John'      ,'A',null)
,(102, 'Dan'       ,'A',101 )
,(103, 'James'     ,'A',101 )
,(104, 'Amy'       ,'A',101 )
,(105, 'Anne'      ,'A',101 )
,(106, 'Ron'       ,'B',101 )
,(107, 'Kenny'     ,'B',102 )
,(108, 'Pandian'   ,'B',102 )
,(109, 'Ricky'     ,'B',103 )
,(111, 'John'      ,'A',null)
,(112, 'Dan'       ,'A',111 )
,(113, 'James'     ,'A',111 )
,(114, 'Amy'       ,'A',111 )
,(115, 'Anne'      ,'A',111 )
,(116, 'Ron'       ,'B',111 );

-- Approach 1: Using CTE table 
with eligible_managers as (
select manager_id 
       from Employee 
   group by 1 having count(distinct emp_id) >= 5)
select e.name
       from eligible_managers m
 inner join Employee e
         on e.emp_id = m.manager_id 
   group by e.name, e.emp_id ;

-- Approach 2: Using Sub Query for table 
select e.name
       from (select manager_id 
                    from Employee 
                group by 1 having count(distinct emp_id) >= 5) m
 inner join Employee e
         on e.emp_id = m.manager_id 
   group by e.name, e.emp_id;

-- Approach 3: Using Self Join 
select e.name 
       from Employee m 
 inner join Employee e 
         on e.emp_id = m.manager_id 
   group by e.name, e.emp_id having count(distinct m.emp_id) >= 5 ;
