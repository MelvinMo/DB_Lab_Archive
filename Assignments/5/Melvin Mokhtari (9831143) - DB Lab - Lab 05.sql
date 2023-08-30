---- DATABASE DESIGN 1 LAB 05 @ IUT
---- FULL NAME: Melvin Mokhtari
---- STUDENT ID: 9831143


--- Answer to Question 1

SELECT
	[Name],
	[Europe],
	[North America],
	[Pacific] 
FROM
	(
	SELECT
		Product.[Name],
		SalesTerritory.[Group],
		SalesOrderDetail.OrderQty 
	FROM
		Production.Product
		INNER JOIN Sales.SalesOrderDetail ON Product.ProductID = SalesOrderDetail.ProductID
		INNER JOIN Sales.SalesOrderHeader ON SalesOrderDetail.SalesOrderID = SalesOrderHeader.SalesOrderID
	INNER JOIN Sales.SalesTerritory ON SalesTerritory.TerritoryID = SalesOrderHeader.TerritoryID 
	) Temp pivot ( count( OrderQty ) FOR [Group] IN ( Europe, [North America], Pacific ) ) AS PVT


--- Answer to Question 2

SELECT
	PersonType,
	M,
	F 
FROM
	( SELECT PersonType, Person.BusinessEntityID, Gender FROM Person.Person INNER JOIN HumanResources.Employee ON Person.BusinessEntityID = Employee.BusinessEntityID ) AS Temp pivot ( count( BusinessEntityID ) FOR Gender IN ( M, F ) ) AS PVT
	

--- Answer to Question 3

SELECT
	Temp.Name 
FROM
	Production.Product AS Temp 
WHERE
	LEN ( Name )< 15 
	AND SUBSTRING( Name, LEN ( Name )- 1, 1 )= 'e'

	
--- Answer to Question 4

CREATE FUNCTION ShamsiDateChecker (
	@Date CHAR ( 10 )) RETURNS VARCHAR ( 100 ) AS BEGIN
	DECLARE
		@Message VARCHAR ( 100 ) DECLARE
		@DAY VARCHAR ( 10 ) DECLARE
		@FullDate VARCHAR ( 10 ) DECLARE
		@MONTH VARCHAR ( 10 ) DECLARE
		@YEAR VARCHAR ( 10 ) 
		SET @DAY = RIGHT ( @Date, 2 ) 
		SET @FullDate = LEFT ( @Date, 7 ) 
		SET @MONTH = RIGHT ( @FullDate, 2 ) 
		SET @YEAR = LEFT ( @FullDate, 4 )
	IF
		(
			len ( @Date ) != 10 
			OR ( len ( @DAY )!= 2 OR ISNUMERIC ( @DAY )= 0 ) 
			OR ( len ( @MONTH )!= 2 OR ISNUMERIC ( @MONTH )= 0 ) 
		OR ( len ( @YEAR )!= 4 OR ISNUMERIC ( @YEAR )= 0 )) 
		SET @Message = 'INVALID INPUT!' ELSE BEGIN
		IF
			@MONTH = '01' 
			SET @Message = @DAY + ' Farvardin ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '02' 
			SET @Message = @DAY + ' Ordibehesht ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '03' 
			SET @Message = @DAY + ' Khordad ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '04' 
			SET @Message = @DAY + ' Tir ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '05' 
			SET @Message = @DAY + ' Mordad ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '06' 
			SET @Message = @DAY + ' Shahrivar ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '07' 
			SET @Message = @DAY + ' Mehr ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '08' 
			SET @Message = @DAY + ' Aban ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '09' 
			SET @Message = @DAY + ' Azar ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '10' 
			SET @Message = @DAY + ' Dey ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '11' 
			SET @Message = @DAY + ' Bahman ' + @YEAR + ' Shamsi'
		IF
			@MONTH = '12' 
			SET @Message = @DAY + ' Esfand ' + @YEAR + ' Shamsi'
		IF
			@MONTH > '12' 
			SET @Message = 'INVALID INPUT!' 
		END RETURN @Message;
	
END;

SELECT
	dbo.ShamsiDateChecker ( '1401/01/22' );
SELECT
	dbo.ShamsiDateChecker ( '1401/01m/23' );
SELECT
	dbo.ShamsiDateChecker ( '14071/01/032' );
SELECT
	dbo.ShamsiDateChecker ( '1401/13/03' );
SELECT
	dbo.ShamsiDateChecker ( '1401/13/66' );
SELECT
	dbo.ShamsiDateChecker ( '1400/12/20' );
SELECT
	dbo.ShamsiDateChecker ( '1401/01d/03' );
SELECT
	dbo.ShamsiDateChecker ( '14011/01/22' );


--- Answer to Question 4

CREATE FUNCTION TerritoryFinder ( @YEAR INT, @MONTH INT, @NAME VARCHAR ( 50 ) ) RETURNS TABLE AS RETURN SELECT DISTINCT
sales.SalesTerritory.NAME AS TerritoryName 
FROM
	Production.Product
	INNER JOIN Sales.SalesOrderDetail ON ( Production.Product.ProductID = Sales.SalesOrderDetail.ProductID )
	INNER JOIN sales.SalesOrderHeader ON ( sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID )
	INNER JOIN sales.SalesTerritory ON ( sales.SalesTerritory.TerritoryID = sales.SalesOrderHeader.TerritoryID ) 
WHERE
	( Production.Product.NAME = @NAME ) 
	AND ( YEAR ( Sales.SalesOrderHeader.OrderDate ) = @YEAR ) 
	AND ( MONTH ( Sales.SalesOrderHeader.OrderDate ) = @MONTH );
	
SELECT
	* 
FROM
	dbo.TerritoryFinder ( 2005, 07, 'Sport-100 Helmet, Black' );
SELECT
	* 
FROM
	dbo.TerritoryFinder ( 2005, 07, 'Mountain-100 Black, 44' );
SELECT
	* 
FROM
	dbo.TerritoryFinder ( 2005, 08, 'Mountain-100 Black, 44' );
SELECT
	* 
FROM
	dbo.TerritoryFinder ( 2005, 07, 'Long-Sleeve Logo Jersey, M' );