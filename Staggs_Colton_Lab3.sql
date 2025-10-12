USE master;

GO

DROP DATABASE IF EXISTS [OrdersWarehouse];
GO

CREATE DATABASE [OrdersWarehouse];

GO

USE [OrdersWarehouse];

GO

CREATE TABLE [dbo].[DimCustomer]
(
	CustomerID int NOT NULL PRIMARY KEY,
	CustomerName NVARCHAR(50) NOT NULL,
	Region NVARCHAR(50) NOT NULL
);

GO

BULK INSERT [dbo].[DimCustomer]
FROM '\\tsclient\home\Documents\Projects\School\IT420\W3-Star_Schema\Customers.csv' -- Replace with customer csv path
WITH (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a', -- Bug with '\n', instead hex code works
	FIRSTROW = 2
);

GO

CREATE TABLE [dbo].[DimProduct]
(
	ProductID int NOT NULL PRIMARY KEY,
	ProductName NVARCHAR(50) NOT NULL,
	Category NVARCHAR(50) NOT NULL
);

GO


BULK INSERT [dbo].[DimProduct]
FROM '\\tsclient\home\Documents\Projects\School\IT420\W3-Star_Schema\Products.csv' -- Replace with products csv path
WITH (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a', -- Bug with '\n', instead hex code works
	FIRSTROW = 2
);

GO

CREATE TABLE [dbo].[FactOrders]
(
	OrderID int NOT NULL PRIMARY KEY,
	CustomerKey int FOREIGN KEY REFERENCES [dbo].[DimCustomer](CustomerID),
	ProductKey int FOREIGN KEY REFERENCES [dbo].[DimProduct](ProductID),
	Quantity int NOT NULL,
	OrderAmount MONEY NOT NULL
);

GO


BULK INSERT [dbo].[FactOrders]
FROM '\\tsclient\home\Documents\Projects\School\IT420\W3-Star_Schema\Orders.csv' -- Replace with facts csv path
WITH (
	FIELDTERMINATOR = ',',
	ROWTERMINATOR = '0x0a', -- Bug with '\n', instead hex code works
	FIRSTROW = 2
);

GO


SELECT COUNT(*) FROM [dbo].[DimCustomer];
SELECT COUNT(*) FROM [dbo].[DimProduct];
SELECT COUNT(*) FROM [dbo].[FactOrders];
