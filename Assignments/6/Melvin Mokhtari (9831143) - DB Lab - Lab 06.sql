---- DATABASE DESIGN 1 LAB 06 @ IUT
---- FULL NAME: Melvin Mokhtari
---- STUDENT ID: 9831143


--- Answer to Question 1 - Create Table

CREATE TABLE [Production].[ProductLogs](
	[ProductID] [int],
	[Name] [dbo].[Name],
	[ProductNumber] [nvarchar](25),
	[MakeFlag] [dbo].[Flag],
	[FinishedGoodsFlag] [dbo].[Flag],
	[Color] [nvarchar](15),
	[SafetyStockLevel] [smallint],
	[ReorderPoint] [smallint],
	[StandardCost] [money],
	[ListPrice] [money],
	[Size] [nvarchar](5),
	[SizeUnitMeasureCode] [nchar](3),
	[WeightUnitMeasureCode] [nchar](3),
	[Weight] [decimal](8, 2),
	[DaysToManufacture] [int],
	[ProductLine] [nchar](2),
	[Class] [nchar](2),
	[Style] [nchar](2),
	[ProductSubcategoryID] [int],
	[ProductModelID] [int],
	[SellStartDate] [datetime],
	[SellEndDate] [datetime],
	[DiscontinuedDate] [datetime],
	[rowguid] [uniqueidentifier],
	[ModifiedDate] [datetime],
	[ModificationType] [varchar](20)
	);


--- Answer to Question 1

CREATE TRIGGER LogsTrigger ON Production.Product
AFTER DELETE,INSERT,UPDATE
AS
DECLARE	@ModificationType VARCHAR ( 20 )
IF
	NOT EXISTS ( SELECT * FROM deleted ) 
	AND EXISTS ( SELECT * FROM inserted )
	BEGIN
		SET @ModificationType = 'INSERT' INSERT INTO Production.ProductLogs
		SELECT *, @ModificationType 
	FROM
		inserted 
	END
	IF EXISTS ( SELECT * FROM deleted ) 
	AND EXISTS ( SELECT * FROM inserted )
	BEGIN
		SET @ModificationType = 'UPDATE' INSERT INTO Production.ProductLogs
		SELECT *, @ModificationType 
	FROM
		inserted 
	END
	IF EXISTS ( SELECT * FROM deleted ) 
	AND NOT EXISTS ( SELECT * FROM inserted )
	BEGIN	
		SET @ModificationType = 'DELETE' INSERT INTO Production.ProductLogs
		SELECT *, @ModificationType 
	FROM
		deleted 
	END
	
	
--- Answer to Question 1 - Testing
	
INSERT INTO Production.Product (
	Name,
	ProductNumber,
	MakeFlag,
	FinishedGoodsFlag,
	Color,
	SafetyStockLevel,
	ReorderPoint,
	StandardCost,
	ListPrice,
	Size,
	SizeUnitMeasureCode,
	WeightUnitMeasureCode,
	Weight,
	DaysToManufacture,
	ProductLine,
	Class,
	Style,
	ProductSubcategoryID,
	ProductModelID,
	SellStartDate,
	SellEndDate,
	DiscontinuedDate,
	rowguid,
	ModifiedDate 
)
VALUES
	(
		'MelvinMokhGG',
		'CG-1344',
		0,
		0,
		'Red',
		1,
		10,
		900.35,
		1000.50,
		'Big',
		NULL,
		NULL,
		350,
		0,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		'2021-04-19 00:00:00.000',
		NULL,
		NULL,
		'd436cf99-7155-461c-8b06-1d585ab41b57',
		'2022-04-20 03:27:47' 
	);
SELECT
	* 
FROM
	Production.ProductLogs;
UPDATE Production.Product 
SET ProductNumber = 'GG-8001' 
WHERE
	ProductNumber = 'CG-1344';
DELETE 
FROM
	Production.Product 
WHERE
	NAME = 'MelvinMokhGG';
SELECT
	* 
FROM
	Production.ProductLogs;


--- Answer to Question 2

SELECT *
INTO Production.ProductLogsQ2 
FROM
	Production.ProductLogs;
SELECT * 
FROM
	Production.ProductLogsQ2;
UPDATE Production.ProductLogsQ2 
SET NAME = 'MelvinCC' 
WHERE
	NAME = 'MelvinMokhGG';
UPDATE Production.ProductLogsQ2 
SET rowguid = '84fdad17-7866-4cbb-bab7-535769a8a2ae' 
WHERE
	rowguid = 'd436cf99-7155-461c-8b06-1d585ab41b57';
UPDATE Production.ProductLogsQ2 
SET ModificationType = 'DLT' 
WHERE
	ModificationType = 'DELETE';

	
--- Answer to Question 3

CREATE PROCEDURE Differences
AS
BEGIN
	IF (EXISTS ( SELECT * FROM Production.ProductLogsQ3 ))
	BEGIN
		DELETE 
		FROM
			Production.ProductLogsQ3;
	END;
	WITH Temp AS ( SELECT * FROM Production.ProductLogs EXCEPT SELECT * FROM Production.ProductLogsQ2 )
	INSERT INTO Production.ProductLogsQ3
	SELECT * 
	FROM
		Temp 
END
SELECT * INTO Production.ProductLogsQ3 
FROM
	Production.ProductLogs 
WHERE
	1 <> 1;
EXECUTE Differences;
SELECT * 
FROM
	Production.ProductLogsQ3;