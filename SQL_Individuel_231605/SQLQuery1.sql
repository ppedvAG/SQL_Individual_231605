drop database testdb

---DB Settings

create database testdb

/*
WIEVIELE FEHLER?

Pfade.. wo LDF und mdf
Wie groß? 16 MB  8MB ldf und 8MB mdf
Wachstum: um wieivle wachsen die Dateien:
	bis SQL 2014: 1 MB für Daten und 10% ldf
				   5 MB Daten und 2 MB logfile Startgrößen
	ab SQL 2016: 64MB

	ideal, wenn keine Vergrößerung:
*/

use testdb;

create table t1 (id int identity, spx char(4100));
GO


insert into t1
select 'XY'
GO 30000


select * into t2 from t1


create table t3 (id int identity, spx char(4100));
GO


insert into t3
select 'XY'
GO 30000






