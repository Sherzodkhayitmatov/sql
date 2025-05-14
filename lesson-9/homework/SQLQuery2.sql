drop table if exists Employees
CREATE TABLE Employees
(
	EmployeeID  INTEGER PRIMARY KEY,
	ManagerID   INTEGER NULL,
	JobTitle    VARCHAR(100) NOT NULL
);
INSERT INTO Employees (EmployeeID, ManagerID, JobTitle) 
VALUES
	(1001, NULL, 'President'),
	(2002, 1001, 'Director'),
	(3003, 1001, 'Office Manager'),
	(4004, 2002, 'Engineer'),
	(5005, 2002, 'Engineer'),
	(6006, 2002, 'Engineer');

SELECT 
    e.EmployeeID, 
    e.ManagerID, 
    e.JobTitle,
    (
        SELECT COUNT(*)
        FROM Employees AS sub
        WHERE sub.ManagerID = e.EmployeeID
    ) AS Depth
FROM Employees AS e;



WITH cte AS (
    SELECT 1 AS step, 1 AS value
    UNION ALL
    SELECT step + 1, value * (step + 1)
    FROM cte
    WHERE step < 10
)
SELECT * FROM cte;


WITH cte AS (
    SELECT 1 AS step, 0 AS prev, 1 AS curr
    UNION ALL
    SELECT step + 1, curr, prev + curr
    FROM cte
    WHERE step < 10
)
SELECT step, curr AS fibonacci
FROM cte;
