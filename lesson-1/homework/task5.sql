create table account
(
	account_id int primary key,
	balance decimal check(balance>=0),
	account_type varchar(50) check(account_type in ('Saving' , 'Checking'))
);