SELECT * 
FROM employee_salary
WHERE first_name = 'Leslie';

SELECT * 
FROM employee_salary
WHERE salary <= 50000
;

SELECT * 
FROM employee_demographics
WHERE gender != 'Female'
;

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
;

-- AND OR NOT - LOGICAL OPERATORS

-- AND = both statement has to be correct to appear
-- or = one of the other can match the statement to appear

SELECT * 
FROM employee_demographics
WHERE birth_date > '1985-01-01'
OR NOT gender = 'male'
;


SELECT * 
FROM employee_demographics
WHERE (first_name = 'leslie' and age = '44') or age > 55
;

-- LIKE STATEMENT, patterns, not exact match
SELECT * 
FROM employee_demographics
WHERE first_name = 'jerry'
;

-- % means anything , _ specfic value
-- IE - A as an example, the % means, anything with an A at the front has to return. 
-- ___ - Starts with an A, then A___ needs to contain 2 additional characters. IE ANN to return.


SELECT * 
FROM employee_demographics
WHERE first_name LIKE 'a__%'
;


SELECT * 
FROM employee_demographics
WHERE birth_date LIKE '1989%'
;