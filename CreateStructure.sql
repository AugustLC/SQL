CREATE DATABASE taskdb;
GO

USE taskdb;

CREATE TABLE dbo.SKU
(
	ID INT PRIMARY KEY IDENTITY,
	Code AS (CONCAT('s', CAST(ID AS nvarchar))) UNIQUE,
	Name NVARCHAR(20) NOT NULL
);

CREATE TABLE dbo.Family
(
	ID INT PRIMARY KEY IDENTITY,
	SurName nvarchar(50) NOT NULL,
	BudgetValue MONEY DEFAULT 0
);

CREATE TABLE dbo.Basket
(
	ID INT PRIMARY KEY IDENTITY,
	ID_SKU INT,
	ID_Family INT,
	Quantity INT CHECK(Quantity >= 0),
	Value MONEY CHECK(Value >= 0),
	PurchaseDate DATE NOT NULL DEFAULT GETDATE(),
	DiscountValue MONEY DEFAULT 0,
	FOREIGN KEY (ID_SKU) REFERENCES dbo.SKU (Id),
	FOREIGN KEY (ID_Family) REFERENCES dbo.Family (Id)
);