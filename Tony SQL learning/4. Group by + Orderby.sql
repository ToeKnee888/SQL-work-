SELECT * 
FROM employee_demographics;

-- tells me the avg age of the gorup. 
SELECT gender, AVG(age)
FROM employee_demographics
GROUP BY gender
;

-- when doing group by, it needs to match on the select. IE Occupation to Occupation.
SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

-- ORDER BY= A-Z 

-- lowest to highest (ASC)

SELECT *
FROM employee_demographics
ORDER BY first_name ASC
;

-- highest to lowest (DESC)
SELECT *
FROM employee_demographics
ORDER BY first_name DESC
;

