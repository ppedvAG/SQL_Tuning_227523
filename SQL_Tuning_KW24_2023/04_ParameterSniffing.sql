--Parameter Sniffing

UPDATE CustomersBig
SET City = 'Bonn'
WHERE Country IN ('France', 'Spain', 'USA', 'Italy', 'Mexico')

CREATE NONCLUSTERED INDEX NCIX_City ON CustomersBig (City)

ALTER PROCEDURE CustomerCity @City varchar(50)
AS
SELECT City FROM CustomersBig
WHERE City = @City

SELECT DISTINCT City FROM CustomersBig

EXEC CustomerCity Bonn

EXEC CustomerCity Caracas



CREATE TABLE Sniffing (
ID int identity,
Buchstabe varchar(10) )

INSERT INTO Sniffing
VALUES ('A')
GO 10

INSERT INTO Sniffing
VALUES ('B')
GO 10

INSERT INTO Sniffing
VALUES ('C')
GO 10000

CREATE CLUSTERED INDEX IX_ID ON Sniffing (ID)

CREATE NONCLUSTERED INDEX NIX_ID ON Sniffing (Buchstabe)


CREATE PROCEDURE spSniffing @Buchstabe varchar(20)
AS
SELECT ID FROM Sniffing
WHERE Buchstabe = @Buchstabe


EXEC spSniffing A WITH RECOMPILE
--WITH RECOMPILE erzwingt neue Plangenerierung


