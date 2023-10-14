USE taskdb;
GO

CREATE TRIGGER dbo.TR_Basket_insert_update ON dbo.Basket
   AFTER INSERT, UPDATE
AS
	DECLARE 
		@Id INT
		, @ID_SKU INT
		, @Count INT

	DECLARE temp_cur CURSOR FOR 
		SELECT 
			Id
			, ID_SKU 
		FROM inserted

	OPEN temp_cur

	FETCH NEXT FROM temp_cur 
	INTO 
		@Id
		, @ID_SKU
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Count = (  
			SELECT COUNT(*) 
			FROM inserted 
			WHERE ID_SKU = @ID_SKU)
			
		IF (@Count > 1)
			UPDATE dbo.Basket 
			SET DiscountValue = Value * 0.05 
			WHERE Id = @Id
		ELSE
			UPDATE dbo.Basket 
			SET DiscountValue = 0 
			WHERE Id = @Id

		FETCH NEXT 
		FROM temp_cur 
		INTO @Id, @ID_SKU
	END

	CLOSE temp_cur
	DEALLOCATE temp_cur
GO