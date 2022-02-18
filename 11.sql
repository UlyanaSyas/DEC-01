--1.
/*
The HR department needs a list of department IDs for 
departments that do not contain the job ID ST_CLERK. Use the set operators to create this report.
*/

Select
    e.department_id,
    e.job_id
From
    hr.employees e
Minus
Select
    e.department_id,
    e.job_id  
From
    hr.employees e
Where e.job_id = 'ST_CLERK';

--2.
/*
The HR department needs a list of countries that have no departments located in them. 
Display the country IDs and the names of the countries. Use the set operators to create this report.
*/

Select
    c.country_id,
    c.country_name
From
    hr.countries c   
Minus
Select
     c.country_id,
     c.country_name
From
    hr.countries c 
Join
     hr.locations l
On c.country_id=l.country_id
Join
     hr.departments d
On l.location_id=d.location_id;

--3. 
/*
Produce a list of jobs for departments 10, 50, and 20, in that particular order. 
Display the job ID and department ID by using the set operators.
*/

Select
Distinct 
    e.job_id,
    e.department_id
From 
    hr.employees e
Where e.department_id=10
Union all
Select
Distinct
    e.job_id,
    e.department_id
From 
    hr.employees e
Where e.department_id=50
Union all
Select
Distinct
    e.job_id,
    e.department_id
From hr.employees e
Where e.department_id=20;

--4.
/*
Create a report that lists the employee IDs and job IDs of those employees who currently have a job title that is 
the same as their previous one (that is, they changed jobs but have now gone back to doing the same job they did previously).
*/

Select
    e.employee_id,
    e.job_id
From hr.employees e
Intersect
Select
    j.employee_id,
    j.job_id
From hr.job_history j;

--5. 
/*
The HR department needs a report with the following specifications: 
• Last names and department IDs of all employees from the EMPLOYEES table, 
    regardless of whether or not they belong to a department 
• Department IDs and department names of all departments from the DEPARTMENTS table, 
    regardless of whether or not they have employees working in them
*/

Select
    e.last_name as "Фамилия", 
    e.department_id as "Айдишник", 
    to_char('') as "Название департамента"
From hr.employees e
Union
Select 
    to_char(''),
    d.department_id,
    d.department_name
From hr.departments d;

--5.2 
/*
ОThe HR department needs a query that prompts the user for an employee’s last name.
The query then displays the last name and hire date of any employee in the same department
as the employee whose name the user supplies (excluding that employee). For example, if
the user enters Zlotkey, find all employees who work with Zlotkey (excluding Zlotkey).
*/

Select
    e.last_name,
    to_char(e.hire_date, 'DD-MM-YYYY'),
    e.department_id
From e.department_id = 
                    (Select
                        e.department_id
                    From hr.employees e
                    Where e.last_name = '&&Last_Name')
And e.last_name != '&&Last_Name';

--5.3
/*
Create a report that displays the employee number, last name, and salary of all employees
who earn more than the average salary. Sort the results in ascending order by salary.
*/

Select
    e.employee_id,
    e.last_name,
    e.salary
FROM hr.employees e
Where salary >
                (SELECT 
                    avg(e.salary)
                 FROM hr.employees e)
Order by e.salary;

--5.4 
/*
Write a query that displays the employee number and last name of all employees who work
in a department with any employee whose last name contains the letter “u.” Save your SQL
statement. Run your query and show the result.
*/

Select
    e.employee_id,
    e.last_name
From hr.employees e
Where e.department_id in 
                        (Select e.department_id
                        From hr.employees e
                        Where e.last_name like '%u%');
                        
--5.5
/*
The HR department needs a report that displays the last name, department number, and
job ID of all employees whose department location ID is 1700.
*/

Select
    e.last_name,
    e.department_id,
    e.job_id
From hr.employees e
Where e.department_id in 
                        (Select d.department_id 
                        From hr.departments d
                        Where d.location_id = 1700);
                           
--5.6
/*
Modify the query so that the user is prompted for a location ID.
*/

Select
    e.last_name as "Last name",
    e.department_id as "Department ID",
    e.job_id as "Job ID"
From hr.employees e
Where e.department_id in 
                        (Select d.department_id 
                        From hr.departments d
                        Where d.location_id = '&location_id');
                        
--5.7
/*
Create a report for HR that displays the last name and salary of every employee who
reports to King.
*/

Select
    e.last_name as "Last name",
    e.salary as "Salary"
From hr.employees e
Where e.manager_id in 
                    (Select e.employee_id
                    From hr.employees e
                    Where e.last_name = 'King')
And e.last_name != 'King';

--5.8 
/*
Create a report for HR that displays the department number, last name, and job ID for every
employee in the Executive department.
*/

Select
    e.department_id,
    e.last_name,
    e.job_id
From hr.employees e
Where e.department_id in 
                        (Select d.department_id
                        From hr.departments d
                        Where d.department_name= 'Executive');

--5.9 
/*
 Create a report that displays a list of all employees whose salary is more than the salary of
any employee from department 60.
*/

Select
    e.employee_id,
    e.salary
From hr.employees e
Where e.salary > any 
                    (Select e.salary
                    From hr.employees e
                    Where e.department_id = 60);

--5.10
/*
Modify the query in the 3rd task to display the employee number, last name, and
salary of all employees who earn more than the average salary and who work in a
department with any employee whose last name contains the letter “u.” Save and run the statement.
*/

Select
    e.employee_id,
    e.last_name,
    e.salary
From hr.employees e
Where e.salary > 
                (Select avg(e.salary)
                From hr.employees e)
And e.department_id in 
                    (Select e.department_id
                    From hr.employees e
                    Where e.last_name LIKE '%u%');