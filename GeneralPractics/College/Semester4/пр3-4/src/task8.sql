create or replace view task8 
as
    select name from departments as dp
    join appointments on appointments.department_id = dp.id 
    join employees as emp on appointments.employee_id = emp.id
    where (select count(*) from departments 
            join appointments as app on app.department_id = departments.id
            join employees on employees.id = app.employee_id
            where dp.id = departments.id and employees.gender = 'm') = 0
    group by dp.name;

select * from task8 