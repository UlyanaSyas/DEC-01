-- 1.

Select 
    'Сегодня ' || to_char(sysdate, 'DD') ||
    (case
    when (select to_char(sysdate, 'MM') from dual) = '12'
        then ' декабря' 
        end) ||
    ' ' || to_char(sysdate, 'YYYY') || ' года' as "today",
    case
    when (select to_char(sysdate, 'DY') from dual) = 'TUE'
        then 'Вторник'
    when (select to_char(sysdate, 'DY') from dual) = 'MON'
        then 'Понедельник'
    when (select to_char(sysdate, 'DY') from dual) = 'WED'
        then 'Среда'
        end as "weekday"
from dual;

/*2.
   Преобразование данных подразумевает собой изменение типа данных,
   например тектовых или числовых типов, в тот, с котором нам будет удобно работать.
   Неявное преобразование происходит автоматически сервером, или же если мы обращаемся
   к одному типу данных, который не контачит с другим,
   а явное же - при помощи функций cast или convert, to_char, to_num.
   На сколько я помню, только null всегда будет null-ом.
*/
   
-- Пример не явного преобразования:

Select
    e.*
From 
    hr.employees e
Where e.salary in '5000', '6', '7';

--Пример явного:

Select
    to_date ('01.08.1676', 'DD.MM.YYYY')
From dual;

-- 3.
Select
    e.employee_id as "EMP_NO",
    e.first_name || ' ' ||e.last_name as "Full_name",
    lower(e.email) || 'edu.artetl.com' as "EMAIL",
    '+1 ' || 
    '(' || SUBSTR ((replace(e.phone_number,'.', '')), 1, 3) || ') ' ||
    SUBSTR ((replace(e.phone_number,'.', '')), 4, 3) || ' ' ||
    SUBSTR ((replace(e.phone_number,'.', '')), 7, 4) || 
    NVL2 (SUBSTR(e.phone_number, 13, 6), ', ', ' ') ||
    SUBSTR ((replace(e.phone_number,'.', '')), 11, 5) as "CONTACT",
    to_char(e.hire_date, 'MM') as "HIRED_MNTH",
    to_char(e.hire_date, 'YYYY') as "HIRED_YEAR",
    e.salary*75 as "SALARY", -- нет ни запятых, ни знаков после неё
    (NVL2(e.commission_pct,(e.salary*e.commission_pct)*75, '0')) as "BONUS",
    ((NVL2(e.commission_pct,(e.salary*e.commission_pct)*75,'0')) + (e.salary * 75)) *
    ((2009 - to_char(e.hire_date, 'YYYY'))*11 + (12 - to_char(e.hire_date, 'MM'))) as "HISTORY_PAYED",
    (((NVL2(e.commission_pct,(e.salary*e.commission_pct)*75, '0')) + trunc(e.salary * 75, 2)) * 
    ((2009 - to_char(e.hire_date, 'YYYY'))*11 + (12 - to_char(e.hire_date, 'MM')))) * 0.419 as "EMPLOYEE_COST"
From hr.employees e;





