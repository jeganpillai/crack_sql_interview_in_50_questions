-- Question: Find the average selling price for each product

-- English Video: https://www.youtube.com/watch?v=7PQ4uCKzvhE
-- Tamil Video: Pending 

Create table Prices (product_id int, start_date date, end_date date, price int);
Truncate table Prices;
insert into Prices (product_id, start_date, end_date, price) values 
 (1, '2019-02-17', '2019-02-28', 5 )
,(1, '2019-03-01', '2019-03-22', 20)
,(2, '2019-02-01', '2019-02-20', 15)
,(2, '2019-02-21', '2019-03-31', 30);

Create table UnitsSold (product_id int, purchase_date date, units int);
Truncate table UnitsSold;
insert into UnitsSold (product_id, purchase_date, units) values
 (1, '2019-02-25', 100)
,(1, '2019-03-01', 15 )
,(2, '2019-02-10', 200)
,(2, '2019-03-22', 30 );

-- SQL: 
select u.product_id 
      ,round(sum(u.units * p.price)/sum(units),2) as average_price
      from UnitsSold u 
inner join Prices p 
        on p.product_id = u.product_id 
       and u.purchase_date between p.start_date and p.end_date 
  group by 1 ;
