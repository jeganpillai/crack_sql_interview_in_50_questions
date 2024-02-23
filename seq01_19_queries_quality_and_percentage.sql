-- Question: Find each query_name, the quality and poor_query_percentage.
-- Video: https://www.youtube.com/watch?v=r3QITge37PQ

Create table Queries (query_name varchar(30), result varchar(50), position int, rating int);
Truncate table Queries;
insert into Queries (query_name, result, position, rating) values 
 ('Dog', 'Golden Retriever', 1  , 5)
,('Dog', 'German Shepherd' , 2  , 5)
,('Dog', 'Mule'            , 200, 1)
,('Cat', 'Shirazi'         , 5  , 2)
,('Cat', 'Siamese'         , 3  , 3)
,('Cat', 'Sphynx'          , 7  , 4);

-- basic sql 
select query_name
,round(avg(rating/position),2) as quality 
,round(sum(case when rating < 3 then 1 else 0 end)/count(*) * 100,2) as poor_query_percentage 
from Queries
group by 1;

-- insert records with NULL query names 
insert into Queries (query_name, result, position, rating) values 
 (Null, 'Golden Retriever', 1, 5)
,(Null, 'German Shepherd', 2, 5)
,(Null, 'Mule', 200, 1);

-- include the NULL filter 
select query_name
,round(avg(rating/position),2) as quality 
,round(sum(case when rating < 3 then 1 else 0 end)/count(*) * 100,2) as poor_query_percentage 
from Queries
where query_name is not null 
group by 1;

-- brute force method 
select base.query_name
      ,round(base.quality, 2) as quality  
      ,round(base.poor_query / total.total_query * 100,2) as poor_query_percentage
      from (select query_name
                  ,avg(rating/position) as quality 
                  ,sum(case when rating < 3 then 1 else 0 end) as poor_query 
                  from Queries
                 where query_name is not null 
              group by 1) base 
inner join (select query_name, count(*) as total_query from Queries where query_name is not null group by 1) total 
        on total.query_name = base.query_name ;
