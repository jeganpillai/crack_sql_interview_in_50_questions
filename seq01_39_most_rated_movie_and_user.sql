-- Question: Find the top rated movie and title

-- English Video: https://www.youtube.com/watch?v=W0L0U0vpa10
-- Tamil Video: https://www.youtube.com/watch?v=JnUuYin0wlo

Truncate table Movies;
insert into Movies (movie_id, title) values 
 (1, 'Avengers')
,(2, 'Frozen 2')
,(3, 'Joker');

Create table Users (user_id int, name varchar(30));
Truncate table Users;
insert into Users (user_id, name) values 
 (1, 'Daniel')
,(2, 'Monica')
,(3, 'Maria')
,(4, 'James');

Create table MovieRating (movie_id int, user_id int, rating int, created_at date);
Truncate table MovieRating;
insert into MovieRating (movie_id, user_id, rating, created_at) values 
 (1, 1, 3, '2024-01-12')
,(1, 2, 4, '2024-02-11')
,(1, 3, 2, '2024-02-12')
,(1, 4, 1, '2024-01-01')
,(2, 1, 5, '2024-02-17')
,(2, 2, 2, '2024-02-01')
,(2, 3, 2, '2024-03-01')
,(3, 1, 3, '2024-02-22')
,(3, 2, 4, '2024-02-25');

-- Approach 1: Using individual dataset and merge
(
select u.name as results
      from MovieRating r 
inner join Users u 
        on u.user_id = r.user_id
  group by 1 order by count(*) desc, u.name limit 1)
union all 
(
select m.title as results
      from MovieRating r
inner join Movies m
        on m.movie_id = r.movie_id
--     where created_at between '2020-02-01' and '2020-02-29'
--     where left(created_at,7) = '2020-02'
--     where year(created_at) = 2020 and month(created_at) = 2
     where extract(year_month from created_at) = 202002
  group by 1 order by avg(rating) desc, m.title limit 1 );

-- Approach 2: Using single dataset and divide to merge 
with all_data as (
select u.name, m.title, r.rating 
      from MovieRating r 
inner join Users u 
        on u.user_id = r.user_id 
 left join Movies m 
        on m.movie_id = r.movie_id 
       and left(created_at, 7) = '2020-02')
(select u.name as results 
       from all_data u 
   group by 1 order by count(*) desc, u.name limit 1 )
union all 
(select title as results 
       from all_data 
      where title is not null 
   group by 1 order by avg(rating) desc, title limit 1 );

-- Approach 3: Using Windows function 
with user_rating as (
select u.name as results
      ,rank() over (order by count(r.movie_id) desc, u.name) as rnum 
      from MovieRating r 
inner join Users u 
        on u.user_id = r.user_id 
  group by 1)
,movie_rating as (
select m.title as results 
      ,rank() over(order by avg(r.rating) desc, m.title) as rnum 
      from MovieRating r 
inner join Movies m 
        on m.movie_id = r.movie_id 
       and left(created_at, 7) = '2020-02'
  group by 1 )
select results from user_rating where rnum = 1 
union all 
select results from movie_rating where rnum = 1;


