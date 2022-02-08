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

/* Из учебника: 
Консистентное чтение. 
Образ для чтения состоит из зафиксированных данных и старых данных,
которые ещё не зафиксированы., т.е. видны только зафиксированные на момент запуска запроса данные. 
Юзеры, использующие операторы для чтения не смогут увидеть изменения тех, кто их внёс и не зафиксировал,
и только кто пишет сможет увидеть изменённые данные. Видимые на данный момент данные находятся в записях отмены, 
это гарантирует что читающий юзер получает информацию.
Select - оператор чтения, а delete, update, и insert - операторы записи.
При изменениях в БД посредством операторов записи, сервер Оракл изначально делает копию предыдущих данных и записывает их в записи отмены.
Записи отмены Оракл хранятся в табличном пространстве отмены, которое было создано изначально вместе с БД.
Когда операторы DML фиксируются, данные видны всем, и пространство в записях отмены освобождается.


О транзакции и уровнях изоляции:

Транзакция (именно в БД) - это единый целый результат множества (или нет) последовательных операций, с сохранением согласованности,
атомарности и изоляции, иначе говоря - мы получаем результат в виде корректных данных, 
и все операции транзакции выполнены полностью, и при этом, этому результату не помешали другие транзакции.

Транзакция имеет требования ACID:
- Согласованность - не корректные данные не могут быть зафиксированными.
- Атомарность - гарантирует исполнение транзакции полностью, а не частично. Либо всё, либо ничего.
- Изоляция - во время выполнения транзакции парралельные транзакции не могут повлиять на результат данной.
- Долговечность - т.е. если сервер упал, и мы успели зафиксировать данные, то эти данные сохранятся. 

В зависимости от уровня изоляции, результат при параллельных транзакциях на один и тех же данных может быть не корректным.

Аномалии:

1. Lost update (потерянное обновление) Вообще не допускается. Это когда две (и более) 
транзакции происходят на одних и тех же данных, и первая транзакция выполняется 
давая свой результат (допустим изначальное значение было 100, в первой транзакции мы добавили ещё 100, 
на выходе получили 200), и вторая транзакция берёт в работу результат первой (т.е. 200) и 
выполняется некорректно (приняв результат 200, она прибавляет 0, т.к. изначальные данные 100,
хотя вторая транзакция так же должна была прибавить 100, и мы должны были получить результат 300, в итоге сотку).
2. Dirty read (грязное чтение). Происходит, когда транзакция читает незафиксированный данные другой
транзакции и работает с незафиксированными данными (возьмём то же изначальное значение 100, 
первая транзакция вносит ещё 100, итог первой - 200, и вторая транзакция такая «оп, у нас тут две сотки» 
и дядя Петя уже бежит за своим стопариком в соседний магаз на чилле, на раслабоне и покупает свой заветный сосуд,
и покупает он вполне не заслуженно, ведь данные первой транзакции не зафиксированны и следует второй 
набить ебальник шоб не читала не зафиксированные данные).
3. Non-repeatable read (неповторяющееся чтение). Пошагово:
- Первая транзакция читает изначальные данные, принимает их значение, но ещё не фиксирует изменения.
- Вторая транзакция изменяет изначальные данные, и фиксирует изменения.
- Первая продолжает свою работу и при фиксировании получает другой результат.
(Тот же дядя Петя видит сотку на счету, бежит за стопариком, а в это время Сбер списывает у него 60+ 
за обслуживание, но транзакция Сбера такая «ну я пока подумаю выполнятся ли мне», и пока эта 
транзакция раздуплялась дядя Петя уже уже в говно и ему насрать что у него минус на счету потому что 
Сбер раздуплился только сейчас ).
4. Phantom read (Фантомное чтение). Пошагово:
- Первая транзакция читает изначальные данные которые соответствуют условиям 
(допустим, кол-во допустимых строк по дефолту - 5, изначально - 3, и она начинает добавлять ещё две,
потому что может себе позволить).
- Вторая транзакция работает с изначальными данными и фиксируется (допустим, изначально было три строки,
она добавила две и всё ок).
- Первая фиксируется и выполняется с результатом второй (и охреневает от результата в 7 срок).
(Решил дядя Петя взять кредит в банке под залог недвижимости, проверили сотрудники реестр и сказали 
«Петя, всё ок, на кредит» и съебался дядя Петя в Таиланд, ведь недвижимость он продал за 5 минут 
до взятия кредита и данные в реестре ещё не успели обработаться, теперь сотрудники банка в жопе).

Это были основные аномалии.

Уровни изоляции:
1. Read uncommitted - транзакция не позволяет работать второй транзакции с теми данными,
которая выполняет первая, позволительно только чтение данных.
2. Read committed - парралельно исполняющиеся транзакции видят только
зафиксированные изминения из других транзакций.
3. Repeattable read - не видны изминения операторов update, delete, но
видны результаты insert.
4. Serializable - используется достаточно редко, блокирует чтение.
В ней нет смысла, т.к. по сути Repeattable read решает все проблемы.

И немного об установке уровней изоляции:

Будет действовать на 1 следующую транзакцию в текущей сессии:
set transaction isolation level (и тут подставляем уровень, котолрый нам нужен, например serializable);

Будет действовать на все транзакции в текущей сессии:
set session isolation level (уровень);

Будет действовать на все транзакции:
set global transaction isolation level (уровень);
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

-- 9. 
/*Populate the table with the next two rows of the sample data listed in step 8 by running the
INSERT statement in the script that you created. */

Insert into hr.my_employee
(id, first_name, last_name, userid, salary)
Values (&id, '&first_name', '&last_name', '&userid', &salary);

Insert into hr.my_employee
(id, first_name, last_name, userid, salary)
Values (&id, '&first_name', '&last_name', '&userid', &salary);

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

Select * From hr.my_employee;

-- 14. Delete Betty Dancs from the MY_EMPLOYEE table.

Insert into hr.my_employee
Values (4, 'Betty', 'Dancs', null, null);


Delete From hr.my_employee
Where last_name = 'Betty';

-- 15. Confirm your changes to the table.

Commit;

-- 16. Commit all pending changes.

Commit;                  -- он тут и нахер не нужен

-- 17.
/* Populate the table with the last row of the sample data listed in step 8 by using the
statements in the script that you created in step 11. Run the statements in the script.
Note: Perform next 6 steps (18-23) in one session only.
*/

Insert into hr.my_employee
(id, first_name, last_name, userid, salary)
Values (&id, '&first_name', '&last_name', '&userid', &salary);

-- 17.1

Savepoint 2;

-- 17.2

Delete From hr.my_employee;

-- 17.3

Select * From my_employee;

-- 17.4

Rollback to 2;

-- 17.5

Select * From my_employee;

-- 17.6

Commit;

-- 18. Mark an intermediate point in the processing of the transaction.

Savepoint 1;

-- 19. Delete all the rows from the MY_EMPLOYEE table.

Delete From hr.my_employee;

-- Truncate table hr.my_employee;

-- 20. Confirm that the table is empty.

Select * From my_employee;

-- 21. Discard the most recent DELETE operation without discarding the earlier INSERT operation.

Rollback to 1;

-- 22. Confirm that the new row is still intact.

Select * From my_employee;

-- 23. Make the data addition permanent.

Commit;

-- 24.
/*Modify the query 8 script such that the USERID is generated automatically by
concatenating the first letter of the first name and the first seven characters of the last
name. The generated USERID must be in lowercase. Therefore, the script should not
prompt for the USERID. Save this script.
*/


Update hr.my_employee m
Set m.userid =  (Select 
                lower(substr(m.first_name,1,1)) || lower(substr(m.last_name,1,7)) as "userid"
                From hr.MY_EMPLOYEE m 
                Where ID = &ID)
Where ID = &ID;


/*  У меня эта херня не работает, почему????????
Insert into hr.my_employee
(id, first_name, last_name, userid, salary)
Values (999, '&&first_name', '&&last_name', substr('&&first_name',1,1), || substr('&&last_name',1,7), salary;
*/

-- 25. Run the previous script to insert the following record: 6, Anthony, Mark, manthoney, 1230.

Insert into hr.my_employee
(id, first_name, last_name, userid, salary)
Values (6, 'Anthony', 'Mark', 'manhoney', 1230);

Update hr.my_employee m
Set m.userid =  (Select 
                lower(substr(m.first_name,1,1)) || lower(substr(m.last_name,1,7)) as "userid"
                From hr.MY_EMPLOYEE m 
                Where ID = 6)
Where ID = 6;

-- 26. Confirm that the new row was added with the correct USERID.

Select * From my_employee;
