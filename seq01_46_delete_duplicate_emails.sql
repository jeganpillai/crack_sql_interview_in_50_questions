-- Question: Delete duplicate emails

-- English Video: https://www.youtube.com/watch?v=Q5GvWc2uXis
-- Tamil Video: https://www.youtube.com/watch?v=Awn6ONtZ_Ng

Create table Person (Id int, Email varchar(255));
Truncate table Person;
insert into Person (id, email) values 
 (1, 'john@example.com')
,(2, 'bob@example.com')
,(3, 'john@example.com')
,(4, 'randi@example.com')
,(5, 'randi@example.com')
,(6, 'randi@example.com')
,(7, 'randi@example.com')

/* 
-- For Case Sensitivity data processing 
truncate table Person;
insert into Person (id, email) values 
 (1, 'john@example.com')
,(2, 'bob@example.com')
,(3, 'John@example.com')
,(4, 'randi@example.com')
,(5, 'Randi@example.com')
,(6, 'RANDI@example.com')
,(7, 'RANDi@example.com');
*/ 

-- Approach 1: Using Self Join 
delete dup
      from Person dup
          ,Person prim 
      where prim.email = dup.email
        and dup.id > prim.id;

-- Approach 2: Using Correlated Subquery
delete from Person where id in 
(select id from (select distinct p.id 
                        from Person p 
                       where 1 < (select count(*) from Person pp where lower(pp.email) = lower(p.email) and pp.id <= p.id)) a);

-- Approach 3: Simple Subquery
delete from Person
       where id not in (select * from (select min(id) from Person group by email) a );

-- Approach 4: Using Windows Function 
delete from Person where id in 
       (select id from (select id, email 
                              ,row_number() over(partition by email order by email, id) as rnum 
                              from Person 
       ) a where a.rnum > 1);
