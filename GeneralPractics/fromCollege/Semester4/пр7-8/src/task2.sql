create or replace procedure task2(employeeid int)
    language plpgsql
as 
$$
    declare 

    begin 
        execute
        'create or replace view task2 
        as
        select dep.name,
        (
            select min(positions.salary), max(positions.slary) 
            from positions 
            inner join appointments on appointments.position_id = positions.id 
            where appointments.department_id = dep.id and appointments.dismissal_date is null 
        )
        from departments as dep
        inner join appointments as app1 on app1.department_id =dep.id 
        where app1.employee_id = ' || employeeid || ';';
    end;
$$;

call task2(3)

select * task2