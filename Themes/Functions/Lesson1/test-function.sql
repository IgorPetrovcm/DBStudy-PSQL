CREATE OR REPLACE FUNCTION two-sum_func(a INT, b INT)
    RETURNS INT
    LANGUAGE plpgsql
AS 
$$
    DECLARE
        c INT;
    BEGIN
        c := a + b;

        RETURN a + b + c;
    END;
$$;

SELECT sum_func(1,2);