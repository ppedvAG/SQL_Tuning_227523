--Daten komprimieren über Data Compression

EXEC sp_estimate_data_compression_savings dbo, Bestellungen, NULL, NULL, ROW --PAGE
EXEC sp_estimate_data_compression_savings dbo, Bestellungen, NULL, NULL, PAGE 


SET STATISTICS IO,TIME ON

SELECT * FROM Bestellungen
-- CPU-Zeit = 62 ms, verstrichene Zeit = 638 ms.; Anzahl von Überprüfungen: 4, logische Lesevorgänge: 320,


ALTER TABLE Bestellungen
REBUILD PARTITION = ALL --alternativ Nummer der jeweiligen Partition angeben
WITH (DATA_COMPRESSION = PAGE) --oder ROW

SELECT * FROM Bestellungen
--, CPU-Zeit = 78 ms, verstrichene Zeit = 519 ms.;  Anzahl von Überprüfungen: 4, logische Lesevorgänge: 187,

--Indexes compressen:
ALTER INDEX CIX_Name
REBUILD PARTITION = ALL
WITH (DATA_COMPRESSION = PAGE/ROW)


SELECT * FROM sys.dm_db_index_physical_stats(db_id(),object_id('Bestellungen'),NULL, NULL, 'detailed')




SELECT * FROM sys.dm_db_index_physical_stats(db_id(),object_id('test'),NULL, NULL, 'detailed')
EXEC sp_estimate_data_compression_savings dbo, test, NULL, NULL, ROW --PAGE
EXEC sp_estimate_data_compression_savings dbo, test, NULL, NULL, PAGE 

ALTER TABLE test
REBUILD PARTITION = ALL --Wenn keine Partitionen vorhanden, dann ALL 
WITH (DATA_COMPRESSION = PAGE) 