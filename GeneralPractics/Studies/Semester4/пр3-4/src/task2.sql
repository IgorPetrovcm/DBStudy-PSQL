do
$$
    declare 

    begin
        update appointments 
        set dismissal_date = current_date
        where employee_id = 2;
    end
$$;