--- View Cars detail 
CREATE VIEW [dbo].[CarsDetail]
AS
SELECT
	man.[Name] AS Manufacturer,
	mdl.[Name] AS Model,
	cty.[Name] AS [ChassisType],
	cnt.[Name] AS CountryOfProduction,
	YEAR(vcl.[Year]) AS YearOfProduction,
	vcl.[Milage],
	vcl.[Fuel] AS FuelType,
	clr.[Name] AS ColorName	
FROM 
	dbo.Vehicle AS vcl 
	INNER JOIN dbo.Manufacturer AS man ON vcl.ManufacturerID = man.ManufacturerID
	INNER JOIN dbo.Country AS cnt ON man.CountryID = cnt.CountryID
	INNER JOIN dbo.Model AS mdl ON vcl.ModelID = mdl.ModelID
	INNER JOIN dbo.Car_Type AS cty ON vcl.TypeID = cty.TypeID
	INNER JOIN dbo.Color AS clr ON vcl.ColorID = clr.ColorID;


--- View Sales detail 
CREATE VIEW [dbo].[SalesDetail]
AS
SELECT
	CONCAT(per.FirstName, ' ', per.LastName) AS CustomerFullName,
	per.NationalCode,
	pty.[Name] AS PersonType,
	trntype.[Name] AS TransactionType,
	trn.VIN,
	man.[Name] AS Manufacturer,
	mdl.[Name] AS Model,
	cty.[Name] AS [ChassisType],
	YEAR(vcl.[Year]) AS YearOfProduction,
	vcl.[Milage],
	vcl.[Fuel] AS FuelType,
	trn.[Date] AS DateOfTransaction,
	trn.Price,
	trn.Currency
FROM dbo.[Transaction] AS trn
	INNER JOIN dbo.Vehicle AS vcl ON trn.VIN = vcl.VIN
	INNER JOIN dbo.Manufacturer AS man ON vcl.ManufacturerID = man.ManufacturerID
	INNER JOIN dbo.Country AS cnt ON man.CountryID = cnt.CountryID
	INNER JOIN dbo.Model AS mdl ON vcl.ModelID = mdl.ModelID
	INNER JOIN dbo.Car_Type AS cty ON vcl.TypeID = cty.TypeID
	INNER JOIN dbo.Person AS per ON trn.PersonID = per.PersonID
	INNER JOIN dbo.Person_Type AS pty ON per.PersonTypeID = pty.PersonTypeID
	INNER JOIN dbo.Transaction_Type AS trntype ON trn.TypeCode = trntype.TypeCode;


--- Information about Customers
CREATE VIEW [dbo].[CustomersDetail]
AS
SELECT
	CONCAT(per.FirstName, ' ', per.LastName) AS CustomerFullName,
	per.Gender,
	per.NationalCode,
	per.EmailAddress,
	cty.[Name] AS [City],
	stt.[Name] AS [State],
	cnt.[Name] AS [Country]
FROM
	dbo.Person AS per 
	INNER JOIN dbo.Person_Type AS pty ON per.PersonTypeID = pty.PersonTypeID
	INNER JOIN dbo.City AS cty ON per.CityID = cty.CityID
	INNER JOIN dbo.[State] AS stt ON cty.StateID = stt.StateID
	INNER JOIN dbo.Country AS cnt ON stt.CountryID = cnt.CountryID
WHERE  pty.[Name] = 'Customer';


--- Information about Suppliers
CREATE VIEW [dbo].[SuppliersDetail]
AS
SELECT
	CONCAT(per.FirstName, ' ', per.LastName) AS CustomerFullName,
	per.Gender,
	per.NationalCode,
	per.EmailAddress,
	cty.[Name] AS [City],
	stt.[Name] AS [State],
	cnt.[Name] AS [Country]
FROM
	dbo.Person AS per 
	INNER JOIN dbo.Person_Type AS pty ON per.PersonTypeID = pty.PersonTypeID
	INNER JOIN dbo.City AS cty ON per.CityID = cty.CityID
	INNER JOIN dbo.[State] AS stt ON cty.StateID = stt.StateID
	INNER JOIN dbo.Country AS cnt ON stt.CountryID = cnt.CountryID
WHERE  pty.[Name] = 'Supplier';