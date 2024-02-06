-- Question: Find the average time each machine takes to complete a process.
-- Video: https://www.youtube.com/watch?v=yW3-pxfnOgA

Create table If Not Exists Activity 
(machine_id int, process_id int, activity_type ENUM('start', 'end'), timestamp float);
Truncate table Activity;
insert into Activity (machine_id, process_id, activity_type, timestamp) values 
 (0, 0, 'start', 0.712)
,(0, 0, 'end'  , 1.52 )
,(0, 1, 'start', 3.14 )
,(0, 1, 'end'  , 4.12 )
,(1, 0, 'start', 0.55 )
,(1, 0, 'end'  , 1.55 )
,(1, 1, 'start', 0.43 )
,(1, 1, 'end'  , 1.42 )
,(2, 0, 'start', 4.1  )
,(2, 0, 'end'  , 4.512)
,(2, 1, 'start', 2.5  )
,(2, 1, 'end'  , 5    );

-- *** Approach 1: Self Join *** 
select e.machine_id, round(avg(e.timestamp - s.timestamp),3) as processing_time
       from Activity s
 inner join Activity e 
         on e.machine_id = s.machine_id 
        and e.process_id = s.process_id 
        and e.activity_type = 'end'
        and s.activity_type = 'start'
   group by 1 
   order by 1 ;

-- *** Approach 2: Windows Function - LAG() *** 
with raw_data_details as (
select machine_id, process_id, activity_type, timestamp 
      ,lag(timestamp, 1) over(partition by machine_id, process_id order by machine_id, process_id, timestamp) as start_timestamp
      from Activity )
select machine_id, round(avg(timestamp - start_timestamp),3) as processing_time 
       from raw_data_details 
      where activity_type = 'end'
   group by 1 ;
