-- Question: Find the names of the customer that are not referred by the customer
-- Video: https://www.youtube.com/watch?v=RTfYlh2WM6M

Create table Customer (id int, name varchar(25), referee_id int);
Truncate table Customer;
insert into Customer (id, name, referee_id) values 
 (1, 'Will', NULL)
,(2, 'Jane', NULL)
,(3, 'Alex', 2)    -- *** 
,(4, 'Bill', NULL)
,(5, 'Zack', 1)
,(6, 'Mark', 2);   -- *** 

-- General approach 
select name as customer_name
from Customer 
where referee_id != 2 or referee_id is Null;

-- Using COALESCE function 
select name as customer_name
       from Customer 
      where coalesce(referee_id,0) != 2;
