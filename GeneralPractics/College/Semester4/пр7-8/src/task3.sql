create or replace procedure task3(employeeid int )
    language plpgsql
as 
$$
    declare 

    begin 
        execute 
        'create or replace view task3
        as 
            select * from employees 
            where date_part(''month'', employees.birth_day) = date_part(''month'', (
                    select birth_day from employees where employees.id = ' || employeeid ||
                ')) and employees.id != ' || employeeid || '; ';
    end;
$$;

call task3(3)

select * from task3