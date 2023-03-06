/*
Given a table of purchases by date, calculate the month-over-month percentage change in revenue. 
The output should include the year-month date (YYYY-MM) and percentage change, rounded to the 2nd decimal point, and sorted from the beginning of the year to the end of the year.
The percentage change column will be populated from the 2nd month forward and can be calculated as ((this month's revenue - last month's revenue) / last month's revenue)*100.

Difficulty: Hard

Table: sf_transactions

id:int
created_at:datetime
value:int
purchase_id:int
*/
WITH a AS (select DATE_TRUNC('month', CAST(created_at as date)) as dates,
                  SUM(value) as summa
           from sf_transactions
           GROUP BY DATE_TRUNC('month', CAST(created_at as date)))
SELECT TO_CHAR(CAST(a.dates as date), 'YYYY-MM'),
       ROUND((a.summa - LAG(a.summa) OVER (ORDER BY a.dates))/LAG(a.summa) OVER (ORDER BY a.dates)*100, 2) as agrg
FROM a