select departments.name, positions.name, staffes.seats_count, task1.count, staffes.seats_count - task1.count
from task1
inner join departments on departments.id = task1.task_department
inner join positions on positions.id = task1.task_position
inner join staffes on staffes.department_id = task1.task_department and staffes.position_id = task1.task_position
group by departments.name, positions.name, staffes.seats_count, task1.count;