-- Drop tables if they exist
DROP TABLE IF EXISTS Projects;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

-- Create the Departments table first
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(255)
);

-- Create the Employees table after Departments
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(255),
    DepartmentID INT,
    Salary INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Create the Projects table
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(255),
    EmployeeID INT
    -- optionally: FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Insert data into Departments
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(101, 'IT'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

-- Insert data into Employees
INSERT INTO Employees (EmployeeID, Name, DepartmentID, Salary) VALUES
(1, 'Alice', 101, 60000),
(2, 'Bob', 102, 70000),
(3, 'Charlie', 101, 65000),
(4, 'David', 103, 72000),
(5, 'Eva', NULL, 68000);

-- Insert data into Projects
INSERT INTO Projects (ProjectID, ProjectName, EmployeeID) VALUES
(1, 'Alpha', 1),
(2, 'Beta', 2),
(3, 'Gamma', 1),
(4, 'Delta', 4),
(5, 'Omega', NULL);

-- Select from all tables
SELECT * FROM Employees;
SELECT * FROM Departments;
SELECT * FROM Projects;

select e.name as Employees, d.DepartmentName 
from Employees e 
inner join Departments d 
On e.DepartmentID = d.DepartmentID

select e.EmployeeID, e.Name, e.DepartmentID, e.Salary
from Employees e
Left join Departments d
on e.DepartmentID = d.DepartmentID

select d.DepartmentName from Departments d
right join Employees e
on e.DepartmentID = d.DepartmentID

select e.name as Employees, d.DepartmentName 
from Employees e 
full outer join Departments d 
On e.DepartmentID = d.DepartmentID

SELECT d.DepartmentName, 
    SUM(e.Salary) AS TotalSalary
FROM Departments d
LEFT JOIN Employees e ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentName;

select d.DepartmentName, p.ProjectName from Departments d
cross join Projects p

select e.Name, d.DepartmentName, p.ProjectName from Employees e
left join Departments d 
on e.DepartmentID = d.DepartmentID
left join Projects p
on e.EmployeeID = p.EmployeeID