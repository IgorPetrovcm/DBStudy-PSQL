select last_name from employees 
join appointments on appointments.employee_id = employees.id 
where date_part('year', (select appoint_date from appointments 
                            where employee_id = 1 /*любой ваш номер*/)) = date_part('year', appointments.appoint_date) 
                            and employees.id != 1 /*любой ваш номер*/;
