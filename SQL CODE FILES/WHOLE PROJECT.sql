CREATE DATABASE pbl;
USE pbl;

CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    Name VARCHAR(100),
    Gender VARCHAR(10),
    AdmissionDate DATE NOT NULL,
    CGPA DECIMAL(3,2)
);

CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Credits INT,
    Department VARCHAR(50)
);

CREATE TABLE Subject (
    SubjectID INT PRIMARY KEY,
    SubjectName VARCHAR(100),
    Semester INT,
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    Name VARCHAR(100),
    Phone VARCHAR(15),
    Department VARCHAR(50)
);

CREATE TABLE Enrollment (
    EnrollmentID INT PRIMARY KEY,
    StudentID INT,
    CourseID INT,
    EnrollmentDate DATE,
    Grade VARCHAR(5),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

INSERT INTO Student VALUES
(1, 'Ali Khan', 'Male', '2024-09-01', 3.2),
(2, 'Sara Malik', 'Female', '2024-09-01', 3.8),
(3, 'Bilal Ahmed', 'Male', '2023-09-01', 2.9),
(4, 'Ayesha Noor', 'Female', '2023-09-01', 3.5),
(5, 'Usman Tariq', 'Male', '2022-09-01', 3.0),
(6, 'Fatima Zahra', 'Female', '2022-09-01', 3.6),
(7, 'Hamza Ali', 'Male', '2021-09-01', 2.7),
(8, 'Nida Hassan', 'Female', '2021-09-01', 3.9),
(9, 'Omar Siddiq', 'Male', '2020-09-01', 3.1),
(10, 'Zara Shah', 'Female', '2020-09-01', 3.4);


INSERT INTO Course VALUES
(101, 'Database Systems', 3, 'CS'),
(102, 'Operating Systems', 4, 'CS'),
(103, 'Linear Algebra', 3, 'Math'),
(104, 'Digital Logic Design', 3, 'CS'),
(105, 'Computer Networks', 4, 'CS'),
(106, 'Software Engineering', 3, 'CS'),
(107, 'Artificial Intelligence', 4, 'CS'),
(108, 'Probability & Statistics', 3, 'Math'),
(109, 'Data Structures', 3, 'CS'),
(110, 'Web Development', 3, 'CS');


INSERT INTO Faculty VALUES
(201, 'Dr. Ahmed', '03001234567', 'CS'),
(202, 'Dr. Fatima', '03007654321', 'Math'),
(203, 'Dr. Salman', '03009876543', 'CS'),
(204, 'Dr. Nadia', '03004561234', 'CS'),
(205, 'Dr. Imran', '03007894561', 'Math'),
(206, 'Dr. Hina', '03003456789', 'CS'),
(207, 'Dr. Kamran', '03005678912', 'CS'),
(208, 'Dr. Saima', '03002345678', 'CS'),
(209, 'Dr. Yasir', '03006789123', 'Math'),
(210, 'Dr. Bushra', '03008912345', 'CS');

INSERT INTO Subject VALUES
(301, 'SQL Queries', 3, 101, 201),
(302, 'Concurrency Control', 5, 102, 203),
(303, 'Matrix Theory', 2, 103, 202),
(304, 'Boolean Algebra', 1, 104, 204),
(305, 'Routing Protocols', 6, 105, 207),
(306, 'Agile Methods', 4, 106, 206),
(307, 'Machine Learning', 7, 107, 208),
(308, 'Random Variables', 2, 108, 205),
(309, 'Linked Lists', 3, 109, 209),
(310, 'HTML & CSS', 1, 110, 210);

INSERT INTO Enrollment VALUES
(401, 1, 101, '2024-09-05', 'A'),
(402, 2, 101, '2024-09-05', 'B'),
(403, 3, 102, '2023-09-10', 'C'),
(404, 4, 103, '2023-09-12', 'A'),
(405, 5, 104, '2022-09-15', 'B'),
(406, 6, 105, '2022-09-20', 'A'),
(407, 7, 106, '2021-09-25', 'C'),
(408, 8, 107, '2021-09-30', 'A'),
(409, 9, 108, '2020-09-10', 'B'),
(410, 10, 109, '2020-09-15', 'A');

-- Create AuditLog table
CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    Action VARCHAR(50),
    LogDate DATE
);

-- Change delimiter so MySQL knows where the trigger ends
DELIMITER $$

CREATE TRIGGER AfterEnrollmentInsert
AFTER INSERT ON Enrollment
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (StudentID, Action, LogDate)
    VALUES (NEW.StudentID, 'Enrollment Added', NEW.EnrollmentDate);
END$$

-- Reset delimiter back to normal
DELIMITER ;

-- Join Across 3 tables


SELECT s.Name, c.CourseName, e.Grade
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID;

-- Aggregation with GROUP BY + HAVING


SELECT Department, AVG(Credits) AS AvgCredits
FROM Course
GROUP BY Department
HAVING AVG(Credits) > 3;

-- Nested Subquery


SELECT Name
FROM Student
WHERE StudentID IN (
    SELECT StudentID
    FROM Enrollment
    WHERE Grade = 'A'
);

-- View Creation


CREATE VIEW StudentCourseView AS
SELECT s.Name, c.CourseName, e.Grade
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID;


SELECT s.Name, c.CourseName, e.Grade
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID;

-- Aggregation with GROUP BY + HAVING


SELECT Department, AVG(Credits) AS AvgCredits
FROM Course
GROUP BY Department
HAVING AVG(Credits) > 3;

-- Nested Subquery


SELECT Name
FROM Student
WHERE StudentID IN (
    SELECT StudentID
    FROM Enrollment
    WHERE Grade = 'A'
);

-- View Creation


CREATE VIEW StudentCourseView AS
SELECT s.Name, c.CourseName, e.Grade
FROM Student s
JOIN Enrollment e ON s.StudentID = e.StudentID
JOIN Course c ON e.CourseID = c.CourseID;

