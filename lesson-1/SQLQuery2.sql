drop table if exists person;

create table person
(
	id int not null,
	name varchar(50)
);

insert into person(id)
values(1);

select * from person

drop table if exists person;

create table person
(
	id int unique,
	name varchar(50)
);

insert into person
values
	(1, 'John'),
	(2, 'Mike');



drop table if exists person;
create table person
(
	id int not null,
	name varchar(50)
);
alter table person
add unique(id);

alter table person
drop constraint UQ__person__3213E83E9B7B47C2

/*	 primary key	*/

drop table if exists person
create table person
(
	id int primary key,
	name varchar(50)
);

insert into person(id, name)
values (1, 'John');

select * from person

/*Foreign key*/
drop table if exists person
create table person
(
	id int primary key,
	name varchar(50),
	department_id int
);

insert into person
values (1, 'John', 1);

insert into person
values (2, 'Adam', 2);

insert into person
values (3, 'Anna', 1);

insert into person
values (4, 'Josh', 5);

select * from person
drop table if exists department
create table department
(
	id int primary key,
	name varchar(50)
);

insert into department
values
(1, 'HR'),(2, 'IT'),(3, 'Marketing')
select * from department
select * from person

drop table if exists person
create table person
(
	id int primary key,
	name varchar(50),
	department_id int foreign key references department(id)
);

/*	Check constraint	*/
drop table if exists employee;
create table employee
(
	id int primary key,
	name varchar(50),
	age int check(age > 0)
);
insert into employee
values
	(1, 'name1', -1),
	(2, 'name2', 2)

select * from employee

drop table if exists employee;
create table employee
(
	id int primary key,
	name varchar(50),
	age int check (age > 0),
	email varchar(255) NOT NULL DEFAULT 'No Email'
);
insert into employee(id, name, age, email)
select 1, 'Josh', 45, NULL

select * from employee;

/* IDENTITY */

drop table if exists person;
create table person
(
	id int primary key identity(5,2),
	name varchar(50)
);

insert into person(id, name)
values (3, 'John')

--An explicit value for the identity column in table 'person' can only be specified when a column list is used and IDENTITY_INSERT is ON.

insert into person(name)
values ('John')

select * from person

SET IDENTITY_INSERT person OFF