-- 2.2 Multiline


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Department VARCHAR(50) NOT NULL
);

CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY IDENTITY(1,1),
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL
);

CREATE TABLE EmployeeProjects (
    EmployeeID INT FOREIGN KEY REFERENCES Employees(EmployeeID),
    ProjectID INT FOREIGN KEY REFERENCES Projects(ProjectID),
    Role VARCHAR(50),
    HoursWorked DECIMAL(10,2),
    PRIMARY KEY (EmployeeID, ProjectID)
);


INSERT INTO Employees (FullName, Department) VALUES
    ('Alice Johnson', 'IT'),
    ('Bob Smith', 'IT'),
    ('Charlie Brown', 'HR'),
    ('David White', 'Finance');

INSERT INTO Projects (ProjectName, StartDate, EndDate) VALUES
    ('ERP System', '2023-01-01', '2024-06-30'),
    ('Website Redesign', '2023-05-15', '2023-12-31'),
    ('HR Automation', '2023-07-01', '2024-03-15'),
    ('Financial Forecasting', '2023-08-01', NULL); -- Ongoing project

INSERT INTO EmployeeProjects (EmployeeID, ProjectID, Role, HoursWorked) VALUES
    (1, 1, 'Developer', 400),
    (1, 2, 'Lead Developer', 300),
    (2, 1, 'QA Engineer', 250),
    (2, 3, 'Consultant', 150),
    (3, 3, 'HR Specialist', 350),
    (4, 4, 'Analyst', 200);


select * from EmployeeProjects
select * from Projects
select * from Employees