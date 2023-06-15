-- FROM Clause

SELECT * FROM dbo.Customer ;

-- The FIELD LIST

SELECT CustomerNumber, Name, BillingCity
FROM dbo.Customer ;


SELECT DISTINCT BillingCity
FROM dbo.Customer ;


-- The JOIN CLAUSE


SELECT c.CustomerNumber, c.Name, c.BillingCity, ih.InvoiceNumber, ih.TotalAmount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber ;


SELECT c.CustomerNumber, c.Name, c.BillingCity, ih.InvoiceNumber, ih.TotalAmount, ld.Discount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	INNER JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber ;


SELECT c.CustomerNumber, c.Name, c.BillingCity, ih.InvoiceNumber, ih.TotalAmount, ld.Discount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	LEFT JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber ;

-- The WHERE Clause

SELECT c.CustomerNumber, c.Name, c.BillingCity, ih.InvoiceNumber, ih.TotalAmount, ld.Discount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	LEFT JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber 
WHERE c.BillingCity = 'Axelburg' ;


SELECT c.CustomerNumber, c.Name, c.BillingCity, ih.InvoiceNumber, ih.TotalAmount, ld.Discount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	LEFT JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber 
WHERE c.BillingCity = 'Axelburg' AND c.Name > 'C' ;


-- The ORDER BY Clause

SELECT c.CustomerNumber, c.Name, c.BillingCity, ih.InvoiceNumber, ih.TotalAmount, ld.Discount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	LEFT JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber 
WHERE c.BillingCity = 'Axelburg' AND c.Name > 'C' 
ORDER BY c.Name DESC, ih.InvoiceNumber ;


-- Constant and Calculated Fields

SELECT c.CustomerNumber, c.Name, c.BillingCity, ih.InvoiceNumber, ih.TotalAmount, ld.Discount, 'AXEL' AS ProcessingCode
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	LEFT JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber 
WHERE c.BillingCity = 'Axelburg' AND c.Name > 'C' 
ORDER BY c.Name DESC, ih.InvoiceNumber ;


SELECT c.CustomerNumber, c.Name, c.BillingCity, ih.InvoiceNumber, ih.TotalAmount, ld.Discount, 
	ih.TotalAmount - (ih.TotalAmount * ld.Discount) AS DiscountedTotalAmount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	LEFT JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber 
WHERE c.BillingCity = 'Axelburg' AND c.Name > 'C' 
ORDER BY c.Name DESC, ih.InvoiceNumber ;


SELECT c.CustomerNumber, c.Name, c.BillingCity, ih.InvoiceNumber, ih.TotalAmount, ld.Discount, 
	ih.TotalAmount - (ih.TotalAmount * ISNULL(ld.Discount, 0.00)) AS DiscountedTotalAmount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	LEFT JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber 
WHERE c.BillingCity = 'Axelburg' AND c.Name > 'C' 
ORDER BY c.Name DESC, ih.InvoiceNumber ;


-- The GROUP BY Clause

SELECT c.CustomerNumber, c.Name, c.BillingCity, COUNT(ih.InvoiceNumber) AS NumberOfInvoices, SUM(ih.TotalAmount) AS TotalAmount, ld.Discount, 
	SUM(ih.TotalAmount - (ih.TotalAmount * ISNULL(ld.Discount, 0.00))) AS DiscountedTotalAmount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	LEFT JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber 
WHERE c.BillingCity = 'Axelburg' AND c.Name > 'C' 
GROUP BY c.CustomerNumber, c.Name, c.BillingCity, ld.Discount
ORDER BY c.Name ;


-- The HAVING Clause

SELECT c.CustomerNumber, c.Name, c.BillingCity, COUNT(ih.InvoiceNumber) AS NumberOfInvoices, SUM(ih.TotalAmount) AS TotalAmount, ld.Discount, 
	SUM(ih.TotalAmount - (ih.TotalAmount * ISNULL(ld.Discount, 0.00))) AS DiscountedTotalAmount
FROM dbo.Customer c
	INNER JOIN dbo.InvoiceHeader ih
		ON c.CustomerNumber = ih.CustomerNumber 
	LEFT JOIN dbo.LoyaltyDiscount ld
		ON c.CustomerNumber = ld.CustomerNumber 
WHERE c.BillingCity = 'Axelburg' AND c.Name > 'C' 
GROUP BY c.CustomerNumber, c.Name, c.BillingCity, ld.Discount
HAVING COUNT(ih.InvoiceNumber) >= 2 
ORDER BY c.Name ;
