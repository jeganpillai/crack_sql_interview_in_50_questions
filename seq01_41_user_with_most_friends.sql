-- Question: Find Users with More Friends

-- English Video: https://www.youtube.com/watch?v=xXEN6TgdTO4
-- Tamil Video: https://www.youtube.com/watch?v=UBsCVJGRd6U

Create table RequestAccepted (requester_id int, accepter_id int, accept_date date);
Truncate table RequestAccepted;
insert into RequestAccepted (requester_id, accepter_id, accept_date) values 
 (1, 2, '2024-04-03')
,(1, 3, '2024-04-08')
,(2, 3, '2024-04-08')
,(3, 4, '2024-04-09');

-- Approach 1: General sql approach 
with all_users as (
select user, sum(friends_cnt) as friends_cnt 
      from (select requester_id as user, count(accepter_id) as friends_cnt from RequestAccepted group by 1
            union all 
            select accepter_id as user, count(requester_id) as freinds_cnt from RequestAccepted group by 1) a 
  group by 1 )
select user from all_users where friends_cnt = (select max(friends_cnt) from all_users);

-- Approach 2: Clean version 
with all_users as (
select user, count(user) as friends_cnt 
      from (select requester_id as user from RequestAccepted
            union all 
            select accepter_id as user from RequestAccepted) a 
  group by 1 )
select user from all_users where friends_cnt = (select max(friends_cnt) from all_users);
