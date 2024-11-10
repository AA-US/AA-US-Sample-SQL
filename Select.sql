
Use Northwind;
--  Select
--  Select all the records from the Customers table.
Select * from customers; -- 93 rows returned

--  Get distinct countries from the Customers table.
Select distinct Country from customers;  -- 22 distict countries from customer table

--  Get all the records from the Customers table where the CustomerID starts with “BL”.
Select CustomerID from customers
where CustomerID like 'BL%'; -- two ID's

Select * from customers limit 100;


--  Get the first 100 records of the Orders table.
Select distinct * from customers limit 100; -- distict will not help as customer are unique in table


--  Get all customers that live in the postal codes 1010, 3012, 12209, and 05023.
Select PostalCode from customers
where PostalCode in (1010, 3012, 12209, 05023);

Select PostalCode from customers
where PostalCode in ('1010', '3012', '12209', '05023'); -- both queries same result but since PostalCode defined as varchar sigle quotes should be used if integer no need


--  Get all orders where the ShipRegion is not equal to NULL.
Select ShipRegion from orders -- total rowe 830
where ShipRegion <> ''; -- 323 rows returned

Select ShipRegion from orders -- total rowe 830
where ShipRegion is null; -- 507 records received

Select * from orders -- total rowe 830
where ShipRegion is null; -- 507 records received -- list of all oders with no postal code

--  Get all customers ordered by the country, then by the city.

Select * from customers
order by Country, City ;

SET @Counter:=0;
Select @Counter:= @Counter+1 AS RN, CustomerID, CompanyName, City, Country from customers
where Country <> '' AND City <> '';

Select CustomerID, count(*) from customers
group by CustomerID
order by Country, City ;


--  Calculate the average, max, and min of the quantity at the `Order Details` table.
Select AVG(Quantity) AS AQ, min(Quantity) As MQ, MAX(quantity) AS MXQ  from orderdetails;
-- no group by used - result 23.81, 1 & 130

--  Calculate the average, max, and min of the quantity at the `Order Details` table, grouped by the OrderID.
Select  OrderID, avg(quantity) AS AQ, min(Quantity) AS MINQ, max(Quantity) AS MAXQ from orderdetails
group by OrderID; -- test oderid 10248 avg is 9.00 , min 5 max 12

Select  OrderID, avg(quantity) AS AQ, min(Quantity) AS MINQ, max(Quantity) AS MAXQ from orderdetails
group by OrderID; 

Select  OrderID, round(AVG(Quantity),2) AS AQ, min(Quantity) AS MINQ, max(Quantity) AS MAXQ from orderdetails
group by OrderID; -- rounding the average to two decimal numbers


Select  OrderID, concat(round(AVG(Quantity),2)," ", "%") AS AQ,  min(Quantity) AS MINQ, max(Quantity) AS MAXQ from orderdetails
group by OrderID; -- add % sign to avewrage


-
--  Find the CustomerID that placed order 10290 (Orders table)

select * from `order details`
where OrderID = 10248 ;-- validated above statement  -- using back tick ` for space in table name.

--  Do an inner join, left join, right join on orders and Customers tables.

-- Inner Join

Select customers.CustomerID, orders.OrderID From
customers inner JOIN orders on
customers.CustomerID=orders.CustomerID;  -- 830 rows

-- left
Select customers.CustomerID, orders.OrderID From
customers left JOIN orders on
customers.CustomerID=orders.CustomerID;  -- 834 rows

-- right

Select customers.CustomerID, orders.OrderID From
customers right JOIN orders on
customers.CustomerID=orders.CustomerID;  -- 830 rows

-- Q12 Get employees’ FirstName for all employees who report to no one.
SELECT E.firstname AS "Employee Name", M.firstname AS "Manager" FROM employees E LEFT JOIN employees M ON E.EmployeeID = M.reportsto;


-- Q13 Get employees’ FirstName for all employees who report to Andrew.

Select FirstName from employees where reportsto = (Select EmployeeID from employees where FirstName= 'Andrew');  -- 5 rows

--  Get category name, count of orders processed by the USA employees

select c.CategoryName,
m.Country,
Count(o.OrderID) As TNOOrdersUSA
from `order details` d
inner join orders o on
d.OrderID=o.OrderID
inner join employees m on
o.EmployeeID=m.EmployeeID
inner join products p on
d.ProductID=p.ProductID
inner join categories c on
p.CategoryID=c.CategoryID
Group by c.CategoryName, m.Country
having m.Country like 'USA';  -- 8 rows

