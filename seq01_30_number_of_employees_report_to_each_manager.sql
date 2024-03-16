-- Question : Find the number of employees report to each manager
-- Video: https://www.youtube.com/watch?v=giaTRFlsA1M

-- *** Approach 1: Using CTE/Subquery *** 
select e.employee_id, e.name, m.reports_count, m.average_age
      from Employees e 
inner join (select reports_to, count(*) as reports_count, round(avg(age),0) as average_age
                  from Employees 
                 where reports_to is not null 
              group by 1) m 
       on m.reports_to = e.employee_id 
 order by 1;

-- *** Approach 2: Using Self Join *** 
select e.employee_id, e.name
      ,count(m.employee_id) as reports_count
      ,round(avg(m.age),0) as average_age
      from Employees m
inner join Employees e
        on e.employee_id = m.reports_to 
       and m.reports_to is not null 
  group by 1,2 order by 1;
