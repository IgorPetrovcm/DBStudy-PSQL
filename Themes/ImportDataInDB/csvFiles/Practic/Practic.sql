DROP TABLE IF EXISTS users;

DROP TABLE IF EXISTS company;

CREATE TABLE company (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(30) UNIQUE
);

CREATE TABLE users (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(30),
    company_id INTEGER REFERENCES company(id)
);

CREATE OR REPLACE PROCEDURE addDataFromFiles(path TEXT)
    LANGUAGE plpgsql
AS
$$
    DECLARE

    BEGIN
        CREATE TABLE current_table (
            id SERIAL NOT NULL PRIMARY KEY,
            user_name VARCHAR(40),
            company_name VARCHAR(40)
        );

        EXECUTE format('COPY current_table FROM %L 
        DELIMITER '','' CSV HEADER', path);

        INSERT INTO company (name) 
        SELECT DISTINCT company_name FROM current_table;

        INSERT INTO users (name, company_id) 
        SELECT user_name, company.id FROM current_table
        INNER JOIN company ON company.name = current_table.company_name;

        DROP TABLE current_table;
    END;
$$;

CALL addDataFromFiles('C:\Users\igorp\Programming\DBStudy-PSQL\Themes\ImportDataInDB\csvFiles\Practic\task-file.csv');

SELECT * FROM company;