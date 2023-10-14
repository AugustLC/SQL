USE taskdb;
GO

CREATE VIEW dbo.vw_SKUPrice
AS
	SELECT 
		*
		, dbo.udf_GetSKUPrice(Id) As "OneValue"
	FROM dbo.SKU
GO