drop table if exists users;

create table users(
	id serial not null primary key,
	name varchar(20) not null
);

insert into users (name) values ('TestUser');
insert into users (name) values ('TestUser2');
insert into users (name) values ('TestUser3');
insert into users (name) values ('TestUser4');

update users
set name = 'EditUser' || right(name,1)
where id > 2;

alter table users
add age integer null;

update users
set age = length(name);

select * from users;