-- Create schema for departments.

CREATE SCHEMA Departments;
USE Departments;

-- Create five tables in the department schema, namely: department, students, lecturers, courses, student_course_registration.

CREATE TABLE Department (
	Department_ID INT AUTO_INCREMENT,
    Department_Name VARCHAR(50) NOT NULL,
    Head_of_Department VARCHAR(100),
    PRIMARY KEY (Department_ID)
);

CREATE TABLE Students (
	Student_ID INT AUTO_INCREMENT,
    Last_Name VARCHAR(50) NOT NULL,
    First_Name VARCHAR(50) NOT NULL,
    Birth_date DATE NOT NULL,
    Phone_Number VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    State_of_Origin VARCHAR(50) NOT NULL,
    State_of_Residence VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Next_of_Kin VARCHAR(50) NOT NULL,
    Phone_Number_Next_of_Kin VARCHAR(50) NOT NULL,
    Department_ID INT,
    PRIMARY KEY (Student_ID),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Lecturers (
	Lecturer_ID INT AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Birth_date DATE NOT NULL,
    Phone_Number VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    State_of_Origin VARCHAR(50) NOT NULL,
    State_of_Residence VARCHAR(50) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Next_of_Kin VARCHAR(50) NOT NULL,
    Phone_Number_Next_of_Kin VARCHAR(50) NOT NULL,
    Department_ID INT,
    PRIMARY KEY (Lecturer_ID),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

CREATE TABLE Courses (
	Course_ID INT AUTO_INCREMENT,
    Course_Name VARCHAR(100) NOT NULL,
    Department_ID INT,
    PRIMARY KEY (Course_ID),
    FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)
);

 CREATE TABLE Student_Course_Registration (
	Registration_ID INT AUTO_INCREMENT,
    Student_ID INT,
    Course_ID INT,
    Academic_Year VARCHAR(20),
    Semester VARCHAR(10) NOT NULL,
    PRIMARY KEY (Registration_ID),
    FOREIGN KEY (Student_ID) REFERENCES Students(Student_ID),
    FOREIGN KEY (Course_ID) REFERENCES Courses(Course_ID)
);


-- Create a schema for administration.

CREATE SCHEMA Administration;
USE Administration;

-- Create five tables in the administration schema, namely: events, timetables, hostels, rooms, and room_allocation.

CREATE TABLE Events (
	Event_ID INT AUTO_INCREMENT,
    Event_Name VARCHAR(100) NOT NULL,
    Event_Date DATE NOT NULL,
    Event_Time TIME NOT NULL,
    Venue VARCHAR(100),
    PRIMARY KEY (Event_ID)
);

CREATE TABLE Timetables (
	Timetable_ID INT AUTO_INCREMENT,
    Department_ID INT,
    Course_ID INT,
    Lecturer_ID INT,
    Day VARCHAR(10),
    Start_Time TIME NOT NULL,
    End_Time TIME NOT NULL,
    PRIMARY KEY (Timetable_ID),
    FOREIGN KEY (Department_ID) REFERENCES Departments.Department(Department_ID),
    FOREIGN KEY (Course_ID) REFERENCES Departments.Courses(Course_ID),
    FOREIGN KEY (Lecturer_ID) REFERENCES Departments.Lecturers(Lecturer_ID)
);

CREATE TABLE Hostels (
	Hostel_ID INT AUTO_INCREMENT,
    Hostel_Name VARCHAR(50) NOT NULL,
    Location VARCHAR(100) NOT NULL,
    Capacity INT NOT NULL,
    PRIMARY KEY (Hostel_ID)
);

CREATE TABLE Rooms (
	Room_ID INT AUTO_INCREMENT,
    Room_Number VARCHAR(20) NOT NULL,
    Capacity INT NOT NULL,
    Hostel_ID INT,
    PRIMARY KEY (Room_ID),
    FOREIGN KEY (Hostel_ID) REFERENCES Hostels(Hostel_ID)
);
    
CREATE TABLE Room_Allocation (
	Allocation_ID INT AUTO_INCREMENT,
    Student_ID INT,
    Hostel_ID INT,
    Room_ID INT,
    PRIMARY KEY (Allocation_ID),
    FOREIGN KEY (Student_ID) REFERENCES Departments.students(Student_ID),
    FOREIGN KEY (Hostel_ID) REFERENCES Hostels(Hostel_ID),
    FOREIGN KEY (Room_ID) REFERENCES Rooms(Room_ID)
);

-- Create a schema for human_resource.

CREATE SCHEMA Human_Resource;
USE Human_Resource;

-- Create three tables in the human_resource schema, namely: non_lecturer_staff, employment, and student_enrollment. 

CREATE TABLE Non_Lecturer_Staff (
	Staff_ID INT AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Birth_date DATE NOT NULL,
    Phone_Number VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE,
    State_of_Origin VARCHAR(100) NOT NULL,
    State_of_Residence VARCHAR(100) NOT NULL,
    Address VARCHAR(100) NOT NULL,
    Next_of_Kin VARCHAR(50) NOT NULL,
    Phone_Number_Next_of_Kin VARCHAR(50) NOT NULL,   
    Department_ID INT,
    PRIMARY KEY (Staff_ID),
    FOREIGN KEY (Department_ID) REFERENCES Departments.Department(Department_ID)
);

CREATE TABLE Employment (
	Employment_ID INT AUTO_INCREMENT,
    Lecturer_ID INT,
    Non_Lecturer_ID INT,
    Employment_Date DATE NOT NULL,
    Job_Title VARCHAR(100),
    PRIMARY KEY (Employment_ID),
    FOREIGN KEY (Lecturer_ID) REFERENCES departments.lecturers(Lecturer_ID),
    FOREIGN KEY (Non_Lecturer_ID) REFERENCES non_lecturer_staff(Staff_ID)
);

CREATE TABLE Student_Enrollment (
	Enrollment_ID INT AUTO_INCREMENT,
    Student_ID INT,
    Academic_Year VARCHAR(20) NOT NULL,
    PRIMARY KEY (Enrollment_ID),
    FOREIGN KEY (Student_ID) REFERENCES Departments.Students(Student_ID)
);


-- Create a schema for finance.

CREATE SCHEMA Finance;
USE Finance;

-- Create four tables in the finance schema, namely: fees, payments, salaries, and investments. 

CREATE TABLE Fees (
	Fee_ID INT AUTO_INCREMENT,
    Fee_Type VARCHAR(50) NOT NULL,
    Amount DECIMAL (10,2),
    PRIMARY KEY (Fee_ID)
);

CREATE TABLE Payments (
	Payment_ID INT AUTO_INCREMENT,
    Student_ID INT,
    Fee_ID INT,
    Payment_Date DATE NOT NULL,
    Amount_Paid DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Payment_ID),
    FOREIGN KEY (Student_ID) REFERENCES Departments.Students(Student_ID),
    FOREIGN KEY (Fee_ID) REFERENCES Fees(Fee_ID)
);

CREATE TABLE Salaries (
	Salary_ID INT AUTO_INCREMENT,
    Employment_ID INT,
    Lecturer_ID INT,
    Salary_Day VARCHAR(50) NOT NULL,
    Amount_Paid DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (Salary_ID),
    FOREIGN KEY (Employment_ID) REFERENCES Human_Resource.Employment(Employment_ID)
);

CREATE TABLE Investments (
	Investment_ID INT AUTO_INCREMENT,
    Investment_Type VARCHAR(100),
    Amount_Invested DECIMAL(10,2),
    PRIMARY KEY (Investment_ID)
);


-- Insert records into each of the four tables in the departments schema. 

USE Departments;

INSERT INTO department (Department_ID, Department_Name, Head_of_Department) 
VALUES 
	(1, 'Accounting', 'John Pane'),
    (2, 'Music', 'Anita Gold'),
    (3, 'Biology', 'Smith Frank'),
    (4, 'Agriculture', 'Beauty Rose');


INSERT INTO courses (Course_ID, Course_Name, Department_ID)
VALUES 
	(1,'Financial Accounting',1),
    (2,'Music Theory',2),
    (3,'Cell Biology',3),
    (4,'Crop Production',4),
    (5,'Auditing',1),
    (6,'Instrumental Music',2),
    (7,'Genetics',3),
    (8,'Agricultural Economics',4),
    (9,'Taxation',1),
    (10,'Microbiology',3);


INSERT INTO lecturers (Lecturer_ID, First_Name, Last_Name, Birth_date, Phone_Number, Email, State_of_Origin, State_of_Residence, Address, Next_of_Kin, Phone_Number_Next_of_Kin, Department_ID)
VALUES 
	(1,'John','Doe','1970-01-01','08012345678','johndoe@email.com','Lagos','Abuja','10 Abuja Street','Jane Doe','08098765432',1),
	(2,'Jane','Smith','1975-06-15','08123456789','janesmith@email.com','Rivers','Kaduna','20 PH Road','John Smith','08076543210',2),
    (3,'Michael','Davis','1980-03-20','07012345678','michael@email.com','Ogun','Edo','30 Lagos Avenue','Emily Davis','08054321098',3),
    (4,'Emily ','Brown','1982-11-12','09012345678','emily@email.com','Edo','Lagos','40 Benin Road','Michael Brown','08098765432',4),
    (5,'David','Lee','1978-09-08','08045678910','david@email.com','Kano','Edo','25 Kano Street','Sarah Lee','08011111111',1),
    (6,'Sarah','Taylor','1985-02-22','08178901234','sarah@email.com','Kaduna','Plateau','10 Kaduna Road','David Taylor','08022222222',2),
    (7,'James','Wilson','1972-05-10','07098765432','james@email.com','Plateau','Delta','70 Jos Road','Helen Wilson','08033333333',3),
    (8,'Helen','Anderson','1988-07-25','09045678901','helen@email.com','Anambra','Ebonyi','80 Asaba Avenue','James Anderson','08044444444',4);


INSERT INTO students (Student_ID, First_Name, Last_Name, Birth_date, Phone_Number, Email, State_of_Origin, State_of_Residence, Address, Next_of_Kin, Phone_Number_Next_of_Kin, Department_ID)
VALUES 
	(1,'Olamide','Bamidele','1992-06-15','08012345678','olamidebamidele@email.com','Abia','Abuja','10 Abuja Street','Chike Okoro','09022228888',1),
    (2,'Nneoma','Okoro','1992-06-15','08012345678','nneomaokoro@email.com','Oyo','Owerri','20 Osogbo Road','Tunde Ademola','08045678901',2),
    (3,'Zuri','Ademola','1995-03-20','07012345678','zuriademola@email.com','Imo','Osogbo','30 Awka Avenue','Uche Nwachukwu','09023456789',3),
    (4,'Amara','Nwachukwu','1998-11-12','09012345679','amaranwachukwu@email.com','Anambra','Akure','50 Akure Crescent','Chidi Okafor','08012345678',4),
    (5,'Nnamdi','Okafor','1991-09-08','08045678901','nnamdiokafor@email.com','Ondo','Ibadan','4 Ibadan Road','Bode Adeyeye','07011111111',1),
    (6,'Folake','Adeyeye','1993-02-22','08178901234','folakeadeyeye@email.com','Osun','Owerri','8 Osun Close','Yinka Oyedele','08022222222',2),
    (7,'Kehinde','Oyedele','1996-05-10','07098765432','kehindeoyedele@email.com','Enugu','Abeokuta','19 Peace Close','Ifeanyi Mbachu','08033333333',3),
    (8,'Chidinma','Mbachu','1999-07-25','09045678901','chidinmambachu@email.com','Ekiti','Abakaliki','34 Abeokuta Road','Femi Adebayo','09044444444',4),
    (9,'Bukola','Adebayo','1994-01-15','08090123456','bukoaadebayo@email.com','Ebonyi','Ado-Ekiti','7 Enugu Street','Chika Okeke','08055555555',1),
    (10,'Ugochukwu','Okeke','1997-09-01','08111111111','ugochukwuokeke@email.com','Ogun','Enugu','50 Akure Street','Tayo Bamidele','08066666666',2);


INSERT INTO student_course_registration (Registration_ID, Student_ID, Course_ID, Academic_Year, Semester) 
VALUES 
	(1,1,1,'2022/2023','First'),
    (2,2,2,'2022/2023','First'),
    (3,3,3,'2022/2023','First'),
    (4,4,4,'2022/2023','First'),
    (5,5,5,'2022/2023','Second'),
    (6,6,6,'2022/2023','Second'),
    (7,7,7,'2022/2023','First'),
    (8,8,8,'2022/2023','Second'),
    (9,9,9,'2022/2023','First'),
    (10,10,10,'2022/2023','Second');

-- Insert records into each of the tables in the administration department.


USE Administration;

INSERT INTO events (Event_Name, Event_Date, Event_Time, Venue)
VALUES
	('Matriculation', '2024-10-01', '10:00', 'Main Auditorium'),
    ('Inaugural speech', '2024-08-12', '12:00', 'Staff Hall'),
    ('Award Ceremony', '2024-09-10', '15:00', 'Student Center'),
    ('Sports Day', '2024-11-24', '18:00', 'Basketball Court'),
    ('End of Session Prayer', '2024-12-13', '09:00', 'Church Hall');

INSERT INTO timetables (Timetable_ID, Department_ID, Course_ID, Lecturer_ID, Day, Start_Time, End_Time)
VALUES
	(1, 2, 5, 3, 'Monday', '09:00:00', '10:30:00'),
    (2, 1, 8, 6, 'Monday', '10:45:00', '12:15:00'),
    (3, 4, 2, 1, 'Tuesday', '08:00:00', '09:30:00'),
    (4, 3, 9, 7, 'Tuesday', '13:00:00', '14:30:00'),
    (5, 2, 1, 4, 'Wednesday', '11:00:00', '12:30:00'),
    (6, 1, 6, 2, 'Thursday', '14:00:00', '15:30:00'),
    (7, 4, 10, 8, 'Friday', '09:45:00', '11:15:00'),
    (8, 3, 3, 5, 'Monday', '13:45:00', '14:15:00'),
    (9, 2, 4, 6, 'Wednesday', '08:30:00', '10:00:00'),
    (10, 1, 7, 3, 'Thursday', '10:15:00', '11:45:00');

INSERT INTO hostels (Hostel_ID, Hostel_Name, Location, Capacity) 
VALUES 
	(1,'Sapphire Hostel','Frankfurt Avenue',300),
    (2,'Diamond Hostel','MaryLand Estate',200),
    (3,'Gold Hostel','Houston Park',150),
    (4,'Silver Hostel','Brilliant Close',350),
    (5,'Bronze Hostel','Massachussets',100);

INSERT INTO rooms (Room_ID, Room_Number, Capacity, Hostel_ID)
VALUES
	(1, 8, 6, 3),
    (2, 5, 9, 1),
    (3, 2, 5, 5),
    (4, 10, 4, 2),
    (5, 1, 8, 4),
    (6, 9, 7, 1),
    (7, 4, 10, 3),
    (8, 6, 6, 2),
    (9, 3, 5, 5),
    (10, 7, 8, 4);
    
INSERT INTO room_allocation (Allocation_ID, Student_ID, Hostel_ID, Room_ID)
VALUES
	(1, 5, 3, 8),
    (2, 9, 1, 5),
    (3, 1, 5, 2),
    (4, 10, 2, 10),
    (5, 6, 4, 1),
    (6, 8, 1, 9),
    (7, 4, 3, 4),
    (8, 2, 2, 6),
    (9, 7, 5, 3),
    (10, 3, 4, 7);

-- Insert records into each of the tables in the finance schema.

USE finance;

INSERT INTO fees (Fee_ID, Fee_Type, Amount)
VALUES
	(1, 'Tuition Fees', 8000),
    (2, 'Accommodation', 5000),
    (3, 'Examination Fee', 4500),
    (4, 'Registration', 9000);

INSERT INTO Investments (Investment_ID, Investment_Type, Amount_Invested)
VALUES
	(1, 'Endowment Fund', 80000),
    (2, 'Research Grant', 50000),
    (3, 'Infrastructure Development', 90000),
    (4, 'Scholarship Program', 60000);

INSERT INTO payments (Payment_ID, Student_ID, Payment_Date, Amount_Paid)
VALUES
	(1, 8, '2022-03-15', 4200),
    (2, 5, '2022-09-20', 4800),
    (3, 2, '2023-01-10', 4500),
    (4, 9, '2022-06-01', 3800);
    

-- Insert records into each of the tables in the human_resource schema.


USE human_resource;

INSERT INTO Non_lecturer_staff (Staff_ID, First_Name, Last_Name, Birth_date, Phone_Number, Email, State_of_Origin, State_of_Residence, Address, Next_of_Kin, Phone_Number_Next_of_Kin, Department_ID)
VALUES
	(1, 'John', 'Smith', '1990-05-12', '09033333333', 'john.smith@email.com', 'Lagos', 'Ogun', '12 University Road', 'Hannah Wats', '09022222222', 3),
    (2, 'Emily', 'Johnson', '1995-08-25', '08044444444', 'emily.johnson@email.com', 'Abuja', 'Kano', '34 Campus Road', 'Michael John', '09066666666', 1);
    
INSERT INTO employment (Employment_ID, Lecturer_ID, Non_Lecturer_ID, Employment_Date, Job_Title)
VALUES
	(1, 5, NULL, '2022-03-10', 'Senior Lecturer'),
    (2, 4, NULL, '2022-09-15', 'Administrative Officer'),
    (3, 2, NULL, '2022-01-05', 'Lecturer'),
    (4, NULL, 2, '2022-06-20', 'Librarian'),
    (5, 8, NULL, '2022-11-01', 'Professor'),
    (6, 1, NULL, '2022-04-15', 'Senior Lecturer'),
    (7, NULL, 1, '2022-07-10', 'Registrar'),
    (8, 6, NULL, '2022-02-20', 'Associate Professor'),
    (9, 3, NULL, '2022-05-25', 'Research Fellow'),
    (10, 7, NULL, '2022-10-01', 'Professor');
    

USE finance;

INSERT INTO salaries (Salary_ID, Employment_ID, Salary_Day, Amount_Paid)
VALUES
	(1, 5, 12, 450000),
    (2, 2, 25, 520000),
    (3, 7, 5, 380000),
    (4, 3, 18, 550000);
    
    
USE human_resource;

INSERT INTO student_enrollment (Enrollment_ID, Student_ID, Academic_Year)
VALUES
	(1, 5, '2022/2023'),
    (2, 8, '2022/2023'),
    (3, 2, '2022/2023'),
    (4, 9, '2022/2023'),
    (5, 1, '2022/2023'),
    (6, 6, '2022/2023'),
    (7, 4, '2022/2023'),
    (8, 3, '2022/2023'),
    (9, 10, '2022/2023'),
    (10, 7, '2022/2023');


-- Retrieve data from the tables in the department schema.

USE departments;

SELECT *
FROM department;

SELECT
	Student_ID,
    Last_Name,
    First_Name,
    Email
FROM students
ORDER BY First_Name
LIMIT 5;

SELECT 
	Lecturer_ID,
    First_Name,
    Last_Name,
    Birth_date
FROM lecturers
WHERE First_Name LIKE '%n';

SELECT
	S.Student_ID,
    S.Last_Name,
    S.First_Name,
    S.Department_ID,
    D.Department_Name  
FROM students as S
JOIN department as D
	ON S.Department_ID = D.Department_ID
ORDER BY S.Student_ID;


SELECT 
	St.Student_ID,
    St.Last_Name,
    St.First_Name,
    SCR.Registration_ID
FROM students AS St
JOIN student_course_registration AS SCR
	USING (Student_ID);


