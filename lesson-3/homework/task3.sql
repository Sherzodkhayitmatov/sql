drop table if exists Products
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
select * from Products

with MostExpensive as (
	select 
		category,
		ProductName,
		Price,
		Stock,
		ROW_NUMBER() over (partition by category order by Price desc) as rn
		from Products
) 
select 
Category, ProductName, Price,
IFF(Stock=0, 'Out of stock',
	IFF(stock between 1 and 10, 'Low stock', 'In stock')) as NewStatus
from MostExpensive
where rn = 1
order by Price desc
offset 5 rows