-- Question: swap the seat id of every two consecutive students

-- English Video: 
-- Tamil Video: 

Create table Seat (id int, student varchar(255));
Truncate table Seat;
insert into Seat (id, student) values 
 (1, 'Abbot')
,(2, 'Doris')
,(3, 'Emerson')
,(4, 'Green')
,(5, 'Jeames');

-- Approach 1: Simple Select statement with Subquery 
SELECT CASE WHEN l.lst = s.id and l.lst%2 = 1 then s.id
            WHEN s.id % 2 = 1 THEN s.id + 1
            WHEN s.id % 2 = 0 THEN s.id - 1 END AS id
        ,s.student
      FROM Seat s
inner join (select max(id) as lst from Seat) l 
 on 1 = 1 
  ORDER BY 1;

-- Approach 2: Split between ODD and EVEN sequence 
SELECT s.id, ss.student
      FROM Seat s
INNER JOIN Seat ss
        ON ss.id = s.id - 1 WHERE s.id % 2 = 0
UNION ALL 
SELECT s.id, COALESCE(ss.student, s.student) AS student
      FROM Seat s
 LEFT JOIN Seat ss
        ON ss.id = s.id + 1 WHERE s.id % 2 = 1
order by 1;

-- Approach 3: Using Windows Function LEAD() and LAG()
select id
      ,case when id%2=1 then lead(student,1,student) over (order by id )
            when id%2=0 then lag(student) over (order by id)
        end as student
from Seat ;
