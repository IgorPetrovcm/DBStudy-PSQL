create or replace procedure task4(n_count int)
    language plpgsql
as
$$
    declare

    begin 
        execute 
        'create or replace view task4
        as 
            select * from employees
            limit ' || n_count  ;
    end;
$$;

call task4(4)

select * from task4
