-- Question: find the IDs of the invalid tweets. The tweet is invalid if the number of characters used in the content of the tweet is strictly greater than 15.

-- English Video: https://www.youtube.com/watch?v=nAs9J3AVCpw
-- Tamil Video: Pending 

Create table Tweets(tweet_id int, content varchar(50));
Truncate table Tweets;
insert into Tweets (tweet_id, content) values 
 (1, 'Vote for Biden')
,(2, 'Let us make America great again!');
insert into Tweets (tweet_id, content) values 
(3, NULL);

-- SQL: basic code 
select tweet_id 
       from Tweets 
where length(content) > 15;

-- SQL with change in the invaid tweet as length < 15 
select tweet_id 
from Tweets 
where length(content) < 15 or content is null;

-- SQL: using COALESCE() function 
select tweet_id 
from Tweets 
where length(coalesce(content,'')) < 15;
