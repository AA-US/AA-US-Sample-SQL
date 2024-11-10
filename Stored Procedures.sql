# ---------------------------------------------------------------------- #
# StoredObjects-StoredProcedures_CodeAlong.sql
# ---------------------------------------------------------------------- #
/*
		Practice usng DDL to
			create and drop stored procedures
		Practice calling stored procedures
*/


USE northwind;


# -------------------------------------------------------------------------------- #
# CREATE PROCEDURE statement basic syntax                                          #
# -------------------------------------------------------------------------------- #
# CREATE PROCEDURE procedure_name ([proc_param [, ...]])
# BEGIN
#
#   routine_body
#
# END
#
# proc_param:
#		[IN | OUT | INOUT] param_name type
#
# -------------------------------------------------------------------------------- #
# NOTE: delemiter change required
# -------------------------------------------------------------------------------- #
# MySQL Reference Manual: 13.1.17 CREATE PROCEDURE and CREATE FUNCTION Statements
# -------------------------------------------------------------------------------- #



-- ----------------------------------------------------------------------------------
#	 EXAMPLE: create stored proc with single input parameter
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
-- ----------------------------------------------------------------------------------



-- ----------------------------------------------------------------------------------
-- CODE ALONG: create stored proc with input and output parameter
-- ----------------------------------------------------------------------------------

-- create stored procedure to insert record into Northwind.Shippers
-- provide input parmaesters for CompanyName and Phone
-- provide output parameter for ShipperId for newly inserted record

-- #1: create stored procedure

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
-- #2: use stored procedure

CALL spShippersInsert('XZY Company', '5551215345', @ShipperIDOut);

-- #3: observe effect of stored procedure call

Select * 
from shippers
where shipperid = @ShipperIDOut;

-- ----------------------------------------------------------------------------------



-- ----------------------------------------------------------------------------------
-- CODED ALONG: create stored proc to perform update
-- ----------------------------------------------------------------------------------

-- create stored procedure to update record into Northwind.Shippers
-- provide input parmaesters for CompanyName and Phone

-- #1: create stored procedure



-- #2: use stored procedure



-- #4: observe effect of stored procedure call



-- ----------------------------------------------------------------------------------



-- ----------------------------------------------------------------------------------
-- CODE ALONG: create stored proc to perform delete
-- ----------------------------------------------------------------------------------

-- create stored procedure to delete record into Northwind.Shippers
-- provide input parmaester for ShipperId

-- #1: create stored procedure



-- #2: use stored procedure



-- #3: observe effect of stored procedure call



-- ----------------------------------------------------------------------------------



# -------------------------------------------------------------------------------- #
# DROP PROCEDURE statement                                                         #
# -------------------------------------------------------------------------------- #
# DROP PROCEDURE [IF EXISTS] procedure_name
#
# -------------------------------------------------------------------------------- #
# MySQL Reference Manual: 13.1.29 DROP PROCEDURE and DROP FUNCTION Statements
# -------------------------------------------------------------------------------- #
	
DROP PROCEDURE spCustomerOrderSelectMostRecent;



