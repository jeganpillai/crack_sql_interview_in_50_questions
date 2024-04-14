-- Question: Patients With a Condition

-- English Video: 
-- Tamil Video: 

Create table Patients (patient_id int, patient_name varchar(30), conditions varchar(100));
Truncate table Patients;
insert into Patients (patient_id, patient_name, conditions) values 
insert into Patients (patient_id, patient_name, conditions) values 
 (1, 'Moustafa','ARTH'        )
,(2, 'Maria'   ,'DIAB101 MYOP')
,(3, 'Jade'    ,'ACNE MYOP CF')
,(4, 'Daniel'  ,'SADIAB100'   )
,(5, 'Daniel'  ,'YFEV COUGH'  )
,(6, 'Alice'   , NULL         )
,(7, 'Bob'     ,'DIAB100 MYOP')
,(8, 'George'  ,'ACNE DIAB100')
,(9, 'Alain'   ,'DIAB201'     );

-- Approach 1: Using CASE statement 
select patient_id, patient_name
,conditions
from Patients 
where case when conditions like 'DIAB1%' then 1
           when conditions like '% DIAB1%' then 1 
           else 0 end = 1 ;

-- Approach 2: Using Boolean Statement 
select patient_id, patient_name
,conditions
from Patients 
where conditions like 'DIAB1%' or conditions like '% DIAB1%';

-- Approach 3: Using Regular Expression REGEXP()
SELECT patient_id, patient_name, conditions
FROM Patients
WHERE conditions REGEXP '\\bDIAB1(\\d+)';

-- Approach 4: Using Regular Expression REGEXP_LIKE()
SELECT patient_id, patient_name, conditions
FROM Patients
WHERE REGEXP_LIKE(conditions,'(^| )DIAB1');
