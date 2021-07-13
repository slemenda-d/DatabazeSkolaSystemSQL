--Vytvoreni schemat

CREATE SCHEMA skola authorization dbo
GO

--Vytvoreni tabulek

CREATE TABLE skola.Garant (
ID_garant int primary key,
Jmeno varchar(40),
Prijmeni varchar(40)
)

CREATE TABLE skola.Program (
ID_program int primary key,
Nazev varchar(50),
ID_garant int foreign key references skola.Garant(ID_garant)
)

CREATE TABLE skola.Obor (
ID_oboru int primary key,
ID_program int foreign key references skola.Program(ID_program),
Nazev varchar(50),
Delka int,
)

CREATE TABLE skola.Student (
ID_student int primary key identity(1,1) not null,
login varchar(20) not null,
Prijmeni varchar(50),
Jmeno varchar(50),
Rodne_cislo varchar(11),
ID_obor int foreign key references skola.Obor(ID_oboru),
Ulice_cp  varchar(60),
Mesto varchar(50),
Psc varchar(6),
Stat varchar(40),
Fakulta varchar(50)
)

CREATE TABLE skola.Poplatky (
ID_poplatky int primary key,
ID_student int foreign key references skola.Student(ID_student),
Rocnik int,
PlatbaLS int,
ZaplacenoLS varchar(3),
PlatbaZS int,
ZaplacenoZS varchar(3)
)


CREATE TABLE skola.HodnoceniZkouska (
ID_hodnoceni int primary key,
ID_predmet int,
ID_zkouska int,
Hodnoceni varchar(1),
Body int,
ID_student  int foreign key references skola.Student(ID_student)
)

CREATE TABLE skola.HodnoceniZapocet (
ID_hodnoceni int primary key,
ID_predmet int,
ID_zapocet int,
Hodnoceni varchar(10),
Body int,
ID_student int foreign key references skola.Student(ID_student)
)

CREATE TABLE skola.KartaPredmetuCj (
ID_kartaCj int primary key not null,
Nazev_predmetu varchar(50),
Obsah varchar(max),
Cil_predmetu varchar(max),
Prerekvizity varchar(max),
Osnova varchar(max),
Kriteria_hodnoceni varchar(max)
)

CREATE TABLE skola.KartaPredmetuAj (
ID_kartaAj int primary key not null,
Nazev_predmetu varchar(50),
Obsah varchar(max),
Cil_predmetu varchar(max),
Prerekvizity varchar(max),
Osnova varchar(max),
Kriteria_hodnoceni varchar(max)
)

CREATE TABLE skola.Predmet (
ID_predmet int primary key,
Zkratka varchar(10),
Nazev varchar(50),
Povinnost varchar(10),
Rocnik int,
Ukonceni varchar(10),
Kredity int,
Jazyk varchar(20),
Semestr varchar(2),
Prava int,
Garant varchar(50),
Fakulta varchar(50),
Ustav varchar(50),
ID_garant int foreign key references skola.Garant(ID_garant),
ID_kartaCj int foreign key references skola.KartaPredmetuCj(ID_kartaCj),
ID_kartaAJ int foreign key references skola.KartaPredmetuAj (ID_kartaAj)
)

CREATE TABLE skola.Obsahuje (
ID_obsahuje int primary key,
ID_obor  int foreign key references skola.Obor(ID_oboru),
ID_predmet  int foreign key references skola.Predmet(ID_predmet)
)

CREATE TABLE skola.Absolvent (
ID_absolvent int primary key identity(1,1),
Jmeno varchar(50),
Prijmeni varchar(50),
telefon varchar(13)
)

CREATE TABLE skola.Studoval (
ID_studoval int primary key,
ID_program int foreign key references skola.Program(ID_program),
ID_absolvent  int foreign key references skola.Absolvent(ID_absolvent)
)

CREATE TABLE skola.Zapocet (
ID_zapocet int primary key identity(1,1),
Mistnost varchar(10),
Datum Date,
ID_predmet  int 
)

CREATE TABLE skola.Zkouska (
ID_zkouska  int primary key identity(1,1),
Datum Date,
Mistnost varchar(10),
ID_Predmet int
)

CREATE TABLE skola.ZaverecnaPrace(
ID_zaverecna_prace  int primary key identity(1,1),
ID_student int foreign key references skola.Student(ID_student),
Tema varchar(50),
Hodnoceni varchar(1)
)

CREATE TABLE skola.KonaZapocet(
ID_konaZapocet int primary key,
ID_zapocet int foreign key references skola.Zapocet(ID_zapocet),
ID_student int foreign key references skola.Student(ID_student)
)

CREATE TABLE skola.KonaZkousku(
ID_konaZkousku int primary key,
ID_zkouska int foreign key references skola.Zkouska(ID_zkouska),
ID_student int foreign key references skola.Student(ID_student)
)

CREATE TABLE skola.Prihlaska(
ID_prihlaska int primary key identity(1,1),
ID_student int foreign key references skola.Student(ID_student),
Zaplaceno int,
Na_obor varchar(50),
Ukonceni_BC varchar(3)
)
GO

--Vlozeni dat

insert into skola.garant (ID_garant, Jmeno, Prijmeni) 
values ('1', 'David', 'Kalma')
insert into skola.garant (ID_garant, Jmeno, Prijmeni) 
values ('2', 'Petr', 'Malina')
insert into skola.garant (ID_garant, Jmeno, Prijmeni) 
values ('3', 'Luděk', 'Rožba')
GO

insert into skola.Program (ID_program, Nazev, ID_garant) 
values ('1', 'MSC. In Businness and Informatics', '2')
GO

insert into skola.Obor (ID_oboru, ID_program, Nazev, Delka)
values ('1', '1', 'Ekonomika podniku', '2')
insert into skola.Obor (ID_oboru, ID_program, Nazev, Delka)
values ('2', '1', 'Manažerská informatika', '2')
insert into skola.Obor (ID_oboru, ID_program, Nazev, Delka)
values ('3', '1', 'Účetnictví a daně', '2')
insert into skola.Obor (ID_oboru, ID_program, Nazev, Delka)
values ('4', '1', 'Podnikový obchod', '2')
GO

insert into skola.Student(login, Prijmeni, Jmeno, Rodne_cislo, ID_obor, Ulice_cp, Mesto, PSC, Stat, Fakulta)
values ('xplolo00', 'Lolek', 'Petr', '960210/0453', '3', 'Meltská 24', 'Pelhřimov', '271 01', 'Česká republika', 'Podnikatelská') 
insert into skola.Student(login, Prijmeni, Jmeno, Rodne_cislo, ID_obor, Ulice_cp, Mesto, PSC, Stat, Fakulta)
values ('xpmelo00', 'Melek', 'Roman', '960710/0423', '2', 'Mrožská 324', 'Kladno', '272 01', 'Česká republika', 'Podnikatelská') 
insert into skola.Student(login, Prijmeni, Jmeno, Rodne_cislo, ID_obor, Ulice_cp, Mesto, PSC, Stat, Fakulta)
values ('xpmrak00', 'Mráčková', 'Monika', '965210/0375', '1', 'Romanová 111', 'Olomouc', '341 21', 'Česká republika', 'Podnikatelská')
insert into skola.Student(login, Prijmeni, Jmeno, Rodne_cislo, ID_obor, Ulice_cp, Mesto, PSC, Stat, Fakulta)
values ('xpmroo00', 'Mrokl', 'Milan', '950421/0726', '2', 'Prachova 338', 'Praha', '275 02', 'Česká republika', 'Podnikatelská')
GO

insert into skola.Poplatky (ID_poplatky, ID_student, Rocnik, PlatbaLS, ZaplacenoLS, PlatbaZS, ZaplacenoZS)
values ('1', '2', '2', '10000', 'ano', '28000', 'ano') 
insert into skola.Poplatky (ID_poplatky, ID_student, Rocnik, PlatbaLS, ZaplacenoLS, PlatbaZS, ZaplacenoZS)
values ('2', '1', '2', '10000', 'ne', '28000', 'ano') 
insert into skola.Poplatky (ID_poplatky, ID_student, Rocnik, PlatbaLS, ZaplacenoLS, PlatbaZS, ZaplacenoZS)
values ('3', '3', '1', '10000', 'ne', '28000', 'ne') 
GO

insert into skola.HodnoceniZkouska (ID_hodnoceni, ID_predmet, ID_zkouska, Hodnoceni, Body, ID_student)
values ('1', '1', '1', 'A', '95', '1')
insert into skola.HodnoceniZkouska (ID_hodnoceni, ID_predmet, ID_zkouska, Hodnoceni, Body, ID_student)
values ('2', '3', '2', 'E', '35', '2')
insert into skola.HodnoceniZkouska (ID_hodnoceni, ID_predmet, ID_zkouska, Hodnoceni, Body, ID_student)
values ('3', '2', '3', 'B', '83', '4')
GO

insert into skola.HodnoceniZapocet (ID_hodnoceni, ID_predmet, ID_zapocet, Hodnoceni, Body, ID_student)
values ('1', '1','1','uspěl','40', '1')
insert into skola.HodnoceniZapocet (ID_hodnoceni, ID_predmet, ID_zapocet, Hodnoceni, Body, ID_student)
values ('2', '3','2','uspěl','38', '2') 
insert into skola.HodnoceniZapocet (ID_hodnoceni, ID_predmet, ID_zapocet, Hodnoceni, Body, ID_student)
values ('3', '4','4','uspěl','9', '3')
GO

insert into skola.KartaPredmetuCJ (ID_kartaCJ,Nazev_predmetu, Obsah, Cil_predmetu, Prerekvizity, Osnova, Kriteria_hodnoceni)
values ('1', 'Databázové systémy', 'Předmět je zaměřen zejména na následující oblasti: Historie databázových systémů. Architektury systémů řízení bází dat. SQL server - celkový pohled. Relační databázový systém. Datové typy, organizace a ukládání dat, indexy. Jazyk SQL. Vytváření a spojování tabulek. Omezení tabulek a normalizace. Transakce, zámky a uložené procedury. Technologie XML. Analytické služby. Bezpečnost.', 'Cílem předmetu je seznámit studenty se základními principy relačních databází, jejich návrhem a vývojem, postavením v architektuře IS/ICT, implementací a získání praktických dovedností s s dotazovacím jazykem SQL.','Předpokládají se znalosti z datového modelování, algoritmizace a programovacích technik.','Základní tématická náplň přednášek je následující: Historie databázových systémů, Relační databázový systém, datové typy, ukládání dat a struktury indexů, Příkazy jazyka T-SQL, Vytváření tabulek a jejich změny, spojování, omezení a normalizace, Pohledy, uložené procedury, Transakce a zámky, Spouště, Pokročilé dotazy, Analytické služby SQL serveru, Praktická část výuky je prováděna v prostředí MS SQL Server., Zálohování a replikace dat, Bezpečnost dat, Technologie XML, Nové trendy databázových technologiích', 'Podmínky zápočtu: Student musí během semestru získat alespoň 50% bodů z možného maxima, tedy 20 bodů ze 40.
Pokud bude odhaleno plagiátorství nebo nedovolená spolupráce na projektech, či u půlsemestrálního testu, zápočet nebude udělen s možností zvážení zahájení disciplinárního řízení.
Půlsemestrální test - písemně, (odpovědi mohou být volbou jedné správné z několika, větné odpovědi nebo jejich kombinace) a vypracováním praktického úkolu dle zadání. Neexistuje opravný termín. (20 bodů)
Vypracování projektu - jeden projekt dle zadání s příslušnou dokumentací. Se zadáním jsou studenti seznámeni na druhé přednášce. (20 bodů)
Podmínky zkoušky:
Závěrečná zkouška - písemně, formou testu (odpovědi mohou být volbou jedné správné z několika, větné odpovědi nebo jejich kombinace) a ústním přezkoušením. (60 bodů pro písemnou část zkoušky, pro úspěšné absolvování zkoušky je nutné písemnou část zkoušky vypracovat tak, aby byla hodnocena nejméně 30 body, v opačném případě bude zkouška hodnocena 0 body s hodnocením F.)')
insert into skola.KartaPredmetuCJ (ID_kartaCJ,Nazev_predmetu, Obsah, Cil_predmetu, Prerekvizity, Osnova, Kriteria_hodnoceni)
values ('2','Kvantitativní metody', 'V předmětu Kvantitativní metody budou studenti seznámeni s vybranými kvantitativními metodami, které slouží pro podporu manažerského rozhodování.', 'Cílem předmětu je seznámit posluchače s vybranými kvantitativními metodami manažerského rozhodování včetně jejich praktické aplikace.', 'Pro studium předmětu jsou nutné základní znalosti z managementu (manažerské funkce, manažerské role) a matematiky (lineární algebra, teorie grafů, pravděpodobnost).', '1. Úvod do předmětu (teorie systémů, kybernetika, operační analýza, systémová analýza, systémové inženýrství). Teorie manažerského rozhodování (teorie rozhodování, rozhodovací proces, rozhodovací problém).
2. Matematické modelování (model, klasifikace modelů, přehled modelů, model matematického programování).
3. Lineární programování (postup formulace úlohy lineárního programování, typy úloh lineárního programování, obecný model úlohy lineárního programování).
4. Formulace matematického modelu úlohy lineárního programování (úloha výrobního plánování, dopravní problém, přiřazovaní problém).
5. Formulace matematického modelu úlohy lineárního programování (směšovací problém, nutriční problém, úloha o dělení materiálů, rozvrhování reklamy, optimalizace portfolia).', 'Pro udělení zápočtu je požadováno splnění následujících podmínek:
1. Úspěšné zpracování semestrálního projektu ve stanoveném termínu.
2. Úspěšné absolvování zápočtového testu.
Celkový počet možných dosažených bodů je 100, přičemž 50 bodů lze získat za zápočtový test, 25 bodů za semestrální projekt a 25 bodů za případný opravný zápočtový test. Pro udělení zápočtu musí být dosaženo minimálně 50 bodů.
Požadavky ke zkoušce: 
1. Úspěšné absolvování zkouškového testu.
Zkouška probíhá písemně. Pro její úspěšné složení je nutné dosáhnout min. 50% z možného bodového hodnocení zkoušky.
Celkové hodnocení předmětu je na základě výsledků získaných u zkoušky s možným přihlédnutím k výsledkům získaným v průběhu semestru.')
insert into skola.KartaPredmetuCJ (ID_kartaCJ,Nazev_predmetu, Obsah, Cil_predmetu, Prerekvizity, Osnova, Kriteria_hodnoceni)
values('3','Počítačové sítě', 'Předmět je zaměřen zejména na následující oblasti: terminologie počítačových sítí, principy komunikace v počítačových sítích, navrhování a výstavba počítačových sítí, management počítačových sítí.', 'Cílem předmětu je seznámit posluchače se základními pojmy a technologiemi počítačových komunikací a počítačových sítí.', 'Základní znalosti z oblasti počítačů, operačních systémů, matematické logiky, číselných soustav.', 'Výuka není kontrolovaná - přednášky jsou nepovinné, předmět nemá cvičení', 'Znalosti jsou ověřovány zkouškou, která se skládá ze dvou částí v různých termínech. První částí je test, pokud student nezodpoví správně alespoň 50% otázek testu, nemůže pokračovat v druhé části. Druhá část má ústní formou. Při ústní zkoušce student obdrží náhodně dvě otázky, na které má vymezený časový prostor 20 minut na přípravu. Vlastní zkouška probíhá diskusí nad otázkami. 
Dovednosti studenta jsou ověřovány na základe vypracování komplexní semestrální práce.
Zkouška je klasifikována dle stupnice ECTS.
Výsledné hodnocení je váženým aritmetickým průměrem s těmito váhami:
Vypracování semestrální práce 30 %
První část zkoušky (test) 20 %
Druhá část zkoušky (ústní) 50 %')
GO

insert into skola.KartaPredmetuAJ (ID_kartaAJ,Nazev_predmetu, Obsah, Cil_predmetu, Prerekvizity, Osnova, Kriteria_hodnoceni)
values ('1','Databázové systémy','The course focuses especially on the following topics: History of database systems, architecture of database management systems. SQL server – general overview. Relational database system. Data types, data organization and storage, indexes, SQL language, Creation and connection of tables. Limitation of tables and normalization. Transactions, locks and saved operations. Use of databases in the internet. XML technology. Analytical services. Security.', 'The main objective of the course is to make students familiar with the basic methods of relational databases, their design and development, the role of architecture in IS / ICT, implementation and skill ss query language SQL.', 'Knowledge of data modelling, algorithmization and programming techniques as well as fundamentals of HTML language are required.','Topics of lectures is as follows:
- History of Database Systems
- Relational database management system, data types, data storage and index structures
- Language commands T-SQL
- Creating tables and their changes, mergers, restrictions and normalization
- Views, Stored Procedures
- Transactions and Locks
- Triggers
- Advanced queries
- SQL Server Analysis Services
- The practical part of the training is done in MS SQL Server.
- Backup and data replication
- Data Security
- XML Technology
- New trends in database technology','Attendance at lectures is not compulsory. Seminars with computer support is required, attendance is controled. One absence from seminars, teacher apologize. Student will replace this lack of elaboration especially given homework.

Seminars with computer support are focused on teaching features and tools of MS SQL Server including query language SQL. During the semester, steudent writes semester test for maximum of 20 points. For this semester test is no trial. If a student has a well-documented and excused absence for the semester test by teacher, he/she can sign on an alternative date.

In the second lecture is given separate project for a maximum of 20 points to students. To accept this project, student has to obtain min. 10 points. The project student submits in the credit week.
Students who have an individual learning plan (ie. they do not go into lectures) must prepare and submit a special individual project for the credit. For this particular project can get 30 points.

The course ends with a written exam for a maximum of 60 points. Participation in the test is mandatory.')
insert into skola.KartaPredmetuAJ (ID_kartaAJ,Nazev_predmetu, Obsah, Cil_predmetu, Prerekvizity, Osnova, Kriteria_hodnoceni)
values ('2','Kvantitativní metody', 'The course Quantitative Methods acquaints students with selected quantitative methods that are used as a support for decision-making.','The aim of the course is to acquaint students with selected quantitative methods of managerial decision-making and their practical application.','For the study of the subject are required basic knowledge of management (management functions, managerial roles) and mathematics (linear algebra, graph theory, probability).','. Introduction (systems theory, cybernetics, operational analysis, system analysis, system engineering). Managerial decision theory (the theory of decision-making process, decision-making problem).
2. Mathematical modeling (model, model classification, survey models, mathematical programming model).
3. Linear Programming (formulation technique of linear programming, types of linear programming problems, the general model of linear programming).
4. Formulation of a mathematical model of linear programming (job production planning, transportation problem, assigning the problem).
5. Formulation of a mathematical model of linear programming (mixing problem, nutritional problems, the task of cutting materials, scheduling commercials, portfolio optimization).
6. Solving linear programming problems (graphical, algebraic, using MS Excel).
7. Methods of network analysis (introduction to the topic of project management, the construction of a network graph).
8. Time analysis of AOA deterministic network graphs.
9.Time analysis of AOA stochastic network graphs.
10. Time analysis AON network graphs. The construction of the project schedule.
11. Source project analysis. Dependence times and project costs.
12. Time analysis generalized network graph.
13. Software support of project management','The following conditions have to be met by a student to be given the credit:
1. Successful completion of the semester project within the specified deadline.
2. Successful completion of credit test.
A maximum of 100 points may be obtained with a maximum of 50 points for credit test, 25 points for the semester project and 25 points for an eventual correction test. A minimum of 50 points need to be achieved for the credit.
Examination Requirements: 
1. Successful completion of the exam test.
The exam is carried out in writing. For its successful completion it is necessary to reach min. 50% out of a possible score of the exam.
Overall evaluation of the course is based on the results obtained by exam with possible reference to the results obtained during the semester.')
insert into skola.KartaPredmetuAJ (ID_kartaAJ,Nazev_predmetu, Obsah, Cil_predmetu, Prerekvizity, Osnova, Kriteria_hodnoceni)
values ('3','Počítačové sítě', 'The course focuses on the following topics: principles of communication within computer networks, designing and construction of computer networks, computer networks management.','The main objective of the course is to familiarise students with basic terms and technologies with respect to computer technologies and computer networks.','Computer literacy, knowledge of operating systems, computer networks, mathematical logic and numerical systems.','The course contains lectures that explain basic principles, problems and methodology of the discipline.','The course is not concluded by a course-unit credit:
Conditions for passing an exam: Knowledge of taught topics and its practical application.
Form of examination: Combined – a written test possibly followed by an oral examination.')
GO

insert into skola.Predmet (ID_predmet, Zkratka, Nazev, Povinnost, Rocnik, Ukonceni, Kredity, Jazyk, Semestr, Prava, Garant, Fakulta, Ustav, ID_garant, ID_kartaCj, ID_kartaAJ)
values ('1', 'DBS', 'Databázové systémy', 'Povinný', '1', 'z,zk', '6', 'ČJ', 'LS', '1', 'Ing. David Kalma, Ph.D', 'Podnikatelská', 'Informatiky', '1', '1', '1')
insert into skola.Predmet (ID_predmet, Zkratka, Nazev, Povinnost, Rocnik, Ukonceni, Kredity, Jazyk, Semestr, Prava, Garant, Fakulta, Ustav, ID_garant, ID_kartaCj, ID_kartaAJ)
values ('2', 'KVM', 'Kvantitativní metody', 'Povinný', '2', 'z,zk', '5', 'ČJ', 'ZS', '1', 'Ing. David Kalma, Ph.D', 'Podnikatelská', 'Informatiky', '1', '2', '2')
insert into skola.Predmet (ID_predmet, Zkratka, Nazev, Povinnost, Rocnik, Ukonceni, Kredity, Jazyk, Semestr, Prava, Garant, Fakulta, Ustav, ID_garant, ID_kartaCj, ID_kartaAJ)
values ('3', 'PSI', 'Počítačové sítě', 'Nepovinný', '1', 'zk', '5', 'ČJ', 'LS', '1', 'Ing. Petr Malina, Ph.D', 'Podnikatelská', 'Informatiky', '2', '3', '3')
GO

insert into skola.Obsahuje (ID_obsahuje, ID_obor, ID_predmet)
values ('1','1','1')
insert into skola.Obsahuje (ID_obsahuje, ID_obor, ID_predmet)
values ('2','3','2')
insert into skola.Obsahuje (ID_obsahuje, ID_obor, ID_predmet)
values ('3','2','3')
GO

insert into skola.Absolvent (Jmeno, Prijmeni, Telefon)
values ('Patrik','Malý','+420752689111')
insert into skola.Absolvent (Jmeno, Prijmeni, Telefon)
values ('Martina','Malá','+420752849122')
insert into skola.Absolvent (Jmeno, Prijmeni, Telefon)
values ('Roman','Černý','+420822689111')
insert into skola.Absolvent (Jmeno, Prijmeni, Telefon)
values ('Milan','Bílý','+420997558112')
GO

insert into skola.Studoval(ID_studoval, ID_program, ID_absolvent)
values('1','1','2')
insert into skola.Studoval(ID_studoval, ID_program, ID_absolvent)
values('2','1','1')
insert into skola.Studoval(ID_studoval, ID_program, ID_absolvent)
values('3','1','4')
GO

insert into skola.zapocet (Mistnost, Datum, ID_predmet)
values('P385','12. 12. 2017', '1')
insert into skola.zapocet (Mistnost, Datum, ID_predmet)
values('P114','5. 5. 2017', '2')
insert into skola.zapocet (Mistnost, Datum, ID_predmet)
values('P386','6. 12. 2017', '3')
insert into skola.zapocet (Mistnost, Datum, ID_predmet)
values('P387','6. 12. 2017', '2')
GO

insert into skola.Zkouska(Datum, Mistnost, ID_predmet)
values('4. 1. 2017', 'P311', '3')
insert into skola.Zkouska(Datum, Mistnost, ID_predmet)
values('2. 5. 2017', 'E221', '2')
insert into skola.Zkouska(Datum, Mistnost, ID_predmet)
values('3. 1. 2017', 'P112', '1')
insert into skola.Zkouska(Datum, Mistnost, ID_predmet)
values('2017-05-21', 'P105', '2')
GO

insert into skola.ZaverecnaPrace(ID_student, Tema, Hodnoceni)
values('1','Programovani ve společnosti','B')
insert into skola.ZaverecnaPrace(ID_student, Tema, Hodnoceni)
values('2','Databáze v malém podniku','F')
GO

insert into skola.KonaZapocet(ID_konaZapocet,ID_zapocet,ID_student)
values('1','1','1')
insert into skola.KonaZapocet(ID_konaZapocet,ID_zapocet,ID_student)
values('2','2','2')
insert into skola.KonaZapocet(ID_konaZapocet,ID_zapocet,ID_student)
values('3','3','3')
insert into skola.KonaZapocet(ID_konaZapocet,ID_zapocet,ID_student)
values('4','4','4')
GO

insert into skola.KonaZkousku(ID_KonaZkousku,ID_zkouska,ID_student)
values('1','1','1')
insert into skola.KonaZkousku(ID_KonaZkousku,ID_zkouska,ID_student)
values('2','2','2')
insert into skola.KonaZkousku(ID_KonaZkousku,ID_zkouska,ID_student)
values('3','3','3')
insert into skola.KonaZkousku(ID_KonaZkousku,ID_zkouska,ID_student)
values('4','4','4')
GO

insert into skola.Prihlaska(ID_student,Zaplaceno,Na_Obor,Ukonceni_BC)
values('1','1','Manažerská informatika','Ano')
insert into skola.Prihlaska(ID_student,Zaplaceno,Na_Obor,Ukonceni_BC)
values('2','1','Manažerská informatika','Ano')
insert into skola.Prihlaska(ID_student,Zaplaceno,Na_Obor,Ukonceni_BC)
values('3','0','Účetnictví a daně','Ne')
insert into skola.Prihlaska(ID_student,Zaplaceno,Na_Obor,Ukonceni_BC)
values('4','0','Manažerská informatika','Ano')
GO


-------------- Trigger pro studenty, kteri neuspeli

CREATE TABLE StudentiSF(
ID_hodnoceni int primary key,
ID_predmet int,
ID_zkouska int,
Hodnoceni varchar(1),
Body int,
ID_student  int
)
GO

CREATE TRIGGER NeuspesniStudentiZeZkousek
ON skola.HodnoceniZkouska
AFTER INSERT
AS
BEGIN
	INSERT INTO StudentiSF
	SELECT * FROM inserted WHERE HODNOCENI = 'F'
END
GO

CREATE TABLE StudentiNEuZapoctu(
ID_hodnoceni int primary key,
ID_predmet int,
ID_zapocet int,
Hodnoceni varchar(10),
Body int,
ID_student int
)
GO

CREATE TRIGGER NeuspesniStudentiZeZapoctu
ON skola.HodnoceniZapocet
AFTER INSERT
AS
BEGIN
	INSERT INTO StudentiNEuZapoctu
	SELECT * FROM inserted WHERE HODNOCENI = 'Neuspěl'                                              
END
GO


--------------vytvoreni procedur a pohledu pro vyucujici

CREATE PROCEDURE VlozHodnoceniZkousky
@ID_hodnoceni int,
@ID_predmet int,
@ID_zkouska int,
@Hodnoceni varchar(1),
@Body int,
@ID_student int
AS
BEGIN
	insert into skola.HodnoceniZkouska(ID_hodnoceni,ID_predmet,ID_zkouska,Hodnoceni,Body,ID_student)
	values(@ID_hodnoceni, @ID_predmet, @ID_zkouska, @Hodnoceni, @Body, @ID_student)
END
GO

CREATE PROCEDURE VlozHodnoceniZapoctu
@ID_hodnoceni int,
@ID_predmet int,
@ID_zapocet int,
@Hodnoceni varchar(10),
@Body int,
@ID_student int
AS
BEGIN
	insert into skola.HodnoceniZapocet(ID_hodnoceni,ID_predmet,ID_zapocet,Hodnoceni,Body,ID_student)
	values(@ID_hodnoceni, @ID_predmet, @ID_zapocet, @Hodnoceni, @Body, @ID_student)
END
GO

CREATE PROCEDURE VlozZkousku
@Datum Date,
@Mistnost varchar(10),
@ID_predmet int
AS
BEGIN
	insert into skola.Zkouska(Datum,Mistnost,ID_predmet)
	values(@Datum,@Mistnost,@ID_predmet)
END
GO

CREATE PROCEDURE VlozZapocet
@Mistnost varchar(10),
@Datum Date,
@ID_predmet int
AS
BEGIN
	insert into skola.Zapocet(Mistnost, Datum, ID_predmet)
	values(@Mistnost,@Datum,@ID_predmet)
END
GO

CREATE PROCEDURE VlozPraci
@ID_student int,
@Tema varchar(50),
@Hodnoceni varchar(1)
AS
BEGIN
	insert into skola.ZaverecnaPrace(ID_student,Tema,Hodnoceni)
	values(@ID_student,@Tema,@Hodnoceni)
END
GO

--------- vytvoreni procedury pro studenty

CREATE PROCEDURE StudentPohledNaZkousku
@ID_studenta int
AS	
BEGIN
	Select Prijmeni, Jmeno, login, ID_predmet, Hodnoceni, Body 
	From skola.Student inner join skola.HodnoceniZkouska ON skola.Student.ID_student = skola.HodnoceniZkouska.ID_student
	Where skola.Student.ID_student = @ID_studenta
END
GO

CREATE PROCEDURE StudentPohledNaZapocet
@ID_studenta int
AS	
BEGIN
	Select Prijmeni, Jmeno, login, ID_predmet, Hodnoceni, Body 
	From skola.Student inner join skola.HodnoceniZapocet ON skola.Student.ID_student = skola.HodnoceniZapocet.ID_student
	Where skola.Student.ID_student = @ID_studenta
END
GO

CREATE PROCEDURE KartaVybranehoPredmetuCJ
@Predmet_id int
AS
BEGIN
	Select Zkratka, Nazev, Obsah, Cil_predmetu, Prerekvizity, Osnova, Kriteria_hodnoceni
	FROM skola.KartaPredmetuCJ join skola.Predmet ON skola.KartaPredmetuCJ.Nazev_predmetu = skola.predmet.Nazev
	WHERE ID_predmet = @Predmet_id
END
GO

CREATE PROCEDURE KartaVybranehoPredmetuAJ
@Predmet_id int
AS
BEGIN
	Select Zkratka, Nazev, Obsah, Cil_predmetu, Prerekvizity, Osnova, Kriteria_hodnoceni
	FROM skola.KartaPredmetuAJ join skola.Predmet ON skola.KartaPredmetuAJ.Nazev_predmetu = skola.predmet.Nazev
	WHERE ID_predmet = @Predmet_id
END
GO



--------- vytvoreni pohledu a procedury pro studijni referentku

-- studenti se splnenymi pozadavky pro prijeti:

CREATE VIEW skola.studentiPrijetiOK
AS
	select * from skola.prihlaska pr
	where pr.Ukonceni_BC = 'Ano' AND pr.Zaplaceno = 1
GO

-- studenti, kteri nezaplatili za letni semestr:

CREATE VIEW skola.NezaplacenoLS 
AS 
	select * from skola.poplatky
	where skola.poplatky.ZaplacenoLS = 'ne'
GO

-- studenti, kteri nezaplatili za zimni semestr: 

CREATE VIEW skola.NezaplacenoZS
AS
	select * from skola.poplatky
	where skola.poplatky.ZaplacenoZS = 'ne'
GO


-- kontrola uhrady za studium studenta:
CREATE PROCEDURE KontrolaUhrady
@ID_studenta int
AS	
BEGIN
	select ST.Prijmeni, ST.Jmeno, ST.login, PO.ZaplacenoLS, PO.ZaplacenoZS 
	from skola.student ST JOIN skola.Poplatky PO ON ST.ID_student = PO.ID_student
	Where ST.ID_student = @ID_studenta
END
GO



---ukazka funkcnosti procedur a pohledu

--exec VlozHodnoceniZkousky 10,2,12,'F',10,1
--select * from skola.HodnoceniZkouska
--select * from studentiSF
--GO 

--exec VlozHodnoceniZapoctu 8,1,5,'neuspěl',2,3
--select * from skola.HodnoceniZapocet
--select * from StudentiNeUZapoctu
--GO

--exec VlozZkousku '2017-12-12', 'P356',2
--select * from skola.Zkouska
--GO

--exec VlozZapocet 'E101','2017-12-06',1
--select * from skola.Zapocet 
--GO

--exec VlozPraci 1,'Programování databází','A'
--select * from  skola.ZaverecnaPrace
--GO


--exec StudentPohledNaZkousku 1
--GO

--exec StudentPohledNaZapocet 2
--GO

--exec KartaVybranehoPredmetuCJ 3
--GO

--exec KartaVybranehoPredmetuAJ 1
--GO

--select * from skola.studentiPrijetiOK

--select * from skola.NezaplacenoLS
--select * from skola.NezaplacenoZS 

--exec KontrolaUhrady 1

--select * from skola.Predmet
