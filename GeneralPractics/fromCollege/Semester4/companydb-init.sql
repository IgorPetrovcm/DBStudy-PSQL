DROP TABLE IF EXISTS appointments CASCADE;

DROP TABLE IF EXISTS employees CASCADE;

DROP TABLE IF EXISTS education CASCADE;

DROP TABLE IF EXISTS departments CASCADE;

DROP TABLE IF EXISTS positions CASCADE;

CREATE TABLE education(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE employees(
    id SERIAL NOT NULL PRIMARY KEY,
    last_name VARCHAR(30),
    first_name VARCHAR(30),
    sur_name VARCHAR(30),
    birth_day TIMESTAMP,
    telephon VARCHAR(20),
    gender character(1),
    education_id integer not null,
    foreign key (education_id) REFERENCES education (id) on delete cascade
);

CREATE TABLE departments(
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE positions (
    id SERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary integer not null
);

create table staffes (
    id serial not null primary key,
    seats_count integer not null,
    department_id integer not null,
    position_id integer not null,
    foreign key (department_id) references departments (id) on delete cascade,
    foreign key (position_id) references positions (id) on delete cascade
);

CREATE TABLE appointments (
    id SERIAL NOT NULL PRIMARY KEY,
    appoint_date TIMESTAMP,
    dismissal_date TIMESTAMP,
    salary int,
    position_id INTEGER not null,
    department_id INTEGER not null,
    employee_id INTEGER not null,
    foreign key (position_id) references positions (id) on delete cascade, 
    foreign key (department_id) references departments (id) on delete cascade,
    foreign key (employee_id) references employees (id) on delete cascade
);