---*********CASE Statement
USE [AdventureWorks2014]
--Here's a simple CASE example

--Here's the SalesOrderHeader table we will work with
select * from sales.salesorderheader


--Let's start with a simple CASE statement
select salesordernumber, customerid, totaldue,
  CASE 
	WHEN totaldue<2500 THEN 'Low'
	WHEN totaldue>2500 and totaldue <10000 THEN 'Avg'
	WHEN totaldue>10000 THEN 'High'
  END as 'Rating'  
from sales.salesorderheader


--Let's use the CASE statement as a column and use group by
--to create some interesting output
select 
	MONTH(OrderDate) 'Month',
	 SUM(CASE YEAR(OrderDate) WHEN 2012 THEN 1 ELSE 0 END) AS Orders,
	 SUM(CASE YEAR(OrderDate) WHEN 2012 THEN Totaldue ELSE 0 END) AS 'Total Value'
from
	sales.salesorderheader
group by Month(orderdate)
order by Month(orderdate) asc

select 
     Year(OrderDate) 'Year',
	 MONTH(OrderDate) 'Month',
	 SUM(CASE YEAR(OrderDate) WHEN 2011 THEN 1 ELSE 0 END) AS Orders,
	 SUM(CASE YEAR(OrderDate) WHEN 2011 THEN Totaldue ELSE 0 END) AS 'Total Value'
from
	sales.salesorderheader
group by Year(OrderDate), Month(orderdate)
order by Year(OrderDate), Month(orderdate) asc
