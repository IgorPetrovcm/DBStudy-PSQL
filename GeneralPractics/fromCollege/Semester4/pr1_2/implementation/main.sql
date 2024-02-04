DROP TABLE IF EXISTS appointments;

DROP TABLE IF EXISTS employees;

DROP TABLE IF EXISTS education;

DROP TABLE IF EXISTS departments;

DROP TABLE IF EXISTS positions;

CREATE TABLE education(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE employees(
    id INTEGER NOT NULL PRIMARY KEY,
    last_name VARCHAR(30),
    first_name VARCHAR(30),
    sur_name VARCHAR(30),
    birth_day TIMESTAMP,
    telephon VARCHAR(20),
    education_id INTEGER REFERENCES education(id)
);

CREATE TABLE departments(
    id INTEGER NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE positions (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE appointments (
    id INTEGER NOT NULL PRIMARY KEY,
    appoint_date TIMESTAMP,
    dismissal_date TIMESTAMP,
    position_id INTEGER REFERENCES positions(id),
    department_id INTEGER REFERENCES departments(id),
    employee_id INTEGER REFERENCES employees(id)
);

CREATE OR REPLACE PROCEDURE importData(path TEXT)
    LANGUAGE plpgsql
AS 
$$
    DECLARE 

    BEGIN
        CREATE TABLE current_table(
            codeEmployee INTEGER, 
            nameEmployee VARCHAR(100),
            gender CHAR(1),
            birthDate TIMESTAMP,
            telephon VARCHAR(20),
            education VARCHAR(50),
            nameDepartment VARCHAR(50),
            codePosition INTEGER,
            namePosition VARCHAR(50),
            codeDepartment INTEGER,
            dateAppoint TIMESTAMP,
            dateDismissal TIMESTAMP
        ) ;

        EXECUTE format('COPY current_table (codeEmployee,
        nameEmployee,
        gender,
        birthDate,
        telephon,
        education,
        nameDepartment,
        codePosition,
        namePosition,
        codeDepartment,
        dateAppoint,
        dateDismissal) FROM %L DELIMITER '','' CSV HEADER', path);

        INSERT INTO education (name) 
        SELECT DISTINCT education FROM current_table;

        INSERT INTO departments (id, name) 
        SELECT DISTINCT codeDepartment, nameDepartment FROM current_table;

        INSERT INTO positions (id, name) 
        SELECT DISTINCT codePosition, namePosition FROM current_table;

        INSERT INTO employees (id, last_name,first_name,sur_name) 
        SELECT codeEmployee, SPLIT_PART(nameEmployee,' ',1), SPLIT_PART(nameEmployee,' ', 2), SPLIT_PART(nameEmployee,' ',3) 
		FROM current_table;
    END;
$$;

CALL importData('C:\Users\Honor\Desktop\Programming\DBStudy-PSQL\GeneralPractics\fromCollege\Semester4\pr1_2\csvСотрудникиИмпорт.csv');
