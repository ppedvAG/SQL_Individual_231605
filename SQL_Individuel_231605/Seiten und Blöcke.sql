--Seiten und Blöcke

--Datensätze (DS) kommen in Seiten

-- Seiten
-- 8192bytes
-- 8072bytes nutzbar für Daten
-- 1DS kann mit fixen Längen nicht mehr als 8060 bytes haben

create table t4 (id int, spx char(4100), spy char(4100))
-- Seiten kommen in Blöcke (immer 8 Seiten) 64kb

je weniger Seiten , desto weniger RAM
--Seiten kommen 1:1 in RAM



--ID int sox char(4100)   30000

dbcc showcontig('t1')
-- Gescannte Seiten.............................: 30000
-- Mittlere Seitendichte (voll).....................: 50.79%

--Verschwendung minimieren

--Spalten auslagern (Kundensonstiges)
--Datenytpen

--Otto
--char(50)  'otto                       ' 50
--varchar(50)  'otto'  4
--nchar(50) 'otto             ' 50 *2  = 100
--nvarchar(50) 'otto'  4*2 = 8

--datetime ms
--datetime2 ns

select * from orders where year(orderdate) = 1997--richtig aber langsam

select * from orders
	where orderdate between '1.1.1997' and '31.12.1997 23:59:59.997'







use northwind;
GO


create table t1 (id int identity, spx char(4100));
GO


insert into t1 
select 'XY'
GO 20000
--Zeit Messen


dbcc shwocontig('')



select * from sys.dm_db_index_physical_stats(db_id(), object_id(''), NULL, NULL, 'detailed')
GO

