select (5 + 1) / 2

;with cte as (
	select 1 as n
	union all
	select n+ 1  from cte
	where n < 10
)
select * into numbers from cte


go
declare @num int = 0;
select @num = @num + n from numbers-- order by n desc;
select @num;

select * from numbers;

select @@SERVERNAME
select @@IDENTITY

create table emp
(
	id int primary key identity,
	name varchar(50)
);

insert into emp(name)
values ('josh')

select * from emp

select @@IDENTITY
select @@ROWCOUNT
select @@ERROR
select @@VERSION

select * from emp	

begin tran t1
insert into emp(name)
values ('adam')

commit tran t1
rollback tran t1

-- Table variable

declare @dept table (
	id int,
	name varchar(50)
);
insert into @dept
values (1, 'hr'), (2, 'it');


insert into newtable
select * 
from @dept;

select * from  newtable

-- ==============================
-- SQL Server Temporary Tables
-- ==============================

create table #sales
(
	id int,
	product varchar(50),
	price int
);

insert into #sales
values (1, 'apple', 10), (2, 'cherry', 30);

select * from #sales;

create table ##emp
(
	id int,
	name varchar(50)
);

insert into ##emp
values (1, 'john'), (2, 'doe');

select * from ##emp