--1.
/*
Write a query for the HR department to produce the addresses of all the departments.
Use the LOCATIONS and COUNTRIES tables. Show the location ID, street address, city,
state or province, and country in the output. Use a NATURAL JOIN to produce the results.
*/

Select
    l.location_id as "ID",
    l.street_address as "Улица",
    l.city as "Город",
    l.state_province as "Штат или населённый пункт",
    c.country_name as "Страна"
From
    hr.countries c
Join                      -- соединяем таблицы
    hr.locations l
On
    l.country_id=l.country_id; -- соединяемся через айдишник
    
    
--2.
/*
The HR department needs a report of all employees with corresponding departments.
Write a query to display the last name, department number, and department name for all the employees.
*/

Select
    e.last_name as "Фамилия",
    d.department_id as "Номер департамента",
    d.department_name as "Название департамента"
From
    hr.departments d
Join
    hr.employees e
On  d.department_id=e.department_id;
    
--3.
/*
The HR department needs a report of employees in Toronto. 
Display the last name, job, department number, and department name for all employees who work in Toronto.
*/

Select
    e.last_name as "Фамилия",
    j.job_title as  "Работа",
    d.department_id as "Номер департамента",
    d.department_name as "Название департамента",
    l.city as "Город"
From
    hr.departments d
Join                            -- соединяем с
    hr.employees e
On  d.department_id=e.department_id   -- по айди департамента
Join                            -- и соединяемся с
    jobs j
On e.job_id=J.job_id            -- по ид работы
Join                            -- и с
    locations l
On d.location_id=l.location_id  -- по ид локации
Where 
    l.city in ('Toronto');      -- где город "Торонто"

--4.
/*
Create a report to display employees’ last names and employee numbers along with their managers’ last names and manager numbers. 
Label the columns Employee, Emp#, Manager, and Mgr#, respectively. 
Save your SQL statement and run the query.
*/

Select
    e.last_name as "Employee",
    e.employee_id as "Emp #",
    m.last_name as "Manager",
    e.manager_id as "Mgr #"
From
    hr.employees e
Join 
    hr.employees m
On e.manager_id=m.employee_id
Order by  e.manager_id asc;   -- сортировка по айдишнику менеджера
    
--5.
/*
Modify previous query to display all employees, including King, who has no manager. 
Order the results by employee number. 
Save your SQL statement. Run the query.
*/

Select
    e.last_name as "Employee",
    e.employee_id as "Emp #",
    m.last_name as "Manager",
    e.manager_id as "Mgr #"

From
    hr.employees e
Left outer join           -- соединение слева
    hr.employees m
On e.manager_id = m.employee_id
Order by  e.employee_id asc;

--6. 
/*
Create a report for the HR department that displays employee last names, department numbers, 
and all employees who work in the same department as a given employee. 
Give each column an appropriate label. Save and run the query.
*/
Select
    m.last_name as "Фамилия",
    m.department_id as "Номер департамента",
    e.last_name as "Сотрудники в департаменте"
From 
    hr.employees e
Join 
    hr.employees m
ON e.department_id=m.department_id  -- соединяемся по айдишнику
And e.employee_id <> m.employee_id  -- иcключения
Order by m.department_id asc;
    
--7. 
/*
The HR department needs a report on job grades and salaries. To familiarize yourself with the 
JOB_GRADES table, first show the structure of the JOB_GRADES table. 
Then create a query that displays the name, job, department name, salary, and grade for all employees.
*/

Select
    e.first_name ||
     ' ' ||
    e.last_name,
    j.job_title,
    d.department_name,
    e.salary,
    g.grade_level
From
    hr.employees e
Join
    hr.jobs j
On j.job_id=e.job_id
Join
    hr.departments d
On e.department_id=d.department_id
Join
    job_grades g
On (e.salary >= g.lowest_sal
And e.salary <= g.highest_sal)
Order by e.salary;

--8. 
/*
The HR department wants to determine the names of all employees who were hired after Davies. 
Create a query to display the name and hire date of any employee hired after employee Davies
*/
Select
    m.first_name ||
     ' ' ||
    m.last_name as "Имя и фамилия",
    to_char(m.hire_date, 'DD-MM-YYYY') as "Дата найма"
From
    hr.employees e
Join
    hr.employees m
On (e.last_name in 'Davies') 
And (m.hire_date >= m.hire_date)
Order by w.hire_date asc;



--9.
/*
The HR department needs to find the names and hire dates of all employees 
who were hired before their managers, along with their managers’ names and hire dates.
*/
Select
    e.first_name ||
     ' ' ||
    e.last_name as "Имя и фамилия",
    to_char (e.hire_date, 'DD-MM-YYYY' ) as "Дата найма",
    m.first_name ||
     ' ' ||
    m.last_name as "Менеджер",
    to_char (m.hire_date, 'DD-MM-YYYY') as "Дата найма менеджера"
   
From
    hr.employees e
Join 
    hr.employees m
On e.manager_id = m.employee_id
And e.hire_date < m.hire_date
Order by e.hire_date asc;