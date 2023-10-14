USE taskdb;
GO

CREATE PROCEDURE dbo.usp_MakeFamilyPurchase
	(@FamilySurName varchar(255))
AS
	IF EXISTS ( 
		SELECT Id 
		FROM dbo.Family 
		WHERE SurName = @FamilySurName)

		BEGIN
			DECLARE 
				@sum money
				, @Id int

			SET @Id = ( 
				SELECT Id 
				FROM dbo.Family 
				WHERE SurName = @FamilySurName)

			SET @sum = (
				SELECT SUM(Value) 
				From dbo.Basket 
				WHERE ID_Family = @Id)

			UPDATE dbo.Family 
			SET BudgetValue = BudgetValue - @sum
			WHERE Id = @Id
		END
	ELSE
		PRINT 'Семьи с такой фамилией нет в базе данных'
GO