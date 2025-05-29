CREATE PROCEDURE usp_GetRoutineParameters
    @DatabaseName SYSNAME = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @sql NVARCHAR(MAX) = '';

    IF @DatabaseName IS NOT NULL
    BEGIN
        SET @sql = '
        USE [' + QUOTENAME(@DatabaseName) + '];
        SELECT 
            DB_NAME() AS DatabaseName,
            SPECIFIC_SCHEMA AS SchemaName,
            SPECIFIC_NAME AS RoutineName,
            ROUTINE_TYPE,
            PARAMETER_NAME,
            DATA_TYPE +
                COALESCE(''('' + 
                    CASE 
                        WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN ''MAX''
                        WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR)
                        ELSE NULL 
                    END + '')'', '''') AS DataType
        FROM INFORMATION_SCHEMA.ROUTINES R
        LEFT JOIN INFORMATION_SCHEMA.PARAMETERS P
            ON R.SPECIFIC_NAME = P.SPECIFIC_NAME AND R.SPECIFIC_SCHEMA = P.SPECIFIC_SCHEMA
        WHERE R.ROUTINE_TYPE IN (''PROCEDURE'', ''FUNCTION'');';
    END
    ELSE
    BEGIN
        SELECT @sql = STRING_AGG('
        USE [' + name + '];
        SELECT 
            ''' + name + ''' AS DatabaseName,
            SPECIFIC_SCHEMA AS SchemaName,
            SPECIFIC_NAME AS RoutineName,
            ROUTINE_TYPE,
            PARAMETER_NAME,
            DATA_TYPE +
                COALESCE(''('' + 
                    CASE 
                        WHEN CHARACTER_MAXIMUM_LENGTH = -1 THEN ''MAX''
                        WHEN CHARACTER_MAXIMUM_LENGTH IS NOT NULL THEN CAST(CHARACTER_MAXIMUM_LENGTH AS VARCHAR)
                        ELSE NULL 
                    END + '')'', '''') AS DataType
        FROM INFORMATION_SCHEMA.ROUTINES R
        LEFT JOIN INFORMATION_SCHEMA.PARAMETERS P
            ON R.SPECIFIC_NAME = P.SPECIFIC_NAME AND R.SPECIFIC_SCHEMA = P.SPECIFIC_SCHEMA
        WHERE R.ROUTINE_TYPE IN (''PROCEDURE'', ''FUNCTION'');', CHAR(13) + CHAR(10))
        FROM sys.databases
        WHERE name NOT IN ('master', 'tempdb', 'model', 'msdb');
    END

    EXEC sp_executesql @sql;
END;
