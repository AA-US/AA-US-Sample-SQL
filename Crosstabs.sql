-- Crosstabs

select * from dbo.Products

select * from dbo.[Order Details]

select * from dbo.Orders


Select p.ProductName, od.UnitPrice * od.Quantity as Total, o.ShipCity
From dbo.Products p join dbo.[Order Details] od
on p.ProductID=od.ProductID
join dbo.Orders o
on o.OrderID=od.OrderID -- in joining follow the seq of how in diagram you connected fields

Select o.ShipCity,p.ProductName, Sum(od.UnitPrice * od.Quantity) as Total
From dbo.Products p join dbo.[Order Details] od
on p.ProductID=od.ProductID
join dbo.Orders o
on o.OrderID=od.OrderID
Group by o.ShipCity, p.ProductName

-- sample set
Albuquerque	Alice Mutton	2449.2000
Anchorage	Alice Mutton	624.0000
Boise	Alice Mutton	7956.0000
Charleroi	Alice Mutton	1248.0000
Elgin	Alice Mutton	62.4000
Frankfurt a.M.	Alice Mutton	468.0000
Graz	Alice Mutton	4368.0000
London	Alice Mutton	975.0000
Luleå	Alice Mutton	312.0000
Madrid	Alice Mutton	1560.0000
Marseille	Alice Mutton	624.0000
México D.F.	Alice Mutton	1341.6000
Montréal	Alice Mutton	2184.0000
Nantes	Alice Mutton	585.0000
Reggio Emilia	Alice Mutton	780.0000
Rio de Janeiro	Alice Mutton	1053.0000
Salzburg	Alice Mutton	2730.0000
Seattle	Alice Mutton	2418.0000
Sevilla	Alice Mutton	780.0000
Strasbourg	Alice Mutton	936.0000
Tsawassen	Alice Mutton	1794.0000

-- Cross tab
Select o.ShipCity,p.ProductName, Sum(od.UnitPrice * od.Quantity) as Total
From dbo.Products p join dbo.[Order Details] od
on p.ProductID=od.ProductID
join dbo.Orders o
on o.OrderID=od.OrderID
Group by o.ShipCity, p.ProductName
order by Total Desc

Select TOP 3 o.ShipCity,p.ProductName, Sum(od.UnitPrice * od.Quantity) as Total
From dbo.Products p join dbo.[Order Details] od
on p.ProductID=od.ProductID
join dbo.Orders o
on o.OrderID=od.OrderID
Group by o.ShipCity, p.ProductName
order by Total Desc



SELECT p.ProductName
	, ISNULL(SUM(
		CASE WHEN o.ShipCity = 'Cunewalde' THEN od.UnitPrice * od.Quantity  END
		), 0) AS Cunewalde
	, iSNULL(SUM(
		CASE WHEN o.ShipCity = 'Cork' THEN od.UnitPrice * od.Quantity  END
		), 0) AS Cork
	, ISNULL(SUM(
		CASE WHEN o.ShipCity = 'Rio de Janeiro' THEN od.UnitPrice * od.Quantity END
		), 0) AS [Rio de Janeiro]
	
From dbo.Products p join dbo.[Order Details] od
on p.ProductID=od.ProductID
join dbo.Orders o
on o.OrderID=od.OrderID
Group by p.ProductName


SELECT p.ProductName
	, ISNULL(SUM(
		CASE WHEN o.ShipCity = 'Cunewalde' THEN od.UnitPrice * od.Quantity  END
		), 0) AS Cunewalde
	, iSNULL(SUM(
		CASE WHEN o.ShipCity = 'Cork' THEN od.UnitPrice * od.Quantity  END
		), 0) AS Cork
	, ISNULL(SUM(
		CASE WHEN o.ShipCity = 'Rio de Janeiro' THEN od.UnitPrice * od.Quantity END
		), 0) AS [Rio de Janeiro]
	
From dbo.Products p join dbo.[Order Details] od
on p.ProductID=od.ProductID
join dbo.Orders o
on o.OrderID=od.OrderID
Group by p.ProductName
order by Sum(od.UnitPrice * od.Quantity) Desc

SELECT top 5 p.ProductName
	, ISNULL(SUM(
		CASE WHEN o.ShipCity = 'Cunewalde' THEN od.UnitPrice * od.Quantity  END
		), 0) AS Cunewalde
	, iSNULL(SUM(
		CASE WHEN o.ShipCity = 'Cork' THEN od.UnitPrice * od.Quantity  END
		), 0) AS Cork
	, ISNULL(SUM(
		CASE WHEN o.ShipCity = 'Rio de Janeiro' THEN od.UnitPrice * od.Quantity END
		), 0) AS [Rio de Janeiro]
	
From dbo.Products p join dbo.[Order Details] od
on p.ProductID=od.ProductID
join dbo.Orders o
on o.OrderID=od.OrderID
Group by p.ProductName
order by Sum(od.UnitPrice * od.Quantity) Desc



SELECT top 5 o.ShipCity
	, ISNULL(SUM(
		CASE WHEN p.ProductName = 'Côte de Blaye' THEN od.UnitPrice * od.Quantity  END
		), 0) AS [Côte de Blaye]
	, iSNULL(SUM(
		CASE WHEN p.ProductName = 'Thüringer Rostbratwurst' THEN od.UnitPrice * od.Quantity  END
		), 0) AS [Thüringer Rostbratwurst] 
         ,ISNULL(SUM(
		CASE WHEN p.ProductName = 'Raclette Courdavault'THEN od.UnitPrice * od.Quantity END
		), 0) AS [Raclette Courdavault]
	
From dbo.Products p join dbo.[Order Details] od
on p.ProductID=od.ProductID
join dbo.Orders o
on o.OrderID=od.OrderID
Group by o.ShipCity
order by Sum(od.UnitPrice * od.Quantity) Desc

-- S0 piviting the columns is the first field becomes the row, second is in case becomes colm headings and sum are the numbers for the pivit that fill the cols.