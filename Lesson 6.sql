-- 1.

Select 
    sysdate as "Date" 
From dual;

Select
    to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') as "Date"
From dual;

-- Это основной формат iso.
Select
    to_char(sysdate, 'YYYYMMDD hhmiss') as "Date"
From dual;
    
-- Это расширенный формат.

Select
    to_char(sysdate, 'YYYY-MM-DD hh:mi:ss') as "Date"
From dual;
    
-- 2.

Select
    e.employee_id,
    e.last_name,
    e.salary,
    e.salary + (salary*15.5)/100 as "New salary"
From
    hr.employees e;
    
-- 3.

Select
    e.employee_id,
    e.last_name,
    e.salary,
    e.salary + (e.salary*15.5)/100 as "New salary",
    (e.salary*15.5)/100 as "Increase"
From
    hr.employees e;
    
-- 4.

Select
    upper(e.first_name || ' ' || e.last_name) as "fullname",
    initcap (e.last_name) as "Last name",
    lenght (e.last_name) as "Characters in the surname"
From 
    hr.employees e
Where
    substr(e.last_name, 1, 1) in ('J', 'A', 'M')
Order by e.last_name;

-- 5.

Select
    e.employee_id,
    e.first_name || ' ' || e.last_name as "Employee name",
    e.department_id,
    trunc(MONTHS_BETWEEN(sysdate, hire_date)) as "Months worked"
From 
    hr.employees e
Order by e.hire_date;
    
-- 6.

Select
    (e.first_name || ' ' || e.last_name) as "Name",
    lpad(salary, 15, '$') as "Modified Salary"
From
    hr.employees e;
    
--7.

Select
    e.first_name,
    rpad ('*',e.salary/1000,'*') as "Salary rank"
From
    hr.employees e;

--8.

Select
    e.first_name,
    trunc((to_date('2010-01-01','YYYY-MM-DD') - hire_date)/7) as "Weeks worked"
From 
    hr.employees e
Where 
    e.department_id = 90
Order by e.hire_date desc;