/*
1. Запросы для выбора всех колонок, 5 шт.:
*/

-- 1

select
*
from
HR.EMPLOYEES;

-- 2

select
*
from
HR.JOBS;

-- 3
select
*
from
HR.DEPARTMENTS;

-- 4

select
*
from
HR.LOCATIONS;

-- 5

select
*
from
HR.REGIONS;

/*
2. Запросы на выбор первых трёх полей из таблиц, 5шт.:
*/

-- 1

select
employee_id,
first_name,
last_name
from
HR.EMPLOYEES;

-- 2

select
job_id,
job_title,
min_salary
from
HR.JOBS;

-- 3

select
department_id,
department_name,
manager_id
from
HR.DEPARTMENTS;

-- 4

select
location_id,
street_adress,
postal_code
from
HR.LOCATIONS;

-- 5

select
grade_level,
lowest_sal,
highest_sal
from
HR.JOB_GRADES;

/* 3. Запросы с выборкой определённых колонок в таблице, логически связанных, 5 шт.:
*/

-- 1

select
country_name,
country_id
from
HR.COUNTRIES;

-- 2

select
department_name,
manager_id
from
HR.DEPARTMENTS;

-- 3

select
first_name,
last_name,
salary
from
HR.EMPLOYEES;

-- 4

select
job_title,
max_salary,
min_salary
from
HR.JOBS;

-- 5

select
data_type,
data_default
from
HR.COPY_EMP;