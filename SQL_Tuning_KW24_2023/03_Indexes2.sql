SELECT * INTO CustomersNeu FROM Customers

SELECT * INTO OrdersNeu FROM Orders





INSERT INTO OrdersNeu
SELECT  [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], 
[ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry] FROM OrdersNeu
GO 6

SET STATISTICS IO, TIME ON


SELECT * FROM CustomersNeu c
JOIN OrdersNeu o ON c.CustomerID = o.CustomerID
--, CPU-Zeit = 1953 ms, verstrichene Zeit = 8729 ms.

SELECT CompanyName, SUM(Freight) FROM CustomersNeu c
JOIN OrdersNeu o ON c.CustomerID = o.CustomerID
GROUP BY CompanyName
--, CPU-Zeit = 94 ms, verstrichene Zeit = 177 ms.

SELECT OrderID, SUM(Freight) FROM CustomersNeu c
JOIN OrdersNeu o ON c.CustomerID = o.CustomerID
GROUP BY OrderID
--, CPU-Zeit = 1157 ms, verstrichene Zeit = 2516 ms.

SELECT [OrderID], c.[CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], 
[ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry], SUM(Freight) FROM CustomersNeu c
JOIN OrdersNeu o ON c.CustomerID = o.CustomerID
GROUP BY [OrderID], c.[CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], 
[ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]
--, CPU-Zeit = 2453 ms, verstrichene Zeit = 2932 ms. + , CPU-Zeit = 5485 ms, verstrichene Zeit = 6504 ms.

ALTER TABLE CustomersNeu
ADD PRIMARY KEY (CustomerID)

SELECT * from CustoMersNeu c
JOIN OrdersNeu o ON c.CustomerID = o.CustomerID
--, CPU-Zeit = 2641 ms, verstrichene Zeit = 9223 ms.

SELECT OrderID, CompanyName FROM CustomersNeu c
JOIN OrdersNeu o ON c.CustomerID = o.CustomerID

SELECT * FROM CustomersNeu 
CROSS JOIN OrdersNEu

CREATE PROCEDURE 