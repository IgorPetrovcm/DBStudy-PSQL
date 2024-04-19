do
$$
    declare 

    begin
        update appointments 
        set position_id = 2
        where employee_id = 1;
    end
$$;