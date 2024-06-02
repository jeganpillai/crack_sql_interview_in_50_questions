-- Question: find the percentage of immediate orders in the first orders of all customers.

-- English Video: https://www.youtube.com/watch?v=VIruaB0hrAI
-- Tamil Video: Pending 

Create table Delivery 
(delivery_id int
,customer_id int
,order_date date
,customer_pref_delivery_date date);
Truncate table Delivery;
insert into Delivery (delivery_id, customer_id, order_date, customer_pref_delivery_date) values 
 (1, 1, '2019-08-01', '2019-08-02')  -- Scheduled
,(3, 1, '2019-08-11', '2019-08-12')
,(2, 2, '2019-08-02', '2019-08-02')  -- Immediate
,(6, 2, '2019-08-11', '2019-08-13')
,(4, 3, '2019-08-24', '2019-08-24') 
,(5, 3, '2019-08-21', '2019-08-22')  -- Scheduled 
,(7, 4, '2019-08-09', '2019-08-09'); -- Immediate

-- Approach 1: General SQL with CTE table 
with first_order as (
select customer_id, min(order_date) as order_date from Delivery group by 1 )
select round(sum(case when d.order_date = d.customer_pref_delivery_date then 1 else 0 end) / count(*) * 100.00,2) as immediate_percentage
       from first_order f 
 inner join Delivery d 
         on d.customer_id = f.customer_id 
        and d.order_date = f.order_date ; 

-- Approach 2: Using Windows function 
with all_orders as (
select customer_id
      ,order_date
      ,customer_pref_delivery_date
      ,row_number() over(partition by customer_id order by customer_id, order_date) as rnum 
      from Delivery)
select round(sum(case when d.order_date = d.customer_pref_delivery_date then 1 else 0 end) / count(*) * 100.00,2) as immediate_percentage
       from all_orders d 
      where rnum = 1 ;
