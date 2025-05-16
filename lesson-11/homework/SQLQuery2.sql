-- ==============================================================
--                          Puzzle 1 DDL                         
-- ==============================================================

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2)
);

INSERT INTO Employees (EmployeeID, Name, Department, Salary)
VALUES
    (1, 'Alice', 'HR', 5000),
    (2, 'Bob', 'IT', 7000),
    (3, 'Charlie', 'Sales', 6000),
    (4, 'David', 'HR', 5500),
    (5, 'Emma', 'IT', 7200);

create table #EmployeeTransfers(
	EmployeeID INT,
    Name NVARCHAR(50),
    Department NVARCHAR(50),
    Salary INT
);

Insert into #EmployeeTransfers (EmployeeID, Name, Department, Salary)
	Select 
	EmployeeID, 
	Name, 
	case 
		when Department = 'HR' Then 'IT'
		WHEN Department = 'IT' then 'Sales'
		WHEN Department = 'Sales' then 'HR'
		else Department
	end as Department,
	Salary
	from Employees
Select * from Employees
Select * from #EmployeeTransfers



-- ==============================================================
--                          Puzzle 2 DDL
-- ==============================================================

CREATE TABLE Orders_DB1 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB1 VALUES
(101, 'Alice', 'Laptop', 1),
(102, 'Bob', 'Phone', 2),
(103, 'Charlie', 'Tablet', 1),
(104, 'David', 'Monitor', 1);

CREATE TABLE Orders_DB2 (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

INSERT INTO Orders_DB2 VALUES
(101, 'Alice', 'Laptop', 1),
(103, 'Charlie', 'Tablet', 1);

select * from Orders_DB1
Select * from Orders_DB2

CREATE TABLE #MissingOrders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(50),
    Product VARCHAR(50),
    Quantity INT
);

Insert into #MissingOrders (OrderID, CustomerName, Product, Quantity)
select o1.OrderID, o1.CustomerName, o1.Product, o1.Quantity from Orders_DB1 o1
left join Orders_DB2 o2
on o1.OrderID = o2.OrderID
where o2.OrderID is null

select * from #MissingOrders

-- ==============================================================
--                          Puzzle 3 DDL
-- ==============================================================

CREATE TABLE WorkLog (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    WorkDate DATE,
    HoursWorked INT
);

INSERT INTO WorkLog VALUES
(1, 'Alice', 'HR', '2024-03-01', 8),
(2, 'Bob', 'IT', '2024-03-01', 9),
(3, 'Charlie', 'Sales', '2024-03-02', 7),
(1, 'Alice', 'HR', '2024-03-03', 6),
(2, 'Bob', 'IT', '2024-03-03', 8),
(3, 'Charlie', 'Sales', '2024-03-04', 9);

select * from WorkLog

-- Step 1: Create the summary table
CREATE TABLE vw_MonthlyWorkSummary (
    EmployeeID INT,
    EmployeeName VARCHAR(50),
    Department VARCHAR(50),
    TotalHoursWorked INT,
    TotalHoursDepartment INT,
    AvgHoursDepartment INT
);

-- Step 2: Insert aggregated data
INSERT INTO vw_MonthlyWorkSummary (EmployeeID, EmployeeName, Department, TotalHoursWorked, TotalHoursDepartment, AvgHoursDepartment)
SELECT 
    w.EmployeeID,
    w.EmployeeName,
    w.Department,
    SUM(w.HoursWorked) AS TotalHoursWorked,
    d.TotalDeptHours,
    d.AvgDeptHours
FROM WorkLog w
JOIN (
    SELECT 
        Department,
        SUM(HoursWorked) AS TotalDeptHours,
        AVG(HoursWorked) AS AvgDeptHours
    FROM WorkLog
    GROUP BY Department
) d ON w.Department = d.Department
GROUP BY w.EmployeeID, w.EmployeeName, w.Department, d.TotalDeptHours, d.AvgDeptHours;


