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