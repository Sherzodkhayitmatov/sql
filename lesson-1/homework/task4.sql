create table category
(
	category_id int primary key,
	category_name varchar(50)
);

create table item
(
	item_id int primary key,
	item_name varchar(50),
	category_id int foreign key references category(category_id)
);
alter table item

add constraint fk_item_category
foreign key (category_id) references category(category_id);

select * from category
select * from item