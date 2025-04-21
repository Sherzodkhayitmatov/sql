drop table if exists Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

select * ,
	case
		when Orders.Status in ('Shipped','Delivered') then 'completed'
		when Orders.Status = 'Pending' then 'Pending'
		when Orders.Status = 'Cancelled' then 'Cancelled'
	end as OrderStatus,
	COUNT(*) as TotalOrders,
	SUM(Orders.TotalAmount) as TotalRevenue
from Orders
where Orders.OrderDate between '2023-01-01' and '2023-12-31'
Group by 
		case 
		when Orders.Status in ('Shipped','Delivered') then 'completed'
		when Orders.Status = 'Pending' then 'Pending'
		when Orders.Status = 'Cancelled' then 'Cancelled'
		end
Having sum(orders.TotalAmount) > 5000
order by TotalRevenue desc;
