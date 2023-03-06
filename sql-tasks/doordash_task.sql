/*
You have been asked to find the job titles of the highest-paid employees.


Your output should include the highest-paid title or multiple titles with the same salary.

Difficulty: Medium

Tables: worker

worker_id:int
first_name:varchar
last_name:varchar
salary:int
joining_date:datetime
department:varchar

title

worker_ref_id:int
worker_title:varchar
affected_from:datetime

*/
select t.worker_title
from title as t
JOIN worker as w ON t.worker_ref_id=w.worker_id
ORDER BY salary DESC
LIMIT 2;