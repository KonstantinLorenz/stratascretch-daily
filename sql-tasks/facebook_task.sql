/*
Calculate each user's average session time. 
A session is defined as the time difference between a page_load and page_exit. 
For simplicity, assume a user has only 1 session per day and if there are multiple of the same events on that day, consider only the latest page_load and earliest page_exit. 
Output the user_id and their average session time.

Difficulty: Medium

Table: facebook_web_log

user_id:int
timestamp:datetime
action:varchar

*/
WITH a as (SELECT user_id,
                  MAX(timestamp) as maximum_load,
                  CAST(timestamp as date) as dates
            FROM facebook_web_log
            WHERE action ='page_load'
            GROUP BY user_id,CAST(timestamp as date)),
    b as (SELECT user_id,
                 MIN(timestamp) as minimum_exit,
                 CAST(timestamp as date) as dates2
          FROM facebook_web_log
          WHERE action = 'page_exit'
          GROUP BY user_id,CAST(timestamp as date)),
 c as (SELECT a.user_id,
       a.dates,
       a.maximum_load,
       b.minimum_exit,
       (b.minimum_exit-a.maximum_load) as session_time
FROM a JOIN b ON a.user_id=b.user_id AND a.dates=b.dates2)
SELECT c.user_id,
       AVG(c.session_time) as average
FROM c
GROUP BY user_id