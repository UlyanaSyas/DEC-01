--1. 
/*Опишите, чем отличаются ограничения вида PRIMARY KEY и ограничение вида UNIQUE с условием,
что входящие в UNIQUE поля таблицы ограничены, в том числе, NOT NULL? Если различий нет, напишите, почему так?

Разница между unique и primary key в том, что unique задается внешним констрейном.
Ещё в primary key нельзя запихнуть null и дублирующиеся значения.
Primary key может быть больше одной колонки, и составной первичный ключ всегда будет not null.
*/

--2. Создайте таблицу HR.DEPT по шаблону, вызовите описание таблицы.

CREATE TABLE hr.dept
(
id       NUMBER(7),
name     VARCHAR2(25),
CONSTRAINT dept_PK PRIMARY KEY(id)
);

desc hr.dept;

-- 3. Создайте таблицу EMP по следующему шаблону.

/*INSERT INTO hr.dept
VALUES (1, 'Soso Uzbeck');

SELECT
    *
FROM hr.dept;
*/

CREATE TABLE hr.emp
(
id               NUMBER(7),
last_name        VARCHAR2(25),
first_name       VARCHAR2(25),
dept_id          NUMBER(7),
    CONSTRAINT emp_dept_id_FK FOREIGN KEY(dept_id)
    REFERENCES hr.dept(id)
);

SELECT
    *
FROM hr.emp;

desc hr.emp;
-- 4.
/*
Modify the EMP table. Add a COMMISSION column of the NUMBER data type, with precision 2
and scale 2. Confirm your modification. 
*/

ALTER TABLE hr.emp
ADD (
commission      NUMBER(2,2)
);

-- 5.
/*
Modify the EMP table to allow for longer employee last names. Confirm your modification.
*/

ALTER TABLE hr.emp
MODIFY (
last_name      VARCHAR2(30)
);

-- 6.
/*
Drop the FIRST_NAME column from the EMP table. Confirm your modification by checking
the description of the table.
*/

ALTER TABLE hr.emp
DROP column first_name;

-- 7.
/*
In the EMP table, mark the DEPT_ID column as UNUSED. Confirm your modification by
checking the description of the table.
*/

ALTER TABLE hr.emp 
SET UNUSED(
dept_id
);

-- 8.
/*
Drop all the UNUSED columns from the EMP table.
*/

ALTER TABLE hr.emp
DROP UNUSED columns;

-- 9.
/*
Create the EMPLOYEES2 table based on the structure of the EMPLOYEES table. Include only
the EMPLOYEE_ID, FIRST_NAME, LAST_NAME, SALARY, and DEPARTMENT_ID columns.
Name the columns in your new table ID, FIRST_NAME, LAST_NAME, SALARY, and
DEPT_ID, respectively.
*/

CREATE TABLE hr.employees2
(
id          NUMBER(6)       NOT NULL,
first_name  VARCHAR2(20),
last_name   VARCHAR2(25)    NOT NULL,
salary      NUMBER(8,2),
dept_id     NUMBER(4)
);

SELECT
    *
FROM employees;

-- 10.
/*
Alter the status of the EMPLOYEES2 table to read-only.
*/

ALTER TABLE hr.employees2 read only;

-- 11.
/*
Try to add a column JOB_ID in the EMPLOYEES2 table.
Note, you will get the “Update operation not allowed on table” error message. You will not
be allowed to add any column to the table because it is assigned a read-only status.
*/

ALTER TABLE hr.employees2 read write;

ALTER TABLE hr.employees2
ADD (
job_id      VARCHAR2(25)   NOT NULL
);

DESC hr.employees2;

-- 12.
/*
Revert the EMPLOYEES2 table to the read/write status. Now try to add the same column
again. Now, because the table is assigned a READ WRITE status, you will be allowed to add a
column to the table.

            - Ну, я это сделала выше.
*/

-- 13.
/*
Drop the EMP, DEPT, and EMPLOYEES2 table.
*/

DROP TABLE hr.emp;
DROP TABLE hr.dept;
DROP TABLE hr.employees2;