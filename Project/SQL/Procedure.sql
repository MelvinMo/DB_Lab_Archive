-- Buy car with VIN FROM inventory
CREATE OR ALTER PROCEDURE CustomerBuyFromInv    @PersonID INT,
												@VIN nchar(50),
												@Price INT,
												@Currency nchar(50)
AS
BEGIN
		IF EXISTS(	SELECT * 
					FROM	[dbo].[Transaction]	AS trn1
							INNER JOIN [dbo].[Vehicle] AS vcl1 ON (trn1.VIN=vcl1.VIN)
							INNER JOIN [dbo].[Person] AS per1 ON (trn1.PersonID=per1.PersonID)
					WHERE	vcl1.VIN=@VIN AND
							per1.PersonTypeID = 1 AND
							trn1.TypeCode = 1)
			INSERT INTO [dbo].[Transaction] ([TypeCode], [PersonID], [VIN], [Date], [Price], [Currency])
			VALUES (1, @PersonID, @VIN, GETDATE(), @Price, @Currency);
END
GO
EXEC CustomerBuyFromInv 5000, 'FA493B5A-1640-4892-9B31-1B2A26AB57FE', 20000, 'USD'


--- The Procedure to add a new person into the Database
CREATE OR ALTER PROCEDURE AddNewPerson		@PersonTypeName nchar(50),
											@NationalCode INT,
											@FirstName nchar(50),
											@LastName nchar(50),
											@Gender nchar(50),
											@CityName nchar(50),
											@StateName nchar(50),
											@CountryName nchar(50),
											@EmailAddress nchar(50)
AS
	DECLARE
		@CountryID		INT = 0,
		@StateID		INT = 0,
		@CityID			INT = 0,
		@PersonTypeID	INT = 0
BEGIN

	---CountryID Fetched
	SET @CountryID = (SELECT cnt1.CountryID FROM [dbo].[Country] AS cnt1 WHERE cnt1.[Name]=@CountryName);

	---StateID Fetched
	IF EXISTS(SELECT * FROM [dbo].[State] AS stt1 WHERE stt1.[Name]=@StateName)
		SET @StateID = (SELECT stt2.StateID FROM [dbo].[State] AS stt2 WHERE stt2.[Name]=@StateName);
	ELSE
		BEGIN
		INSERT INTO [dbo].[State] ([Name], [CountryID])
			VALUES (@StateName, @CountryID);
		END
		SET @StateID = (SELECT stt3.StateID FROM [dbo].[State] AS stt3 WHERE stt3.[Name]=@StateName);
	
	--- CityID Fetched
	IF EXISTS(SELECT * FROM [dbo].[City] AS cty1 WHERE cty1.[Name]=@CityName)
		SET @CityID = (SELECT cty2.StateID FROM [dbo].[City] AS cty2 WHERE cty2.[Name]=@CityName);
	ELSE
		BEGIN
		INSERT INTO [dbo].[City] ([Name], [StateID])
			VALUES (@CityName, @StateID);
		END
		SET @CityID = (SELECT cty3.CityID FROM [dbo].[City] AS cty3 WHERE cty3.[Name]=@CityName);

	--- Final Insert
	SET @PersonTypeID = CASE	WHEN @PersonTypeName = 'Customer' THEN 1
								WHEN @PersonTypeName = 'Supplier' THEN 2
								ELSE 0
						END

	INSERT INTO [dbo].[Person]
           ([PersonTypeID] ,[NationalCode] ,[FirstName] ,[LastName] ,[Gender] ,[CityID] ,[EmailAddress] ,[ModificationDate])
      VALUES
           (@PersonTypeID, @NationalCode, @FirstName, @LastName, @Gender, @CityID, @EmailAddress, GETDATE());

END
GO
EXEC AddNewPerson 'Customer', '1276194344', 'Sepehr', 'Khodadadi', 'Male', 'Isfahan', 'Esfahan', 'Iran', 'sepehrkhodadadi@ec.iut.ac.ir';


--- Change the currency FROM SourceCurrency to DestinationCurrency
CREATE OR ALTER PROCEDURE ChangeCurrency	    @SourceCurrency nchar(50),
												@DestinationCurrency nchar(50)	
AS
BEGIN		
	
	UPDATE [dbo].[Transaction]
	SET Currency = @DestinationCurrency
	WHERE Currency = @SourceCurrency;
END
GO
EXEC ChangeCurrency 'AFN', 'IRR';