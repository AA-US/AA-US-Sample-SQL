-- SYSTEM OBJECTS

USE [AdventureWorks2014]
GO

-- GET TABLE META INFO ON SPECIFIC TABLE/COL IN A PARTICULAR DB

SELECT * FROM INFORMATION_SCHEMA.COLUMNS

SELECT * FROM INFORMATION_SCHEMA.COLUMNS

WHERE TABLE_NAME = 'Employees'

-- GET CONSTRAINT INFO ON TABLE

EXEC sp_helpconstraint'[HumanResources].[EmployeeDepartmentHistory]'

-- Indexes info

Select * from sys.indexes 

Select * from sys.indexes where object_id = 8

EXEC sys.sp_helpindex @objname = N'[HumanResources].[EmployeeDepartmentHistory]'

-- Find any other table associated with a particular column in a database

SELECT *  FROM sys.tables 

select * from sys.columns


Select c.name as 'ColumnName',
t.name as 'TableName'
From sys.columns c JOIN sys.tables t
on c.object_id = t.object_id
where c.name like'A%'
order by TableName, ColumnName

Select c.name as 'ColumnName',
t.name as 'Tablename'
From sys.columns c JOIN sys.tables t
on c.object_id = t.object_id
where c.name like'I%'
order by TableName, ColumnName

-- System object info 

Select * from sys.objects

SELECT SCHEMA_NAME(schema_id) AS schema_name  
    ,name AS table_name   
FROM sys.tables   
WHERE OBJECTPROPERTY(object_id,'TableHasPrimaryKey') = 0  
ORDER BY schema_name, table_name;  

SELECT SCHEMA_NAME(schema_id) AS schema_name  
    ,name AS table_name   
FROM sys.tables   
WHERE OBJECTPROPERTY(object_id,'TableHasPrimaryKey') = 1  
ORDER BY schema_name, table_name;  

SELECT T1.object_id,
T1.name as TemporalTableName,
SCHEMA_NAME(T1.schema_id) AS TemporalTableSchema,  
T2.name as HistoryTableName, 
SCHEMA_NAME(T2.schema_id) AS HistoryTableSchema,  
T1.temporal_type_desc  
FROM sys.tables T1  
LEFT JOIN sys.tables T2   
ON T1.history_table_id = T2.object_id  
ORDER BY T1.temporal_type desc 

--**********************************
Select * from sys.types

Select OBJECT_SCHEMA_NAME (c.object_id) SchemaName,
o.Name AS Table_Name,
c.Name As Field_Name,
t.Name AS Data_Type,
t.max_length AS Lenght_Size,
t.precision AS Precision
FROM sys.columns c
INNER JOIN sys.objects o  ON o.object_id= c.object_id
LEFT JOIN sys.types t on t.user_type_id = c.user_type_id
WHERE o.type = 'U'

Select OBJECT_SCHEMA_NAME (c.object_id) SchemaName,
o.Name AS Table_Name,
c.Name As Field_Name,
t.Name AS Data_Type,
t.max_length AS Lenght_Size,
t.precision AS Precision
FROM sys.columns c
INNER JOIN sys.objects o  ON o.object_id= c.object_id
LEFT JOIN sys.types t on t.user_type_id = c.user_type_id
WHERE o.type = 'U'
AND o.Name= N'Employee'
order by o.name, c.name

--************************
