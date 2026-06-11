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

