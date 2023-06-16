SELECT * FROM Customers
WHERE Country = 'France'

SELECT * FROM Customers WITH (NOLOCK)
WHERE Country = 'Germany'


SELECT * FROM Customers
WHERE CustomerID = 'PARIS'

CREATE TABLE links (
ID int identity,
Zeug varchar(10) )
GO
INSERT INTO links
VALUES ('XYZ')
GO 5

BEGIN TRAN

UPDATE rechts
SET Zeug = 'ABC'
WHERE ID = 3

UPDATE links
SET Zeug = 'XYZ'
WHERE ID = 3

COMMIT