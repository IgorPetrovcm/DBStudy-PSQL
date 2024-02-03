DROP TABLE IF EXISTS users;

CREATE TABLE users (
    id SERIAL NOT NULL UNIQUE,
    name VARCHAR(20),
    balance INTEGER NULL,
    CONSTRAINT key_appoint
    PRIMARY KEY (id)
);

INSERT INTO users (name,balance) VALUES ('test1',500);
INSERT INTO users (name,balance) VALUES ('test2',2000);
INSERT INTO users (name,balance) VALUES ('test3',700);
INSERT INTO users (name,balance) VALUES ('test4',100);

CREATE OR REPLACE PROCEDURE money_transfer (
    sender INTEGER,
    recipient INTEGER,
    sum INTEGER
)
    LANGUAGE plpgsql
AS 
$$
    DECLARE 

    BEGIN
        IF EXISTS (SELECT FROM users WHERE id = sender) AND EXISTS (SELECT  FROM users WHERE id = recipient) THEN
            IF (SELECT balance - sum FROM users WHERE id = sender) > 0 THEN 
                UPDATE users 
                SET balance = balance + sum 
                WHERE id = recipient;

                UPDATE users
                SET balance = balance - sum
                WHERE id = sender;
				
            ELSE 
                RAISE NOTICE 'У отправителя нет указанной суммы';
            END IF;
        ELSE 
            RAISE NOTICE 'Неверно указан id получателя или отправителя';
        END IF;
            
    END;
$$;

CALL money_transfer(2,1,500);

