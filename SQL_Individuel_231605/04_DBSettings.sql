--DB Settings

create database testdb
/*
WIEVIELE FEHLER?

Pfade.. wo LDF und mdf
Wie gro�? 16 MB  8MB ldf und 8MB mdf
Wachstum: um wieivle wachsen die Dateien:
	bis SQL 2014: 1 MB f�r Daten und 10% ldf
				   5 MB Daten und 2 MB logfile Startgr��en
	ab SQL 2016: 64MB

	ideal, wenn keine Vergr��erung:
*/

/*
Anfangsgr��en !!! wie gro� in 3 Jahren ..

Wachstumsrate : mehr als 64!!!!!.. eher 1 GB


--Wo kann man Verg��erung sehen.. Bericht: Datentr�gerverwendung


Sonderfall: TLOG

-------------------------------------------------
     .... | TX........| TX TX |  TX TX |  TX TX TX TX TX TX TX
-------------------------------------------------

je mehr Virtuelle Logfiles desto gr��er der aufwand

h�ngt von der Wachstumsrate ab..

10MB Logfile.. Verg��erung um 1 MB  + 10 Vergr��erungen
10 VLF                                            10 VLF     10*10 VLF


1000MB Logfile.. Verg��erung um 1000 MB  + 10 Vergr��erungen
10 VLF                                            10 VLF     10*10 VLF

siehe Skript zu VLF


--man sollte einfach nicht mehr als 3000 / 5000 VLF

--Wie kann man es zu weniger VLF bringen

--Logfiles leeren: Gute Idee TLOG Sicherung
--oder RecModel: Simple


--Trenne Daten von Logfiles

-- Dateigruppen: Trenne Stammdaten von Bewegungsdaten 







*/






use [master];
GO

ALTER DATABASE [Northwind] 
	SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = ON)

--update statistics [dbo].[Record] idx_record_name with resample on partitions (1);
--A robust on-demand incremental statistics update process on partitioned tables will boost performance stability, reduce resource consumption (I/O and CPU) and significantly shrink the maintenance window for very large tables.


ALTER DATABASE [Northwind] 
	SET DATE_CORRELATION_OPTIMIZATION ON WITH NO_WAIT
--Gibt es Abh�ngigkeiten zwischen Datumsfeldern..?
--Etwa immer 14 nach Termin1 , dann Termin2
--SQL Server kann die Korrelation erkennen und entsprechen 
--mit geeigneten Statistiken die Daten effizienter holen
--da Plan auch exakter wird




GO
ALTER DATABASE [Northwind] 
	SET DELAYED_DURABILITY = ALLOWED WITH NO_WAIT
GO
--Client bekommt Commit, obwohl TX noch nicht in LOG
--festgeschrieben
--verz�gert: evtl Datenverlust, aber f�r den Client schneller
--verz�gert: Latenzzeit des Datentr�ger verringert sich
--da Batchweise zur�ckgeschrieben wird
--weniger Datentr�gerkonflikte bei gleichzeitigen TX
-->Arbeitsauslastungen weisen eine hohe Konfliktrate auf.
-->Bei Schreibvorg�ngen in das Transaktionsprotokoll treten Engp�sse auf.
-->Datenverluste sind in gewissem Umfang vertretbar.
 --Wegschreiben ins Log: EXECUTE sys.sp_flush_log  

 --Ght allerdings nicht �berall:
 --

ALTER DATABASE 
	SCOPED CONFIGURATION SET MAXDOP = 4;
GO
ALTER DATABASE 
	SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = On;
--this will work same as enabling the Trace Flag 4199 in your SQL Server.

-----------------------------------------
ALTER DATABASE [Northwind] 
	SET ALLOW_SNAPSHOT_ISOLATION ON
GO

ALTER DATABASE [Northwind] 
	SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT

--Ein �ndern eines Datensatzes hindert nicht mehr den Zugriff der anderen
--aber: es werden Versionen in die tempdb kopiert
--evtl massive Last auf tempdb


ALTER DATABASE SCOPED CONFIGURATION 
CLEAR PROCEDURE_CACHE ;
-- vs dbcc freeproccache leert den gesamten Planspeicher des SQL Server