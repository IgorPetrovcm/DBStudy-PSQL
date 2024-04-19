select last_name from employees as emp1
join appointments as app1 on app1.employee_id = emp1.id
where 
    (select count(*) from appointments 
        where appointments.department_id = app1.department_id 
            and appointments.appoint_date > app1.appoint_date 
            and appointments.salary > app1.salary) > 0