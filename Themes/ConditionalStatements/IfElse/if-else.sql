CREATE OR REPLACE FUNCTION readAge(user_age INTEGER)
    RETURNS VARCHAR(30)
    LANGUAGE plpgsql
AS
$$ 
    DECLARE
        age_constaint INTEGER := 18;
    BEGIN
        IF user_age > age_constaint THEN
            RETURN 'This user ready';
        ELSE 
            RETURN 'This user not ready';
        END IF;
    END;
$$;

DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id SERIAL NOT NULL,
    name VARCHAR(20),
    age INTEGER,
    CONSTRAINT key_appoint
    PRIMARY KEY (id)
);

INSERT INTO users (name, age)
VALUES ('test1',20);

INSERT INTO users (name, age)
VALUES ('test1',15);

INSERT INTO users (name, age)
VALUES ('test1',16);

INSERT INTO users (name, age)
VALUES ('test1',22);

SELECT name, readAge(age) 
FROM users;