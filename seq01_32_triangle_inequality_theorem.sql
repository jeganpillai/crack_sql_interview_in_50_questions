-- Question: Find if the three line segments can form a triangle

# English Video: https://www.youtube.com/watch?v=ayWjeTC1x2o
# Tamil Video: https://www.youtube.com/watch?v=W71ToMMCnDA

Create table Triangle (x int, y int, z int);
Truncate table Triangle;
insert into Triangle (x, y, z) values 
 (13, 15, 30)
,(10, 20, 15);

-- Approach 1: Brute force method 
select x, y, z
      ,case when x+y > z then 1 else 0 end as f1 
      ,case when y+z > x then 1 else 0 end as f2 
      ,case when z+x > y then 1 else 0 end as f3 
      from Triangle) 
select x, y, z, case when f1+f2+f3 = 3 then 'Yes' else 'No' end as triangle 
from checking_length;

-- Approach 2: Single SELECT statement with two level of CASE statement 
select x, y, z
,case when case when x+y > z then 1 else 0 end 
         + case when y+z > x then 1 else 0 end
         + case when z+x > y then 1 else 0 end = 3 then 'Yes' else 'No' end  as f3 
from Triangle

-- Approach 3: Simplified version of CASE statement with only the conditions 
select x, y, z
      ,case when x+y > z and y+z > x and z+x > y then 'Yes' else 'No' end as triangle 
      from Triangle;

-- Approach 4: Using IF statement fro the same 
select x, y, z
      ,if(x+y > z and y+z > x and z+x > y, 'Yes', 'No') as triangle 
      from Triangle;
