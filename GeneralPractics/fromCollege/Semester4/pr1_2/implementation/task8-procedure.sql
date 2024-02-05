CREATE OR REPLACE PROCEDURE task8(name_position TEXT, name_department TEXT)
    LANGUAGE plpgsql 
AS
$$
    DECLARE

    BEGIN

        EXECUTE 'SELECT employees.last_name || ' ' || 
            employees.first_name || ' ' || employees.sur_name 
            FROM appointments
            INNER JOIN employees ON employees.id = employee_id
            INNER JOIN departments ON departments.id = appointments.department_id
            INNER JOIN positions ON positions.id = appointments.position_id
            WHERE positions.name = name_position AND departments.name = name_department;
            '
    END; 
$$;
