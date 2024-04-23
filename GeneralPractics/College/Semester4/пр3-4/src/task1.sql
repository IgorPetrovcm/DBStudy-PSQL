-- <summary>
--     Блок кода ниже опирается на основе данных, транзакции файла 'data-transaction'
-- </summary>

do 
$$
    declare 
        current_employee_id int;
    begin
        insert into employees (last_name, first_name, sur_name, birth_day, telephon, education_id)
        values ('Марков', 'Андрей', 'Ярославович', '2000-03-12', '+92558', 1);

        select id into current_employee_id from employees order by id desc limit 1;

        insert into appointments (appoint_date, position_id, department_id, employee_id) values ('2022-09-22', 1, 1, current_employee_id);

        insert into employees (last_name, first_name, sur_name, birth_day, telephon, education_id)
        values ('Иванов', 'Михаил', 'Матвеевич', '2003-12-2', '+92223',2);

        select id into current_employee_id from employees order by id desc limit 1;

        insert into appointments (appoint_date, position_id, department_id, employee_id) values ('2021-01-28', 2, 2, current_employee_id);
    end
$$;
