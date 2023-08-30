---- DATABASE DESIGN 1 LAB 08 @ IUT
---- FULL NAME: Melvin Mokhtari
---- STUDENT ID: 9831143


--- Answer to Question 1 - Session 1

BEGIN TRANSACTION
SELECT ModifiedDate
FROM Production.Product
WHERE ProductID = 1

WAITFOR DELAY '00:00:10'

SELECT ModifiedDate
FROM Production.Product
WHERE ProductID = 1

--- Answer to Question 1 - Session 2

BEGIN TRANSACTION
UPDATE Production.Product
SET ModifiedDate = GETDATE()
WHERE ProductID = 1

	
--- Answer to Question 2 - Dirty Read

--- Dirty Read - Session 1

BEGIN TRANSACTION
UPDATE Sales.SalesOrderDetail
SET ModifiedDate = GETDATE()
WHERE SalesOrderID = 43700 AND SalesOrderDetailID = 356

WAITFOR DELAY '00:00:10'
ROLLBACK TRANSACTION

--- Dirty Read - Session 2

SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
SELECT *
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 43700 AND SalesOrderDetailID = 356


--- Answer to Question 2 - Non Repeatable Read

--- Non Repeatable Read - Session 1

BEGIN TRANSACTION
SELECT SubTotal 
FROM Sales.SalesOrderHeader 
WHERE SalesOrderID = 44000;

WAITFOR DELAY '00:00:10';

SELECT SubTotal 
FROM Sales.SalesOrderHeader 
WHERE SalesOrderID = 44000;
COMMIT;

--- Non Repeatable Read - Session 2
	
BEGIN TRANSACTION
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED
UPDATE Sales.SalesOrderHeader 
SET SubTotal = SubTotal - 50 
WHERE SalesOrderID = 44000;
SELECT SubTotal 
FROM Sales.SalesOrderHeader 
WHERE SalesOrderID = 44000;
COMMIT;