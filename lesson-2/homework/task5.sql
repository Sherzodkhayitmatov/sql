drop table if exists worker
CREATE TABLE worker (
    id INT,
    name VARCHAR(50)
);
BULK insert worker
from '"D:\sql\workers.csv"'
with (
	format = 'csv',
	firstrow = 2,
	fieldterminator = ',',
	rowterminator = '\n'
);

select * from worker;