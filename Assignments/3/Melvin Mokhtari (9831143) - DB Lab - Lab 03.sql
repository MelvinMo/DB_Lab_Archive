---- DATABASE DESIGN 1 Lab 03 @ IUT
---- FULL NAME: Melvin Mokhtari
---- STUDENT ID: 9831143


--- Answer to Question 1-A

CREATE LOGIN loglab3 WITH PASSWORD = 'MelvinMokhtari_9831143';


--- Answer to Question 1-B

CREATE SERVER ROLE rolelab3;
GRANT CREATE ANY DATABASE TO rolelab3;
GRANT ALTER ANY DATABASE TO rolelab3;


--- Answer to Question 1-C

ALTER SERVER ROLE rolelab3 ADD MEMBER loglab3;


--- Answer to Question 1-D

USE AdventureWorks2012;
CREATE USER userlab3 FOR LOGIN loglab3;
GRANT SELECT, INSERT ON DATABASE :: AdventureWorks2012 TO userlab3;

-- On loglab3:

USE AdventureWorks2012;
CREATE TABLE Courses (
	ID CHAR ( 5 ) PRIMARY KEY,
	Title VARCHAR ( 20 ) NOT NULL,
	Credits INT,
	DepartmentID CHAR ( 5 ),
);
INSERT INTO Courses
VALUES
	( 'CS111', 'BP', 4, '101' );
INSERT INTO Courses
VALUES
	( 'CV101', 'Statics', 3, '112' );
INSERT INTO Courses
VALUES
	( 'MA651', 'Dis_Math', 3, '105' );
INSERT INTO Courses
VALUES
	( 'GL120', 'Pedology', 3, '108' );
INSERT INTO Courses
VALUES
	( 'CS324', 'CN', 3, '101' );
INSERT INTO Courses
VALUES
	( 'CS440', 'DB', 3, '101' );
INSERT INTO Courses
VALUES
	( 'CS211', 'AP', 4, '101' );
INSERT INTO Courses
VALUES
	( 'IE334', 'EME', 2, '110' );
INSERT INTO Courses
VALUES
	( 'MI117', 'MEB', 3, '114' );
INSERT INTO Courses
VALUES
	( 'PH498', 'NF', 3, '104' );
INSERT INTO Courses
VALUES
	( 'ST169', 'PDE', 3, '109' );
INSERT INTO Courses
VALUES
	( 'CH222', 'Chemistry_1', 3, '115' );
INSERT INTO Courses
VALUES
	( 'CH232', 'Chemistry_2', 3, '115' );
INSERT INTO Courses
VALUES
	( 'MA151', 'General_Math', 3, '105' );
SELECT
	* 
FROM
	Courses
WHERE
	ID IN ( 'MA651', 'CS111', 'MI117', 'CS440', 'GL120' );


--- Answer to Question 2-A

USE AdventureWorks2012;
CREATE ROLE rolelab3_2;
CREATE USER userlab3_2 FOR LOGIN loglab3_2;
ALTER ROLE rolelab3_2 ADD MEMBER userlab3_2;
ALTER ROLE db_securityadmin ADD MEMBER rolelab3_2;


--- Answer to Question 2-B

ALTER ROLE db_datareader ADD MEMBER rolelab3_2;