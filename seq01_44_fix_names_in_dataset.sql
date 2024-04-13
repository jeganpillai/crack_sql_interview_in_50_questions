-- Question: Fix Names in Dataset

-- English Video: https://www.youtube.com/watch?v=Hx6vBVcUmjc
-- Tamil Video: https://www.youtube.com/watch?v=9i2Q_6r-moE

Create table Users (user_id int, name varchar(40));
Truncate table Users;
insert into Users (user_id, name) values 
 (1, 'aLice')
,(2, 'bOB');

-- Approach 1: Using LEFT() and RIGHT() functions 
select user_id, name
      ,concat(upper(left(name, 1)), lower(right(name, length(name)-1))) as b 
      from Users

-- Approach 2: Using SUBSTRING() function 
select user_id, name
      ,concat(upper(substr(name, 1,1)) , lower(substr(name,2))) as updated_name  
      from Users

-- Approach 3: Using INITCAP() function (Only for Oracle and PostgreSQL)
select user_id, initcap(name) as name from Users;
