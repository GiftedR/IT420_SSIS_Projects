USE master;

GO

IF EXISTS (SELECT database_id 
FROM sys.databases 
WHERE name = 'ClientWarehouse')
BEGIN

alter database ClientWarehouse set single_user with rollback immediate;

DROP DATABASE ClientWarehouse;


--alter database ClientWarehouse set MULTI_USER

END

GO

CREATE DATABASE ClientWarehouse;

GO

use ClientWarehouse;

GO

CREATE TABLE dbo.ProductTable(
	ProductID int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	ProductName varchar(50) NOT NULL,
	Category varchar(50) NOT NULL,
	Price money NOT NULL,
);

GO

create table dbo.CustomerTable
(
	CustomerID int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	CustomerName nvarchar(100) NOT NULL,
	Region nvarchar(50) NOT NULL,
);

GO

create table dbo.DateTable
(
	DateID int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	FullDate DATE NOT NULL,
	DateMonth as MONTH(FullDate),
	DateQuarter as MONTH(FullDate) / 4,
	DateYear as YEAR(FullDate)
);

GO

create table dbo.FactSales
(
	SalesID int NOT NULL PRIMARY KEY IDENTITY(1, 1),
	CustomerKey int NOT NULL FOREIGN KEY REFERENCES [dbo].[CustomerTable](CustomerID),
	ProductKey int NOT NULL FOREIGN KEY REFERENCES [dbo].[ProductTable](ProductID),
	DateKey int NOT NULL FOREIGN KEY REFERENCES [dbo].[DateTable](DateID),
	Quantity int NOT NULL,
	TotalSaleAmount money NOT NULL
);