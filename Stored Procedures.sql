
USE northwind;


-- ----------------------------------------------------------------------------------
--	 EXAMPLE create stored proc with single input parameter
-- ----------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE spCustomerOrderSelectMostRecent (customerIdIn VARCHAR(5))
BEGIN

SELECT	o.OrderId, o.OrderDate,
				od.ProductId, p.ProductName,
        od.UnitPrice, od.Quantity, od.Discount,
        (od.UnitPrice - od.Discount)*od.Quantity LineTotal
FROM Orders o
			JOIN `Order Details` od
				ON o.OrderId = od.OrderId
			JOIN Products p
				ON od.ProductId = p.ProductId
WHERE	o.CustomerId = customerIdIn AND
			o.OrderDate =	(
											SELECT	MAX(OrderDate) OrderDate
											FROM Orders
											WHERE CustomerId = customerIdIn
										);

END //

DELIMITER ;



-- use stored procedure

SELECT CustomerId FROM Customers ORDER BY CustomerId;

CALL spCustomerOrderSelectMostRecent('QUEEN');

-- create stored proc with input and output parameter
-- create stored procedure to insert record into Northwind.Shippers
-- provide input parmaesters for CompanyName and Phone
-- provide output parameter for ShipperId for newly inserted record

--  create stored procedure

Delimiter  //
Create procedure spShippersInsert(CompanyNameIn varchar(40), PhoneIn varchar(24),
									out ShipperIDOut int)
Begin

INsert into Shippers(companyName, Phone)
Values(CompanyNameIn, PhoneIn);

SET ShipperIDOut = Last_Insert_ID();


END//
Delimiter ;
show create procedure spShippersInsert;

Drop procedure spShippersInsert;
--  use stored procedure

CALL spShippersInsert('XZY Company', '5551215345', @ShipperIDOut);

-- observe effect of stored procedure call

Select * 
from shippers
where shipperid = @ShipperIDOut;


-- DROP PROCEDURE statement                                                         #
	
DROP PROCEDURE spCustomerOrderSelectMostRecent;



