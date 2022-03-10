--1.
/*
Query the USER_TABLES data dictionary view to see information about the tables that youown.
*/

SELECT * FROM user_tables;

SELECT * FROM all_tables
WHERE owner = 'HR';

--2.
/*
Query the ALL_TABLES data dictionary view to get all tables you can access excluding tables you own.
*/

SELECT * FROM all_tables 
MINUS
SELECT * FROM all_tables
WHERE owner = 'HR';

--3.
/*
For a specified table, create a script that reports the column names, data types, and datatypes’ lengths,
as well as whether nulls are allowed. Prompt the user to enter the tablename. Give appropriate 
aliases to the DATA_PRECISION and DATA_SCALE columns.
*/

SELECT 
    column_name,
    data_type,
    data_length,
    data_precision DATA_PRECISION,
    data_scale DATA_SCALE,
    nullable 
FROM user_tab_columns
WHERE table_name = UPPER('&Table');

--4.
/*
Create a script that reports the column name, constraint name, constraint type, searchcondition,
 and status for a specified table. You must join the USER_CONSTRAINTS andUSER_CONS_COLUMNS tables
  to obtain all this information. Prompt the user to enter thetable name
*/ 

SELECT * FROM user_constraints;

SELECT * FROM user_cons_columns;

SELECT
    b.column_name,
    a.constraint_name,
    a.constraint_type,
    a.search_condition,
    a.status
FROM user_constraints a
JOIN user_cons_columns b
ON a.constraint_name = b.constraint_name
AND a.table_name = b.table_name
AND a.owner = b.owner
WHERE a.owner = UPPER('&User')
AND a.table_name = UPPER('&Table');

--5.
/*
Add a comment to the DEPARTMENTS table. Then query the USER_TAB_COMMENTS view toverify that the comment is present.
 */

COMMENT ON TABLE hr.departments 
IS 'Departments table that shows details of departments where employees
work. Contains 27 rows; references with locations, employees, and job_history tables.';

SELECT * FROM user_tab_comments
WHERE table_name = 'DEPARTMENTS';

--6.
/*
Drop and re-create dept2 and emp2 tables using all constraints they got.
 */

DROP TABLE hr.dept2 CASCADE CONSTRAINTS;
DROP TABLE hr.emp2 CASCADE CONSTRAINTS;

--DEPT2
CREATE TABLE hr.dept2
AS SELECT * FROM hr.departments;
----------------------------------

ALTER TABLE hr.dept2
ADD CONSTRAINT
		DEPT2_ID_PK PRIMARY KEY (DEPARTMENT_ID); -- работает
        
-- Остальные у меня не работают, и я не пойму почему.
        
ALTER TABLE hr.dept2
ADD CONSTRAINT
		DEPT2_LOC_FK FOREIGN KEY (LOCATION_ID)
        REFERENCE HR.LOCATIONS(LOCATION_ID); -- не работает
        
ALTER TABLE hr.dept2
ADD CONSTRAINT DEPT2_MGR_FK 
        FOREIGN KEY (MANAGER_ID)
	    REFERENCES HR.EMP2 (EMPLOYEE_ID); -- не работает
        
ALTER TABLE hr.dept2
ADD CONSTRAINT
		DEPT2_NAME_NN CHECK (DEPARTMENT_NAME) NOT NULL; -- не работает
        
--EMP2
CREATE TABLE hr.emp2
AS SELECT * FROM hr.employees;
----------------------------------

ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_DEPT_FK FOREIGN KEY (DEPARTMENT_ID)
		REFERENCES hr.dept2 (DEPARTMENT_ID); -- работает
        
ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_EMAIL_NN CHECK (EMAIL) NOT NULL; -- не работает
		
ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_EMAIL_UK UNIQUE (EMAIL); -- работает
		
ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_EMP_ID_PK PRIMARY KEY (EMPLOYEE_ID); -- работает
		
ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_HIRE_DATE_NN CHECK (HIRE_DATE) NOT NULL; -- не работает
		
ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_JOB_FK FOREIGN KEY (JOB_ID)
        REFERENCES hr.jobs (JOB_ID); -- работает
        
ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_JOB_NN CHECK (JOB_ID) NOT NULL; -- не работает
        
ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_LAST_NAME_NN CHECK (LAST_NAME) NOT NULL; -- не работает
        
ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_MANAGER_FK FOREIGN KEY (MANAGER_ID)
        REFERENCES hr.emp2 (EMPLOYEE_ID);       -- работает
        
ALTER TABLE hr.emp2
ADD CONSTRAINT
		EMP2_SALARY_MIN CHECK (salary > 0); -- работает

--7.
/*
Confirm that both the DEPT2 and EMP2 tables are stored in the data dictionary.
*/

SELECT * FROM DICTIONARY;

--8.
/*
Confirm that the constraints were added, by querying the USER_CONSTRAINTS view. Notethe types and names of the constraints.
*/

SELECT * FROM user_constraints
WHERE table_name in 'DEPT2'
UNION ALL
SELECT * FROM user_constraints
WHERE table_name in 'EMP2';

--9.
/*
Display the object names and types from the USER_OBJECTS data dictionary view for theEMP2 and DEPT2 tables.
*/

SELECT
    object_name,
    object_type
FROM user_objects
WHERE object_name = 'DEPT2'
UNION ALL
SELECT
    object_name,
    object_type
FROM user_objects
WHERE object_name = 'EMP2';

--10.

SELECT 
	'CREATE TABLE HR. EMPL_99 (' CREATE_TABLE
FROM dual
UNION ALL
SELECT
	column_name ||
	'    ' ||
	data_type ||
	CASE
		WHEN data_type = 'NUMBER'
			THEN '(' || data_precision || ',' || data_scale || ')'
		WHEN data_type = 'VARCHAR2'
			THEN '(' || data_length || ')'
	END ||
	CASE 
		WHEN nullable = 'Y'
			THEN NULL
		ELSE '   NOT NULL'
	END ||
	CASE 
		WHEN column_id = (SELECT max(column_id)
						  FROM USER_TAB_COLUMNS
						  WHERE table_name = 'EMPLOYEES')
		THEN NULL 
		ELSE ','
	END
FROM USER_TAB_COLUMNS
WHERE table_name = 'EMPLOYEES'
UNION ALL 
SELECT ');'
FROM dual;

--11.

select *
from user_constraints
where table_name = 'EMPLOYEES';

desc user_constraints;

SELECT 
    'ALTER TABLE HR.EMPL_99 ADD CONSTRAINT ' ||  
    a.constraint_name ||
    ' ' ||
    CASE
        WHEN a.constraint_type = 'C'
            THEN 'CHECK'
        WHEN a.constraint_type = 'P'
            THEN 'PRIMARY KEY'
        WHEN a.constraint_type = 'R'
            THEN 'REFERENCE'
        WHEN a.constraint_type = 'V'
            THEN 'CHECK'
        WHEN a.constraint_type = 'U'
            THEN 'UNIQUE'
    END ||
    ' (' ||
    b.column_name ||
    ') ' ||
    a.search_condition_vc ||
    ' ' ||
    a.status ||
    ';' "CONSTRAINTS"
FROM user_constraints a
JOIN user_cons_columns b
ON a.constraint_name = b.constraint_name
AND a.table_name = b.table_name
AND a.owner = b.owner
WHERE a.owner = 'HR'
AND a.table_name = 'EMPLOYEES';

--12.

SELECT * from user_col_comments
where table_name = 'EMPLOYEES';

SELECT
    'COMMENT ON COLUMN HR.EMPL_99.' ||
    a.column_name ||
    ' IS ' ||
    q'[']' ||
    a.comments ||
    q'[';]' "COMMENTS"
FROM user_col_comments a
WHERE table_name = 'EMPLOYEES';


    'COMMENT ON TABLE HR.EMPL