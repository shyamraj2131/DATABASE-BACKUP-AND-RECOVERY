
-- ============================================================
-- CREATE NEW DATABASE (library_db)
-- Library Management System
-- ============================================================

CREATE DATABASE IF NOT EXISTS library_db;
USE library_db;

-- ------------------------------------------------------------
-- Members
-- Stores library member details
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Members (
    Member_ID       INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name       VARCHAR(100) NOT NULL,
    Email           VARCHAR(100) UNIQUE NOT NULL,
    Phone           VARCHAR(15)  UNIQUE NOT NULL,
    Address         VARCHAR(200),
    Membership_Type VARCHAR(20)  DEFAULT 'Regular',
    Joined_Date     DATE         DEFAULT (CURRENT_DATE),
    Status          VARCHAR(20)  DEFAULT 'Active'
);

-- ------------------------------------------------------------
-- Authors
-- Stores book author details
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Authors (
    Author_ID       INT PRIMARY KEY AUTO_INCREMENT,
    Full_Name       VARCHAR(100) NOT NULL,
    Nationality     VARCHAR(50),
    Email           VARCHAR(100)
);

-- ------------------------------------------------------------
-- Books
-- Stores all books available in the library
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Books (
    Book_ID         INT PRIMARY KEY AUTO_INCREMENT,
    Title           VARCHAR(200) NOT NULL,
    Author_ID       INT NOT NULL,
    Genre           VARCHAR(50),
    ISBN            VARCHAR(20)  UNIQUE NOT NULL,
    Total_Copies    INT DEFAULT 1,
    Available_Copies INT DEFAULT 1,
    Published_Year  INT,
    FOREIGN KEY (Author_ID) REFERENCES Authors(Author_ID)
);

-- ------------------------------------------------------------
-- Issued_Books
-- Tracks books issued to members
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Issued_Books (
    Issue_ID        INT PRIMARY KEY AUTO_INCREMENT,
    Member_ID       INT NOT NULL,
    Book_ID         INT NOT NULL,
    Issue_Date      DATE NOT NULL,
    Due_Date        DATE NOT NULL,
    Return_Date     DATE,
    Fine_Amount     DECIMAL(8,2) DEFAULT 0.00,
    Status          VARCHAR(20)  DEFAULT 'Issued',
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
    FOREIGN KEY (Book_ID)   REFERENCES Books(Book_ID)
);

-- ------------------------------------------------------------
-- Backup_Log
-- Tracks all backup activities
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS Backup_Log (
    Log_ID          INT PRIMARY KEY AUTO_INCREMENT,
    Backup_Type     VARCHAR(50)  NOT NULL,
    Backup_Date     DATETIME     DEFAULT NOW(),
    Status          VARCHAR(20)  DEFAULT 'Success',
    Tables_Backed   INT,
    Total_Rows      INT,
    Notes           VARCHAR(300)
);


-- ============================================================
-- INSERT SAMPLE DATA
-- ============================================================

-- Insert Authors
INSERT INTO Authors (Full_Name, Nationality, Email) VALUES
('R.K. Narayan',    'Indian',   'rk@authors.com'),
('Ruskin Bond',     'Indian',   'ruskin@authors.com'),
('Chetan Bhagat',   'Indian',   'chetan@authors.com'),
('A.P.J. Abdul Kalam', 'Indian','apj@authors.com'),
('Sudha Murthy',    'Indian',   'sudha@authors.com');

-- Insert Members
INSERT INTO Members (Full_Name, Email, Phone, Address, Membership_Type) VALUES
('Arun Kumar',    'arun@mail.com',    '9900001111', 'Chennai',    'Premium'),
('Bhavana Reddy', 'bhavana@mail.com', '9900002222', 'Hyderabad',  'Regular'),
('Chandan Singh', 'chandan@mail.com', '9900003333', 'Bangalore',  'Regular'),
('Divya Menon',   'divya@mail.com',   '9900004444', 'Kochi',      'Premium'),
('Elan Selvam',   'elan@mail.com',    '9900005555', 'Chennai',    'Regular'),
('Farida Begum',  'farida@mail.com',  '9900006666', 'Hyderabad',  'Regular');

-- Insert Books
INSERT INTO Books (Title, Author_ID, Genre, ISBN, Total_Copies, Available_Copies, Published_Year) VALUES
('Malgudi Days',         1, 'Fiction',       'ISBN001', 3, 2, 1943),
('The Room on the Roof', 2, 'Fiction',       'ISBN002', 2, 1, 1956),
('2 States',             3, 'Romance',       'ISBN003', 4, 3, 2009),
('Wings of Fire',        4, 'Biography',     'ISBN004', 5, 4, 1999),
('Wise and Otherwise',   5, 'Short Stories', 'ISBN005', 3, 2, 2002),
('The Guide',            1, 'Fiction',       'ISBN006', 2, 1, 1958);

-- Insert Issued Books
INSERT INTO Issued_Books (Member_ID, Book_ID, Issue_Date, Due_Date, Return_Date, Fine_Amount, Status) VALUES
(1, 1, '2024-01-05', '2024-01-19', '2024-01-18', 0.00,  'Returned'),
(2, 2, '2024-01-10', '2024-01-24', '2024-01-26', 20.00, 'Returned'),
(3, 3, '2024-02-01', '2024-02-15', NULL,          0.00,  'Issued'),
(4, 4, '2024-02-05', '2024-02-19', NULL,          0.00,  'Issued'),
(5, 5, '2024-02-10', '2024-02-24', '2024-02-20',  0.00, 'Returned'),
(6, 6, '2024-03-01', '2024-03-15', NULL,           0.00, 'Issued');


-- ============================================================
-- BACKUP SCRIPTS
-- ============================================================

CREATE TABLE IF NOT EXISTS Members_Backup
AS SELECT * FROM Members;


CREATE TABLE IF NOT EXISTS Authors_Backup
AS SELECT * FROM Authors;


CREATE TABLE IF NOT EXISTS Books_Backup
AS SELECT * FROM Books;

CREATE TABLE IF NOT EXISTS Issued_Books_Backup
AS SELECT * FROM Issued_Books;


SELECT 'Members'      AS Table_Name,
       COUNT(*) AS Original_Rows
FROM Members
UNION ALL
SELECT 'Authors',      COUNT(*) FROM Authors
UNION ALL
SELECT 'Books',        COUNT(*) FROM Books
UNION ALL
SELECT 'Issued_Books', COUNT(*) FROM Issued_Books;

SELECT 'Members_Backup'      AS Backup_Table,
       COUNT(*) AS Backup_Rows
FROM Members_Backup
UNION ALL
SELECT 'Authors_Backup',      COUNT(*) FROM Authors_Backup
UNION ALL
SELECT 'Books_Backup',        COUNT(*) FROM Books_Backup
UNION ALL
SELECT 'Issued_Books_Backup', COUNT(*) FROM Issued_Books_Backup;

-- ------------------------------------------------------------
-- Backup a Snapshot Database
-- ------------------------------------------------------------

CREATE DATABASE IF NOT EXISTS library_db_backup;


CREATE TABLE IF NOT EXISTS library_db_backup.Members
AS SELECT * FROM library_db.Members;


CREATE TABLE IF NOT EXISTS library_db_backup.Authors
AS SELECT * FROM library_db.Authors;


CREATE TABLE IF NOT EXISTS library_db_backup.Books
AS SELECT * FROM library_db.Books;


CREATE TABLE IF NOT EXISTS library_db_backup.Issued_Books
AS SELECT * FROM library_db.Issued_Books;


SELECT 'Members'      AS Table_Name, COUNT(*) AS Rows FROM library_db_backup.Members
UNION ALL
SELECT 'Authors',      COUNT(*) FROM library_db_backup.Authors
UNION ALL
SELECT 'Books',        COUNT(*) FROM library_db_backup.Books
UNION ALL
SELECT 'Issued_Books', COUNT(*) FROM library_db_backup.Issued_Books;


USE library_db;
INSERT INTO Backup_Log (Backup_Type, Status, Tables_Backed, Total_Rows, Notes)
VALUES (
    'Full Backup',
    'Success',
    4,
    23,
    'Full backup created — library_db_backup snapshot and individual table backups'
);


-- ============================================================
-- SIMULATE DATABASE FAILURE
-- Accidentally delete data to simulate a real failure
-- ============================================================

USE library_db;

DELETE FROM Issued_Books;

DELETE FROM Members WHERE Membership_Type = 'Regular';

UPDATE Books SET Available_Copies = 0;

SELECT 'Members'      AS Table_Name, COUNT(*) AS Remaining_Rows FROM Members
UNION ALL
SELECT 'Books',        COUNT(*) FROM Books
UNION ALL
SELECT 'Issued_Books', COUNT(*) FROM Issued_Books;


SELECT Book_ID, Title, Total_Copies, Available_Copies
FROM Books;


-- ============================================================
-- RECOVERY SCRIPTS
-- Restore all lost and damaged data from backups
-- ============================================================

TRUNCATE TABLE Issued_Books;

INSERT INTO Issued_Books
SELECT * FROM Issued_Books_Backup;


SELECT COUNT(*) AS Recovered_Issued_Books FROM Issued_Books;


-- ------------------------------------------------------------
-- Restore deleted Members
-- ------------------------------------------------------------

INSERT INTO Members
SELECT * FROM Members_Backup
WHERE Member_ID NOT IN (SELECT Member_ID FROM Members);

SELECT COUNT(*) AS Recovered_Members FROM Members;


-- ------------------------------------------------------------
-- Restore correct Available_Copies for Books
-- ------------------------------------------------------------

UPDATE Books b
JOIN Books_Backup bb ON b.Book_ID = bb.Book_ID
SET b.Available_Copies = bb.Available_Copies;

SELECT Book_ID, Title, Total_Copies, Available_Copies
FROM Books
ORDER BY Book_ID;


TRUNCATE TABLE Members;
INSERT INTO Members
SELECT * FROM library_db_backup.Members;

TRUNCATE TABLE Books;
INSERT INTO Books
SELECT * FROM library_db_backup.Books;

TRUNCATE TABLE Issued_Books;
INSERT INTO Issued_Books
SELECT * FROM library_db_backup.Issued_Books;

INSERT INTO Backup_Log (Backup_Type, Status, Tables_Backed, Total_Rows, Notes)
VALUES (
    'Recovery',
    'Success',
    4,
    23,
    'Full recovery completed from backup tables and snapshot database'
);


-- ============================================================
-- VERIFY FULL RECOVERY
-- ============================================================

USE library_db;

SELECT 'Members'      AS Table_Name, COUNT(*) AS Recovered_Rows FROM Members
UNION ALL
SELECT 'Authors',      COUNT(*) FROM Authors
UNION ALL
SELECT 'Books',        COUNT(*) FROM Books
UNION ALL
SELECT 'Issued_Books', COUNT(*) FROM Issued_Books;

SELECT Member_ID, Full_Name, Membership_Type, Status
FROM Members
ORDER BY Member_ID;


SELECT Issue_ID, Member_ID, Book_ID, Issue_Date, Status
FROM Issued_Books
ORDER BY Issue_ID;

SELECT Book_ID, Title, Total_Copies, Available_Copies
FROM Books
ORDER BY Book_ID;


SELECT SUM(Fine_Amount) AS Total_Fines FROM Issued_Books;


-- ============================================================
-- BACKUP LOG
-- ============================================================

SELECT
    Log_ID,
    Backup_Type,
    Backup_Date,
    Status,
    Tables_Backed,
    Total_Rows,
    Notes
FROM Backup_Log
ORDER BY Backup_Date;
