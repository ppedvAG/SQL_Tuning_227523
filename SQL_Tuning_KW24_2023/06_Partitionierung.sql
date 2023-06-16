--Partitionierung von Tabellen

/*

1. Schritt: Tabelle als Kandidat für Partitionierung? Wenn ja nach welcher Spalte/Wert/Kategorie?
Partitionsgrenzen definieren

2. Schritt: Files und Filegroups erstellen

3. Schritt: Partitionsfunktion schreiben

4. Schritt: Partitionsschema schreiben

5. Schritt: Tabelle endgültig partitionieren

*/


--Dummy Table erstellen
CREATE TABLE Bestellungen (
ID int identity PRIMARY KEY,
BestellDatum date,
BestellWert decimal (10,2) )

INSERT INTO Bestellungen
SELECT 
CAST(getdate()-365*4 + (365*2*RAND() - 365) as date),
CAST(RAND() * 10 + 5  as decimal(10,2))
GO 90000

SELECT MIN(BestellDatum), MAX(BestellDatum) FROM Bestellungen

--Schritt 1, partition für 2018, 2019, 2020 + u.U. Folgejahre



--Schritt 2, entweder über UI, oder syntaktisch:

--Filegroup:
ALTER DATABASE Northwind
ADD FILEGROUP FilegroupName

--File:
ALTER DATABASE Northwind
ADD FILE
	(NAME = [FileName],
	FILENAME = 'C:\usw',
	SIZE = 122,
	AUTOGROWTH
	)
TO FILEGROUP FilegroupName



--Schritt 3: Partitionsfunktion = Definiert Grenzen der Werte der Spalte nach der wir partitionieren wollen
DROP PARTITION FUNCTION fBestellungenJahre
CREATE PARTITION FUNCTION fBestellungenJahre2 (date)
AS
	RANGE LEFT FOR VALUES --oder RIGHT
	('20181231', '20191231', '20201231')


--Schritt 4: Partitionsschema = Verwendet Part.Funkt. und verteilt Datensätze entsprechend der Partitionen
DROP PARTITION SCHEME psBestellungenJahre
CREATE PARTITION SCHEME psBestellungenJahre2
AS PARTITION fBestellungenJahre
TO ('Best2018', 'Best2019', 'Best2020', 'PRIMARY')   --TO FILEGROUP, nicht FILE; Immer eine FILEGROUP mehr als Grenzen!


--Schritt 5: Tabelle Partitionieren

--Für neue Tabelle:
CREATE TABLE jtjt (
id, 
BestellDatum date )
ON psBestellungenJahre (BestellDatum)


--Bei vorhandener Tabelle über neuen Clustered INDEX:

DROP INDEX [PK__Bestellu__3214EC271944E435] ON Bestellungen 
DROP INDEX CIX_Bestellungen_Datum ON Bestellungen

--CIX neu erstellen mit PARTITION SCHEME:
CREATE CLUSTERED INDEX CIX_Bestellungen_Datum
ON Bestellungen (ID)
ON psBestellungenJahre2 (BestellDatum)

SELECT * FROM Bestellungen

SELECT $PARTITION.fBestellungenJahre2(BestellDatum), BestellDatum FROM Bestellungen
WHERE BestellDatum = '20181231'


--Weitere Partitionen nachträglich erstellen:
ALTER PARTITION FUNCTION fBestellungenJahre2 ()
SPLIT RANGE ('20211231')


INSERT INTO Bestellungen
VALUES ('20210505', 12.3)

SELECT $PARTITION.fBestellungenJahre2(BestellDatum), BestellDatum FROM Bestellungen
WHERE BestellDatum = '20210505'

ALTER PARTITION SCHEME psBestellungenJahre2
NEXT USED 'Neue Partition'