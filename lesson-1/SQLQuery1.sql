create database class1

use class1;

create table test(
	id int,
	name varchar(100)
	);
insert into test
values 
(1, 'demo1'),
(2, 'demo2');

 select * from test
 select 1 as 'id', 'John' as 'name'

 select 
	id,
	name
from test;

insert into test
select 3, 'demo3'

select * from test

insert into test
select 4, 'demo4'
union all
select 5, 'demo5'