DECLARE @Year INT = 2025;
DECLARE @Month INT = 5;

DECLARE @StartDate DATE = DATEFROMPARTS(@Year, @Month, 1);
DECLARE @EndDate DATE = EOMONTH(@StartDate);


WITH Dates AS (
    SELECT @StartDate AS CalendarDate
    UNION ALL
    SELECT DATEADD(DAY, 1, CalendarDate)
    FROM Dates
    WHERE CalendarDate < @EndDate
),
LabeledDates AS (
    SELECT
        CalendarDate,
        DATENAME(WEEKDAY, CalendarDate) AS DayName,
        DATEPART(WEEK, CalendarDate) 
            - DATEPART(WEEK, DATEADD(MONTH, DATEDIFF(MONTH, 0, @StartDate), 0)) 
            + 1 AS WeekNum,
        DATEPART(WEEKDAY, CalendarDate) AS WeekdayNum
    FROM Dates
)


SELECT
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 1 THEN CalendarDate END) AS Sunday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 2 THEN CalendarDate END) AS Monday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 3 THEN CalendarDate END) AS Tuesday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 4 THEN CalendarDate END) AS Wednesday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 5 THEN CalendarDate END) AS Thursday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 6 THEN CalendarDate END) AS Friday,
    MAX(CASE WHEN DATEPART(WEEKDAY, CalendarDate) = 7 THEN CalendarDate END) AS Saturday
FROM LabeledDates
GROUP BY WeekNum
ORDER BY WeekNum


OPTION (MAXRECURSION 1000);
