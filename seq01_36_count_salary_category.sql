-- Question: find the salary count based on category.
-- English video: https://www.youtube.com/watch?v=yuDlfMgu2H0
-- Tamil video: https://www.youtube.com/watch?v=uhq_dlbXCqY

Create table Accounts (account_id int, income int);
Truncate table Accounts;
insert into Accounts (account_id, income) values 
 (3, 108939)
,(2, 12747)
,(8, 87709)
,(6, 91796);

-- Approach 1: Using separate CTE table and find the result 
with all_category as (
select 'Low Salary' as category 
union all 
select 'Average Salary' as category
union all 
select 'High Salary' as category)
,given_category as (
select case when income < 20000 then 'Low Salary'
            when income between 20000 and 50000 then 'Average Salary'
            else 'High Salary' end as category
    ,count(account_id) as account_count 
    from Accounts 
    group by 1)
select a.category 
      ,coalesce(g.account_count, 0) as accounts_count
      from all_category a 
 left join given_category g 
        on g.category = a.category ;

-- Approach 2: Using one CTE and fnid the result 
with all_category as (
select 'Low Salary' as category 
union all 
select 'Average Salary' as category
union all 
select 'High Salary' as category)
select c.category 
      ,coalesce(count(account_id), 0) as accounts_count
      from all_category c 
 left join Accounts a
        on case when income < 20000 then 'Low Salary'
                when income between 20000 and 50000 then 'Average Salary'
                else 'High Salary' end = c.category  
  group by 1 ;

-- Approach 3: Using Select statement column
select 'Low Salary' as category, (select count(account_id) from Accounts where income < 20000) as  accounts_count 
union all 
select 'Average Salary' as category, (select count(account_id) from Accounts where income between 20000 and 50000) as  accounts_count 
union all 
select 'High Salary' as category, (select count(account_id) from Accounts where income > 50000) as  accounts_count ;

-- Approach 4: simple UNION ALL statement 
select 'Low Salary' as category, sum(income < 20000) as accounts_count from Accounts 
union all 
select 'Average Salary' as category, sum(income between 20000 and 50000) as accounts_count from Accounts 
union all 
select 'High Salary' as category, sum(income > 50000) as accounts_count from Accounts ;
