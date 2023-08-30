-- Change modification date after change of Person's info
CREATE OR ALTER TRIGGER PersonInfo
ON dbo.Person
AFTER UPDATE,INSERT
AS
UPDATE dbo.Person
SET dbo.Person.ModificationDate = GETDATE()
WHERE PersonID IN (SELECT PersonID FROM inserted)


--- Update car Milages above 200000 to 200000 
CREATE OR ALTER TRIGGER LegalCarMilage
ON dbo.[Vehicle]
AFTER UPDATE,INSERT
AS
UPDATE [Vehicle]
SET dbo.[Vehicle].[Milage] = 200000
WHERE (dbo.[Vehicle].[Milage] >= 200000) AND dbo.[Vehicle].Milage IN (SELECT dbo.[Vehicle].Milage FROM inserted)


--- Increment Year by two for ManufacturerID=2 and ModelID=1250
CREATE OR ALTER TRIGGER LegalCarYear
ON [dbo].[vehicle]
AFTER  INSERT
AS
UPDATE [dbo].[vehicle]
SET [dbo].[vehicle].[Year] = (SELECT DATEADD(YEAR, 2, [dbo].[vehicle].[Year]))
WHERE ManufacturerID=2 AND ModelID=1250
		AND ManufacturerID IN (SELECT dbo.[Vehicle].ManufacturerID FROM inserted)
		AND ModelID IN (SELECT dbo.[Vehicle].ModelID FROM inserted)


--- Calculate tax of the Cars based on the countries law suit
CREATE OR ALTER TRIGGER TaxCalculation
ON dbo.[Transaction]
AFTER INSERT
AS
UPDATE dbo.[Transaction]
SET Price = CASE  
                WHEN [Transaction].Currency = 'USD' THEN Price * 1.0575 
                WHEN [Transaction].Currency = 'EUR' THEN Price * 1.2 
				WHEN [Transaction].Currency = 'GBP' THEN Price * 1.22
				WHEN [Transaction].Currency = 'CAD' THEN Price * 1.15
				WHEN [Transaction].Currency = 'JPY' THEN Price * 1.05
				WHEN [Transaction].Currency = 'CNY' THEN Price * 1.1
                ELSE Price
             END 
WHERE VIN IN (SELECT VIN FROM inserted)