/*

--a) adhoc Abfrage  select .. tabelle
--b) View           select ...view
--c) Proc            exec proc 10,5
--d) F()            select ...f(wert) 

/*
langsam --- schnell--->

b   d   a   c

(c)  ....... d .....a|b........c

----------------------------


DB Design

Normalisierung
Ziel: keine doppelten Werte, Vermeidung von Redundanz

NF1 
in Zelle nur ein Wert

NF2 
jeder DS muss einen PK


NF3
alle Spalten ausser dem PK dürfen keine wechselseitigen Abhängigkeiten besitzen

--hier ist die Grenze des guten Geschmacks


--Wie finde ich eigtl raus.. welche Tabellen wir haben und wie stehen sie in Beziehung?

Diagramm
generiert Schemasperren.. das Bearbeiten an anderen Stellen ist nicht möglich wie IX Erstellung , Dateigruppen zu weisen
eignet sich um ein Bild der DB zu bekommen: Beziehungen PK FK, Joins assen sich gut auslesen
welche DAtentypen, Pflichtfelder etc..

es können mehrere Diagramme erstellt werden und Tabellen dabei auch immer wieder verwedent werden.



--> Sichten gemerkte Abfragen

--Sicht hat keine Daten

--was kann eine Sicht?

--wie Tabelle: SELECT  INS DEL UP  (aber nur unter gewissenen Bedingungen) ,aber auch eig!!!!!! Rechte


wofür: 
komplexe Abfragen zu Vereinfachen
Security


*/

create view VName
as
SELECT .....


--der View Editor kann nicht alles


select Companyname from customers c inner join orders o on c.CustomerID=o.CustomerID where c.Country='UK'

--Was ist schneller : ausführen einer Sicht oder Ausführen des SQL Statments direkt
---es ist gleich schnell!

select * from (select * from customers ) c


--Tabellen 


Sicht:
hat keine Daten.. gemerkte Abfrage

select * from (select * from ...) t

create view t
as
select ....

auch INS UP DEL möglich 

Warum Sichten: 
--eig Rechte auf Sichten
--komplexe Abfragen wiederverwendbar machen

--immer with schemabinding

*/

drop view v1
drop table slf

create table slf (id int, stadt int, land int)

insert into slf
select 1,10,100
UNION ALL
select 2,20,200
UNION ALL
select 3,30,300


create view v1 with schemabinding
as
select id, stadt , land from dbo.slf

select * from v1
select * from slf

alter table slf add fluss int

update slf set fluss = Id*1000

select * from slf
select * from v1

alter table slf drop column land



--Prozeduren
-
--Proc ist nich tmit normalen Abfragen kombinierbar (JOINS)
--immer wiederkehrende (komplexere) Vorgänge  mit Parametern
--ähnlich wie Windows Batchdateien

create proc gpname @par int , @par2 int
as
select * from tabelle where id = @par1 and sp5 = @par2
-INS UP DEL


exec gpName 10,200






--Proc oder Adhoc oder Sicht
--Proc in der Regel schneller , aber mal auch elend langsamer
--schneller , weil ein Plan generiert wird und auch aufgehoben wird ( auch über Neustart hinaus) 
--und der kann durchaus mal im Laufe der Zeit falsch werden


--Funktionen
--sind extrem flexible im Einsatz

select f(Sp) , f(wert) from f(Wert) where f(sp) > f(wert)

--die gehören in den Giftschrank!!! weil sie nur sehr selten schätzbar

--F() können nicht mit mehr CPU Kernen verarbeiten werden


where famname = 'HOPFGARTNER' ---Indizes
where len(famname) = 11


--Functions
use northwind

select * from [Order Details]

select sum(unitprice*quantity) from [Order Details]
where orderid = 10250

create function fRngSumme(@oid int) returns money
as
Begin
	return(
			select sum(unitprice*quantity) from [Order Details]
			where orderid = @oid
			)
end

select dbo.fRngSumme(10250)


select * from orders where dbo.fRngsumme(orderid) < 1000


alter table orders add RngSumme as dbo.fRngSumme(orderid)

select * from orders where rngsumme < 1000










select * from customers


NF2 NF3 NF4 NF5 BC


Tabellen

Beziehungen
man kann keine PK Datensätze löschen ,wenn FK existieren
man kann keine DS mit FK anlegen, zu denen keine PK Werte exisiteren

Primärschlüssel  
er ist für Beziehungen  1:N
macht den DS eindeutig


Fremdschlüssel




*/

select * from orders
select * from [Order Details]