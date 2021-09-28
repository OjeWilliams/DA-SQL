## All questions can be found [here](https://quip.com/2gwZArKuWk7W)

Self-Join Practice Problems 

#1: MoM Percent Change 

*Context:* Oftentimes it's useful to know how much a key metric, such as monthly active users, changes between months. Say we have a table logins in the form: 
| user_id | date       |
|---------|------------|
| 1       | 2018-07-01 |
| 234     | 2018-07-02 |
| 3       | 2018-07-02 |
| 1       | 2018-07-02 |
| ...     | ...        |
| 234     | 2018-10-04 |

**Task**: Find the month-over-month percentage change for monthly active users (MAU). 

### Query
```
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
```
