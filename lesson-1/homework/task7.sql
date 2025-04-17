create table invoice
(
	invoice_id int identity,
	amount decimal
);

insert into invoice(amount)
values
(120),(130),(140),(150),(160)
select * from invoice