/*

LOCKS/BLOCKS/DEADLOCKS

Transaktionen locken die jeweilige Ressource (sperren sie mit einem Schloss)

*/

SELECT * FROM Customers

SELECT * FROM CustomersBig

BEGIN TRAN
DROP TABLE Test
ROLLBACK COMMIT

SELECT @@TRANCOUNT

/*
Es gibt verschiedene Arten von Locks; bzw. Isolation Level
*/

BEGIN TRAN
UPDATE Customers
SET City = 'Bonn'
WHERE CustomerID = 'ALFKI'

SELECT * FROM Customers

--Locking 


CREATE TABLE rechts (
ID int identity,
Zeug varchar(10) )
GO
INSERT INTO rechts
VALUES ('ABC')
GO 5

BEGIN TRAN

UPDATE rechts
SET Zeug = 'ABC'
WHERE ID = 3

UPDATE links
SET Zeug = 'XYZ'
WHERE ID = 3

COMMIT