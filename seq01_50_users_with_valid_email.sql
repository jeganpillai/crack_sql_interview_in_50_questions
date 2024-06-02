-- Question: Find users with valid email

-- English Video: https://www.youtube.com/watch?v=y6nK3upadFA
-- Tamil Video: https://www.youtube.com/watch?v=i7JOYvOp8Lg

Create table Users (user_id int, user_name varchar(30), email varchar(50));
Truncate table Users;
insert into Users (user_id, user_name, email) values 
 (1, 'Winston'  , 'winston@growwithdata.co'   )
,(2, 'Jonathan' , 'jonathanisgreat'           )
,(3, 'Annabelle', 'bella-@growwithdata.co'    )
,(4, 'Sally'    , 'sally.come@growwithdata.co')
,(5, 'Marwan'   , 'quarz#2020@growwithdata.co')
,(6, 'David'    , 'david69@gmail.com'         )
,(7, 'Shapiro'  , '.shapo@growwithdata.co'    );

-- Approach 1: Basic Search 
select user_id, user_name,email
from Users 
where substring_index(email,'@',-1) = 'growwithdata.co'
and length(substring_index(email,'@',1)) > 1
and substring_index(email, '@',1) REGEXP '^[a-zA-Z]' = 1 
and substring_index(email, '@',1) REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*$' = 1;

-- Approach 2: Regular Expression 
select user_id, user_name, email
      from Users 
     where email REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@growwithdata.co$';
