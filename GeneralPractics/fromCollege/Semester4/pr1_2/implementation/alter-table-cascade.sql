ALTER TABLE appointments
DROP CONSTRAINT department_id_fkey,
DROP CONSTRAINT position_id_fkey,
DROP CONSTRAINT employee_id_fkey,

ADD CONSTRAINT department_id_fkey 
    FOREIGN KEY (department_id)
    REFERENCES departments (ID)
    ON UPDATE CASCADE,
ADD CONSTRAINT position_id_fkey
    FOREIGN KEY (position_id)
    REFERENCES positions (id)
    ON UPDATE CASCADE,
ADD CONSTRAINT employee_id_fkey
    FOREIGN KEY (employee_id)
    REFERENCES employees (id)
    ON UPDATE CASCADE;

ALTER TABLE employees
DROP CONSTRAINT employees_education_id_fkey,

ADD CONSTRAINT education_id_fkey
    FOREIGN KEY (education_id)
    REFERENCES education (id)
    ON UPDATE CASCADE;