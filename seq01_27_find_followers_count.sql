-- Question: Find the followers count for each user

-- English Video: https://www.youtube.com/watch?v=VIh4uD6YL3k
-- Tamil Video: Pending 

Create table Followers(user_id int, follower_id int);
Truncate table Followers;
insert into Followers (user_id, follower_id) values 
 (0, 1)
,(1, 0)
,(2, 0)
,(2, 1);

-- General Aggregation function 
select user_id, count(follower_id) as followers_count 
from Followers 
group by 1 order by 1;

-- *** using Windows Function to get second top user with followers count *** 
-- General approach 
with all_followers_data as (
select user_id , count(follower_id) as followers_count 
       from Followers 
   group by 1) 
select user_id, followers_count
      ,rank() over(order by followers_count desc) as rnk 
      from all_followers_data;

-- simplified version
select user_id , count(follower_id) as followers_count 
      ,rank() over(order by count(follower_id) desc) as rnk
      from Followers 
  group by 1;

-- *** Get the third highest user based on followers *** 
Truncate table Followers;
insert into Followers (user_id, follower_id) values 
 (0, 1)
,(0, 2)
,(1, 0)
,(1, 1)
,(2, 0)
,(2, 1)
,(2, 2)
,(3, 1);

with all_followers_cnt as (
select user_id , count(follower_id) as followers_count 
      ,rank() over(order by count(follower_id) desc) as rnk
      ,dense_rank() over(order by count(follower_id) desc) as drnk
      from Followers 
  group by 1) 
select user_id
       from all_followers_cnt 
      where drnk = 3;
