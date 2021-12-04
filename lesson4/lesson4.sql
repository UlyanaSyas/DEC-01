
-- 1. Выбрала все записи и определила структуру таблицы hr.departments.

Select
    *
From
    hr.departments;
    
Desc hr.departments;

-- 2. Определила структуру таблицы hr.employees.

Desc hr.employees;

-- 3. Все уникальные поля из колонки job_id в таблице hr.employees.

Select distinct
    job_id
From
    hr.employees;
    
-- 4. Там длинный текст, мне было его лень писать, прошу понять и простить.

Select
    employee_id,
    last_name,
    job_id,
    hire_date as "start_date"
From
    hr.employees;
    
-- 5. То же самое, но переимновать колонки.

Select
    employee_id as "Emp #",
    last_name as "Employee",
    job_id as "Job",
    hire_date as "Hire Date"
From
    hr.employees;
    
-- 6. Данные одной строкой "Имя Фамилия, должность", и переименовала строку.

Select
    last_name ||
    ' ' ||
    first_name ||
    ', ' ||
    job_id as "Employee and title"
From
    hr.employees;
    
/* 7. Крч, тут все строки в колонке слились в одну строку как трансформеры в фильме.
В строковой тип мы добавили кавычки, а номерной тип остался голым, так же всё через запятую. 
Так же переименовала эту длинную и необъятную строку.
*/
Select
    employee_id ||
    ', "' ||
    first_name ||
    '  ' ||
    last_name ||
    '", "' ||
    email ||
    '", "' ||
    phone_number ||
    '", ' ||
    hire_date ||
    ', "' ||
    job_id ||
    '", ' ||
    salary ||
    ', ' ||
    commission_pct ||
    ', ' ||
    manager_id ||
    ', ' ||
    department_id as "CSV_OUTPUT"
From
    hr.employees;

-- Если что-то не так, прошу обоссать, но не бить.