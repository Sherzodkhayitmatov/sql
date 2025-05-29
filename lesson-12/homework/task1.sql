DECLARE @sql NVARCHAR(MAX) = '';

SELECT @sql += '
USE [' + name + '];
SELECT 
    DB_NAME() AS DatabaseName,
    TABLE_SCHEMA AS SchemaName,
    TABLE_NAME AS TableName,
    COLUMN_NAME AS ColumnName,
    DATA_TYPE + 
    COALESCE(''('' + 
        CASE 
            WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN ''MAX''
            WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR)
            ELSE NULL 
        END + '')'', '''') AS DataType
FROM INFORMATION_SCHEMA.COLUMNS;
'
FROM sys.databases
WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');

EXEC sp_executesql @sql;
