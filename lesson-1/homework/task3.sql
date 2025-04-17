create table orders
(
	order_id int primary key,
	customer_name varchar(50),
	order_date date
);

alter table orders
add constraint new_order primary key(order_id)