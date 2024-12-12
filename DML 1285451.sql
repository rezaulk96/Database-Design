

/*

					SQL Project Name	 : Police Management System(PMS)
					Trainee Name		 : Md. Rezaul Karim 
					Trainee ID		 : 1285451
					Batch ID		 : CS/PNTL-A/62/01 
 --------------------------------------------------------------------------------
Table of Contents: DML
			=> SECTION 01: INSERT DATA USING INSERT INTO KEYWORD
			=> SECTION 02: INSERT DATA THROUGH STORED PROCEDURE
				SUB SECTION => 2.1 : INSERT DATA THROUGH STORED PROCEDURE WITH AN OUTPUT PARAMETER 
				SUB SECTION => 2.2 : INSERT DATA USING SEQUENCE VALUE
			=> SECTION 03: UPDATE DELETE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.1 : UPDATE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.2 : DELETE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.3 : STORED PROCEDURE WITH TRY CATCH AND RAISE ERROR
			=> SECTION 04: INSERT UPDATE DELETE DATA THROUGH VIEW
				SUB SECTION => 4.1 : INSERT DATA through view
				SUB SECTION => 4.2 : UPDATE DATA through view
				SUB SECTION => 4.3 : DELETE DATA through view
			=> SECTION 05: RETREIVE DATA USING FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED)
			=> SECTION 06: TEST TRIGGER (FOR/AFTER TRIGGER ON TABLE, INSTEAD OF TRIGGER ON TABLE & VIEW)
			=> SECTION 07: QUERY
				SUB SECTION => 7.01 : SELECT FROM TABLE
				SUB SECTION => 7.02 : SELECT FROM VIEW
				SUB SECTION => 7.03 : SELECT INTO
				SUB SECTION => 7.04 : IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE
				SUB SECTION => 7.05 : INNER JOIN WITH GROUP BY CLAUSE
				SUB SECTION => 7.06 : OUTER JOIN
				SUB SECTION => 7.07 : CROSS JOIN
				SUB SECTION => 7.08 : TOP CLAUSE WITH TIES
				SUB SECTION => 7.09 : DISTINCT
				SUB SECTION => 7.10 : COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR
				SUB SECTION => 7.11 : LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE
				SUB SECTION => 7.12 : OFFSET FETCH
				SUB SECTION => 7.13 : UNION
				SUB SECTION => 7.14 : EXCEPT INTERSECT
				SUB SECTION => 7.15 : AGGREGATE FUNCTIONS
				SUB SECTION => 7.16 : GROUP BY & HAVING CLAUSE
				SUB SECTION => 7.17 : ROLLUP & CUBE OPERATOR
				SUB SECTION => 7.18 : GROUPING SETS
				SUB SECTION => 7.19 : SUB-QUERIES (INNER, CORRELATED)
				SUB SECTION => 7.20 : EXISTS
				SUB SECTION => 7.21 : CTE
				SUB SECTION => 7.22 : MERGE
				SUB SECTION => 7.23 : BUILT IN FUNCTION
				SUB SECTION => 7.24 : CASE
				SUB SECTION => 7.25 : IIF
				SUB SECTION => 7.26 : COALESCE & ISNULL
				SUB SECTION => 7.27 : WHILE
				SUB SECTION => 7.28 : GROPING FUNCTION
				SUB SECTION => 7.29 : RANKING FUNCTION
				SUB SECTION => 7.30 : IF ELSE & PRINT
				SUB SECTION => 7.31 : TRY CATCH
				SUB SECTION => 7.32 : GOTO
				SUB SECTION => 7.33 : WAITFOR
				SUB SECTION => 7.34 : sp_helptext
				SUB SECTION => 7.35 : TRANSACTION WITH SAVE POINT
*/


/*
==============================  SECTION 01  ==============================
					INSERT DATA USING INSERT INTO KEYWORD
==========================================================================
*/

USE PMS
GO

INSERT INTO Departments (department_name) VALUES
('Patrol Division'),
('Criminal Investigations'),
('Traffic Enforcement'),
('Forensic Science'),
('Internal Affairs'),
('Public Affairs')
GO
SELECT * FROM Departments
GO

INSERT INTO Officers (first_name, last_name, badge_number, [rank], contact_number, department_id) VALUES
('John', 'Doe', 'A12345', 'Chief', '555-0101', 1),
('Jane', 'Smith', 'B67890', 'Lieutenant', '555-0102', 2),
('Michael', 'Johnson', 'C11223', 'Constable', '555-0103', 1),
('Emily', 'Davis', 'D44556', 'Constable', '555-0104', 3),
('David', 'Wilson', 'E78901', 'Sergeant', '555-0105', 2),
('Sarah', 'Brown', 'F22334', 'Constable', '555-0106', 3),
('Chris', 'Jones', 'G55678', 'Lieutenant', '555-0107', 1),
('Lisa', 'Miller', 'H88990', 'Constable', '555-0108', 2),
('James', 'Taylor', 'I33445', 'Sergeant', '555-0109', 3),
('Mary', 'Moore', 'J66789', 'Constable', '555-0110', 1)
GO

SELECT * FROM Officers
GO

INSERT INTO Cases (case_number, case_status, end_date)
VALUES
('CASE001', 'Open', NULL),
('CASE002', 'Closed', '2023-07-15'),
('CASE003', 'Pending', NULL),
('CASE004', 'Open', NULL),
('CASE005', 'Closed', '2023-09-30'),
('CASE006', 'Pending', NULL),
('CASE007', 'Closed', '2024-01-05'),
('CASE008', 'Open', NULL),
('CASE009', 'Open', NULL),
('CASE010', 'Closed', '2024-02-01')
GO

INSERT INTO Crimes (crime_type, [description], location, severity)
VALUES
('Robbery','A robbery occurred at a convenience store. The suspect threatened the cashier and took cash from the register.','Mirpur, Dhaka','High'),
('Homicide','A fatal shooting occurred during a gang-related dispute in an alley near downtown.', 'Dhanmondi, Dhaka','High'),
('Fraud', 'Suspected credit card fraud at a local electronics store, where stolen cards were used to make large purchases.', 'Best Buy, 210 Oak Rd', 'Normal'),
('Drug Possession', 'An individual was arrested for possession of illegal substances during a routine traffic stop.', 'Highway 101', 'Medium')
GO
SELECT * FROM Crimes
GO

INSERT INTO Suspects VALUES 
('David', 'Brown', 'Male', '1985-07-15', 'USA', '456 Oak St'),
('Emily', 'Davis', 'Female', '1990-02-20', 'Canada', '789 Pine St'),
('John', 'Miller', 'Male', '1988-12-05', 'USA', '101 Elm St')
GO
SELECT * FROM Suspects
GO

INSERT INTO Incidents(incident_type,description,location) VALUES 
('Domestic Violence', 'Physical altercation reported', '456 Oak St'),
('Hit and Run', 'Car accident with fleeing driver', '123 Main St'),
('Traffic Violation', 'Speeding on highway', 'Highway 101')
GO

SELECT * FROM Incidents
GO

--============== Insert data by specifying column name ============--
INSERT INTO Arrests (suspect_id, arrest_date, officer_id, charge) VALUES
(1, '2024-01-10', 17, 'Burglary'),
(2, '2024-02-12', 18, 'Assault'),
(3, '2024-03-15', 19, 'Theft'),
(4, '2024-04-20', 20, 'Drug Possession'),
(5, '2024-05-22', 21, 'Fraud'),
(6, '2024-06-10', 22, 'Vandalism'),
(7, '2024-07-05', 23, 'Robbery'),
(8, '2024-08-18', 24, 'Homicide'),
(9, '2024-09-25', 25, 'Domestic Violence'),
(10, '2024-09-25', 26, 'Domestic Violence')
GO

--============== Insert data by column sequence ============--

INSERT INTO Evidence (evidence_type, description) VALUES
('Photograph', 'Photographs of the crime scene taken by the responding officer.'),
('Weapon', 'A firearm found at the scene of the assault, with fingerprints on it.'),
('Fingerprint', 'Latent fingerprints found on the stolen vehicle.'),
('Drugs', 'Bag of suspected illegal drugs found in the suspect’s car during a search.'),
('Documents', 'Fraudulent bank documents found in the suspect’s apartment.'),
('Surveillance Video', 'Video footage showing the suspect vandalizing the property.'),
('Cash', 'Large sum of cash discovered during the robbery investigation.'),
('Bullet Casings', 'Several bullet casings found at the scene of the homicide.'),
('Clothing', 'Clothing items found at the scene of the domestic violence incident.'),
('Arson Evidence', 'Evidence of accelerants used to start the fire at the abandoned warehouse.')
GO


INSERT INTO CourtHearings (judge_name, verdict, punishment) VALUES
('Judge John Smith', 'Guilty', '10 years in prison'),
('Judge Sarah Davis', 'Not Guilty', 'N/A'),
('Judge Michael Brown', 'Guilty', '5 years probation'),
('Judge Lisa White', 'Guilty', '2 years in prison'),
('Judge Robert Johnson', 'Guilty', '15 years in prison'),
('Judge Patricia Lee', 'Not Guilty', 'N/A'),
('Judge James Wilson', 'Guilty', '7 years in prison'),
('Judge Angela Clark', 'Guilty', 'Life imprisonment'),
('Judge Charles Turner', 'Guilty', '2 years of community service'),
('Judge Emily Roberts', 'Guilty', '20 years in prison')
GO

SELECT * FROM Departments
SELECT * FROM Officers
SELECT * FROM Cases
SELECT * FROM Crimes
SELECT * FROM Suspects
SELECT * FROM Incidents
SELECT * FROM Arrests
SELECT * FROM Evidence
SELECT * FROM CourtHearings
GO

/*
==============================  SECTION 02  ==============================
					INSERT DATA THROUGH STORED PROCEDURE
==========================================================================
*/

EXEC Officers ('Harun','Or Rashid','B5678','Superintendent of Police','2','555-6789')
EXEC Officers ('Biplob','Kumar','B5679','Asst. SP','3','444-6789')
EXEC Officers ('Kamal','Khan','B5677','ASP','4','332-6759')
EXEC Officers ('Rahat','Khan','B5371','ASP','4','123-6288')
EXEC Officers ('Rabiul','Bashar','B5612','OC','5','534-6712')
EXEC Officers ('Faruk','Bin','B7673','SI','7','513-6569')
GO
SELECT * FROM Officers
GO

--============== INSERT DATA THROUGH STORED PROCEDURE WITH AN OUTPUT PARAMETER ============--

DECLARE @NewOfficerID INT
EXEC InsertOfficerWithOutput 'Harun','Or Rashid','B5678','Superintendent of Police','2','555-6789' @OfficerID = @NewOfficerID OUTPUT
PRINT 'New Officer ID: ' + CAST(@NewOfficerID AS NVARCHAR(10))
GO

-- insert data with relation

INSERT INTO Officers VALUES
(1, 1, 1, 2, 1),
(2, 2, 2, 2, 2),
(3, 10, 2, 1, 10),
(4, 9, 1, 1, 9),
(5, 8, 2, 1, 8),
(6, 7, 1, 2, 7),
(7, 6, 1, 2, 6)
GO
SELECT * FROM Officers
GO

INSERT INTO Departments VALUES
('Criminal Investigation'), ('Traffic Control'), ('Forensic Science'), ('Cyber Crime')
GO

INSERT INTO Crimes VALUES 
('Burglary', 'Residential break-in', '2024-11-01', '123 Main St', 'High', 1),
('Robbery', 'Bank robbery', '2024-10-10', 'Downtown Bank', 'Critical', 2),
('Vandalism', 'Graffiti on public property', '2024-09-25', 'City Park', 'Low', 3)
GO

INSERT INTO Suspects VALUES 
('David', 'Brown', 'Male', '1985-07-15', 'DHA', '456 Oak St'),
('Emily', 'Davis', 'Female', '1990-02-20', 'CTG', '789 Pine St'),
('John', 'Miller', 'Male', '1988-12-05', 'BAR', '101 Elm St')
GO

--============== INSERT DATA USING SEQUENCE VALUE ============--

INSERT INTO CaseNumberSeq VALUES((NEXT VALUE FOR seqNum), NULL)
GO
SELECT * FROM CaseNumberSeq
GO

/*
==============================  SECTION 03  ==============================
			UPDATE DELETE DATA THROUGH STORED PROCEDURE
==========================================================================
*/

--============== UPDATE DATA THROUGH STORED PROCEDURE ============--

EXEC InsertOfficers 'John','Doe','B1234','Sergeant',1,'555-1234'
EXEC InsertOfficers 'Jane','Smith','B1235','Lieutenant',2,'555-1235'
EXEC InsertOfficers 'Harun','Lord','B1236','Constable',3,'555-1236'
EXEC InsertOfficers 'Lord','Ripon','B1237','Sergeant',4,'555-1237'
EXEC InsertOfficers 'Lord','Tasrif','B1238','Constable',5,'555-1238'
EXEC InsertOfficers 'Lord','Liton','B1239','Constable',1,'555-1239'
EXEC InsertOfficers 'Lord','Shanto','B1244','Constable',1,'555-1244'
EXEC InsertOfficers 'Lord','Miraz','B1245','Constable',1,'555-1245'
EXEC InsertOfficers 'Lord','Musfik','B1246','Constable',1,'555-1246'
EXEC InsertOfficers 'Lord','Korn','B1247','Constable',1,'555-1247'
GO

--============== DELETE DATA THROUGH STORED PROCEDURE ============--

-- STORED PROCEDURE for Delete CourseSales
EXEC InsertOfficers A123
EXEC InsertOfficers B456
GO
SELECT * FROM UpdateOfficer
GO

--============== STORED PROCEDURE WITH TRY CATCH AND RAISE ERROR ============--

EXEC spRaisError
GO

/*
==============================  SECTION 04  ==============================
					INSERT UPDATE DELETE DATA THROUGH VIEW
==========================================================================
*/

INSERT INTO VW_OfficerDepartmentDetails (first_name, last_name, department_id, contact_number) VALUES ('James', 'Smith', 1, '555-1234')
INSERT INTO VW_OfficerDepartmentDetails (first_name, last_name, department_id, contact_number) VALUES ('Milar', 'K', 2, '546-2134')
INSERT INTO VW_OfficerDepartmentDetails (first_name, last_name, department_id, contact_number) VALUES ('Kamerun', 'Smith', 3, '231-3243')
GO
SELECT * FROM VW_OfficerDepartmentDetails
GO

--============== UPDATE DATA through view ============--
UPDATE VW_OfficerDepartmentDetails
SET contact_number = '555-9876'
WHERE officer_id = 1
GO

SELECT * FROM VW_OfficerDepartmentDetails
GO

--============== DELETE DATA through view ============--

DELETE FROM VW_OfficerDepartmentDetails
WHERE officer_id = 1
GO

--Scalar Function to Retrieve Officer's Full Name
SELECT dbo.GetOfficerFullName(1) AS OfficerFullName;
GO

--Inline Table-Valued Function to Retrieve All Officers in a Specific Department
SELECT * FROM dbo.GetOfficersByDepartment(1);
GO

--Multi-Statement Table-Valued Function to Retrieve Officers with Additional Calculations
SELECT * FROM dbo.GetOfficersWithDetails(2);
GO

/*
==============================  SECTION 06  ==============================
							   TEST TRIGGER
==========================================================================
*/
--============== FOR/AFTER TRIGGER ON TABLE ============--
-- Insert a new arrest
INSERT INTO Arrests (suspect_id, arrest_date)
VALUES (1, GETDATE())
GO

SELECT * FROM Arrests
GO

--============== INSTEAD OF TRIGGER ON TABLE ============--
-- Attempting to insert into Arrests
INSERT INTO Arrests (arrest_id, suspect_id, arrest_date)
VALUES (101, 2001, GETDATE());
GO
-- Attempting to delete an officer
DELETE FROM Officers WHERE officer_id = 1
GO

--============== AN INSTEAD OF TRIGGER ON VIEW ============--

-- Insert a new officer via the view
INSERT INTO VW_OfficerDetails (officer_id, first_name, last_name, department_id)
VALUES (1001, 'John', 'Doe', 2)
GO

/*
==============================  SECTION 07  ==============================
								  QUERY
==========================================================================
*/

--============== 7.01 A SELECT STATEMENT TO GET RESULT SET FROM A TABLE ============--
SELECT * FROM Officers
GO

--============== 7.02 A SELECT STATEMENT TO GET information FROM A VIEW ============--
SELECT * FROM v_CrimeDetails;  -- Assuming a view named v_CrimeDetails exists
GO

--============== 7.03 SELECT INTO > BACKUP SET TO A NEW TEMPORARY TABLE ============--
SELECT * INTO Officers_Backup FROM Officers;
GO

--============== 7.04 IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE ============--
SELECT O.OfficerID, O.Name, D.DepartmentName
FROM Officers O, Departments D
WHERE O.DepartmentID = D.DepartmentID
ORDER BY O.Name;
GO

--============== 7.05 INNER JOIN WITH GROUP BY CLAUSE ============--
SELECT D.DepartmentName, COUNT(O.OfficerID) AS OfficerCount
FROM Officers O
INNER JOIN Departments D ON O.DepartmentID = D.DepartmentID
GROUP BY D.DepartmentName;
GO

--============== 7.06 OUTER JOIN ============--
SELECT O.Name, A.ArrestDate
FROM Officers O
LEFT OUTER JOIN Arrests A ON O.OfficerID = A.OfficerID;
GO

--============== 7.07 CROSS JOIN ============--
SELECT O.Name, S.SuspectName
FROM Officers O
CROSS JOIN Suspects S;
GO

--============== 7.08 TOP CLAUSE WITH TIES ============--
SELECT TOP 5 WITH TIES OfficerID, Name
FROM Officers
ORDER BY OfficerID;
GO

--============== 7.09 DISTINCT ============--
SELECT DISTINCT CrimeType FROM Crimes;
GO

--============== 7.10 COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR ============--
SELECT * 
FROM Cases 
WHERE CaseDate BETWEEN '2024-01-01' AND '2024-12-31'
AND CrimeType = 'Theft' 
AND Status = 'Open';
GO

--============== 7.11 LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE ============--
SELECT * 
FROM Suspects 
WHERE Name LIKE 'John%' 
AND CrimeType IN ('Burglary', 'Assault')
AND ArrestDate IS NULL;
GO

--============== 7.12 OFFSET FETCH ============--
SELECT OfficerID, Name
FROM Officers
ORDER BY OfficerID
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
GO

--============== 7.13 UNION ============--
SELECT OfficerID, Name FROM Officers
UNION
SELECT OfficerID, Name FROM Arrests;


--============== 7.14 EXCEPT INTERSECT ============--
SELECT OfficerID FROM Officers
EXCEPT
SELECT OfficerID FROM Arrests;

SELECT OfficerID FROM Officers
INTERSECT
SELECT OfficerID FROM Arrests;
GO

--============== 7.15 AGGREGATE FUNCTION ============--
SELECT COUNT(*), AVG(ArrestDate), MIN(ArrestDate), MAX(ArrestDate)
FROM Arrests;
GO

--============== 7.16 AGGREGATE FUNCTION WITH GROUP BY & HAVING CLAUSE ============--
SELECT CrimeType, COUNT(*) AS CrimeCount
FROM Crimes
GROUP BY CrimeType
HAVING COUNT(*) > 5;
GO

--============== 7.17 ROLLUP & CUBE OPERATOR ============--
SELECT DepartmentID, CrimeType, COUNT(*) 
FROM Crimes
GROUP BY DepartmentID, CrimeType
WITH ROLLUP;
GO

--============== 7.18 GROUPING SETS ============--
SELECT DepartmentID, CrimeType, COUNT(*)
FROM Crimes
GROUP BY GROUPING SETS ((DepartmentID), (CrimeType), (DepartmentID, CrimeType));
GO

--============== 7.19 SUB-QUERIES============--
SELECT OfficerID, Name 
FROM Officers O
WHERE EXISTS (SELECT 1 FROM Arrests A WHERE A.OfficerID = O.OfficerID AND A.ArrestDate > '2024-01-01');

SELECT OfficerID, Name
FROM Officers O
WHERE O.OfficerID IN (SELECT OfficerID FROM Arrests WHERE CrimeType = 'Assault');
GO

--============== 7.20 EXISTS ============--
SELECT Name 
FROM Officers O
WHERE EXISTS (SELECT 1 FROM Arrests A WHERE A.OfficerID = O.OfficerID);
GO

--============== 7.21 CTE ============--
WITH OfficerStats AS (
    SELECT OfficerID, COUNT(*) AS CasesHandled
    FROM Cases
    GROUP BY OfficerID
)
SELECT * FROM OfficerStats WHERE CasesHandled > 10;
GO

--============== 7.22 MERGE ============--
MERGE INTO Officers O
USING NewOfficers NO
ON O.OfficerID = NO.OfficerID
WHEN MATCHED THEN
    UPDATE SET O.Name = NO.Name
WHEN NOT MATCHED THEN
    INSERT (OfficerID, Name) VALUES (NO.OfficerID, NO.Name);
GO

--============== 7.23 BUILT IN FUNCTION ============--
SELECT GETDATE() AS CurrentDate;
SELECT LEN(Name) AS NameLength FROM Officers;
GO

--============== 7.24 CASE ============--
SELECT OfficerID, Name,
    CASE 
        WHEN ArrestCount > 10 THEN 'Veteran'
        WHEN ArrestCount <= 10 THEN 'New'
        ELSE 'Unknown'
    END AS OfficerStatus
FROM Officers;
GO

--============== 7.25 IIF ============--
SELECT OfficerID, IIF(ArrestCount > 10, 'Veteran', 'New') AS OfficerStatus
FROM Officers;
GO

--============== 7.26 COALESCE & ISNULL ============--
SELECT OfficerID, COALESCE(ArrestCount, 0) AS ArrestCount
FROM Officers;

SELECT OfficerID, ISNULL(ArrestCount, 0) AS ArrestCount
FROM Officers;
GO


--============== 7.27 WHILE ============--
DECLARE @Counter INT = 0;
WHILE @Counter < 5
BEGIN
    PRINT 'Officer #' + CAST(@Counter AS VARCHAR);
    SET @Counter = @Counter + 1;
END;
GO

--============== 7.28 GROPING FUNCTION ============--
SELECT OfficerID, RANK() OVER (ORDER BY ArrestDate) AS Rank
FROM Arrests;
GO


--============== 7.29 RANKING FUNCTION ============--
SELECT OfficerID, ROW_NUMBER() OVER (PARTITION BY DepartmentID ORDER BY ArrestDate DESC) AS RowNum
FROM Arrests;
GO


--============== 7.30 IF ELSE & PRINT ============--

IF EXISTS (SELECT 1 FROM Officers WHERE Name = 'John Doe')
    PRINT 'Officer Found'
ELSE
    PRINT 'Officer Not Found';
GO


--============== 7.31 TRY CATCH ============--
BEGIN TRY
    -- Code that might throw an error
    SELECT * FROM NonExistingTable;
END TRY
BEGIN CATCH
    PRINT 'Error Occurred: ' + ERROR_MESSAGE();
END CATCH;
GO


--============== 7.32 GOTO ============--
IF EXISTS (SELECT 1 FROM Officers WHERE Name = 'John Doe')
    GOTO OfficerFound;

OfficerNotFound:
    PRINT 'Officer Not Found';
    RETURN;

OfficerFound:
    PRINT 'Officer Found';
GO


--============== 7.33 WAITFOR ============--
WAITFOR DELAY '00:00:10';  -- Waits for 10 seconds
GO


--============== 7.34 SYSTEM STORED PROCEDURE(sp_helptext) TO GET UNENCRYPTED STORED PROCEDURE SCRIPT  ============--
EXEC sp_helptext 'ViewName'; -- Shows the text of the view definition
GO


--============== 7.35 TRANSACTION WITH SAVE POINT  ============--
BEGIN TRANSACTION;
    SAVE TRANSACTION SavePoint1;
    -- Some SQL operation
    ROLLBACK TRANSACTION SavePoint1;  -- Rolls back to the save point
COMMIT TRANSACTION;
GO
