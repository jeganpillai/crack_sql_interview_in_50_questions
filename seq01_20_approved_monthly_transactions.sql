-- Question: find total transactions and approved transactions
-- Video: https://www.youtube.com/watch?v=_UTdfH0Fcn0

Create table Transactions 
(id int
,country varchar(4)
,state enum('approved', 'declined')
,amount int, trans_date date);
Truncate table Transactions;
insert into Transactions (id, country, state, amount, trans_date) values 
 (121, 'US', 'approved', 1000, '2018-12-18')
,(122, 'US', 'declined', 2000, '2018-12-19')
,(123, 'US', 'approved', 2000, '2019-01-01')
,(124, 'DE', 'approved', 2000, '2019-01-07');

-- using CASE Statement 
select SUBSTR(trans_date,1,7) as month
       ,country
       ,count(id) as tx_count 
       ,sum(case when state = 'approved' then 1 else 0 end) as app_count 
       ,sum(amount) as tx_amount 
       ,sum(case when state = 'approved' then amount else 0 end) as app_tx_amount
from Transactions 
group by 1,2;

-- using IF statement 
select SUBSTR(trans_date,1,7) as month
       ,country
       ,count(id) as tx_count 
       ,sum(if(state = 'approved' , 1 , 0)) as app_count 
       ,sum(amount) as tx_amount 
       ,sum(if(state = 'approved' , amount, 0)) as app_tx_amount
from Transactions 
group by 1,2;

-- wrong way of coding the sql 
with overall_transactions as (
select substr(trans_date,1,7) as month
       ,country
       ,count(id) as tx_count 
       ,sum(amount) as tx_amount 
       from Transactions 
   group by 1,2) 
,approved_transactions as (
  select substr(trans_date,1,7) as month
       ,country
       ,count(id) as tx_count 
       ,sum(amount) as tx_amount 
       from Transactions 
      where state = 'approved'
   group by 1,2)
select a.month, a.country
      ,a.tx_count as tx_cnt 
      ,b.tx_count as app_tx_cnt
      ,a.tx_amount as tx_amt 
      ,b.tx_amount as app_tx_amt 
      from overall_transactions a 
 left join approved_transactions b 
        on b.month = a.month 
       and b.country = a.country;
