--1.
/*
The HR department needs to find data for all the clerks who were hired after 1997.
*/

Select
    e.first_name ||
    ' ' ||
    e.last_name "Чуваки",
    e.job_id "Кто по жизни",
    to_char(e.hire_date, 'YYYY-MM-DD') "Дата найма"
From hr.employees e
Where e.job_id like '%CLERK' 
And e.hire_date >= to_date('1997-01-01', 'YYYY-MM-DD');

--2.
/*
The HR department needs a report of employees who earn a commission. Show the last
name, job, salary, and commission of these employees. Sort the data by salary in
descending order.
*/

Select *
From hr.employees;

Select *
From hr.jobs;

Select
    e.last_name,
    j.job_title,
    e.salary,
    e.commission_pct
From hr.employees e
Join hr.jobs j
On e.job_id = j.job_id
Order by e.salary desc;

--3.
/*
For budgeting purposes, the HR department needs a report on projected raises. The report
should display those employees who do not get a commission but who have a 10% raise in
salary (round off the salaries).
*/

Select
	e.first_name ||
    ' ' ||
    e.last_name "Чуваки",
	round(e.salary + e.salary*0.1) "ЗП",
	e.commission_pct "Комиссия"
From hr.employees e
Where e.commission_pct is null;

--4.
/*
Create a report of employees and the duration of their employment. Show the last names of
all employees, together with the number of years and the number of completed months that
they have been employed. Order the report by the duration of their employment. The
employee who has been employed the longest should appear at the top of the list.
*/

/*Select
    to_char(jh.start_date, 'YYYY-MM-DD'),
    to_char(jh.end_date, 'YYYY-MM-DD')
From hr.job_history jh;*/

Select
    e.last_name "Фамилия",
    floor(months_between(jh.end_date, jh.start_date)/12) "Продолжительность работы в годах",
    floor(mod(months_between(jh.end_date, jh.start_date),12)) "И месяцы"
From hr.job_history jh
Join hr.employees e
On jh.employee_id = e.employee_id
Order by 2 desc;

-- Все работники.

Select
    e.last_name "Фамилия",
    floor(months_between(sysdate, e.hire_date)/12) "Продолжительность работы в годах",
    floor(mod(months_between(sysdate, e.hire_date),12)) "И месяцы"
From hr.employees e
Order by 2 desc;

--5.
/*
Show those employees who have a last name that starts with the letters “J,” “K,” “L,” or “M.”
*/

Select
    e.first_name ||
    ' ' ||
    e.last_name "Чуваки"
From
    hr.employees e
Where substr(e.last_name, 1, 1) in ('J', 'K', 'L', 'M');

--6.
/*
Create a report that displays all employees, and indicate with the words Yes or No whether
they receive a commission. Use the DECODE expression in your query. These exercises can be used for extra practice
after you have discussed the following topics: basic SQL SELECT statement, basic SQL Developer commands, SQL functions, joins, and group functions.
*/

Select
	e.first_name ||
    ' ' ||
    e.last_name "Чуваки",
    Decode (e.commission_pct, null, 
                             'Нет', 'Да') "Коммиссия"
From hr.employees e;


--7.
/*
Create a report that displays the department name, location ID, last name, job title, and
salary of those employees who work in a specific location. Prompt the user for a location.
Enter 1800 for location_id when prompted.
*/

Select
    d.department_name "Название департамента",
    l.location_id "Местоположение",
    e.last_name "Фамилия",
    j.job_title "Кем работает",
    e.salary "ЗП"
From
     hr.locations l
Join hr.departments d
On l.location_id = d.location_id
Join hr.employees e
On d.department_id = e.department_id
Join hr.jobs J
On e.job_id = j.job_id
Where l.location_id = 1800;

--8.
/*
Find the number of employees who have a last name that ends with the letter “n.”
Create two possible solutions.
*/

Select
    rownum "Номер чувака",
    e.last_name "Фамилия"
From hr.employees e
Where e.last_name like '%n';

Select
    count(e.last_name) "Количество чуваков"
From hr.employees e
Where e.last_name like '%n';

--9.
/*
Create a report that shows the name, location, and number of employees for each
department. Make sure that the report also includes department_IDs without employees.
*/

Select
    d.department_name "Название департамента",
    d.location_id "Локация",
    count(e.employee_id) "Количество чуваков"
From hr.departments d
Left join hr.employees e
On d.department_id = e.department_id
Group by d.department_name, d.location_id
Order by "Количество чуваков" desc;

--10.
/*
The HR department needs to find the job titles in departments 10 and 20. Create a report to
display the job IDs for these departments.
*/

Select
    j.job_title,
    e.department_id
From hr.employees e
Join hr.jobs j
On e.job_id=j.job_id
Where e.department_id in (10, 20);

--11.
/*
Create a report that displays the jobs that are found in the Administration and Executive
departments. Also display the number of employees for these jobs. Show the job with the
highest number of employees first. These exercises can be used for extra practice after you 
have discussed the following topics: basic SQL SELECT statements, basic SQL Developer 
commands, SQL functions, joins, group functions, and subqueries.
*/

Select
    count(e.employee_id) "Количество",
    j.job_title "Должность",
    d.department_name "Название департамента"
From hr.employees e
Join hr.departments d 
On e.department_id = d.department_id
Join hr.jobs j
On e.job_id=j.job_id
Where d.department_name in ('Administration', 'Executive')
Group by j.job_title, d.department_name;

--12.
/*
Show all employees who were hired in the first half of the month (before the 16th of the
month, irrespective of the year).
*/

Select
    e.first_name ||
    ' ' ||
    e.last_name "Чуваки",
    to_char(e.hire_date, 'YYYY-MM-DD')
From hr.employees e
Where to_char(e.hire_date, 'DD') < 16;

--13.
/*
Create a report that displays the following for all employees: last name, salary, and salary
expressed in terms of thousands of dollars.
*/

Select
    e.last_name,
    e.salary,
    trunc(e.salary/1000) ||
    'K $' 
From hr.employees e;

--14.
/*
Show all employees who have managers with a salary higher than $15,000. Show the
following data: employee name, manager name, manager salary, and salary grade of the
manager.
*/

Select
    e.employee_id,
    e.first_name ||
    ' ' ||
    e.last_name "Менеджеры",
    m.first_name ||
    ' ' ||
    m.last_name "Чуваки",
    e.salary "ЗП",
    g.grade_level
From hr.employees e
Join hr.employees m
On e.employee_id = m.manager_id
Natural join hr.job_grades g
Where e.salary > 15000
And e.salary between g.lowest_sal and g.highest_sal;

/*select *
from hr.job_grades;*/


--15.
/*
Show the department number, name, number of employees, and average salary of all
departments, together with the names, salaries, and jobs of the employees working in each
department.
*/

--16.
/*
Create a report to display the department number and lowest salary of the department with
the highest average salary.
*/

--17.
/*
Create a report that displays the departments where no sales representatives work. Include
the department number, department name, manager ID, and location in the output.
*/

Select
    d.department_id,
    d.department_name,
    d.manager_id,
    l.city
From
    hr.departments d
Join hr.locations l
On d.location_id = l.location_id
Order by d.department_id;

--18.
/*
Create the following statistical reports for the HR department. Include the department
number, department name, and the number of employees working in each department that:
A. Employs fewer than three employees
B. Has the highest number of employees
C. Has the lowest number of employees
*/
--18.А

Select
    d.department_id "Номер департамента",
    d.department_name "Название департамента",
    count(employee_id) "Количество работающих"
From hr.departments d 
Join hr.employees e 
On d.department_id = e.department_id
Group by d.department_id, d.department_name
Having count(e.employee_id) < 3;

-- 18.В


--19.
/*
Create a report that displays the employee number, last name, salary, department number,
and the average salary in their department for all employees.
*/

Select
    e.employee_id "Номер",
    e.last_name "Фамилия",
    e.salary "ЗП",
    e.department_id "Номер департамента",
    round(avg(e.salary) over (partition by e.department_id)) "Средняя ЗП"
From hr.employees e
Group by e.employee_id, e.last_name, e.salary, e.department_id;

--20.
/*
Create an anniversary overview based on the hire date of employees. Sort the
anniversaries in ascending order.
*/

Select 
    e.first_name ||
    ' ' ||
    e.last_name "Чуваки",
    to_char(e.hire_date, 'DD') "День",
    to_char(e.hire_date, 'MM') "Месяц"
From hr.employees e;
