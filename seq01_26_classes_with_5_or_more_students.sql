-- Question: Find all the classes that have at least five students.

-- English Video: https://www.youtube.com/watch?v=w5Hyu1bBXLI
-- Tamil Video: Pending 

Create table If Not Exists Courses (student varchar(255), class varchar(255));
Truncate table Courses;
insert into Courses (student, class) values 
 ('A', 'Math')
,('B', 'English')
,('C', 'Math')
,('D', 'Biology')
,('E', 'Math')
,('F', 'Computer')
,('G', 'Math')
,('H', 'Math')
,('I', 'Math');

-- Approach 1: General Group By function 
select class
from Courses 
group by class having count(student) >= 5;

-- Approach 2: Using Windows function 
with all_courses as (
select student, class
      ,count(*) over(partition by class order by student) as cnt
      from Courses)
select distinct class from all_courses 
where cnt >= 5; 

