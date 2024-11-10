-- Northwind Products Indexes & Full Text
use northwind;
-- Run the following query on the Products table: SELECT UnitPrice FROM Products.
--  View the execution plan and see how the query is executed. 
select UnitPrice
from products;  -- 77 rows

/*
Execution Plan - Full table scan - expensive for big tables. Index might help.
*/

-- Create an index on the UnitPrice column in the Products table. 
select *
From products; -- 77 rows

Describe products; -- 6 rows

CREATE INDEX idx_UnitPrice
ON products (unitPrice);

-- Rerun the query from step 1 and then view the execution plan. What do you notice? What is the major change here?

/*
Execution Plan - Full table scan - expensive for big tables. Index might help.
*/

-- List all the indexes on the Products table. 

show indexes
from products;

--  Drop the index that you created on step 2. 

Drop Index idx_UnitPrice on products;

show indexes
from products;

--  Create a full text search index on a column that you select in the Products table. 

Alter Table products
Add fulltext (ProductName, QuantityPerUnit);

select * from Products
where Match(ProductName)
AGAINST('Ch');
