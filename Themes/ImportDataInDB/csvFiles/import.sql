DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id SERIAL NOT NULL,
    name VARCHAR(30),
    age INTEGER
);

COPY users TO '*******\DBStudy-PSQL\Themes\ImportDataInDB\csvFiles\test-file.csv'
DELIMITER ',' CSV HEADER;