drop table if exists data_types_demo
create table data_types_demo
(
	id int,
	name varchar(50),
	grade decimal(10,2),
	opened_date date,
	profile_pic varbinary(MAX)
);
insert into data_types_demo(id, name, grade, opened_date, profile_pic)
values (1, 'new data', 4.8, '2025-04-18', null);
select * from data_types_demo

