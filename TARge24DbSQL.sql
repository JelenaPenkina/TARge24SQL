-- 1tund 26.02.25
--loome db
crEaTE database TARge24

--db valimine
use TARge24

-- db kustutamine
-- drop database TARge24

-- 2tund 05.03.2025

--tabeli loomine
create table Gender
(
Id int not null primary key,
Gender nvarchar(10) not null
)

--andmete sisestamine
insert into Gender (Id, Gender)
values (2, 'Male')
insert into Gender (Id, Gender)
values (1, 'Female'),
(3, 'Unknown')

--vaatame tabeli andmeid
select * from Gender

create table Person
(
Id int not null primary key,
Name nvarchar(30),
Email nvarchar(30),
GenderId int
)

--andmete sisestamine
insert into Person (Id, Name, Email, GenderId)
values (1, 'Superman', 's@s.com', 2),
(2, 'Wonderwoman', 'w@w.com', 1),
(3, 'Batman', 'b@b.com', 2),
(4, 'Aquaman', 'a@a.com', 2),
(5, 'Catwoman', 'c@c.com', 1),
(6, 'Antman', 'ant"ant.com', 2),
(8, NULL, NULL, 2)

select * from Person

--v��rv�tme �henduse loomine kahe tabeli vahel
alter table Person add constraint tblPerson_GenderId_FK
foreign key (GenderId) references Gender(Id)

--- kui sisestad uue rea andmeid ja ei ole sisestanud GenderId alla v��rtust, siis
--- see automaatselt sisestab sellele reale v��rtuse 3 e nagu meil on unknown
alter table Person
add constraint DF_Person_GenderId
default 3 for GenderId

select * from Person

insert into Person (Id, Name, Email)
values (7, 'Spiderman', 'spider@s.com')

--piirangu kustutamine
alter table Person
drop constraint DF_Person_GenderId

--lisame veeru
alter table Person
add Age nvarchar(10)

--lisame nr piirangu vanuse sisestamisel
alter table Person
add constraint CK_Person_Age check (Age > 0 and Age < 155)

-- rea kustutamine
delete from Person where Id = 8

select * from Person

--kuidas uuendada andmeid
update Person
set Age = 19
where Id = 7

select * from Person

--lisame veeru juurde
alter table Person
add City nvarchar(50)

-- k]ik, kes elavad Gothami linnas
select * from Person where City = 'Gotham'
-- k�ik, kes ei ela Gothamis
select * from Person where City != 'Gotham'
select * from Person where City <> 'Gotham'

-- n�itab teatud vanusega olevaid inimesi
select * from Person where Age = 100 or Age = 45 or Age = 19
select * from Person where Age in (100, 45, 19)

-- n�itab teatud vanusevahemikus olevaid inimesi
select * from Person where Age between 27 and 31

-- wildcard e n�itab k�ik g-t�hega linnad
select * from Person where City like 'g%'
select * from Person where City like '%g%'

--n�itab k�iki, kellel ei ole @-m�rki emailis
select * from Person where Email not like '%@%'

-- n'tiab k�iki, kellel on emailis ees ja peale @-m�rki ainult �ks t�ht
select * from Person where Email like '_@_.com'

-- k�ik, kellel nimes ei ole esimene t�ht W, A, S
select * from Person where Name Like '[^WAS]%'
select * from Person

--k�ik, kes elavad Gothamis ja New Yorkis
select * from Person where City in ('Gotham','New York')

--- k�ik, kes elavad v�lja toodud linnades ja on nooremad 
--  kui 30 a 
select * from Person where (City = 'Gotham' or City = 'New York')
and Age < 30

-- kuvab t�hestikulises j�rjekorras inimesi ja v�tab aluseks nime
select * from Person order by Name
-- kuvab vastupidises j�rjestuses
select * from Person order by Name desc

-- v�tab kolm esimest rida
select top 3 * from person

-- kolm esimest, aga tabeli j�rjestus on Age ja siis Name
select top 3 Age, Name from Person

-- 3tund 12.03.2025

-- n�ita esimesed 50% tabelist
SELECT TOP 50 PERCENT * FROM Person

-- j�rjestab vanuse j�rgi isikud 
-- see p�ring ei j�rjesta numbreid �igesti kuna Age on nvarchar
SELECT * FROM Person ORDER BY Age desc

USE TARge24SQL

--castime Age int andmet��biks ja siis j�rjestub �igesti 
SELECT * FROM Person ORDER BY CAST(Age as int)

-- k�ikide isikute koondvanus 
SELECT SUM(CAST(Age as int)) FROM Person

-- k�ige noorem isik
SELECT MIN(CAST(Age as int)) FROM Person

-- k�ige vanem isik
SELECT MAX(CAST(Age as int)) FROM Person

-- n�eme konkreetsetes linnades olevate isikute koondvanust 
-- enne oli Age nvarchar, aga enne p�ringut muudame selle int-ks
SELECT City, SUM(Age) AS TotalAge FROM Person GROUP BY City

-- n��d muudame muutuja andmet��pi koodiga
ALTER TABLE Person 
ALTER COLUMN NAME NVARCHAR(25)

-- kuva esimese reas v�lja toodud j�rjestuse ja kuvab Age-i TotalAge-ks
-- j�rjestab City-s olevate nimede j�rgi ja siis GenderId j�rgi 
SELECT City, GenderId, SUM(Age) AS TotalAge FROM Person
GROUP BY City, GenderId ORDER BY City 

-- n�itab, et mitu rida on selles tabelis 
SELECT COUNT(*) FROM Person
SELECT * FROM Person

-- n�itab tulemust, et mitu inimest on GenderID v��rtusega 2 konkreetses linnas
-- veel arvutab vanuse kokku 
SELECT City, GenderId, SUM(Age) as TotalAge, COUNT(Id) as [Total Person(s)]
from Person
WHERE GenderId = '2'
GROUP BY GenderId, City

INSERT INTO Person VALUES
(10, 'Black Panther', 'b@b.com', 2, 34, 'New York')

-- n�itab �ra inimeste koondvanuse, kelle vanus on v�hemalt 29a
-- kui palju neid iga linnas elab 
SELECT GenderId, SUM(Age) as TotalAge, COUNT(Id)
as [Total Person(s)]
FROM Person
GROUP BY GenderId, City HAVING SUM(Age) > 29

--loome tabelid Emplopyees ja Department
CREATE TABLE Department 
(
ID INT PRIMARY KEY, 
DepartmentName NVARCHAR(50),
Location NVARCHAR(50), 
DepartmentHead nvarchar(50),
)

CREATE TABLE Employees 
(
ID INT PRIMARY KEY, 
NAME NVARCHAR(50),
Gender NVARCHAR(50), 
SALARY NVARCHAR(50),
DepartmentId int
)

SELECT * FROM Employees
SELECT * FROM Department

-- left join 
SELECT Name, Gender, Salary, DepartmentName
FROM Employees
LEFT JOIN Department
ON Employees.DepartmentId = Department.Id

-- Arvuta k�ikide palgad kokku 
SELECT SUM(CAST(Salary as int)) FROM Employees

-- Arvuta v�ikseama palgasaaja palk
SELECT MIN(CAST(Salary as int)) FROM Employees

-- �he kuu palgafond linnade l�ikes
SELECT Location, SUM(CAST(Salary as int)) as TotalSalary 
FROM Employees
left join Department
ON Employees.DepartmentId = Department.Id
GROUP BY Location

ALTER TABLE Employees 
ADD City nvarchar(30)

SELECT * FROM Employees

--sooline erip�ra palkade osas
SELECT City, Gender, SUM(CAST(Salary as int)) as TotalSalary FROM Employees
GROUP BY City, Gender

-- sama nagu eelmine, aga linnad on t�hestikulises j�rjekorras
SELECT City, Gender, SUM(CAST(Salary as int)) as TotalSalary FROM Employees
GROUP BY City, Gender ORDER BY CAST(City as nvarchar) 


-- loeb �ra, mitu rida andmeid on tabelis, 
-- * asemele v�ib panna ka muid veergude nimetusi
SELECT COUNT(*) FROM Employees
SELECT COUNT(DepartmentId) FROM Employees

-- Mitu t��tajat on soo ja linna kaupa selles tabelis 
SELECT Gender, City, COUNT(Id) as [Total Employee(s)]
FROM Employees
GROUP BY Gender, City

-- n�itab k�ik mehed linnade kaupa
SELECT Gender, City, COUNT(Id) as [Total Employee(s)]
FROM Employees
WHERE Gender = 'Male'
GROUP BY Gender, City

-- n�itab k�ik naised linnade kaupa
SELECT Gender, City, COUNT(Id) as [Total Employee(s)] FROM Employees
GROUP BY Gender, City
HAVING Gender = 'female'

-- kelle palk on v�hemalt �le 4000
SELECT SALARY, COUNT(Salary) as TotalSalary, COUNT(Id)
as [Total Employee(s)] FROM Employees
GROUP BY Salary HAVING SALARY > 4000

-- Vale p�ring 
SELECT * FROM Employees WHERE SUM(CAST(Salary as int)) > 4000

-- �ige p�ring
SELECT * FROM Employees WHERE Salary > 4000

--k�igil kellel on palk �le 4000 j aarvutab need kokku ning n�itab soo kaupa
SELECT Salary, Gender, SUM(Cast(Salary as int)) as TotalSalary, 
COUNT(Id) as [Total Employee(s)] FROM Employees
HAVING SUM(CAST(Salary as int)) > 4000

-- loome tabeli, milles hakatakse automaatselt nummerdama Id-d
CREATE TABLE Test1
(
Id int identity(1,1),
VALUE NVARCHAR(20)
)

insert into Test1 VALUES('X')
SELECT * FROM Test1

-- kustutakse �ra City veerg Employees tabelist 
ALTER TABLE Employees
DROP COLUMN CITY 

-- inner join 
-- kuvab neid, kellel on DepratmentName all olemas v��rtus
SELECT Name, Gender, Salary, DepartmentName FROM Employees
inner join Department -- ei v�ta kaasa NULL-e
ON Employees.DepartmentId = Department.Id

-- kuidas saada k�ik andmed Employees tabelist k�tte 
SELECT Name, Gender, Salary, DepartmentName FROM Employees
left join Department -- v�ib kasutada ka LEFT OUTER JOIN-i 
-- left join v�tab kaasa NULL, kuid lisab tabeli l�ppu
ON Employees.DepartmentId = Department.Id

-- right join 
-- kuidas saada DeparmtentName alla uus nimetuse antud juhul Other Department
SELECT Name, Gender, Salary, DepartmentName FROM Employees
right join Department 
ON Employees.DepartmentId = Department.Id --Viimase reana v�tab NULL-i kaasa k�ik veerud

-- full outer join
SELECT Name, Gender, Salary, DepartmentName FROM Employees
FULL OUTER JOIN Department
ON Employees.DepartmentId = Department.Id

-- CROSS JOIN v�tab kaks allpool olevat tabelit kokku ja korrutab need omavahel l�bi 
SELECT Name, Gender, Salary, DepartmentName FROM Employees
CROSS JOIN Department

--p�ringu sisu e loogika 
SELECT ColumnList FROM LeftTable 
joinType RightTable ON JoinCondition

-- kuidas kuvada ainult need isikud kellel on DepartmentName Null
SELECT Name, Gender, Salary, DepartmentName FROM Employees
left join Department
ON Employees.DepartmentId = Department.Id 
WHERE Employees.DepartmentId is NULL



--4 tund 19.03.2025
-- teine variant
SELECT name, gender, salary, DepartmentName FROM Employees 
left join Department on Employees.DepartmentId = Department.Id WHERE 
Department.Id is null

--Kuidas saame Deparment tabelsi oleva rea, kus on null 
SELECT Name, Gender, Salary DepartmentName FROM Employees RIGHT JOIN Department ON 
Employees.DepartmentId = Department.Id WHERE Employees.DepartmentId is NULL 

--full join
--m�lema tabeli mitte kattuvate v��rtustega read kuvab v�lja
SELECT Name, gender, salary DepartmentName FROM Employees FULL JOIN Department ON 
Employees.DepartmentId = Department.Id WHERE Employees.DepartmentId is NULL OR Department.ID IS NULL

--muudame tabeli nimetus , alguses vana tabeli nimi ja siis uus soovitud
SP_RENAME 'Department123', ' Department'

--left join, e employees tabel nimetuse on l�hendina: E
SELECT Name, gender, salary, DEpartmentName FROM Employees E
left join Department on E.DepartmentId = Department.id WHERE Department.id is NULL

select E.Name as Employee, M.Name as Manager
from Employees E left join Employees M ON E.ManagerId = M.Id

ALTER TABLE Employees ADD ManagerId int 

--inner join
--kuvab ainult ManagerId all olevate isikute v��rtuseid
SELECT E.Name AS Employee, M.Name AS Manager FROM Employees E INNER JOIN Employees M ON E.ManagerId = M.Id

--cross join
--- k�ik saavad k�ikide �lemused olla
select E.Name AS Employee, M.Name as Manager
from Employees E cross join Employees AS M

SELECT ISNULL('Asd', 'No manager') as Manager

--NULL asemel kuvab No Manager
SELECT COALESCE(NULL, 'No Manager')as Manager

-- neil kellel ei ole �lemust, siis paneb neile No Manager v��rtuse 
SELECT E.Name AS Employee, IS`NULL(M.Name, 'No Manager') as Manager
FROM Employees E
left join Employees M
on E.ManagerId = M.Id

--teeme p�ringu, kus kasutame case-i
SELECT E.Name as Employee, CASE WHEN M.Name IS NULL THEN 'No Manager'
ELSE M.Name end as Manager
FROM Employees E
LEFT JOIN Employees M
ON E.ManagerId = M.Id

--lisame tabelisse uued veerud 
alter table Employees
add MiddleName nvarchar(30)
alter table Employees
add LastName nvarchar(30)


--muudame veeru nime 
SP_RENAME 'Employees.Name', 'FirstName'

INSERT INTO Employees VALUES 
(1, 'Tom', 'Nick', 'Jones', 'Male', 4000, 1, NULL),
(2, 'Pam', NULL, 'Anderson', 'Female', 3000, 3, 1),
(3, 'John', NULL, NULL, 'Male', 3500, 1, 1),
(4, 'Sam', NULL, 'Smith', 'Male', 4500, 2, 1),
(5, NULL, 'Todd', 'Someone', 'Male', 2800, 2, 2),
(6, 'Ben', 'Ten', 'Sven', 'Male', 7000, 1, 2),
(7, 'sara', 'NULL', 'Connor', 'Female', 4800, 3, 3),
(8, 'Valarie', 'Balerine', NULL, 'Female', 5500, 1, 3),
(9, 'James', '007', 'Bond', 'Male', 6500, NULL, 3),
(10, NULL, NULL, 'Crowe', 'Male', 8800, NULL, 4)