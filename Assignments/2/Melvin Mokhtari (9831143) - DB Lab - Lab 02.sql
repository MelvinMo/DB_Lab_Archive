---- DATABASE DESIGN 1 Lab 02 @ IUT
---- FULL NAME: Melvin Mokhtari
---- STUDENT ID: 9831143


--- Answer to Question 1

SELECT
	* 
FROM
	( Sales.SalesOrderHeader INNER JOIN Sales.SalesTerritory ON Sales.SalesOrderHeader.TerritoryID = Sales.SalesTerritory.TerritoryID ) 
WHERE
	( status = 5 AND TotalDue >= 100000 AND TotalDue <= 500000 AND ( name = 'France' OR "group" = 'North America' ) );


--- Answer to Question 2

SELECT
	SalesOrderID,
	CustomerID,
	TotalDue,
	OrderDate,
	Name 
FROM
	( Sales.SalesOrderHeader INNER JOIN Sales.SalesTerritory ON Sales.SalesOrderHeader.TerritoryID = Sales.SalesTerritory.TerritoryID );
	

--- Answer to Question 3

SELECT DISTINCT
	Temp_1.* 
FROM
	(
	SELECT
		ProductID,
		COUNT ( OrderQty ) AS Quantity,
		TerritoryID 
	FROM
		Sales.SalesOrderHeader
		INNER JOIN Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID 
	GROUP BY
		TerritoryID,
		ProductID 
	) AS Temp_1
	INNER JOIN (
	SELECT
		ProductID,
		MAX ( Quantity ) AS MaximumQuantity 
	FROM
		(
		SELECT
			ProductID,
			TerritoryID,
			COUNT ( OrderQty ) AS Quantity 
		FROM
			Sales.SalesOrderHeader
			INNER JOIN Sales.SalesOrderDetail ON Sales.SalesOrderHeader.SalesOrderID = Sales.SalesOrderDetail.SalesOrderID 
		GROUP BY
			TerritoryID,
			ProductID 
		) AS Temp_2 
	GROUP BY
		ProductID 
	) AS Temp_3 ON Temp_1.ProductID = Temp_3.ProductID 
	AND Temp_1.Quantity = Temp_3.MaximumQuantity 
ORDER BY
	ProductID;
	

--- Answer to Question 4

WITH Temp_1 ( SalesOrderID, OrderDate, Status, CustomerID, SubTotal, TotalDue, TerritoryID, Name, CountryRegionCode, "Group" ) AS (
	SELECT
		SalesOrderID,
		OrderDate,
		Status,
		CustomerID,
		SubTotal,
		TotalDue,
		sales.SalesOrderHeader.TerritoryID,
		Name,
		CountryRegionCode,
		sales.SalesTerritory."group" 
	FROM
		sales.SalesOrderHeader
		INNER JOIN sales.SalesTerritory ON ( sales.SalesOrderHeader.TerritoryID = sales.SalesTerritory.TerritoryID ) 
	WHERE
		( sales.SalesOrderHeader.Status = 5 ) 
		AND ( sales.SalesOrderHeader.TotalDue > 100000 AND sales.SalesOrderHeader.TotalDue < 500000 ) 
		AND ( sales.SalesTerritory.Name = 'France' OR sales.SalesTerritory."Group" = 'North America' ) 
	) SELECT
	* INTO NAmerica_Sales 
FROM
	Temp_1;
DELETE 
FROM
	NAmerica_Sales 
WHERE
	Name = 'France';
ALTER TABLE NAmerica_Sales ADD Price_Category CHAR ( 4 ) CHECK ( Price_Category IN ( 'LOW', 'MID', 'HIGH' ) );
WITH Temp_2 ( TotalDue_AVG ) AS (
	SELECT AVG
		( TotalDue ) 
	FROM
		sales.SalesOrderHeader
		INNER JOIN sales.SalesTerritory ON ( sales.SalesOrderHeader.TerritoryID = sales.SalesTerritory.TerritoryID ) 
	WHERE
		sales.SalesTerritory."Group" = 'North America' 
		AND ( sales.SalesOrderHeader.TotalDue > 100000 AND sales.SalesOrderHeader.TotalDue < 500000 ) 
	) UPDATE NAmerica_Sales 
	SET Price_Category = ( CASE WHEN TotalDue < TotalDue_AVG THEN 'LOW' WHEN TotalDue = TotalDue_AVG THEN 'MID' WHEN TotalDue > TotalDue_AVG THEN 'HIGH' END ) 
	FROM
		NAmerica_Sales,
		Temp_2;
	SELECT
		* 
FROM
	NAmerica_Sales;
	
	
--- Answer to Question 5

	WITH Temp_1 ( BusinessEntityID, NewSalary ) AS ( SELECT BusinessEntityID, MAX ( Rate ) FROM HumanResources.EmployeePayHistory GROUP BY BusinessEntityID ),
Temp_2 ( BusinessEntityID, NewSalary, LEVEL ) AS (
	SELECT
		BusinessEntityID,
		NewSalary,
	CASE
			
			WHEN NewSalary < 29.0000 THEN
			3 
			WHEN NewSalary >= 29.0000 
			AND NewSalary < 50.0000 THEN
				2 
				WHEN NewSalary >= 50.0000 THEN
				1 
		END AS LEVEL 
		FROM
			Temp_1 
		),
		Temp_AVG ( Average_Salary ) AS ( SELECT AVG ( NewSalary ) FROM Temp_2 ),
		Temp_3 ( BID, NewSalary, LEVEL ) AS (
		SELECT
			BusinessEntityID,
		CASE
				
				WHEN NewSalary <= Average_Salary / 2 THEN
				( NewSalary + ( NewSalary * 20 ) / 100 ) 
				WHEN NewSalary > Average_Salary / 2 
				AND NewSalary <= Average_Salary THEN
					( NewSalary + ( NewSalary * 15 ) / 100 ) 
					WHEN NewSalary > Average_Salary 
					AND NewSalary <= Average_Salary + Average_Salary / 2 THEN
						( NewSalary + ( NewSalary * 10 ) / 100 ) 
						WHEN NewSalary > Average_Salary + Average_Salary / 2 THEN
						( NewSalary + ( NewSalary * 5 ) / 100 ) 
					END,
				LEVEL 
				FROM
					Temp_2,
					Temp_AVG 
				) SELECT
				* 
			FROM
				Temp_3 
		ORDER BY
	BID;