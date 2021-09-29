
# Q1
## Solution 1
-- Using a CTE, EXTRACT and Self-Joining
WITH MoM AS
(
    SELECT EXTRACT(month FROM starttime) AS mymonth,
    COUNT(DISTINCT memid) AS usr
    FROM cd.bookings
    GROUP BY mymonth 
)

SELECT 
a.mymonth AS old_month, a.usr AS old_usrc,
b.mymonth AS new_month, b.usr AS new_usrc,
ROUND((100*(b.usr - a.usr) / a.usr),2) as perc_change
FROM MoM AS a 
INNER JOIN MoM AS b on a.mymonth = b.mymonth - 1;

## Solution 2
-- Using a CTE, DATE_TRUNC and Self-Joining
WITH MoM AS
(
    SELECT DATE_TRUNC('month', starttime) AS mymonth,
    COUNT(DISTINCT memid) AS usr_count
    FROM cd.bookings
    GROUP BY mymonth 
)

SELECT 
A.mymonth AS old_month, A.usr_count AS old_usrc,
B.mymonth AS new_month, B.usr_count AS new_usrc,
ROUND(100*(B.usr_count - A.usr_count) / A.usr_count,2) as perc_change
FROM MoM AS A 
INNER JOIN MoM AS B on A.mymonth = B.mymonth - INTERVAL '1 month' ;
