/*

tinyint bis 255 


SQL Abfragen laufen über Memory

Die Speicherung von Daten in SQL erfolgt über sog. Pages/Seiten

Jede hat ca. 8kb Speicherplatz; tatsächlich etwas mehr, ist aber für Metadaten reserviert


ID int = 4 byte
char(50) = 50 Byte

Pro Datensatz 54 Byte

SELECT 8000/54

SELECT 148*1000000


1 Page = 8kb; 8 Pages = 1 Block

*/

dbcc showcontig('Customers')


CREATE TABLE Test (
ID int identity,
Zeugs char(4100) )

INSERT INTO Test
VALUES ('abc')
GO 100

SELECT * FROM test

dbcc showcontig('Test')

CREATE TABLE Test2 (
ID int identity,
Zeugs varchar(4100) )

INSERT INTO Test2
VALUES ('abc')
GO 100

dbcc showcontig('Test2')

CREATE TABLE Test3 (
ID smallint identity,
Zeugs varchar(4100) )

INSERT INTO Test3
VALUES ('a')
GO 1000

dbcc showcontig('Test3')

/*
Seite ist voll, bei maximal ca. 8kb Speicherplatz, oder Anzahl von Datensätzen überschreitet 700

*/
SELECT * FROM Test3


SELECT * FROM sys.dm_db_index_physical_stats(db_id(),object_id('Test3'),NULL, NULL, 'detailed')


CREATE TABLE Test4 (
ID smallint identity,
Zeugs varchar(MAX) )

-- LOB Daten - Large Object Data
-- Können nicht gefilter werden, bzw. semantik funktioniert nicht
-- ehemalig war das Datentyp "Text"



SET STATISTICS TIME, IO ON

SELECT * FROM Test
SELECT * FROM Test2


--80% Seitendichte ist gut
