/*
1. Создать вьюху с номером емлоя, фамилией и номером департамента.
Емплоев подписать EMPLOYEE. Назвать EMPLOYEES_VU.
*/

CREATE OR REPLACE VIEW EMPLOYEES_VU 
AS
SELECT  employee_id, 
		last_name "EMPLOYEE", 
		department_id
FROM EMPLOYEES;

/*
2. Подтвердить.
*/

SELECT *
FROM EMPLOYEES_VU;

/*
3. Показать емлоев и отделы.
*/

SELECT 
	EMPLOYEE, 
	department_id
FROM EMPLOYEES_VU;

/*
4. Создать вьюху DEPT50 с номером емлоя, фамилией и номером департамента 80.
Назвать колонки EMPNO, EMPLOYEE, DEPTNO. Ограничить перенос сотрудников по отделам.
*/

DROP VIEW DEPT50; -- без дропа не создалась, уже была

CREATE VIEW DEPT50 
AS
SELECT
	employee_id "EMPNO",
	last_name "EMPLOYEE", 
	department_id "DEPTNO"
FROM EMPLOYEES
WHERE department_id = 80
WITH CHECK OPTION CONSTRAINT EMP_DEPT_50; 

/*
5. Показать вьюху и данные.
*/

SELECT *
FROM DEPT50;

DESCRIBE DEPT50;

/*
6. Перенести Abel в 80-й отдел.
*/

UPDATE DEPT50
SET DEPTNO = 50
WHERE EMPLOYEE = 'Abel';

-- ну, с 80-м всё ок, но суть показать констрейн так что написала 50-й отдел 

/*
7. Определить имена всех вьюх. Выбрать имя и текст нашей вьюхи.
*/

SELECT *
FROM USER_VIEWS;

SELECT 
	view_name,
	text
FROM USER_VIEWS
WHERE view_name = 'DEPT50';

/*
8. Снести всё к херам.
*/

DROP VIEW DEPT50;

DROP VIEW EMPLOYEES_VU;

/*
9. Создать таблицу DEPT. Подтвердить её создание.
*/

CREATE TABLE DEPT
(
ID     NUMBER(7),
NAME   VARCHAR2(25),
	CONSTRAINT DEPT_PK PRIMARY KEY(ID)
);

SELECT *
FROM DEPT;

/*
10. Создать сиквенс, который будет работать с первичным ключём.
Последовательность должна начинаться с 200, и иметь масимальное значение 1000. Увеличить последовательность на 10.
Сиквенс назвать DEPT_ID_SEQ.
*/

CREATE SEQUENCE DEPT_ID_SEQ
START WITH 200
INCREMENT BY 10
MAXVALUE 1000;

/*
11. Создать скрипт, для вставки строк в таблицу DEPT, используя сиквенс. Добавить два отдела Education и Administration.
*/

INSERT INTO DEPT VALUES
(DEPT_ID_SEQ.nextval,
'Education');

INSERT INTO DEPT VALUES
(DEPT_ID_SEQ.nextval,
'Administration');

/*
12. Найти в сиквенсах их имя, максимальное значение, счётчик, и последний номер.
*/

SELECT 
	sequence_name,
	max_value,
	increment_by,
	last_number
FROM USER_SEQUENCES;

/*
13. Создать синоним к таблице с емлоями. Назвать EMP1. Затем найти все синонимы.
*/

CREATE SYNONYM EMP1 FOR EMPLOYEES;

SELECT *
FROM all_synonyms; -- или user_synonyms, но там только наш отображается один

/*
14. Дропнуть синоним EMP1.
*/

DROP SYNONYM EMP1;

/*
15. Создать не уникальный индекс для колонки NAME таблицы DEPT.
*/

CREATE INDEX DEPT_NAME_NONUNIQUE_INDX ON DEPT(NAME);

/*
16. Создать таблицу SALES_DEPT. Индекс для PK - SALES_PK_IDX. Затем найти в словаре имя индекса, имя таблицы, и юники. 
*/

DROP TABLE SALES_DEPT;

CREATE TABLE SALES_DEPT
(
Team_ID	NUMBER(3),
Location	VARCHAR2(30),
	CONSTRAINT SALES_PK_IDX PRIMARY KEY(Team_ID)
);

SELECT 
	index_name,
	table_name,
	uniqueness
FROM USER_INDEXES 
WHERE table_name = 'SALES_DEPT';

/*
17. Дропнуть всё к херам, ну таблицы и сиквенсы.
*/

DROP TABLE SALES_DEPT;

DROP SEQUENCE DEPT_ID_SEQ;

DROP TABLE DEPT;
