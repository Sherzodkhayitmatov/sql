drop table if exists Customers
drop table if exists Orders
drop table if exists OrderDetails
drop table if exists Products
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100)
);

CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    OrderDate DATE
);

CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT,
    Quantity INT,
    Price DECIMAL(10,2)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    Category VARCHAR(50)
);

INSERT INTO Customers (CustomerID, CustomerName) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana'),
(5, 'Eve');

INSERT INTO Products (ProductID, ProductName, Category) VALUES
(101, 'Laptop', 'Electronics'),
(102, 'Smartphone', 'Electronics'),
(103, 'Notebook', 'Stationery'),
(104, 'Pen', 'Stationery'),
(105, 'Table', 'Furniture');

INSERT INTO Orders (OrderID, CustomerID, OrderDate) VALUES
(1001, 1, '2025-01-10'),
(1002, 1, '2025-02-15'),
(1003, 2, '2025-03-12'),
(1004, 3, '2025-04-20'),
(1005, 3, '2025-05-01');

INSERT INTO OrderDetails (OrderDetailID, OrderID, ProductID, Quantity, Price) VALUES
(1, 1001, 101, 1, 800.00),        
(2, 1001, 102, 2, 500.00),        
(3, 1002, 103, 5, 3.00),          
(4, 1003, 103, 10, 3.00),         
(5, 1004, 101, 1, 800.00),        
(6, 1005, 105, 1, 200.00);        

select * from Customers 
select * from Products
select * from Orders 
select * from OrderDetails 

select c.CustomerName, o.OrderID, o.OrderDate from Customers c
left join Orders o
on c.CustomerID = o.CustomerID

select c.CustomerID, c.CustomerName from Customers c
left join Orders o
on c.CustomerID = o.CustomerID
where o.OrderID is null

select o.OrderID, p.ProductName, o.Quantity from Products p
inner join OrderDetails o
on p.ProductID = o.ProductID

select c.CustomerName, d.Quantity from Customers c
inner join Orders o
on c.CustomerID = o.CustomerID
inner join OrderDetails d
on o.OrderID = d.OrderID
where d.Quantity > 1

SELECT d.OrderID, p.ProductName, d.Price
FROM OrderDetails d
JOIN Products p ON d.ProductID = p.ProductID
WHERE (d.OrderID, d.Price) IN (
    SELECT OrderID, MAX(Price)
    FROM OrderDetails
    GROUP BY OrderID
);

SELECT o.CustomerID, c.CustomerName, o.OrderID, o.OrderDate
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
WHERE o.OrderDate = (
    SELECT MAX(OrderDate)
    FROM Orders o2
    WHERE o2.CustomerID = o.CustomerID
	group by CustomerID
);

SELECT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.CustomerID, c.CustomerName
HAVING COUNT(DISTINCT CASE WHEN p.Category <> 'Electronics' THEN p.ProductID END) = 0;

SELECT DISTINCT c.CustomerID, c.CustomerName
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE p.Category = 'Stationery';

SELECT c.CustomerID, c.CustomerName, 
       SUM(od.Quantity * od.Price) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CustomerName;




