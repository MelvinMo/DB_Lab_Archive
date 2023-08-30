---- DATABASE DESIGN 1 LAB 07 @ IUT
---- FULL NAME: Melvin Mokhtari
---- STUDENT ID: 9831143


--- Answer to Question 1

--Getting .txt output from the SalesTerritory table

exec xp_cmdshell 'bcp AdventureWorks2012.Sales.SalesTerritory out C:\Users\Win10\Desktop\7\Question1.txt -T -c -t^|'

--Creating SalesTerritoryNew table

CREATE TABLE [Sales].[SalesTerritoryNew](
	[TerritoryID] [int],
	[Name] [dbo].[Name],
	[CountryRegionCode] [nvarchar](3),
	[Group] [nvarchar](50),
	[SalesYTD] [money],
	[SalesLastYear] [money],
	[CostYTD] [money],
	[CostLastYear] [money],
	[rowguid] [uniqueidentifier],
	[ModifiedDate] [datetime]
);

--Inserting data into the new table

BULK INSERT [Sales].[SalesTerritoryNew]
FROM 'C:\Users\Win10\Desktop\7\Question1.txt'
WITH
(
    fieldterminator = '|'
)

--Displaying the new table

SELECT * FROM [Sales].[SalesTerritoryNew]
	
	
--- Answer to Question 2

exec xp_cmdshell 'bcp "SELECT Name, TerritoryID FROM AdventureWorks2012.Sales.SalesTerritory" queryout C:\Users\Win10\Desktop\7\Question2.txt -T -c -t^|'

	
--- Answer to Question 3

exec xp_cmdshell 'bcp AdventureWorks2012.Production.Location out C:\Users\Win10\Desktop\7\location.dat -T -c -t^|'


--- Answer to Question 4

--Displaying the results

SELECT [Name],
	Demographics.query ( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	for $x in /StoreSurvey
	return 
	<AnnualSales>
	{$x/AnnualSales}
</AnnualSales>' ) AS AnnualSales,
Demographics.query ( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	for $y in /StoreSurvey 
	return 
	<YearOpened>
	{$y/YearOpened}
</YearOpened>' ) AS YearOpened,
Demographics.query ( 'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey";
	for $z in /StoreSurvey
	return  
	<NumberEmployees>
	{$z/NumberEmployees}
</NumberEmployees>' ) AS NumberEmployees 
FROM Sales.Store

--Getting .txt output of the given query

exec xp_cmdshell 'bcp "select Name, Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $x in /StoreSurvey return <AnnualSales>{$x/AnnualSales}</AnnualSales>'') as AnnualSales,Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $y in /StoreSurvey return <YearOpened>{$y/YearOpened}</YearOpened>'') as YearOpened,Demographics.query(''declare default element namespace \"http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey\";for $z in /StoreSurvey return <NumberEmployees>{$z/NumberEmployees}</NumberEmployees>'') as NumberEmployees from AdventureWorks2012.Sales.Store" queryout C:\Users\Win10\Desktop\7\Question4.txt -T -c -q -t^|'