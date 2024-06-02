-- Question: Group the Products Sold by Date

-- English Video: https://www.youtube.com/watch?v=FHKTOgsZ5GY
-- Tamil Video: https://www.youtube.com/watch?v=ejd5zKhgv7w

Create table Activities (sell_date date, product varchar(20));
Truncate table Activities;
insert into Activities (sell_date, product) values 
 ('2020-05-30', 'Headphone')
,('2020-05-30', 'Basketball')
,('2020-05-30', 'T-Shirt')
,('2020-06-01', 'Pencil')
,('2020-06-01', 'Bible')
,('2020-06-02', 'Mask')
,('2020-06-02', 'Mask');

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
