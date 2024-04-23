create or replace procedure pr11_task1(employeeid int, is_remove boolean)
    language plpgsql
as 
$$
    declare 

    begin
        execute 
        '
            delete from appointments 
            where employee_id = ' || employeeid || '
        ';

        if is_remove = true then
            commit;
        else 
            rollback;
        end if;
    end;
$$;

call pr11_task1(1, true);