
-- 1

Select
    round(max(e.salary)) as "Max", -- масимальная ЗП, функция round округляет значение
    round(min(e.salary)) as "Min", -- минимальная ЗП
    round(sum(e.salary)) as "Sum", -- сумма ЗП всех сотрудников
    round(avg(e.salary)) as "Average" -- средняя ЗП сотрудников
From
    hr.employees e;
    
-- 2

Select
    round(max(e.salary)) as "Max",
    round(min(e.salary)) as "Min",
    round(sum(e.salary)) as "Sum",
    round(avg(e.salary)) as "Average",
    job_title as "EMP" -- должность сотрудника
From
    hr.employees e
Join 
    hr.jobs j -- связать с таблицей
On j.job_id = e.job_id -- связали колонки сотрудников
Group by j.job_title; -- группировка

    
-- 3

Select 
    e.job_id,
    count (e.job_id) as "Number" -- функция count посчитала количевство сотрудников
From employees e
Group by e.job_id; -- группировка по должности


-- 4

Select 
    count (e.job_id) as "Amount of workers" -- функция count посчитала количевство сотрудников
From employees e
Where job_id='&jobs'; -- функция амперсанд, взятая в кавычки (благодаря чему мы можем ввести текст), экранировала сотрудников по должности

-- 5

Select
   count(e.manager_id) as "Number of managers" -- количевство сотрудников, которые занимают должность менеджера
From 
    hr.employees e;
    
-- 6
    
Select
    max(e.salary) - min(e.salary) as "DIFFERENCE" -- разница между самой высокой и самой низкой ЗП
From hr.employees e;

-- 7

Select
   e.manager_id as "Manager", -- переименование колонки
   min (e.salary) as "Min salary", -- минимальная ЗП сотрудников
   count(*) as "Manager amount" -- функция count посчитала сотрудников
From hr.employees e
Group by e.manager_id -- группировка сотрудников
     having e.manager_id is not null and -- после группировки невозжно применить where(т.е. где), используется having, где менеджеры не null, и
     min (e.salary) > 6000 -- где минимальная ЗП больше 6000
Order by min (e.salary); -- и сортировка по минимальной ЗП в порядке возрастания (от меньшего к большему)

-- 8

Select
    count(*) as "Amount", -- функция count считает колонки с сотрудниками (всего сотрудников)
    sum(decode(to_char(e.hire_date, 'YYYY'),2005, 1, 0)) as "2005", -- дата приёма на работу в годах, преобразовывание в текст, функция декод
    sum(decode(to_char(e.hire_date, 'YYYY'),2006, 1, 0)) as "2006", -- принимает значение принятых в этом году за 1, не в этом году принимает за 0
    sum(decode(to_char(e.hire_date, 'YYYY'),2007, 1, 0)) as "2007", -- функция sum суммирует количевство принятых в этом году (1)  
    sum(decode(to_char(e.hire_date, 'YYYY'),2009, 1, 0)) as "2009"
From hr.employees e;
    
-- 9
    
Select 
    e.job_id as "Job ID", -- должность сотрудников
    nvl(sum(case when e.department_id='20' then e.salary end),0) "Department 20", -- 1. функция case выбрала сотрудников из определённого департамента и их ЗП
    nvl(sum(case when e.department_id='50' then e.salary end),0) "Department 50", -- (т.е. если значение номера департамента - истина, то берётся salary департамента)
    nvl(sum(case when e.department_id='80' then e.salary end),0) "Department 80", -- 2. функция sum суммирует ЗП сотрудников департамента
    nvl(sum(case when e.department_id='90' then e.salary end),0) "Department 90", -- 3. функция nvl конвертит null в значение 0 
    nvl(sum(case when e.department_id='90' then e.salary end),0) + 
    nvl(sum(case when e.department_id='50' then e.salary end),0) + 
    nvl(sum(case when e.department_id='80' then e.salary end),0) + 
    nvl(sum(case when e.department_id='20' then e.salary end),0) as "Total salary" -- 4. сумма ЗП сотрудников из департаметов
From hr.employees e
Group by e.job_id; -- группировка по должности


-- 10

Select 
    d.department_name as "Должность",
    min(e.salary) as "Min",
    max(e.salary) as "Max",
    count(*) as "Количество сотрудников"
From hr.employees e
Join hr.departments d -- связать таблицы
    On e.department_id = d.department_id -- связь колонок 
Group by d.department_name -- группировка по должности сотрудников 
    having (max(e.salary )/min(e.salary)) >=1.7 -- у которых минимальная ЗП больше, чем максимальная, умноженная на 1,7 и выше
Order by d.department_name; --сортировка по должности
