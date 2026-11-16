-- limit and aliasing 

-- Order	SQL command	What it does
-- SELECT	Choose which columns you want
-- 	FROM	Choose which table to get data from
-- 	WHERE	Filter individual rows
-- GROUP BY	Group matching values
-- HAVING	Filter grouped results
-- ORDER BY	Sort the results
-- LIMIT	Restrict the number of results

SELECT * 
from employee_demographics
order by age desc
limit 2, 1
;

-- Aliasing - changing name of a column 

SELECT gender, AVG(age) AS avg_age
FROM employee_demographics
GROUP BY gender
HAVING avg_age > 40;
;