create or replace view task1
as 
    select staf.department_id as task_department, pos.id as task_position, 
            (select count(id) from appointments
            where dismissal_date is null
            and appointments.department_id = staf.department_id
            and appointments.position_id = pos.id)
        
    from staffes as staf
    right join positions as pos on pos.id = staf.position_id 
    group by task_department, task_position
    order by task_department;

select * from task1;
