
--System objects
exec sp_columns [Employees]-- column info on table

Select * From INFORMATION_SCHEMA.COLUMNS Where TABLE_NAME = 'Employees'

EXEC sp_columns @table_name = N'Employees',  
   @table_owner = N'dbo'; 

select *
from INFORMATION_SCHEMA.COLUMNS
where TABLE_NAME='Employees'

sp_columns 'Employees'
   
EXEC sp_help [Employees] -- more info on table

SELECT  s.name AS [schema],
        t.name AS [table],
        c.name AS [column],
        value AS [property]
FROM    sys.extended_properties AS ep
        INNER JOIN sys.tables AS t
            ON ep.major_id = t.object_id
        INNER JOIN sys.schemas AS s
            ON s.schema_id = t.schema_id
        INNER JOIN sys.columns AS c
            ON ep.major_id = c.object_id
               AND ep.minor_id = c.column_id
WHERE   class = 1
ORDER BY t.name

-- this is it you can filter on them s.name AS [schema],t.name AS [table],c.name AS [column]


SELECT  s.name AS [schema],
        t.name AS [table],
        c.name AS [column],
        value AS [property]
FROM    sys.extended_properties AS ep
        INNER JOIN sys.tables AS t
            ON ep.major_id = t.object_id
        INNER JOIN sys.schemas AS s
            ON s.schema_id = t.schema_id
        INNER JOIN sys.columns AS c
            ON ep.major_id = c.object_id
               AND ep.minor_id = c.column_id
WHERE   class = 1 and c.name like 'End%'
ORDER BY c.name

-- looking in entire db for column that bengings with End

SELECT  s.name AS [schema],
        t.name AS [table],
        c.name AS [column],
        value AS [property]
FROM    sys.extended_properties AS ep
        INNER JOIN sys.tables AS t
            ON ep.major_id = t.object_id
        INNER JOIN sys.schemas AS s
            ON s.schema_id = t.schema_id
        INNER JOIN sys.columns AS c
            ON ep.major_id = c.object_id
               AND ep.minor_id = c.column_id
WHERE   class = 1 and t.name = 'Employee'

-- all info on tables cols thier relationships and purpose

SELECT  FK.name AS FK_Table,
        FkCol.name AS FK_Column,
        PK.name AS PK_Table,
        PkCol.name AS PK_Column,
        OBJECT_NAME(f.object_id) AS Constraint_Name,
        SCHEMA_NAME(FK.schema_id) AS fkSchema,
        SCHEMA_NAME(PK.schema_id) AS pkSchema,
        PkCol.name AS primarykey,
        k.constraint_column_id AS ORDINAL_POSITION
FROM    sys.objects AS PK
        INNER JOIN sys.foreign_keys AS f
            INNER JOIN sys.foreign_key_columns AS k
                ON k.constraint_object_id = f.object_id
            INNER JOIN sys.indexes AS i
                ON f.referenced_object_id = i.object_id
                   AND f.key_index_id = i.index_id
            ON PK.object_id = f.referenced_object_id
        INNER JOIN sys.objects AS FK
            ON f.parent_object_id = FK.object_id
        INNER JOIN sys.columns AS PkCol
            ON f.referenced_object_id = PkCol.object_id
               AND k.referenced_column_id = PkCol.column_id
        INNER JOIN sys.columns AS FkCol
            ON f.parent_object_id = FkCol.object_id
               AND k.parent_column_id = FkCol.column_id
ORDER BY FK_Table, FK_Column




SELECT u.TABLE_SCHEMA,
                                u.TABLE_NAME,
                                u.COLUMN_NAME,
                                u.ORDINAL_POSITION
                         FROM   INFORMATION_SCHEMA.KEY_COLUMN_USAGE u
                                INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
                                    ON u.TABLE_SCHEMA = tc.CONSTRAINT_SCHEMA
                                       AND u.TABLE_NAME = tc.TABLE_NAME
                                       AND u.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
                         WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY' ;
						 
						 

-- Gives PK

SELECT DISTINCT
                                u.TABLE_SCHEMA,
                                u.TABLE_NAME,
                                u.COLUMN_NAME
                         FROM   INFORMATION_SCHEMA.KEY_COLUMN_USAGE u
                                INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
                                    ON u.TABLE_SCHEMA = tc.CONSTRAINT_SCHEMA
                                       AND u.TABLE_NAME = tc.TABLE_NAME
                                       AND u.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
                         WHERE  CONSTRAINT_TYPE = 'FOREIGN KEY'
-- gives fk





SELECT  c.TABLE_SCHEMA AS SchemaName,
        c.TABLE_NAME AS TableName,
        t.TABLE_TYPE AS TableType,
        c.ORDINAL_POSITION AS Ordinal,
        c.COLUMN_NAME AS ColumnName,
        CAST(CASE WHEN IS_NULLABLE = 'YES' THEN 1
                  ELSE 0
             END AS BIT) AS IsNullable,
        DATA_TYPE AS TypeName,
        ISNULL(CHARACTER_MAXIMUM_LENGTH, 0) AS [MaxLength],
        CAST(ISNULL(NUMERIC_PRECISION, 0) AS INT) AS [Precision],
        ISNULL(COLUMN_DEFAULT, '') AS [Default],
        CAST(ISNULL(DATETIME_PRECISION, 0) AS INT) AS DateTimePrecision,
        ISNULL(NUMERIC_SCALE, 0) AS Scale,
        CAST(COLUMNPROPERTY(OBJECT_ID(QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME)), c.COLUMN_NAME, 'IsIdentity') AS BIT) AS IsIdentity,
        CAST(CASE WHEN COLUMNPROPERTY(OBJECT_ID(QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME)), c.COLUMN_NAME, 'IsIdentity') = 1 THEN 1
                  WHEN COLUMNPROPERTY(OBJECT_ID(QUOTENAME(c.TABLE_SCHEMA) + '.' + QUOTENAME(c.TABLE_NAME)), c.COLUMN_NAME, 'IsComputed') = 1 THEN 1
                  WHEN DATA_TYPE = 'TIMESTAMP' THEN 1
                  ELSE 0
             END AS BIT) AS IsStoreGenerated,
        CAST(CASE WHEN pk.ORDINAL_POSITION IS NULL THEN 0
                  ELSE 1
             END AS BIT) AS PrimaryKey,
        ISNULL(pk.ORDINAL_POSITION, 0) PrimaryKeyOrdinal,
        CAST(CASE WHEN fk.COLUMN_NAME IS NULL THEN 0
                  ELSE 1
             END AS BIT) AS IsForeignKey
FROM    INFORMATION_SCHEMA.COLUMNS c
        LEFT OUTER JOIN (SELECT u.TABLE_SCHEMA,
                                u.TABLE_NAME,
                                u.COLUMN_NAME,
                                u.ORDINAL_POSITION
                         FROM   INFORMATION_SCHEMA.KEY_COLUMN_USAGE u
                                INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
                                    ON u.TABLE_SCHEMA = tc.CONSTRAINT_SCHEMA
                                       AND u.TABLE_NAME = tc.TABLE_NAME
                                       AND u.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
                         WHERE  CONSTRAINT_TYPE = 'PRIMARY KEY') pk
            ON c.TABLE_SCHEMA = pk.TABLE_SCHEMA
               AND c.TABLE_NAME = pk.TABLE_NAME
               AND c.COLUMN_NAME = pk.COLUMN_NAME
        LEFT OUTER JOIN (SELECT DISTINCT
                                u.TABLE_SCHEMA,
                                u.TABLE_NAME,
                                u.COLUMN_NAME
                         FROM   INFORMATION_SCHEMA.KEY_COLUMN_USAGE u
                                INNER JOIN INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc
                                    ON u.TABLE_SCHEMA = tc.CONSTRAINT_SCHEMA
                                       AND u.TABLE_NAME = tc.TABLE_NAME
                                       AND u.CONSTRAINT_NAME = tc.CONSTRAINT_NAME
                         WHERE  CONSTRAINT_TYPE = 'FOREIGN KEY') fk
            ON c.TABLE_SCHEMA = fk.TABLE_SCHEMA
               AND c.TABLE_NAME = fk.TABLE_NAME
               AND c.COLUMN_NAME = fk.COLUMN_NAME
        INNER JOIN INFORMATION_SCHEMA.TABLES t
            ON c.TABLE_SCHEMA = t.TABLE_SCHEMA
               AND c.TABLE_NAME = t.TABLE_NAME
WHERE c.TABLE_NAME NOT IN ('EdmMetadata', '__MigrationHistory')
and  c.TABLE_SCHEMA = 'dbo' and c.TABLE_NAME ='Employees'

-- complete table info



SELECT
    t .NAME AS TableName  ,
    s.Name AS SchemaName,
    p.rows AS RowCounts,
    SUM(a.total_pages) * 8 AS TotalSpaceKB, 
    CAST(ROUND(((SUM(a.total_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS TotalSpaceMB,
    SUM(a.used_pages) * 8 AS UsedSpaceKB, 
    CAST(ROUND(((SUM(a.used_pages) * 8) / 1024.00), 2) AS NUMERIC(36, 2)) AS UsedSpaceMB, 
    (SUM(a.total_pages) - SUM(a.used_pages)) * 8 AS UnusedSpaceKB,
    CAST(ROUND(((SUM(a.total_pages) - SUM(a.used_pages)) * 8) / 1024.00, 2) AS NUMERIC(36, 2)) AS UnusedSpaceMB
FROM 
    sys.tables t
INNER JOIN      
    sys.indexes i ON t.OBJECT_ID = i.object_id
INNER JOIN 
    sys.partitions p ON i.object_id = p.OBJECT_ID AND i.index_id = p.index_id
INNER JOIN 
    sys.allocation_units a ON p.partition_id = a.container_id
LEFT OUTER JOIN 
    sys.schemas s ON t.schema_id = s.schema_id
WHERE 
    t.NAME = 'Employees'--NOT LIKE 'Emp%' 
    AND t.is_ms_shipped = 0
   AND i.OBJECT_ID > 255 
GROUP BY 
    t.Name, s.Name, p.Rows
ORDER BY 
    t.Name

-- another view

EXEC sp_helpconstraint '[Production].[Document]';  
--VI gives contraints and FK info


SELECT  *
FROM    sys.objects
WHERE   type = 'U';

	SELECT  *
FROM    sys.objects
WHERE   type IN ( 'UQ','PK','f')



SELECT  @@Servername AS Server ,
        DB_NAME() AS DBName ,
        isc.Table_Name AS TableName ,
        isc.Table_Schema AS SchemaName ,
        Ordinal_Position AS Ord ,
        Column_Name ,
        Data_Type ,
        Numeric_Precision AS Prec ,
        Numeric_Scale AS Scale ,
-- -1 means MAX like Varchar(MAX)
        Character_Maximum_Length AS LEN ,
        Is_Nullable ,
        Column_Default ,
        Table_Type
FROM    INFORMATION_SCHEMA.COLUMNS isc
        INNER JOIN information_schema.tables ist
              ON isc.table_name = ist.table_name
--      WHERE Table_Type = 'BASE TABLE' -- 'Base Table' or 'View'
ORDER BY DBName ,
        TableName ,
        SchemaName ,
        Ordinal_position;
 
-- Summary of Column names and usage counts
-- Watch for column names with different data types
 --  or different lengths
SELECT  @@Servername AS Server ,
        DB_NAME() AS DBName ,
        Column_Name ,
        Data_Type ,
        Numeric_Precision AS Prec ,
        Numeric_Scale AS Scale ,
        Character_Maximum_Length ,
        COUNT(*) AS Count
FROM    information_schema.columns isc
        INNER JOIN information_schema.tables ist
               ON isc.table_name = ist.table_name
WHERE   Table_type = 'BASE TABLE'
GROUP BY Column_Name ,
        Data_Type ,
        Numeric_Precision ,
        Numeric_Scale ,
        Character_Maximum_Length;
 
-- Summary of data types
SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DBName ,
        Data_Type ,
        Numeric_Precision AS Prec ,
        Numeric_Scale AS Scale ,
        Character_Maximum_Length AS [Length] ,
        COUNT(*) AS COUNT
FROM    information_schema.columns isc
        INNER JOIN information_schema.tables ist
               ON isc.table_name = ist.table_name
WHERE   Table_type = 'BASE TABLE'
GROUP BY Data_Type ,
        Numeric_Precision ,
        Numeric_Scale ,
        Character_Maximum_Length
ORDER BY Data_Type ,
        Numeric_Precision ,
        Numeric_Scale ,
        Character_Maximum_Length
 
-- Large object data types or Binary Large Objects(BLOBs)
SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DBName ,
        isc.Table_Name ,
        Ordinal_Position AS Ord ,
        Column_Name ,
        Data_Type AS BLOB_Data_Type ,
        Numeric_Precision AS Prec ,
        Numeric_Scale AS Scale ,
        Character_Maximum_Length AS [Length]
FROM    information_schema.columns isc
        INNER JOIN information_schema.tables ist
               ON isc.table_name = ist.table_name
WHERE   Table_type = 'BASE TABLE'
        AND ( Data_Type IN ( 'text', 'ntext', 'image', 'XML' )
              OR ( Data_Type IN ( 'varchar', 'nvarchar', 'varbinary' )
                   AND Character_Maximum_Length = -1
                 )
            ) -- varchar(max), nvarchar(max), varbinary(max)
ORDER BY isc.Table_Name ,
        Ordinal_position;
--COL INFORMATION_SCHEMA

	SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DBName ,
        parent.name AS 'TableName' ,
        o.name AS 'Constraints' ,
        o.[Type] ,
        o.create_date
FROM    sys.objects o
        INNER JOIN sys.objects parent
               ON o.parent_object_id = parent.object_id
WHERE   o.Type = 'C' -- Check Constraints
ORDER BY parent.name ,
        o.name
 
--CHECK constriant definitions
SELECT  @@Servername AS ServerName ,
        DB_NAME() AS DBName ,
        OBJECT_SCHEMA_NAME(parent_object_id) AS SchemaName ,
        OBJECT_NAME(parent_object_id) AS TableName ,
        parent_column_id AS Column_NBR ,
        Name AS CheckConstraintName ,
        type ,
        type_desc ,
        create_date ,
        OBJECT_DEFINITION(object_id) AS CheckConstraintDefinition
FROM    sys.Check_constraints
ORDER BY TableName ,
        SchemaName ,
        Column_NBR
GO

-- CHECK CONSTRAINTS
	 SELECT so.name AS table_name, 
          sc.name AS column_name, 
          sm.text AS default_value
     FROM sys.sysobjects so
     JOIN sys.syscolumns sc ON sc.id = so.id
LEFT JOIN sys.syscomments sm ON sm.id = sc.cdefault
    WHERE so.xtype = 'U' 
      AND so.name = 'Store'
 ORDER BY so.[name], sc.colid
 -- get default value of table
