-- Question: Find the not boring movie

-- English Video: https://www.youtube.com/watch?v=aL07wtTG_2k
-- Tamil Video: Pending 

Create table If Not Exists Cinema 
(movie_id int, movie_name varchar(255), description varchar(255), rating float(2, 1));
Truncate table Cinema;
insert into Cinema (movie_id, movie_name, description, rating) values 
 (1, 'War', 'great 3D', 8.9)
,(2, 'Science', 'boring', 4.5)
,(3, 'irish', 'boring', 6.2)
,(4, 'Ice song', 'Fantacy', 8.6)
,(5, 'House card', 'Interesting', 9.1);

-- additional samples 
insert into Cinema (movie_id, movie_name, description, rating) values 
 (6, 'DDLJ', 'Awesome', 9.9)
,(7, 'Bombay Velvet', 'Its Boring', 0.5)
,(8, 'Dil Se', 'romance', 8.5)
,(9, 'Red', 'Boring', 0.5);

-- basic SQL 
select movie_id, movie_name, description, rating
       from Cinema 
      where movie_id %2 <> 0 
        and lower(description) <> 'boring'
   order by rating desc  ;
  
-- SQL with sentiments
insert into Cinema (movie_id, movie_name, description, rating) values 
 (11, 'Tester', 'The movie is not boring', 9.9);

select movie_id, movie_name, lower(description) as description, rating
       from Cinema 
      where movie_id % 2 != 0
        and case when lower(description) like '%not%boring%' then 1
       when lower(description) not like '%boring%' then 1 end = 1 ; 

