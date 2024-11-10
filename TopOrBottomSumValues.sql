use northwind

-- Sum, Top and bottom values


select UnitPrice * Quantity as Total from [Order Details]


select Sum(UnitPrice * Quantity) as AllTotal from [Order Details]-- Sum Of all

select p.ProductName, od.UnitPrice * od.Quantity as Total 
From [Order Details] od Join dbo.Products p
ON od.ProductID = p.ProductID

select p.ProductName, Sum(od.UnitPrice * od.Quantity) as Total 
From [Order Details] od Join dbo.Products p
ON od.ProductID = p.ProductID
Group by p.ProductName

select p.ProductName, Sum(od.UnitPrice * od.Quantity) as Total 
From [Order Details] od Join dbo.Products p
ON od.ProductID = p.ProductID
Group by p.ProductName
order by Sum(od.UnitPrice * od.Quantity) Desc

select top 5 p.ProductName, Sum(od.UnitPrice * od.Quantity) as Total 
From [Order Details] od Join dbo.Products p
ON od.ProductID = p.ProductID
Group by p.ProductName
order by Total Desc

select UnitPrice * Quantity as Total from [Order Details]
order by Total Desc

select top 5 UnitPrice * Quantity as Total from [Order Details]
order by Total Desc -- Highest Price

select UnitPrice * Quantity as Total from [Order Details]
order by Total 

select top 5 UnitPrice * Quantity as Total from [Order Details]
order by Total -- Lowest price
