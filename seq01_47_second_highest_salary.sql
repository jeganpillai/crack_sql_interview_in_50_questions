-- Question: Find the Second Highest Salary

-- English Video: https://www.youtube.com/watch?v=LF_hTic7_Ig
-- Tamil Video: https://www.youtube.com/watch?v=5Qj41FCKmvg

Create table If Not Exists Employee (Id int, Name varchar(255), Salary int, Department varchar(100));

insert into Employee (Id, Name, Salary, Department) values 
(1, 'Max', '90000', 'IT')
,(2, 'Joe', '85000', 'IT')
, (3, 'Henry', '85000', 'HR')
, (4, 'Will', '70000', 'IT')
, (5, 'Janet', '69000', 'IT')
, (6, 'Sam', '60000', 'HR')
;

-- Approach 1: n00b format using Subquery
select max(salary) from Employee where salary
     < (select max(salary) from Employee where salary
          < (select max(salary) from Employee where salary
               < (select max(salary) from Employee where salary
                    < (select max(salary) from Employee)
                 )
            )
        );
-- Approach 2: Correlated subquery
SELECT max(e.Salary) AS SecondHighestSalary
  FROM Employee e
 WHERE 2 = (SELECT COUNT(DISTINCT ee.Salary) FROM Employee ee
             WHERE ee.Salary >= e.Salary);

-- Approach 3: Windows function with subquery format 
SELECT MAX(e.Salary) AS SecondHighestSalary
  FROM (SELECT Salary
              ,DENSE_RANK() OVER(ORDER BY Salary Desc) AS rnk
          FROM Employee  )e
         WHERE e.rnk = 2

-- Approach 4: Windows function with CTE table 
with main_table as (
SELECT Salary as salary
      ,DENSE_RANK() OVER(ORDER BY Salary desc) AS rnk
      FROM Employee) 
select max(salary) as SecondHighestSalary
      from main_table  
      where rnk = 2
      ;
