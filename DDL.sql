# ---------------------------------------------------------------------- #
# DDL-Practice-1_CodeAlong.sql
# ---------------------------------------------------------------------- #
/*
	•	Practice using DDL to
			o	Create database
			o	Create, Alter database table
			o	Constrain database table data and relations
	•	Practice using DML to
			o	Insert, Update, Delete records
			o	Observe constraint enforcement
*/



-- ################################################################################
--	DATABASE
-- ################################################################################

-- fyi: commands to show supported character sets, collations
		SHOW CHARACTER SET;
        SHOW COLLATION;

-- fyi: create data base specifying values for character set and collation options
CREATE DATABASE demodb
	DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_danish_ci;
  
-- DEFAULT keyword is optional
CREATE DATABASE IF NOT EXISTS demodb
	CHARACTER SET utf8mb4
  COLLATE utf8mb4_danish_ci;

SHOW CREATE DATABASE demodb; -- gives sql code to create db

SHOW DATABASES;



-- -----------------------------------------------
-- CODE ALONG: drop database
-- -----------------------------------------------

-- drop database demodb
Drop database demodb;
SHOW DATABASES;

-- -----------------------------------------------
-- CODE ALONG: create database using defaults
-- -----------------------------------------------

-- create database DDLPractice using default options
CREATE DATABASE DDLPractice
	DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_danish_ci;
SHOW DATABASES;

-- set database DDLPractice as current database for code in this script

use DDLPractice;

-- ################################################################################
--	TABLE
-- ################################################################################

-- -- -----------------------------------------------------------------------------
-- CODE ALONG: create table
-- -- -----------------------------------------------------------------------------
-- MySQL Reference Manual: 13.1.12 CREATE TABLE Statement
/*
	Table
		Reservation
	Columns
		ReservationId
		LastName
		FirstName				<--intentional typo
		PhoneNumber			<-- allow NULL
		IsMobilePhone		<-- allow NULL
		EmailAddress		<-- allow NULL
		PartySize				<-- 0 < PartySize < 7
		ReservationTime
		DateReserved
		IsCanceled
*/

-- create table Reservation

/*
create table Reservation
(
		ReservationId INT UNSIGNED NOT NULL AUTO_INCREMENT primary key,
		LastName varchar(32) NOT NULL,
        FirstName varchar(32) NOT NULL,				
		PhoneNumber	varchar(16) NULL,
		IsMobilePhone BIT NULL,
		EmailAddress VARCHAR(64) NULL,
--error in this line		PartySize TINYINT UNSIGNED NOT NULL constraint CK_Reservation_PartySize Check(PartySize > 0 and PartySize < 7) enforced,			<-- 0 < PartySize < 7
		ReservationTime datetime not null,
		DateReserved datetime not null default current_timestamp,
		LastUpdated DateTime Not Null Default Current_timestamp On Update Current_TimeStamp,
        IsCancelled bit not null default (0)
        
);
*/

CREATE TABLE Reservation
(
 ReservationId INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  LastName VARCHAR(32) NOT NULL,
  FirtName VARCHAR(32) NOT NULL,
  PhoneNumber VARCHAR(16) NULL,
  IsMobilePhone BIT NULL,
  EmailAddress VARCHAR(64) NULL,
  PartySize TINYINT UNSIGNED NOT NULL CONSTRAINT CK_Reservation_PartySize CHECK (PartySize > 0 AND PartySize < 7) ENFORCED,
  ReservationTime DATETIME NOT NULL,
  DateReserved DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  LastUpdated DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  IsCancelled BIT  Not Null Default(0)
);

Drop table reservation;
-- observe created table in database

show tables;

SHOW CREATE TABLE reservation;
describe reservation;
-- -----------------------------------------------------------------------------
-- CODE ALONG: alter table - rename column w/o changing column definition
-- -----------------------------------------------------------------------------
-- MySQL Reference Manual: 13.1.9 ALTER TABLE Statement

-- alter table

ALTER TABLE reservation
RENAME column fIRsTNAME TO FirstName;
  
-- ----------------------------------------------------------------------------------
-- CODE ALONG: alter table - modify column definition without changing column name
-- ----------------------------------------------------------------------------------

-- alter table
alter table reservation
modify PhoneNumber Char(12);


-- ----------------------------------------------------------------------------------
-- CODE ALONG: alter table - add constraint
-- ----------------------------------------------------------------------------------

-- add constraint
alter table reservation
add constraint CK_Reservation_PhoneNumberOREmail Check(PhoneNumber is not null or emailaddress is not null);

  
-- test constraint

Insert reservation (LastName, FirstName, PhoneNumber, IsMobilePhone, PartySize, ReservationTime)
Values('Ahmed', 'Arif1', '111-444-5555',0,4,'2023-11-09 21:30');


Insert reservation (LastName, FirstName, EmailAddress, PartySize, ReservationTime)
Values('Ahmed', 'Arif2', 'aa@gmail.com',4,'2023-11-09 21:30');

select *
from information_schema.check_constraints;


-- ----------------------------------------------------------------------------------
-- CODE ALONG: alter table - drop constraint
-- ----------------------------------------------------------------------------------

-- drop constraint


  alter table reservation
  drop constraint CK_Reservation_PhoneNumberOREmail;


-- ----------------------------------------------------------------------------------
-- CODE ALONG: alter table - add column
-- ----------------------------------------------------------------------------------

-- add column
  alter table reservation
    add column MiddleName  varchar(32)
    After FirstName;
  
  describe reservation;
  
  -- observe added column in table def
  
  
  
  -- --------------------------------------------------------------------------------
-- CODE ALONG: alter table - drop column
-- ----------------------------------------------------------------------------------

-- drop column
alter table reservation
drop column middlename;


-- observe column dropped in table def
describe reservation;


  -- --------------------------------------------------------------------------------
-- CODE ALONG: observe AUTO_INCREMENT
-- ----------------------------------------------------------------------------------

-- insert records into Reservation



-- view inserted records

select * from reservation;

-- insert record into Reservation; provide value 100 for ReservationId
Insert reservation (reservationid, lastName, FirstName, EmailAddress, PartySize, ReservationTime)
Values(100, 'Ahmed3', 'Arif3,', 'aa3@gmail.com',2,'2023-11-09 21:30');


-- observe inserted record

Insert reservation ( lastName, FirstName, EmailAddress, PartySize, ReservationTime)
Values('Ahmed4', 'Arif4,', 'aa3@gmail.com',3,'2023-11-29 21:30'),
        ('Ahmed5', 'Arif5,', 'aa5@gmail.com',5,'2023-11-19 21:30');

-- insert records into Reservation; do not provide value for ReservationId



-- view inserted records
select * from reservation;


-- set new AUTO_INCREMENT value
  alter table reservation 
  auto_increment=300;
  


-- insert records into Reservation

Insert reservation ( lastName, FirstName, EmailAddress, PartySize, ReservationTime)
Values('Ahmed8', 'Arif8,', 'aa8@gmail.com',3,'2023-11-29 21:30'),
        ('Ahmed9', 'Arif9,', 'aa9@gmail.com',5,'2023-11-19 21:30');

-- view inserted records

select * from reservation;

-- clear records from Reservation
truncate TABLE reservation;


-- insert records into reservation



-- view insertd records
select * from reservation;


-- --------------------------------------------------------------------------------
-- CODE ALONG: observe column LastUpdated
-- --------------------------------------------------------------------------------

-- insert record into Reservation
Insert reservation (LastName, FirstName, PhoneNumber, IsMobilePhone, PartySize, ReservationTime)
Values('Ahmed', 'Arif3', '111-444-5555',0,5,'2023-11-29 21:30'),
      ('Ahmed1', 'Arif4', '111-444-5555',0,5,'2023-11-09 21:30'),  
      ('Ahmed2', 'Arif5', '111-444-5555',0,2,'2023-11-19 21:30');


-- view inserted record
select * from reservation;



-- update columns for inserted record EXCEPT FOR LastUpdated
UPDATE reservation
SET LastName = 'AhmedN',
    FirstName='ArifN'
    where ReservationID=1;

UPDATE reservation
SET IsCancelled = default
    where ReservationID=1;
    
    UPDATE reservation
SET IsCancelled=1
    where ReservationID=1;

-- view updated record
select * from reservation;


-- one-to-one; cascading delete
-- -----------------------------------------------
-- CODE ALONG: create second table
-- -----------------------------------------------
/*
	Table
		ReservationNote
	Columns
		ReservationId			<-- PK,FK
		Note
*/

select * from reservation;

Create Table ReservationNote
(
  ReservationID INT UNSIGNED NOT NULL Primary Key,
  Note Varchar(120) Not Null
  
  Constraint FK_ReservationNote_ReservationID Foreign Key (ReservationID)
              Reference Reservation (ReservationID)
		      OnUpdate no action
              on Delete cascade
              
);  -- bad

CREATE TABLE ReservationNote
(
 ReservationId INT UNSIGNED NOT NULL PRIMARY KEY,
  Note VARCHAR(128) NOT NULL,
  
  CONSTRAINT FK_ReservationNote_ReservationId FOREIGN KEY (ReservationId)
       REFERENCES Reservation (ReservationId)
              ON UPDATE NO ACTION
              ON DELETE CASCADE
);
-- insert records into Reservation

select * from reservationnote;

-- view inserted records

select * from reservationnote;
Select * from reservation;
Insert ReservationNote (ReservationID, Note)
Values( 7, 'Testing');

-- attempt to insert record into ReservationNote using ReservationId that does NOT reference record in Reservation

Insert ReservationNote (ReservationID, Note)
Values( 3, 'Testing');

-- insert record into ReservationNote using ReservationId that references record in Reservation
select r.*, n.*
from reservation r 
left join reservationnote n on
r.ReservationId=n.ReservationId;


-- view joined Reservation and ResevationNote records
        


-- attempt to update Reservation.ReservationId for record that has associated record in ReservationNote
Update Reservation
Set Reservationid = 100
where reservationid=3;  -- enforcement works







-- delete record from Reservation that has associated record in ReservationNote

delete from reservation
where reservationid =3;

-- view joined Reservation and ResevationNote records

select * from reservationnote;

select r.*, n.*
from reservation r 
left join reservationnote n on
r.ReservationId=n.ReservationId;

-- -----------------------------------------------
-- CODE ALONG: rename table
-- -----------------------------------------------

-- rename table ReservationNote to ReservationInfo

Rename table reservationnote to ReservationInfo;
-- or usse 
alter table resrvationnote 
rename to reservationinfo;


-- observe table name change
select * from reservationinfo;


-- -----------------------------------------------
-- CODE ALONG: drop table
-- -----------------------------------------------

-- drop tables Reservation and ReservationInfo

drop table reservation, reservationinfo;