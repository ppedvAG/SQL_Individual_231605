--Kompression

--Seitenkompression
--Zeilenkompression

--Erwartung:
--bei viel Text besser: ca 40 bis 60%


--SQL Neustart: Taskmanger : RAM 
use testdb;
GO

set statistics io, time on
--gilt nur in der akt Session bis Session weg oder off
--time: cpu Zeit in ms und Dauer in ms
--io: Anzahl der Seiten

select * from t1

--RAM im Taskmanager ca 500MB 
-- 30000 Seiten
--, CPU-Zeit = 250 ms, verstrichene Zeit = 1438 ms.

----Gr��e nach Kompresssion: kleiner
--RAM nach Neustart: kleiner 
--Stat: Seiten weniger  Dauer : k�rzer  CPU: mehr


--Kompression schafft Platz im RAM f�r andere... bezahlt wir dmit CPU

---
--RAM nach Ausf�hrung: mehr ..


--Seiten 43
--RAM nach Abfrage kaum merkbar 
--CPU : weniger und Dauer weniger