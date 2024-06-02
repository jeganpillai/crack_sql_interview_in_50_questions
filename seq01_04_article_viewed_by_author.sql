-- Question: finding authors who have viewed at least one of their own articles

-- English Video: https://www.youtube.com/watch?v=vGX1b7HqrmA
-- Tamil Video: Pending 

Create table Views (article_id int, author_id int, viewer_id int, view_date date);
Truncate table Views;
insert into Views (article_id, author_id, viewer_id, view_date) values 
 (1, 3, 5, '2024-02-01')
,(1, 3, 6, '2024-02-02')
,(2, 7, 7, '2024-02-01')  -- ***
,(2, 7, 6, '2024-02-02')
,(4, 7, 1, '2024-01-22')
,(3, 4, 4, '2024-01-21')  -- ***
,(3, 4, 4, '2024-01-23'); -- ***

-- SQL: 
select author_id 
       from Views 
      where author_id = viewer_id;

-- SQL to find authors who viewed more than one times 
select author_id, count(*) 
      from Views 
     where author_id = viewer_id 
  group by 1 having count(*) > 1 ;

-- Using Windows Function 
with all_data as (
select article_id
      ,author_id 
      ,viewer_id 
      ,view_date
      ,count(*) over(partition by author_id) as cnt 
      from Views 
     where author_id = viewer_id )
select author_id from all_data where cnt > 1;  


