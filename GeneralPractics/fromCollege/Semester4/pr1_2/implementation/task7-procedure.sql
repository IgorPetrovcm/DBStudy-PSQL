CREATE OR REPLACE PROCEDURE task7(employees_count INTEGER)
    LANGUAGE plpgsql
AS
$$
    DECLARE

    BEGIN
        EXECUTE 'CREATE OR REPLACE VIEW task7_view AS
            SELECT departments.name FROM departments
            INNER JOIN appointments ON appointments.department_id = departments.id
            GROUP BY departments.name 
		    HAVING count(*) = ' || employees_count || ';';
        
    END;
$$;

CALL task7(7);

SELECT * FROM task7_view;