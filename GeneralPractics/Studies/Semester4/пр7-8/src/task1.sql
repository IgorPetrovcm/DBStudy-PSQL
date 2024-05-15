select positions.salary as salary, employees.id as employee_id into salaries
from appointments 
inner join positions on positions.id = appointments.position_id
inner join employees on employees.id = appointments.employee_id;