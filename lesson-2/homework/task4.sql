drop table if exists student
create table student
(
	id int identity(1,1),
	name varchar(50),
	classes int,
	tuition_per_class decimal(10,2),
	total_tuition as (classes * tuition_per_class)
);

insert into student(name, classes, tuition_per_class)
values
('Name1', 2, 300.00),
('Name2', 4, 200.00),
('Name3', 5, 100.00)

select * from student