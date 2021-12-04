ALTER SESSION SET
    nls_date_format='YYYY-MM-DD';

-- 1. Нужно указать имя тех, кто зарабатывает более 12000 в год.

SELECT
    e.first_name,
    e.last_name,
    e.salary
FROM
    hr.employees e
WHERE
    e.salary > 12000;
    
-- 2. Ищем сотрудника номер 176, по коням, нам нужны фамилия и отдел.

SELECT
    e.employee_id,
    e.last_name,
    e.department_id
FROM
    hr.employees e
WHERE
    e.employee_id = '176';
    
-- 3. Ищем сотрудников с такой ЗП, которая вне диапазона от 5000 до 12000.

SELECT
    e.first_name,
    e.salary
FROM 
    hr.employees e
WHERE
    e.salary NOT BETWEEN 5000 AND 12000;
    
-- Или же:

SELECT
    e.first_name,
    e.salary
FROM 
    hr.employees e
WHERE
    e.salary < 5000
OR
    e.salary > 12000;

-- 4. Нужно выбрать фамилию, должность, и дату найма на работу для Матоса и Тейлора. Запрос в возрастающем порядке даты найма.

SELECT
    e.last_name,
    e.job_id,
    e.hire_date
FROM
    hr.employees e
WHERE
    e.last_name in (
    'Taylor',
    'Matos'
    )
ORDER BY
    e.hire_date asc;
    
-- 5. Отображение фамилий и departmen ID всех сотрудников 20 и 50 отделов в возрастающем алфавитном порядке имён.

SELECT
    e.last_name,
    e.department_id
FROM
    hr.employees e
WHERE
    e.department_id in (
    20,
    50)
ORDER BY
    e.first_name desc;

/*
   6. Изменить запрос из 3-й задачи, перечислить фамилии и ЗП сотрудников, которые зарабатывают от
   5000 до 12000 и находятся в отделе 20 или 50, обозначить колонки "Employee" & "Monthly salary".
   Ограничинть набор для первых пяти полей.
*/  

SELECT
    e.first_name as "Employee",
    e.salary as "Monthly salary"
    rownum
FROM 
    hr.employees e
WHERE
    rownum < 5,
    e.salary >= 5000
OR
    e.salary <= 12000
OR 
    e.department_id = 50;
    
    
-- 7. Запрос на отображение и дату приема на работу сотрудников, принятых на работу в 2006 году.

SELECT
    e.*
FROM
    hr.employees e
WHERE
    e.hire_date between 
    ('2006-01-01') 
    and('2006-12-31');
    

-- 8. Запрос на отображение всех сотрудников, у которых нет руководителя.

SELECT
    e.*
FROM
    hr.employees e
WHERE
   e.manager_id is null;

/* 
   9. Запрос на отображение фамилий, ЗП и комиссии для всех сотрудников. Сортировка данных по ЗП и комисси в порядке убывания.
   Отсортировывать нумерацию в ORDER BY.
*/

SELECT
    e.last_name,
    e.salary,
    e.commission_pct
FROM
    hr.employees e
ORDER BY
    e.salary, e.commission_pct desc;

-- 10. Запрос, на отображение фамилии и ЗП, зарабатывающих больше суммы, указанной после запроса.



-- 11. Фамилии сотрудников, у которых в фамилии третья буква "а".



-- 12. Фамилии сотрудников, у которых в фамилии есть буквы "а" и "е".

/*
   13. Отображение фамилии, ЗП, должности всех сотрудников, кто в продажах (sales, storck clerk),
   и чья ЗП не равна 2500, 3500, 7000.
*/

-- 14. Изменить 6-й запрос, что бы была фамилия, ЗП, комиссия всех сотрудников, у которых комиссия 20% и ограничить на 5 полей.

/*
   15. Отобразить имя и фамилию с использованием шаблона (Last name, First name), назвaния отдела и ЗП для каждого сотрудника,
   у которого ЗП больше ста косарей в год.
*/