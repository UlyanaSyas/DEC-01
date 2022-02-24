--9.

Select
    d.department_name,
    d.location_id,
    count(e.employee_id)
From hr.departments d
Left join hr.employees e
On d.department_id = e.department_id
Group by d.department_name, d.location_id
Order by count(e.employee_id) desc;



--16.

Select
    e.department_id,
    min(e.salary),
From hr.employees e
Having avg(e.salary) > (
                        Select max(avg(e.salary))
                        From hr.employees e
                        Group by e.department_id
                        );

--17.

Select
    d.department_id,
    d.department_name,
    d.manager_id,
    d.location_id
From hr.departments d 
Where d.department_id not in (
                             Select 1
                             From hr.employees m 
                             Where e.job_id = 'SA_REP'
                            );


--18.

Select
    d.department_id,
    d.department_name
    count(employee_id) "Количество"
From hr.departments d 
Join hr.employees e 
On d.department_id = e.department_id
Group by d.department_id, d.department_name
Having count(e.employee_id) < 3;

Select
    d.department_id,
    d.department_name
    count(employee_id) "Количество"
From hr.departments d 
Join hr.employees e 
On d.department_id = e.department_id
Group by d.department_id, d.department_name
Having count(e.employee_id) = (
                              Select max(count(1))
                              From hr.employees e 
                              Group by m.department_id
                              );

Select
    d.department_id,
    d.department_name
    count(employee_id) "Количество"
From hr.departments d 
Join hr.employees e 
On d.department_id = e.department_id
Group by d.department_id, d.department_name
Having count(e.employee_id) = (
                              Select max(count(1))
                              From hr.employees e 
                              Group by m.department_id
                              );


-- 19.

Select
    e.employee_id,
    e.last_name,
    e.salary,
    e.department_id,
    round(avg(e.salary) over (partition by e.department_id)) "Средняя ЗП"
From hr.employees e
Group by e.employee_id, e.last_name, e.salary, e.department_id;

