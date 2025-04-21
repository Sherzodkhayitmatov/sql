CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
drop table if exists Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    OrderDate DATE,
    TotalAmount DECIMAL(10,2),
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled'))
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);

select *,
	case
		when salary > 80000 then 'High'
		when salary between 50000 and 80000 then 'Medium'
		else 'Low'
	end as NewSalary
from (select *,
		PERCENT_RANK() over (order by salary desc) 
		from Employees
		) as Ranked

DepartmentSalary as (
	select 
	DepartmentID, AVG(Salary) as AverageSalary,
	from Employees
	group by DepartmentID, Salarycategory
)
select *
from DepartmentSalary
order by AverageSalary desc
OFFSET 2 rows fetch next 5 rows only 