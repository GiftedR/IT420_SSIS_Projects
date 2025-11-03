use ClientWarehouse;

go

declare @StartDate date = CAST('2024-12-31' as date);
declare @EndDate date = CAST('2025-12-31' as date);

SELECT p.Category, p.Subcategory, p.ProductName, SUM(f.TotalSaleAmount) AS TotalSales
FROM FactSales f
JOIN DimProduct p ON f.ProductKey = p.ProductKey
WHERE f.SaleDate BETWEEN @StartDate and @EndDate
GROUP BY p.Category, p.Subcategory, p.ProductName
ORDER BY p.Category, p.Subcategory, p.ProductName;