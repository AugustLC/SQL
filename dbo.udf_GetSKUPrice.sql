USE taskdb;
GO

CREATE FUNCTION dbo.udf_GetSKUPrice
	(@ID_SKU int)
RETURNS decimal(18, 2)
AS
	BEGIN
		DECLARE 
			@result decimal(18, 2)

		SELECT
			@result=Value / Quantity 
		FROM dbo.SKU 
			INNER JOIN dbo.Basket ON dbo.SKU.Id = ID_SKU
		WHERE dbo.SKU.Id = @ID_SKU

		RETURN @result
	END