
-- ================================================
-- USE DATABASE
-- ================================================
CREATE DATABASE IF NOT EXISTS CollegeClub;
USE CollegeClub;

-- ================================================
-- ORIGINAL TABLE
-- ================================================
CREATE TABLE OriginalTable (
    StudentID   INT,
    Name        VARCHAR(50),
    Email       VARCHAR(100),
    ClubName    VARCHAR(50),
    ClubRoom    VARCHAR(20),
    ClubMentor  VARCHAR(50),
    JoinDate    DATE
);

INSERT INTO OriginalTable VALUES
(1, 'Asha',   'asha@email.com',   'Music Club',  'R101', 'Mr. Raman', '2024-01-10'),
(2, 'Bikash', 'bikash@email.com', 'Sports Club', 'R202', 'Ms. Sita',  '2024-01-12'),
(1, 'Asha',   'asha@email.com',   'Sports Club', 'R202', 'Ms. Sita',  '2024-01-15'),
(3, 'Nisha',  'nisha@email.com',  'Music Club',  'R101', 'Mr. Raman', '2024-01-20'),
(4, 'Rohan',  'rohan@email.com',  'Drama Club',  'R303', 'Mr. Kiran', '2024-01-18',)
(5, 'Suman',  'suman@email.com',  'Music Club',  'R101', 'Mr. Raman', '2024-01-22'),
(2, 'Bikash', 'bikash@email.com', 'Drama Club',  'R303', 'Mr. Kiran', '2024-01-25'),
(6, 'Pooja',  'pooja@email.com',  'Sports Club', 'R202', 'Ms. Sita',  '2024-01-27'),
(3, 'Nisha',  'nisha@email.com',  'Coding Club', 'Lab1', 'Mr. Anil',  '2024-01-28'),
(7, 'Aman',   'aman@email.com',   'Coding Club', 'Lab1', 'Mr. Anil',  '2024-01-30');

SELECT * FROM OriginalTable;

-- ================================================
-- 1NF
-- ================================================
CREATE TABLE Table_1NF (
    StudentID   INT,
    Name        VARCHAR(50),
    Email       VARCHAR(100),
    ClubName    VARCHAR(50),
    ClubRoom    VARCHAR(20),
    ClubMentor  VARCHAR(50),
    JoinDate    DATE,
    PRIMARY KEY (StudentID, ClubName)
);

INSERT INTO Table_1NF
SELECT DISTINCT * FROM OriginalTable;

SELECT * FROM Table_1NF;

-- ================================================
-- 2NF - Student Table
-- ================================================
CREATE TABLE Student_2NF (
    StudentID INT PRIMARY KEY,
    Name      VARCHAR(50)  NOT NULL,
    Email     VARCHAR(100) NOT NULL
);

INSERT INTO Student_2NF (StudentID, Name, Email)
SELECT DISTINCT StudentID, Name, Email
FROM Table_1NF;

SELECT * FROM Student_2NF;

-- ================================================
-- 2NF - Club Table
-- ================================================
CREATE TABLE Club_2NF (
    ClubName   VARCHAR(50) PRIMARY KEY,
    ClubRoom   VARCHAR(20) NOT NULL,
    ClubMentor VARCHAR(50) NOT NULL
);

INSERT INTO Club_2NF (ClubName, ClubRoom, ClubMentor)
SELECT DISTINCT ClubName, ClubRoom, ClubMentor
FROM Table_1NF;

SELECT * FROM Club_2NF;

-- ================================================
-- 2NF - Membership Table
-- ================================================
CREATE TABLE Membership_2NF (
    StudentID INT,
    ClubName  VARCHAR(50),
    JoinDate  DATE,
    PRIMARY KEY (StudentID, ClubName),
    FOREIGN KEY (StudentID) REFERENCES Student_2NF(StudentID),
    FOREIGN KEY (ClubName)  REFERENCES Club_2NF(ClubName)
);

INSERT INTO Membership_2NF (StudentID, ClubName, JoinDate)
SELECT DISTINCT StudentID, ClubName, JoinDate
FROM Table_1NF;

SELECT * FROM Membership_2NF;

-- ================================================
-- 3NF - Student Table
-- (must be created BEFORE Membership_3NF)
-- ================================================
CREATE TABLE Student_3NF (
    StudentID INT PRIMARY KEY,
    Name      VARCHAR(50)  NOT NULL,
    Email     VARCHAR(100) NOT NULL
);

INSERT INTO Student_3NF
SELECT * FROM Student_2NF;

SELECT * FROM Student_3NF;

-- ================================================
-- 3NF - Club Table
-- (must be created BEFORE Membership_3NF)
-- ================================================
CREATE TABLE Club_3NF (
    ClubID     INT AUTO_INCREMENT PRIMARY KEY,
    ClubName   VARCHAR(50) NOT NULL,
    ClubRoom   VARCHAR(20) NOT NULL,
    ClubMentor VARCHAR(50) NOT NULL
);

INSERT INTO Club_3NF (ClubName, ClubRoom, ClubMentor)
SELECT ClubName, ClubRoom, ClubMentor
FROM Club_2NF;

SELECT * FROM Club_3NF;

-- ================================================
-- 3NF - Membership Table
-- (created LAST after Student_3NF and Club_3NF)
-- ================================================
CREATE TABLE Membership_3NF (
    StudentID INT,
    ClubID    INT,
    JoinDate  DATE,
    PRIMARY KEY (StudentID, ClubID),
    FOREIGN KEY (StudentID) REFERENCES Student_3NF(StudentID),
    FOREIGN KEY (ClubID)    REFERENCES Club_3NF(ClubID)
);

INSERT INTO Membership_3NF (StudentID, ClubID, JoinDate)
SELECT
    m.StudentID,
    c.ClubID,
    m.JoinDate
FROM Membership_2NF m
JOIN Club_3NF c ON m.ClubName = c.ClubName;

SELECT * FROM Membership_3NF;

-- ================================================
-- FINAL VERIFICATION JOIN
-- ================================================
SELECT
    s.StudentID,
    s.Name       AS StudentName,
    s.Email,
    c.ClubName,
    c.ClubRoom,
    c.ClubMentor,
    m.JoinDate
FROM Membership_3NF m
JOIN Student_3NF s ON m.StudentID = s.StudentID
JOIN Club_3NF    c ON m.ClubID    = c.ClubID
ORDER BY m.JoinDate;