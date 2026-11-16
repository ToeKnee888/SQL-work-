-- cast statement, can refer to as IF statements in excel. 

-- A CASE needs a END. Inbetween would be When, Then logic.


SELECT first_name,
last_name,
age,
CASE 
	WHEN age <=30 THEN 'young'
    WHEN age BETWEEN 31 and 50 then 'old'
    WHEN age >= 50 THEN "on death door"
END AS Age_bracket
FROM employee_demographics
;


-- pay increase and bonus 
-- < 50000 = 5%
-- > 50000 = 7% 
-- Finance = 10% Bonus

SELECT first_name, last_name, Salary,
CASE
	When salary < 50000 THEN salary + (salary * 0.05)
    when salary > 50000 THEN salary + (salary * 0.07)
END AS New_Salary,
CASE
	WHEN dept_id = 6 THEN salary * .10
END Bonus
FROM employee_salary;

SELECT * 
FROM employee_salary;

SELECT * 
FROM parks_departments;


