create table test_identity
(
	id int identity(1,1),
	name varchar(50)
);
insert into test_identity
values
('Husan'),('Hasan'),('Husun'),('Hasun'),('Huasan')

delete from test_identity where name='Hasan'
truncate table test_identity
drop table test_identity
select * from test_identity