

/*
					SQL Project Name : Police Management System(PMS)
					Trainee Name	 : Md. Rezaul Karim 
					Trainee ID		 : 1285451
					Batch ID		 : CS/PNTL-A/62/01 

 --------------------------------------------------------------------------------

Table of Contents: DDL
			=> SECTION 01: Created a Database [PMS]
			=> SECTION 02: Created Appropriate Tables with column definition related to the project
			=> SECTION 03: ALTER, DROP AND MODIFY TABLES & COLUMNS
			=> SECTION 04: CREATE CLUSTERED AND NONCLUSTERED INDEX
			=> SECTION 05: CREATE SEQUENCE & ALTER SEQUENCE
			=> SECTION 06: CREATE A VIEW & ALTER VIEW
			=> SECTION 07: CREATE STORED PROCEDURE & ALTER STORED PROCEDURE
			=> SECTION 08: CREATE FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED) & ALTER FUNCTION
			=> SECTION 09: CREATE TRIGGER (FOR/AFTER TRIGGER)
			=> SECTION 10: CREATE TRIGGER (INSTEAD OF TRIGGER)
*/


/*
==============================  SECTION 01  ==============================
	   CHECK DATABASE EXISTANCE & CREATE DATABASE WITH ATTRIBUTES
==========================================================================
*/

USE master
GO

IF DB_ID('PMS') IS NOT NULL
DROP DATABASE PMS
GO

CREATE DATABASE PMS
ON
(
	NAME = 'pms_data',
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\pms_data.mdf',
	SIZE = 5MB,
	MAXSIZE = 50MB,
	FILEGROWTH = 5%
)
LOG ON
(
	NAME = 'pms_log',
	FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\pms_log.ldf',
	SIZE = 8MB,
	MAXSIZE = 40MB,
	FILEGROWTH = 5MB
)
GO

USE PMS
GO

/*
==============================  SECTION 02  ==============================
		          CREATE TABLES WITH COLUMN DEFINITION 
==========================================================================
*/

--============== Table with IDENTITY, PRIMARY KEY & nullability CONSTRAINT... ============--
--============== Table with PRIMARY KEY & FOREIGN KEY & DEFAULT CONSTRAINT... ============--
--============== Table with CHECK CONSTRAINT & set CONSTRAINT name ============--
--============== Table with composite PRIMARY KEY ============--

-- USE SCHEMA

CREATE TABLE Departments 
(
    department_id INT IDENTITY PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
)
GO

CREATE TABLE Officers
(
    officer_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    badge_number VARCHAR(50) NOT NULL,
    [rank] VARCHAR(50),
    date_joined DATE DEFAULT GETDATE(),
    contact_number VARCHAR(20),
    department_id INT REFERENCES Departments(department_id)
)
GO

CREATE TABLE Cases 
(
    case_id INT IDENTITY PRIMARY KEY,
    case_number VARCHAR(50) UNIQUE NOT NULL,
    case_status VARCHAR(50) CHECK (case_status IN ('Open', 'Closed', 'Pending')),
    start_date DATE DEFAULT GETDATE(),
    end_date DATE,
    officer_id INT REFERENCES Officers(officer_id)
)
GO

CREATE TABLE Crimes 
(
    crime_id INT IDENTITY PRIMARY KEY,
    crime_type VARCHAR(100) NOT NULL,
    [description] TEXT,
    date_reported DATE DEFAULT GETDATE(),
    location VARCHAR(255),
    severity VARCHAR(50) NULL,
    case_id INT REFERENCES Cases(case_id)
)
GO

CREATE TABLE Suspects 
(
    suspect_id INT IDENTITY PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
    date_of_birth DATE,
    nationality VARCHAR(100) NOT NULL,
    address VARCHAR(255) NULL
)
GO

CREATE TABLE Incidents 
(
    incident_id INT IDENTITY PRIMARY KEY,
    incident_type VARCHAR(100) NOT NULL,
    description TEXT,
    incident_date DATE DEFAULT GETDATE(),
    location VARCHAR(255),
    officer_id INT REFERENCES Officers(officer_id)
)
GO

CREATE TABLE Arrests
(
    arrest_id INT IDENTITY PRIMARY KEY,
    suspect_id INT REFERENCES Suspects(suspect_id),
    arrest_date DATE DEFAULT GETDATE(),
    officer_id INT REFERENCES Officers(officer_id),
    charge VARCHAR(255)
)
GO

CREATE TABLE Evidence 
(
    evidence_id INT IDENTITY PRIMARY KEY,
    case_id INT REFERENCES Cases(case_id),
    evidence_type VARCHAR(100) NOT NULL,
    description TEXT,
    date_collected DATE DEFAULT GETDATE(),
)
GO

CREATE TABLE CourtHearings 
(
    hearing_id INT IDENTITY PRIMARY KEY,
    case_id INT REFERENCES Cases(case_id) NULL,
    hearing_date DATE DEFAULT GETDATE() NULL,
    judge_name VARCHAR(255) NULL,
    verdict TEXT NULL,
    punishment TEXT NULL
)
GO

--============== CREATE A SCHEMA ============--

CREATE SCHEMA PoliceManagement
GO
--============== USE SCHEMA IN A TABLE ============--

CREATE TABLE PoliceManagement.Crimes 
(
    crime_id INT IDENTITY(1,1) PRIMARY KEY,
    crime_type VARCHAR(100) NOT NULL,
    description TEXT,
    date_reported DATE DEFAULT GETDATE(),
    [location] VARCHAR(255) NULL
)
GO

/*
==============================  SECTION 03  ==============================
		          ALTER, DROP AND MODIFY TABLES & COLUMNS
==========================================================================
*/

--============== ALTER TABLE SCHEMA AND TRANSFER TO [DBO] ============--

ALTER SCHEMA PoliceManagement TRANSFER PoliceManagement.Officers
GO

--============== Update column definition ============--

ALTER TABLE Officers
ALTER COLUMN contact_number VARCHAR(50) NOT NULL
GO

--============== ADD column with DEFAULT CONSTRAINT ============--
ALTER TABLE Officers
ADD is_active BIT DEFAULT 1
GO

--============== ADD CHECK CONSTRAINT with defining name ============--

ALTER TABLE Officers
ADD CONSTRAINT CHK_Rank CHECK (rank IN ('Constable', 'Sergeant', 'Inspector', 'Chief'))
GO

--============== DROP COLUMN ============--

ALTER TABLE dbo.Officers
DROP COLUMN is_active
GO

--============== DROP TABLE ============--

DROP TABLE dbo.Officers
GO

--============== DROP SCHEMA ============--

DROP SCHEMA PoliceManagement
GO

/*
==============================  SECTION 04  ==============================
		          CREATE CLUSTERED AND NONCLUSTERED INDEX
==========================================================================
*/

-- Clustered Index

CREATE CLUSTERED INDEX IX_Cases_CaseID
ON Cases (case_id);
GO

-- Nonclustered Index
CREATE NONCLUSTERED INDEX IX_Cases_CaseDate
ON Cases (case_iD)
GO

/*
==============================  SECTION 05  ==============================
							 CREATE SEQUENCE
==========================================================================
*/

CREATE SEQUENCE CaseNumberSeq
    START WITH 1
    INCREMENT BY 1
GO

--============== ALTER SEQUENCE ============--

ALTER SEQUENCE CaseNumberSeq
    RESTART WITH 1000
GO


/*
==============================  SECTION 06  ==============================
							  CREATE A VIEW
==========================================================================
*/

-- Create a View for getting officer and their department details
CREATE VIEW VW_OfficerDepartmentDetails 
AS
	SELECT o.officer_id, o.first_name, o.last_name, d.department_name
	FROM Officers o
	JOIN Departments d ON o.department_id = d.department_id
GO

-- Alter the View to include the officer's rank
ALTER VIEW VW_OfficerDepartmentDetails AS
	SELECT o.officer_id, o.first_name, o.last_name, o.rank, d.department_name
	FROM Officers o
	JOIN Departments d ON o.department_id = d.department_id
GO

/*
==============================  SECTION 07  ==============================
							 STORED PROCEDURE
==========================================================================
*/
--============== STORED PROCEDURE for insert data using parameter ============--
CREATE PROCEDURE InsertOfficers
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @BadgeNumber VARCHAR(50),
    @Rank VARCHAR(50),
    @DepartmentID INT,
    @ContactNumber VARCHAR(20)
AS
BEGIN
    INSERT INTO Officers
	(first_name, last_name, badge_number, rank, department_id, contact_number, date_joined)
    VALUES(@FirstName, @LastName, @BadgeNumber, @Rank, @DepartmentID, @ContactNumber, GETDATE())
END
GO

--============== STORED PROCEDURE for insert data with OUTPUT parameter ============--
CREATE PROCEDURE InsertOfficersWithOutput
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @BadgeNumber VARCHAR(50),
    @Rank VARCHAR(50),
    @DepartmentID INT,
    @ContactNumber VARCHAR(20),
    @NewOfficerID INT OUTPUT
AS
BEGIN
    BEGIN TRY
        INSERT INTO Officers (first_name, last_name, badge_number, rank, department_id, contact_number, date_joined)
        VALUES (@FirstName, @LastName, @BadgeNumber, @Rank, @DepartmentID, @ContactNumber, GETDATE())
        SET @NewOfficerID = SCOPE_IDENTITY()
    END TRY
    BEGIN CATCH
        SET @NewOfficerID = NULL
        PRINT ERROR_MESSAGE()
    END CATCH
END
GO

--============== STORED PROCEDURE for UPDATE data ============--
CREATE PROCEDURE UpdateOfficer
    @OfficerID INT,
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @ContactNumber VARCHAR(20)
AS
BEGIN
    UPDATE Officers
    SET first_name = @FirstName,
        last_name = @LastName,
        contact_number = @ContactNumber
    WHERE officer_id = @OfficerID;
END
GO

--============== STORED PROCEDURE for DELETE Table data ============--
CREATE PROCEDURE DeleteOfficers
    @OfficerID INT
AS
BEGIN
    DELETE FROM Officers
    WHERE officer_id = @OfficerID
END
GO

--============== TRY CATCH IN A STORED PROCEDURE & RAISERROR WITH ERROR NUMBER AND ERROR MESSAGE ============--
CREATE PROCEDURE InsertOfficerWithErrorHandling
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @BadgeNumber VARCHAR(50),
    @Rank VARCHAR(50),
    @DepartmentID INT,
    @ContactNumber VARCHAR(20)
AS
BEGIN
    BEGIN TRY
        INSERT INTO Officers (first_name, last_name, badge_number, rank, department_id, contact_number, date_joined)
        VALUES (@FirstName, @LastName, @BadgeNumber, @Rank, @DepartmentID, @ContactNumber, GETDATE())
    END TRY
    BEGIN CATCH
        -- Capture error information
        DECLARE @ErrorNumber INT = ERROR_NUMBER()
        DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE()

        -- Raise a custom error
        RAISERROR ('Error %d: %s', 16, 1, @ErrorNumber, @ErrorMessage)
    END CATCH
END
GO

--============== ALTER STORED PROCEDURE ============--
ALTER PROCEDURE UpdateOfficers
    @OfficerID INT,
    @FirstName VARCHAR(100),
    @LastName VARCHAR(100),
    @Rank VARCHAR(50),
    @ContactNumber VARCHAR(20)
AS
BEGIN
    UPDATE Officers
    SET first_name = @FirstName,
        last_name = @LastName,
        rank = @Rank,
        contact_number = @ContactNumber
    WHERE officer_id = @OfficerID
END
GO

/*
==============================  SECTION 08  ==============================
								 FUNCTION
==========================================================================
*/

--============== A SCALAR FUNCTION ============--

-- Create a Scalar Function to get the full name of an officer
CREATE FUNCTION GetOfficerFullName (@officer_id INT)
RETURNS VARCHAR(200)
AS
BEGIN
    DECLARE @full_name VARCHAR(200);
    SELECT @full_name = first_name + ' ' + last_name FROM Officers WHERE officer_id = @officer_id
    RETURN @full_name;
END
GO

-- Alter the Scalar Function to include rank in the full name
ALTER FUNCTION GetOfficerFullName (@officer_id INT)
RETURNS VARCHAR(250)
AS
BEGIN
    DECLARE @full_name VARCHAR(250);
    SELECT @full_name = first_name + ' ' + last_name + ', Rank: ' + rank FROM Officers WHERE officer_id = @officer_id
    RETURN @full_name;
END
GO

-- Create a Simple Table-Valued Function to get all cases handled by an officer
CREATE FUNCTION GetCasesByOfficer (@officer_id INT)
RETURNS TABLE
AS
RETURN
    SELECT case_id, case_number, case_status
    FROM Cases
    WHERE officer_id = @officer_id
GO

-- Create a Multi-Statement Table-Valued Function to get incident details by officer
CREATE FUNCTION GetIncidentDetailsByOfficer (@officer_id INT)
RETURNS @IncidentDetails TABLE
(
    incident_id INT,
    incident_type VARCHAR(100),
    incident_date DATE
)
AS
BEGIN
    INSERT INTO @IncidentDetails
    SELECT incident_id, incident_type, incident_date
    FROM Incidents
    WHERE officer_id = @officer_id
    RETURN;
END
GO

-- Alter the Multi-Statement Table-Valued Function to add location to the result
ALTER FUNCTION GetIncidentDetailsByOfficer (@officer_id INT)
RETURNS @IncidentDetails TABLE
(
    incident_id INT,
    incident_type VARCHAR(100),
    incident_date DATE,
    location VARCHAR(255)
)
AS
BEGIN
    INSERT INTO @IncidentDetails
    SELECT incident_id, incident_type, incident_date, location
    FROM Incidents
    WHERE officer_id = @officer_id
    RETURN;
END
GO

/*
==============================  SECTION 10  ==============================
							INSTEAD OF TRIGGER
==========================================================================
*/

-- Create an AFTER INSERT trigger to log when a new arrest is made
CREATE TRIGGER LogNewArrest
ON Arrests
AFTER INSERT
AS
BEGIN
    DECLARE @arrest_id INT, @suspect_id INT;
    SELECT @arrest_id = arrest_id, @suspect_id = suspect_id FROM INSERTED;

    INSERT INTO ArrestLog (arrest_id, suspect_id, log_date)
    VALUES (@arrest_id, @suspect_id, GETDATE())
END
GO

-- Create a FOR DELETE trigger to enforce rules before deleting a record
CREATE TRIGGER PreventOfficerDeletion
ON Officers
FOR DELETE
AS
BEGIN
    DECLARE @officer_id INT
    SELECT @officer_id = officer_id FROM DELETED

    -- Prevent deletion if officer is assigned to an active case
    IF EXISTS (SELECT 1 FROM Cases WHERE officer_id = @officer_id AND case_status = 'Open')
    BEGIN
        PRINT 'Cannot delete officer; they are assigned to an open case.'
        ROLLBACK
    END
END
GO

--============== AN INSTEAD OF TRIGGER ON VIEW ============--

CREATE TRIGGER trg_OfficerDetails_Insert
ON VW_OfficerDepartmentDetails
INSTEAD OF INSERT
AS
BEGIN
    -- Insert into the Officers table using data from the inserted pseudo-table
    INSERT INTO Officers (first_name, last_name, badge_number, rank, department_id, contact_number)
    SELECT
        first_name, last_name, badge_number, rank, department_id, contact_number
    FROM inserted;
END
GO

--============== ALTER TRIGGER ============--

ALTER TRIGGER trg_OfficerDetails_Insert
ON VW_OfficerDepartmentDetails
INSTEAD OF INSERT
AS
BEGIN
    -- Check if the badge number already exists
    IF EXISTS (SELECT 1 FROM Officers WHERE badge_number IN (SELECT badge_number FROM inserted))
    BEGIN
        -- If the badge number exists, raise an error
        RAISERROR ('Duplicate badge number. The officer could not be added.', 16, 1)
        RETURN;
    END

    -- Insert into the Officers table using data from the inserted pseudo table
    INSERT INTO Officers 
	(
        first_name, last_name, badge_number, rank, department_id, contact_number
    )
    SELECT
        first_name, last_name, badge_number, rank, department_id, contact_number
    FROM inserted
END
GO
