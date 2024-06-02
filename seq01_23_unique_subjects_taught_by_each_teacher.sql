--Question: find the number of unique subjects taught by each teacher

-- English Video: https://www.youtube.com/watch?v=74HVdNrv5kY
-- Tamil Video: Pending 

Create table Teacher (teacher_id int, subject_id int, dept_id int);
Truncate table Teacher;
insert into Teacher (teacher_id, subject_id, dept_id) values 
 (1, 2, 3)
,(1, 2, 4)
,(1, 3, 3)
,(2, 1, 1)
,(2, 2, 1)
,(2, 3, 1)
,(2, 4, 1)
,(3, 4, 3)
,(3, 1, 3);

select teacher_id, count(subject_id) as cnt
       from Teacher 
   group by teacher_id
   order by cnt desc, teacher_id;
