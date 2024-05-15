select last_name, first_name, sur_name, emp.id from employees as emp
join appointments on appointments.employee_id = emp.id    
join departments on departments.id = appointments.department_id 
where 
    ( select count(*) from appointments
      where employee_id = emp.id ) = ( select count(*) from appointments
        where dismissal_date is not null and appointments.employee_id = emp.id ) 
order by departments.name
