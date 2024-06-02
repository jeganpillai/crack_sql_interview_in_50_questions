-- Question: We are asked to address the following questions:
-- 1. For each customer_id, retrieve the total amount spent and the average amount spent per visit.
-- 2. Identify the customer_id who visited the park without making any transactions and count the number of such visits.
-- 3. Find customers who visited the park but never had a transaction. 

-- English Video: https://www.youtube.com/watch?v=EAjQkKYWCjQ
-- Tamil Video: Pending 

  
Create table If Not Exists Visits(visit_id int, customer_id int);
Truncate table Visits;
insert into Visits (visit_id, customer_id) values 
 (1, 23)
,(2, 9 )
,(4, 30)
,(5, 54)
,(6, 96)
,(7, 54)
,(8, 54);

Create table If Not Exists Transactions(transaction_id int, visit_id int, amount int);
Truncate table Transactions;
insert into Transactions (transaction_id, visit_id, amount) values 
 ( 2, 5, 310)
,( 3, 5, 300)
,( 9, 5, 200)
,(12, 1, 910)
,(13, 2, 970);

-- SQL 1: For each customer_id, retrieve the total amount spent and the average amount spent per visit.
select v.customer_id, count(distinct v.visit_id) as total_visits
      ,sum(t.amount) as total_amount
      ,sum(t.amount)/count(distinct v.visit_id) as average_spent 
      from Visits v 
 left join Transactions t 
        on t.visit_id = v.visit_id
  group by 1 order by 3 desc;

-- SQL 2: Identify the customer_id who visited the park without making any transactions and count the number of such visits.
select v.customer_id, count(v.visit_id) as total_visits
      ,sum(t.amount) as total_amount
      from Visits v 
 left join Transactions t 
        on t.visit_id = v.visit_id
     where t.visit_id is null 
  group by 1 order by 3 desc; 

-- SQL 3: Find customers who visited the park but never had a transaction.
select distinct v.customer_id 
       from Visits v 
  left join (select v.customer_id
                    from Visits v 
              inner join Transactions t 
                      on t.visit_id = v.visit_id
                group by 1) c 
         on c.customer_id = v.customer_id
      where c.customer_id is null; 
