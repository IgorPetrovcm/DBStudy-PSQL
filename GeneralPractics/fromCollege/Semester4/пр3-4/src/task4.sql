select last_name, first_name, sur_name, departments.name from employees
join appointments on appointments.employee_id = employees.id
join departments on departments.id = appointments.department_id 
order by departments.name;
