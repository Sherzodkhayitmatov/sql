drop table if exists Employees
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(50),
    Department VARCHAR(50),
    Salary DECIMAL(10,2),
    HireDate DATE
);
INSERT INTO Employees (EmployeeID, Name, Department, Salary, HireDate)
VALUES
(1, 'Alice Johnson', 'HR', 55000.00, '2020-03-15'),
(2, 'Bob Smith', 'IT', 75000.00, '2019-06-01'),
(3, 'Charlie Lee', 'Finance', 67000.00, '2021-01-10'),
(4, 'Diana King', 'Marketing', 62000.00, '2018-11-23'),
(5, 'Ethan Brown', 'IT', 80000.00, '2022-07-05'),
(6, 'New Smith', 'IT', 67000.00, '2012-06-01');
/*Task - 1*/
select *, 
Row_number() over (order by Salary desc) as Rank 
from Employees
/*Task - 2*/
SELECT *
FROM (
    SELECT *,
           RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) RankedEmployees
where SalaryRank in (
	select SalaryRank from (select Salary, Rank() over (order by Salary desc) as SalaryBank
	from Employees) Sub
	group by SalaryBank
	having COUNT(*)>1
	);
/*Task - 3*/
SELECT *
FROM (
  SELECT *, RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS RankByDepartment
  FROM Employees
) t
WHERE RankByDepartment <= 1;

/*Task - 4*/
SELECT *
FROM (
  SELECT *, RANK() OVER (PARTITION BY Department ORDER BY Salary asc) AS RankByDepartment
  FROM Employees
) t
WHERE RankByDepartment <= 1;

/*Task - 5*/
SELECT *, sum(Salary) over (PARTITION BY Department ORDER BY HireDate)AS RunningTotal 
FROM Employees

/*Task - 6*/
SELECT *, SUM(Salary) over (Partition by Department) as DepartmentTotal
from Employees

/*Task - 7*/
SELECT *, AVG(Salary) over (Partition by Department) as AverageSalary
from Employees

/*Task - 8*/
SELECT *, Salary - AVG(Salary) over (Partition by Department) as Difsalary
from Employees

/*Task - 9*/
SELECT *, AVG(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS MovingAvg
FROM Employees;

/*Task - 10*/
SELECT SUM(Salary)
FROM (
  SELECT Salary FROM Employees ORDER BY HireDate DESC LIMIT 3) t;

/*Task - 11*/
SELECT *, AVG(Salary) OVER (ORDER BY HireDate) AS RunningAvg
FROM Employees;

/*Task - 12*/
SELECT *, MAX(Salary) OVER (ORDER BY HireDate ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING) AS MaxInWindow
FROM Employees;

/*Task - 13*/
SELECT *, ROUND(100 * Salary / SUM(Salary) OVER (PARTITION BY Department), 2) AS PercentOfDept
FROM Employees;
