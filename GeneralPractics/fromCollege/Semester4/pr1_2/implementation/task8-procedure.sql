CREATE OR REPLACE PROCEDURE task8(name_position VARCHAR(50), name_department VARCHAR(50))
    LANGUAGE plpgsql 
AS
$$
    DECLARE

    BEGIN

        EXECUTE 'CREATE OR REPLACE VIEW task8_view AS
            SELECT employees.last_name || '' '' || 
                employees.first_name || '' '' || employees.sur_name 
            FROM appointments
            INNER JOIN employees ON employees.id = employee_id
            INNER JOIN departments ON departments.id = appointments.department_id
            INNER JOIN positions ON positions.id = appointments.position_id
            WHERE positions.name = N''' || name_position || ''' AND departments.name = '''|| name_department || '''';
            
    END; 
$$;

CALL task8('Основной препод', 'Штат преподавателей');

SELECT * FROM task8_view;
