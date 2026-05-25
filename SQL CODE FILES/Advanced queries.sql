create database pbl;
use pbl;

-- Trigger 


CREATE TABLE AuditLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    Action VARCHAR(50),
    LogDate DATE
);

CREATE TRIGGER AfterEnrollmentInsert
AFTER INSERT ON Enrollment
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (StudentID, Action, LogDate)
    VALUES (NEW.StudentID, 'Enrollment Added', NEW.EnrollmentDate);
END;