---- DATABASE DESIGN 1 Lab 04 @ IUT
---- FULL NAME: Melvin Mokhtari
---- STUDENT ID: 9831143


--- Answer to Question 2

SELECT
CASE		
	WHEN
		Temp_1.NAME IS NULL THEN
			'All Territries' ELSE Temp_1.NAME 
			END AS TerritoryName,
	CASE			
			WHEN Temp_1.[Group] IS NULL THEN
			'All Regions' ELSE Temp_1.[Group] 
		END AS Region,
		SUM( Temp_2.SubTotal ) AS SalesTotal,
		COUNT( Temp_2.SalesOrderID ) AS SalesCount 
	FROM
		Sales.SalesOrderHeader AS Temp_2
		INNER JOIN Sales.SalesTerritory AS Temp_1 ON Temp_2.TerritoryID = Temp_1.TerritoryID 
	GROUP BY
		ROLLUP (
		Temp_1.[Group],
	Temp_1.NAME);


--- Answer to Question 3

SELECT
CASE		
	WHEN
		Temp_1.NAME IS NULL THEN
			'All Subcategories' ELSE Temp_1.NAME 
			END AS SubCategory,
	CASE			
			WHEN Temp_2.NAME IS NULL THEN
			'All Categories' ELSE Temp_2.NAME 
		END AS Category,
		SUM( Temp_4.OrderQty ) AS SalesCount,
		SUM( Temp_4.LineTotal ) AS SalesTotal 
	FROM
		(
			Sales.SalesOrderHeader AS Temp_3
			INNER JOIN Sales.SalesOrderDetail AS Temp_4 ON Temp_3.SalesOrderID = Temp_4.SalesOrderID
			INNER JOIN Production.Product AS Temp_5 ON Temp_4.ProductID = Temp_5.ProductID
			INNER JOIN Production.ProductSubcategory AS Temp_1 ON Temp_5.ProductSubcategoryID = Temp_1.ProductSubcategoryID
			INNER JOIN Production.ProductCategory AS Temp_2 ON Temp_1.ProductCategoryID = Temp_2.ProductCategoryID 
		) 
	GROUP BY
		ROLLUP (
		Temp_2.NAME,
	Temp_1.NAME);
	

--- Answer to Question 4

SELECT
	FirstName,
	NationalIDNumber,
	Gender,
	MaritalStatus,
	JobTitle,
	Quantity 
FROM
	(
	SELECT
		Temp_1.FirstName,
		Temp_2.NationalIDNumber,
		Temp_2.Gender,
	CASE
			Temp_2.MaritalStatus 
			WHEN 'M' THEN
			'Married' 
			WHEN 'S' THEN
			'Single' ELSE '' 
		END AS MaritalStatus,
		Temp_2.JobTitle,
		(
		SELECT
			count( Temp_3.JobTitle ) 
		FROM
			person.Person Temp_1
			INNER JOIN HumanResources.Employee Temp_3 ON Temp_1.BusinessEntityID = Temp_3.BusinessEntityID 
		WHERE
			Temp_3.JobTitle = Temp_2.JobTitle 
		GROUP BY
			Temp_3.JobTitle 
		) AS Quantity 
	FROM
		person.Person Temp_1
		INNER JOIN HumanResources.Employee Temp_2 ON Temp_1.BusinessEntityID = Temp_2.BusinessEntityID 
	) Temp 
WHERE
	Quantity > 3;