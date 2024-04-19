select dp.name, count(emp), sum(case when emp.gender = 'm' then 1 else 0 end)  as males, 
                            sum(case when emp.gender = 'f' then 1 else 0 end) as females 
from appointments as app
join departments as dp on dp.id = app.department_id
join employees as emp on emp.id = app.employee_id
group by dp.name