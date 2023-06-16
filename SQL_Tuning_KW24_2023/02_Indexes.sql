SELECT * FROM Customers


SELECT * FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID


SELECT * FROM Test

SELECT * FROM Test
WHERE ID = 10

CREATE TABLE IndexMaybe (
ID int identity PRIMARY KEY,
Zeugs varchar(50) )

INSERT INTO IndexMaybe
VALUES ('Hallo')
GO 10000

SELECT * FROM IndexMaybe

SELECT * FROM IndexMaybe
WHERE ID = 100

SET STATISTICS IO, TIME ON
-- Das erstellen eines PS erstellt auch automatisch einen gruppierten Index auf die selbe Spalte

SELECT * FROM IndexMaybe
WHERE ID BETWEEN 50 AND 200


--Arten von Indizes/Indexes:
/*
0. HEAP bzw. einfach ein Haufen
- Table ohne Index bzw. ohne CIX ist ein unsortierter HEAP
- Datensätze sind NICHT sortiert, auch wenn es in der Ausgabe vllt so wirkt

1. gruppierten Index/clustered Index/CIX
- Wird automatisch erstellt wenn ein Primärschlüssel erstellt wird, und noch kein CIX auf der Tabelle existiert 
- Es kann nur einen geben!
- CIX ist quasi die neue Tabelle, wird physisch im DatabaseFile neu sortiert

2. nicht-gruppierter Index/non-clustered Index/NCIX
- quasi unendlich viele pro Tabelle (eigentlich bis zu ca. 1000)
- "sind eine Kopie" der Tabelle
- verweisen auf die Pages im CIX, wo die Datensätze zu finden sind

3. Columnstore Indexes

"Grundregeln":
- Tabellen auf denen viel geschrieben wird, lieber nicht bzw. wenig indizieren
- Tabellen die viel gelesen werden, eignen sich gut für Indizes
- Spalten die sehr oft gefiltert werden, und insbesondere Spalten die in Joins verwendet werden, sind gute Kandidaten für NCIX
- ID Spalten (Primärschlüsselspalten) gute Kandidaten für CIX
*/

ALTER TABLE test
ADD PRIMARY KEY (ID)

SELECT * FROM test
WHERE ID = 50


SELECT * INTO Customers2 FROM Customers

ALTER TABLE Customers2
ADD PRIMARY KEY (CustomerID)

CREATE CLUSTERED INDEX CIX_Country ON Customers2 (Country)

CREATE CLUSTERED INDEX CIX_City ON Customers2 (City)

DROP INDEX CIX_Country ON Customers2

SELECT * FROM Customers2
WHERE Country = 'France'

--Grundsätzlich SEEK = Gut, SCAN = schlecht


SELECT * FROM Customers
WHERE CITY = 'Bonn'

SELECT * FROM Orders2
WHERE OrderID = 10288

SELECT * INTO Orders2 FROM Orders

INSERT INTO Customers2
SELECT * FROM Customers

SELECT * INTO CustomersBig FROM Customers

INSERT INTO CustomersBig
SELECT * FROM Customers

INSERT INTO CustomersBig
SELECT * FROM CustomersBig

SET STATISTICS IO, TIME ON


SELECT * FROM CustomersBig
WHERE City = 'Bonn'

SELECT CompanyName, City FROM CustomersBig
WHERE City = 'Bonn'

SELECT CompanyName, City FROM CustomersBig
WHERE Country = 'Germany'

