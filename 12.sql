-- 1. Запрос, с удалением эмлоя 113.

Delete From hr.employees Where employee_id = 113;
/* В данном запросе проблем не возникло, но ошибка возможна если на запись ссылается другая таблица,
и для удаления записи в таблице, необходимо изначально удалить из той, которая мешает удалению в данной.
*/

-- 2. Возвращаем эмлоя 113.

Rollback; -- оператор для отката изменений назад, но при его помощи зафиксированную запись, как и 2007 - нам не вернуть.

-- 3. Переименовать (обновить данные) эмплоя 113, дав ему имя Alouis Shekelgruber.

Update hr.employees 
Set first_name = 'Alouis', last_name = 'Shekelgruber'
Where employee_id = 113;

-- Всё, кошерно переименовали.

Select * From hr.employees Where employee_id = 113;

-- 4. 
/*
UPDATE...                    - обновляем, DML оператор
SAVEPOINT название_точки;    - создаем точку возврата, DCL оператор
INSERT...                    - вставляем новые данные, DML оператор
ROLLBACK TO название_точки;  - откат к точке возврата, DCL оператор

Важно. Если использовать несколько точек возврата, то необходимо давать им разные названия,
иначе предыдущая точка с тем же названием удалится. 

DELETE FROM EMPLOYEES        - уже делали, результат этого запроса нам известен
WHERE employee_id=113;

INSERT INTO departments      - вставили одну строку эксплективным методом с данными в таблицу departments
VALUES (290, 'Corporate Tax', NULL, 1700);   - значения в колонки department_id, department_name, manager, lacation_id

COMMIT;                      - зафиксировали изменения, DCL оператор

DELETE FROM copy_emp;        - удалили таблицу
ROLLBACK ;                   - откатили изменения

Состояние данных после ROLLBACK

DELETE FROM test;            - проходили, знаем
4 rows deleted.
ROLLBACK;
Rollback complete.

DELETE FROM test WHERE id = 100;  - удалили строку в таблице test, где id равен 100
1 row deleted.
SELECT * FROM test WHERE id = 100;   - проверили, поверили
No rows selected.
COMMIT;                       - фиксиркуем
Commit complete.

В данном примере смысл таков, что если мы по остроте своего ума удалили таблицу и не зафиксировали результат,
то этот процесс обратим. И далее уже следует удаление строки и фиксация результата.

*/

-- 5.

/* Консистентное чтение.
Образ для чтения состоит из зафиксированных данных и старых данных,
которые ещё не зафиксированы., т.е. видны только зафиксированные на момент запуска запроса данные. 
Юзеры, использующие операторы для чтения не смогут увидеть изменения тех, кто их внёс и не зафиксировал,
и только кто пишет сможет увидеть изменённые данные. Видимые на данный момент данные находятся в записях отмены,
это гарантирует что читающий юзер получает информацию.
Select - оператор чтения, а delete, update, и insert - операторы записи.
При изменениях в БД посредством операторов записи, сервер Оракл изначально делает копию предыдущих данных и записывает их в записи отмены.
Записи отмены Оракл хранятся в табличном пространстве отмены, которое было создано изначально вместе с БД.
Когда операторы DML фиксируются, данные видны всем, и пространство в записях отмены освобождается.
*/

-- 6. 
/*Create an INSERT statement to add the first row of data to the MY_EMPLOYEE table from
the following sample data. Do not list the columns in the INSERT clause. Do not enter all
rows yet. */

Select * From my_employee;
Desc my_employee;

Insert into hr.my_employee
Values (1, 'Biba', 'Boba', null, null);


-- 7. 
/*Populate the MY_EMPLOYEE table with the second row of the sample data from the
preceding list. This time, list the columns explicitly in the INSERT clause. */

Insert into hr.my_employee
(id, first_name, last_name, userid, salary)
Values (2, 'Barebuh', 'Bich', 'Cat', 100500);

-- 8. 
/*Write an INSERT statement in a dynamic reusable script file to load the remaining rows into
the MY_EMPLOYEE table. The script should prompt for all the columns (ID, LAST_NAME,
FIRST_NAME, USERID, and SALARY). Save this query.*/

Insert into hr.my_employee
(id, first_name, last_name, userid, salary)
Values (&id, '&first_name', '&last_name', '&userid', &salary);

-- 9. Не поняла этого задания. 
/*Populate the table with the next two rows of the sample data listed in step 3 by running the
INSERT statement in the script that you created. */

-- 10. Commit your changes.

Commit;

-- 11. Change the last name of employee 3 to Drexler.

Update hr.my_employee
Set last_name = 'Drexler'
Where id = 3;

-- 12. Change the salary to $1,000 for all employees who have a salary less than $900.

Update hr.my_employee
Set salary = 1000
Where salary < 900;

-- 13. Verify your changes to the table.

Select * From my_employee;

-- 14. Delete Betty Dancs from the MY_EMPLOYEE table.

Insert into hr.my_employee
Values (4, 'Betty', 'Dancs', null, null);


Delete From hr.my_employee
Where last_name = 'Betty';

-- 15. Confirm your changes to the table.

Commit;

-- 16. Commit all pending changes.

Commit;

-- 17. Опять не поняла.
/* Populate the table with the last row of the sample data listed in step 3 by using the
statements in the script that you created in step 6. Run the statements in the script.
Note: Perform next 6 steps (18-23) in one session only.
*/

-- 18. Mark an intermediate point in the processing of the transaction.

Savepoint 1;

-- 19. Delete all the rows from the MY_EMPLOYEE table.

Delete From hr.my_employee;

-- 20. Confirm that the table is empty.

Select * From my_employee;

-- 21. Discard the most recent DELETE operation without discarding the earlier INSERT operation.

Rollback to 1;

-- 22. Confirm that the new row is still intact.

Select * From my_employee;

-- 23. Make the data addition permanent.

Commit;

-- 24. Cнова не поняла.
/*Modify the query 8 script such that the USERID is generated automatically by
concatenating the first letter of the first name and the first seven characters of the last
name. The generated USERID must be in lowercase. Therefore, the script should not
prompt for the USERID. Save this script.
*/

-- 25. Run the previous script to insert the following record: 6, Anthony, Mark, manthoney, 1230.

-- 26. Confirm that the new row was added with the correct USERID.

Select * From my_employee;