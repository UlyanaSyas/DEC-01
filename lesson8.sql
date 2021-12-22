
-- 1

Select
    max(e.salary) as "Max",
    min(e.salary) as "Min",
    round(avg(e.salary)) as "Average"
From
    hr.employees e;
    
-- 2

Select
    max(e.salary) as "Max",
    min(e.salary) as "Min",
    round(avg(e.salary)) as "Average",
    j.job_title as "EMP"
From 
    hr.employees e
Join 
    hr.jobs j
On j.job_id = e.job_id
Group by j.job_title;

    
-- 3

Select 
    count (e.job_id) as "Amount of workers"
From employees e
Where job_id='&jobs';

-- 4

Select 
    e.job_id,
    count (e.job_id) as "Number"
From employees e
Group by e.job_id;

-- 5

Select
   count(e.manager_id) as "Number of managers"
From 
    hr.employees e;
    
-- 6
    
Select
    max(e.salary) - min(e.salary) as "DIFFERENCE"
From hr.employees e;

-- 7

Select
   e.manager_id as "Manager",
   min (e.salary) as "Min salary",
   count(*) as "Manager amount"
From hr.employees e
Group by e.manager_id
     having e.manager_id is not null and
     min (e.salary) > 6000
Order by min (e.salary);

-- 8

Select
     sum(case when (to_char(e.hire_date, 'YYYY')) = '2005'
     then '1'
     else '0'
     end) as "2005",
     sum(case when (to_char(e.hire_date, 'YYYY')) = '2006'
     then '1'
     else '0'
     end) as "2006",
     sum(case when (to_char(e.hire_date, 'YYYY')) = '2007'
     then '1'
     else '0'
     end) as "2007",
     sum(case when (to_char(e.hire_date, 'YYYY')) = '2009'
     then '1'
     else '0'
     end) as "2009",
     count(*) as "Total number of employees"
From 
    hr.employees e;
    
-- 9
    
Select
    count(*) as "Amount",
    sum(decode(to_char(e.hire_date, 'YYYY'),2005, 1, 0)) as "2005",
    sum(decode(to_char(e.hire_date, 'YYYY'),2006, 1, 0)) as "2006",
    sum(decode(to_char(e.hire_date, 'YYYY'),2007, 1, 0)) as "2007",
    sum(decode(to_char(e.hire_date, 'YYYY'),2009, 1, 0)) as "2009"
From hr.employees e;

-- 10

SELECT 
    d.department_name as "Suspected",
    min(e.salary) AS "Min",
    max(e.salary) AS "Max",
    count(*)
From hr.employees e
Join hr.departmens d 
    On e.department_id = department_id 
Group by d.department_name
having (max(e.salary )/min(e.salary)) >=1.7
Order by d.department_name;

/*
SELECT 
	d.DEPARTMENT_NAME ,
	j.JOB_TITLE ,
	ROUND(AVG(e.SALARY ) ) AS "Average salary in dept.",
	max(e.SALARY ) AS "Max salary in dept.",
	min(e.SALARY ) AS "Min salary in dept.",
	count(*) AS "cnt"
FROM hr.EMPLOYEES e
JOIN hr.DEPARTMENTS d 
	ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
JOIN hr.JOBS j 
	ON e.JOB_ID = j.JOB_ID 
GROUP BY d.DEPARTMENT_NAME, j.JOB_TITLE  
having (max(e.SALARY )/ROUND(AVG(e.SALARY ))) >=1.5
ORDER BY d.DEPARTMENT_NAME, j.JOB_TITLE  ; 
*/
