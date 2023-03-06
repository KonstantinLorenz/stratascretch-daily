/*
Write a query that'll identify returning active users. 
A returning active user is a user that has made a second purchase within 7 days of any other of their purchases. 
Output a list of user_ids of these returning active users.


Difficulty: Medium
Table: amazon_transactions

id:int
user_id:int
item:varchar
created_at:datetime
revenue:int
*/
WITH a as (select user_id,
       created_at,
       LEAD(created_at) OVER (PARTITION BY user_id ORDER BY created_at)-created_at as leads
from amazon_transactions)
SELECT DISTINCT a.user_id
FROM a
WHERE a.leads<7