-- Question: find the number of times each student attended each exam.

-- English Video: https://www.youtube.com/watch?v=2scFAY9UXXU
-- Tamil Video: Pending 

Create table If Not Exists Students (student_id int, student_name varchar(20));
Truncate table Students;
insert into Students (student_id, student_name) values 
 (1 , 'Alice')
,(2 , 'Bob')
,(13, 'John')
,(6 , 'Alex');

Create table If Not Exists Subjects (subject_name varchar(20));
Truncate table Subjects;
insert into Subjects (subject_name) values 
 ('Math')
,('Physics')
,('Programming'); 

Create table If Not Exists Examinations (student_id int, subject_name varchar(20));
Truncate table Examinations;
insert into Examinations (student_id, subject_name) values 
 (1 , 'Math')
,(1 , 'Math)
,(1 , 'Math')
,(1 , 'Phy;sics')
,(1 , 'Physics')
,(1 , 'Programming')
,(2 , 'Math')
,(2 , 'Programming')
,(13, 'Math')
,(13, 'Physics')
,(13, 'Programming');

select st.student_id, st.student_name, su.subject_name
,count(ex.subject_name) as attended_exams
from Students st 
inner join Subjects su 
on 1 = 1 
left join Examinations ex 
on ex.student_id = st.student_id
and ex.subject_name = su.subject_name
group by 1,2,3
order by 1, 2;
