-- Question: Group the Products Sold by Date

-- English Video: 
-- Tamil Video: 

-- Step 1: Rough version 
select sell_date
      ,count(distinct product) as nuw_sold
      ,group_concat(distinct product) as products 
      from Activities
  group by 1;

-- Step 2: Sort the Products in Des order 
select sell_date
      ,count(distinct product) as nuw_sold
      ,group_concat(distinct product order by product desc) as products 
      from Activities
  group by 1;

-- Step 3: Change the Separator to ':'
select sell_date
      ,count(distinct product) as nuw_sold
      ,group_concat(distinct product order by product desc separator ':') as products 
      from Activities
  group by 1;
