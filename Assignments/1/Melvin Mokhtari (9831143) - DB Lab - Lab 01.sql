---- DATABASE DESIGN 1 Lab @ IUT
---- FULL NAME: Melvin Mokhtari
---- STUDENT ID: 9831143


--- Answer to Question 1-A

CREATE TABLE Departments (
	NAME VARCHAR ( 20 ) NOT NULL,
	ID CHAR ( 5 ) PRIMARY KEY,
	Budget NUMERIC ( 12, 2 ),
	Category VARCHAR ( 15 ) CHECK ( Category IN ( 'Engineering', 'Science' ) ) 
);

CREATE TABLE Teachers (
	FirstName VARCHAR ( 20 ) NOT NULL,
	LastName VARCHAR ( 30 ) NOT NULL,
	ID CHAR ( 7 ),
	BirthYear INT,
	DepartmentID CHAR ( 5 ),
	Salary NUMERIC ( 7, 2 ) DEFAULT 10000.00,
	PRIMARY KEY ( ID ),
	FOREIGN KEY ( DepartmentID ) REFERENCES Departments ( ID ) 
);

CREATE TABLE Students (
	FirstName VARCHAR ( 20 ) NOT NULL,
	LastName VARCHAR ( 30 ) NOT NULL,
	StudentNumber CHAR ( 7 ) PRIMARY KEY,
	BirthYear INT,
	DepartmentID CHAR ( 5 ),
	AdvisorID CHAR ( 7 ),
	FOREIGN KEY ( DepartmentID ) REFERENCES Departments ( ID ),
	FOREIGN KEY ( AdvisorID ) REFERENCES Teachers ( ID ) 
);

ALTER TABLE Students ADD PassedCreditsCount INT;


--- Answer to Question 1-B

CREATE TABLE Courses (
	ID CHAR ( 5 ) PRIMARY KEY,
	Title VARCHAR ( 20 ) NOT NULL,
	Credits INT,
	DepartmentID CHAR ( 5 ),
	FOREIGN KEY ( DepartmentID ) REFERENCES Departments ( ID ) 
);

CREATE TABLE Available_Courses (
	CourseID CHAR ( 5 ) NOT NULL,
	Semester VARCHAR ( 10 ) CHECK ( Semester IN ( 'fall', 'spring' ) ) NOT NULL,
	YEAR INT,
	TeacherID CHAR ( 5 ) NOT NULL,
	PRIMARY KEY ( CourseID ),
	FOREIGN KEY ( CourseID ) REFERENCES Courses ( ID ),
	FOREIGN KEY ( TeacherID ) REFERENCES Teachers ( ID ) 
);

CREATE TABLE Taken_Courses (
	StudentID CHAR ( 5 ) NOT NULL,
	CourseID CHAR ( 5 ) NOT NULL,
	Semester VARCHAR ( 10 ) CHECK ( Semester IN ( 'fall', 'spring' ) ) NOT NULL,
	YEAR INT,
	Grade INT,
	PRIMARY KEY ( StudentID, CourseID, Semester, YEAR ),
	FOREIGN KEY ( StudentID ) REFERENCES Students ( StudentNumber ),
	FOREIGN KEY ( CourseID ) REFERENCES Courses ( ID ) 
);

CREATE TABLE Prerequisites (
	CourseID CHAR ( 5 ) NOT NULL,
	PrereqID CHAR ( 5 ),
	PRIMARY KEY ( CourseID, PrereqID ),
	FOREIGN KEY ( CourseID ) REFERENCES Courses ( ID ) 
);


--- Answer to Question 1-C

--- INSERT INTO Departments table
INSERT INTO Departments
VALUES
	( 'Informatics', '101', 9230000000.00, 'Engineering' );
INSERT INTO Departments
VALUES
	( 'Mechanical', '112', 850000000.00, 'Engineering' );
INSERT INTO Departments
VALUES
	( 'Electrics', '102', 8200000000.00, 'Engineering' );
INSERT INTO Departments
VALUES
	( 'Civil', '107', 775000000.00, 'Engineering' );
INSERT INTO Departments
VALUES
	( 'Physics', '104', 187000000.00, 'Science' );
INSERT INTO Departments
VALUES
	( 'Chemistry', '115', 255000000.00, 'Science' );
INSERT INTO Departments
VALUES
	( 'Biochemistry', '111', 20000000.00, 'Science' );
INSERT INTO Departments
VALUES
	( 'Industrial', '110', 430000000.00, 'Engineering' );
INSERT INTO Departments
VALUES
	( 'Materials', '103', 29100000.00, 'Engineering' );
INSERT INTO Departments
VALUES
	( 'Mining', '114', 9870000.00, 'Engineering' );
INSERT INTO Departments
VALUES
	( 'Geology', '108', 510000000.00, 'Science' );
INSERT INTO Departments
VALUES
	( 'Petroleum', '113', 340000000.00, 'Engineering' );
INSERT INTO Departments
VALUES
	( 'Mathematics', '105', 1000000000.00, 'Science' );
INSERT INTO Departments
VALUES
	( 'Nanotechnology', '106', 23000000.00, 'Science' );
INSERT INTO Departments
VALUES
	( 'Statistics', '109', 74200000.00, 'Science' );
SELECT
	* 
FROM
	Departments;
	
--- INSERT INTO Teachers table

INSERT INTO Teachers
VALUES
	( 'Angelica', 'Morrow', '4519', 1980, '113', 11355.56 );
INSERT INTO Teachers
VALUES
	( 'Nathan', 'Mcnally', '6934', 1983, '107', 14142.17 );
INSERT INTO Teachers
VALUES
	( 'Susan', 'Speed', '6553', 1993, '111', 15469.80 );
INSERT INTO Teachers
VALUES
	( 'Mark', 'Villiger', '7956', 1970, '104', 11141.86 );
INSERT INTO Teachers
VALUES
	( 'Rosalyn', 'Jenkin', '7728', 1969, '115', 24202.86 );
INSERT INTO Teachers
VALUES
	( 'Leroy', 'Wheeler', '4776', 1992, '108', 21930.90 );
INSERT INTO Teachers
VALUES
	( 'Laila', 'Craig', '6182', 1968, '106', 8503.37 );
INSERT INTO Teachers
VALUES
	( 'Chuck', 'Ross', '6559', 1934, '106', 20964.96 );
INSERT INTO Teachers
VALUES
	( 'Jackeline', 'Gosling', '6655', 1950, '101', 19115.27 );
INSERT INTO Teachers
VALUES
	( 'Harvey', 'Tyrrell', '5457', 1971, '108', 11102.27 );
INSERT INTO Teachers
VALUES
	( 'Dorothy', 'Martin', '2626', 1990, '111', 22930.15 );
INSERT INTO Teachers
VALUES
	( 'Hank', 'Martin', '8295', 1986, '102', 14661.93 );
INSERT INTO Teachers
VALUES
	( 'Raquel', 'Robertson', '6534', 1987, '101', 22935.32 );
INSERT INTO Teachers
VALUES
	( 'Matthew', 'Ellis', '5418', 1929, '103', 17678.43 );
INSERT INTO Teachers
VALUES
	( 'Sloane', 'Price', '9055', 1965, '114', 7030.27 );
INSERT INTO Teachers
VALUES
	( 'Lucas', 'Ellwood', '6907', 1935, '115', 21184.15 );
INSERT INTO Teachers
VALUES
	( 'Tyson', 'Allwood', '8908', 1991, '104', 11701.43 );
INSERT INTO Teachers
VALUES
	( 'Mike', 'Lane', '4015', 1985, '107', 23983.21 );
INSERT INTO Teachers
VALUES
	( 'Lucas', 'Shields', '5825', 1952, '104', 19548.73 );
INSERT INTO Teachers
VALUES
	( 'Percy', 'Daniells', '3356', 1933, '106', 18140.73 );
INSERT INTO Teachers
VALUES
	( 'Kamila', 'Ward', '3341', 1945, '102', 8397.66 );
INSERT INTO Teachers
VALUES
	( 'Chuck', 'Hunter', '9262', 1977, '105', 24869.31 );
INSERT INTO Teachers
VALUES
	( 'Valerie', 'Robinson', '5154', 1989, '103', 6367.30 );
INSERT INTO Teachers
VALUES
	( 'Angelina', 'Carpenter', '6751', 1980, '102', 13490.82 );
INSERT INTO Teachers
VALUES
	( 'Noah', 'Uttridge', '8569', 1976, '101', 19065.71 );
INSERT INTO Teachers
VALUES
	( 'Carter', 'Lloyd', '3887', 1989, '115', 15908.14 );
INSERT INTO Teachers
VALUES
	( 'Rhea', 'Gosling', '9672', 1943, '112', 13397.37 );
INSERT INTO Teachers
VALUES
	( 'Florence', 'Gallacher', '3062', 1962, '109', 13689.36 );
INSERT INTO Teachers
VALUES
	( 'Alexander', 'Reid', '1051', 1988, '110', 21707.02 );
INSERT INTO Teachers
VALUES
	( 'Rosalee', 'Pierce', '6586', 1970, '105', 16937.43 );
SELECT
	* 
FROM
	Teachers;
	
--- INSERT INTO Students table

INSERT INTO Students
VALUES
	( 'Regina', 'Becker', '750', 1992, '107', '4015' );
INSERT INTO Students
VALUES
	( 'Harmony', 'Mullins', '104', 2006, '102', '6751' );
INSERT INTO Students
VALUES
	( 'Cassandra', 'Carter', '640', 1993, '111', '6553' );
INSERT INTO Students
VALUES
	( 'Johnathan', 'Rodwell', '623', 2001, '111', '2626' );
INSERT INTO Students
VALUES
	( 'Denis', 'Blackwall', '998', 2009, '103', '5418' );
INSERT INTO Students
VALUES
	( 'Melvin', 'Mokhtari', '123', 2001, '101', '6655' );
INSERT INTO Students
VALUES
	( 'Sasha', 'Widdows', '238', 2003, '108', '5457' );
INSERT INTO Students
VALUES
	( 'Alison', 'Keys', '102', 2001, '109', '3062' );
INSERT INTO Students
VALUES
	( 'Sebastian', 'Fall', '585', 2005, '105', '9262' );
INSERT INTO Students
VALUES
	( 'Kamila', 'Grant', '886', 2008, '113', '4519' );
INSERT INTO Students
VALUES
	( 'Logan', 'Wood', '749', 2002, '110', '1051' );
INSERT INTO Students
VALUES
	( 'Natalie', 'Shields', '888', 2003, '112', '9672' );
INSERT INTO Students
VALUES
	( 'Natalie', 'Vallins', '463', 2002, '105', '6586' );
INSERT INTO Students
VALUES
	( 'Jasmine', 'Greenwood', '694', 2005, '106', '6182' );
INSERT INTO Students
VALUES
	( 'Iris', 'Morrow', '762', 1992, '105', '9262' );
INSERT INTO Students
VALUES
	( 'Mat', 'Morrow', '124', 1998, '112', '9672' );
INSERT INTO Students
VALUES
	( 'Fred', 'Wilde', '178', 2000, '102', '6751' );
INSERT INTO Students
VALUES
	( 'Janelle', 'Ripley', '401', 2000, '106', '6559' );
INSERT INTO Students
VALUES
	( 'Gabriel', 'Donovan', '663', 1996, '101', '8569' );
INSERT INTO Students
VALUES
	( 'Aiden', 'Blackwall', '312', 2006, '110', '1051' );
INSERT INTO Students
VALUES
	( 'Lucas', 'Goldsmith', '937', 2002, '108', '4776' );
INSERT INTO Students
VALUES
	( 'Rocco', 'Griffiths', '803', 2000, '109', '3062' );
INSERT INTO Students
VALUES
	( 'Ronald', 'Wilde', '510', 2006, '106', '6182' );
INSERT INTO Students
VALUES
	( 'Matt', 'Duvall', '963', 1998, '107', '4015' );
INSERT INTO Students
VALUES
	( 'Brad', 'Silva', '487', 1993, '114', '9055' );
INSERT INTO Students
VALUES
	( 'Hayden', 'Parsons', '933', 2006, '104', '8908' );
INSERT INTO Students
VALUES
	( 'Ryan', 'Thatcher', '833', 2001, '104', '8908' );
INSERT INTO Students
VALUES
	( 'Hayden', 'Lucas', '997', 1995, '101', '6655' );
INSERT INTO Students
VALUES
	( 'Tony', 'Cobb', '277', 2000, '101', '6534' );
INSERT INTO Students
VALUES
	( 'Chris', 'Jenkin', '399', 2004, '115', '7728' );
SELECT
	* 
FROM
	Students;
	
--- INSERT INTO Courses table

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
	Courses;
	
--- INSERT INTO Available_Courses table

INSERT INTO Available_Courses
VALUES
	( 'MA151', 'fall', 2021, '9262' );
INSERT INTO Available_Courses
VALUES
	( 'MA651', 'spring', 2022, '6586' );
INSERT INTO Available_Courses
VALUES
	( 'CS111', 'fall', 2021, '6655' );
INSERT INTO Available_Courses
VALUES
	( 'CS440', 'spring', 2022, '8569' );
INSERT INTO Available_Courses
VALUES
	( 'CS211', 'spring', 2022, '8569' );
INSERT INTO Available_Courses
VALUES
	( 'IE334', 'fall', 2021, '1051' );
INSERT INTO Available_Courses
VALUES
	( 'CH222', 'fall', 2021, '3887' );
INSERT INTO Available_Courses
VALUES
	( 'CH232', 'spring', 2022, '6907' );
INSERT INTO Available_Courses
VALUES
	( 'MI117', 'fall', 2021, '9055' );
INSERT INTO Available_Courses
VALUES
	( 'GL120', 'spring', 2022, '4776' );
SELECT
	* 
FROM
	Available_Courses;
	
--- INSERT INTO Taken_Courses table

INSERT INTO Taken_Courses
VALUES
	( '312', 'IE334', 'fall', 2021, 76 );
INSERT INTO Taken_Courses
VALUES
	( '997', 'MA151', 'fall', 2021, 23 );
INSERT INTO Taken_Courses
VALUES
	( '123', 'CH232', 'spring', 2022, 88 );
INSERT INTO Taken_Courses
VALUES
	( '123', 'MA651', 'spring', 2022, 92 );
INSERT INTO Taken_Courses
VALUES
	( '123', 'CS111', 'fall', 2021, 96 );
INSERT INTO Taken_Courses
VALUES
	( '663', 'CS211', 'spring', 2022, 44 );
INSERT INTO Taken_Courses
VALUES
	( '937', 'GL120', 'spring', 2022, 51 );
INSERT INTO Taken_Courses
VALUES
	( '123', 'CS440', 'spring', 2022, 99 );
INSERT INTO Taken_Courses
VALUES
	( '487', 'CH232', 'spring', 2022, 9 );;
INSERT INTO Taken_Courses
VALUES
	( '487', 'MI117', 'fall', 2021, 63 );
INSERT INTO Taken_Courses
VALUES
	( '463', 'MA651', 'spring', 2022, 22 );
INSERT INTO Taken_Courses
VALUES
	( '997', 'CS111', 'fall', 2021, 80 );
INSERT INTO Taken_Courses
VALUES
	( '997', 'CS211', 'spring', 2022, 0 );
INSERT INTO Taken_Courses
VALUES
	( '663', 'CS440', 'spring', 2022, 12 );
INSERT INTO Taken_Courses
VALUES
	( '463', 'MA151', 'fall', 2021, 78 );
INSERT INTO Taken_Courses
VALUES
	( '749', 'IE334', 'fall', 2021, 43 );
INSERT INTO Taken_Courses
VALUES
	( '762', 'MA151', 'fall', 2021, 69 );
INSERT INTO Taken_Courses
VALUES
	( '399', 'CH222', 'fall', 2021, 89 );
INSERT INTO Taken_Courses
VALUES
	( '762', 'MA651', 'spring', 2022, 35 );
INSERT INTO Taken_Courses
VALUES
	( '238', 'GL120', 'spring', 2022, 71 );
SELECT
	* 
FROM
	Taken_Courses;
	
--- INSERT INTO Prerequisites table

INSERT INTO Prerequisites
VALUES
	( 'CS211', 'CS111' );
INSERT INTO Prerequisites
VALUES
	( 'CH232', 'CH222' );
INSERT INTO Prerequisites
VALUES
	( 'IE334', 'MA151' );
INSERT INTO Prerequisites
VALUES
	( 'CS440', 'CS324' );
	INSERT INTO Prerequisites
VALUES
	( 'MA651', 'MA151' );
	INSERT INTO Prerequisites
VALUES
	( 'CV101', 'MA151' );
SELECT
	* 
FROM
	Prerequisites;
	
	
--- Answer to Question 2-A

SELECT
	Students.FirstName AS Student_FirstName,	/*Just for information*/
	Students.LastName AS Student_LastName,	/*Just for information*/
	Students.StudentNumber AS StudentNumber,	/*Just for information*/
	Departments.NAME AS Departments_Name,
	Departments.Category AS Departments_Category,
	Departments.ID AS Departments_ID,
	Departments.Budget AS Departments_Budget 
FROM
	Departments
	INNER JOIN Students ON ( Departments.ID = Students.DepartmentID ) 
WHERE
	Students.StudentNumber = '123';
	
	
--- Answer to Question 2-B

SELECT
	Taken_Courses.StudentID,
	Taken_Courses.CourseID,
	Taken_Courses.Semester,
	Taken_Courses.YEAR,
	Taken_Courses.Grade + 1 AS NewGrade 
FROM
	Taken_Courses;
	
	
--- Answer to Question 2-C

SELECT DISTINCT
	Students.FirstName,
	Students.LastName,
	Students.StudentNumber 
FROM
	Students
	LEFT JOIN Taken_Courses ON ( Students.StudentNumber = Taken_Courses.StudentID ) 
WHERE
	Students.StudentNumber NOT IN ( SELECT StudentID FROM Taken_Courses WHERE CourseID = 'CS440' );