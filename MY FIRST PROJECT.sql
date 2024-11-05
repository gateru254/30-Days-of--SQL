--CREATE  DATABASE EmployeeDB;
--USE EmployeeDB;
/*
CREATE TABLE Employee
(
      EmployeeID INT PRIMARY KEY IDENTITY(1,1),
	  FirstName NVARCHAR(50),
	  LastName NVARCHAR(50),
	  Age INT,
	  JobTitle NVARCHAR(100),
	  Salary DECIMAL(10,2)

);

INSERT INTO Employee(FirstName, LastName, Age, JobTitle, Salary)
VALUES
('KELVIN','KAIRA',25,'DATA ANALYST',90000.00),
('John', 'Doe', 30, 'Software Engineer', 75000.00),
('Jane', 'Smith', 28, 'Project Manager', 85000.00),
('David', 'Jones', 45, 'HR Manager', 65000.00),
('Emily', 'Brown', 35, 'Marketing Manager', 72000.00),
('Michael', 'Clark', 40, 'IT Support', 60000.00),
('Olivia', 'Johnson', 32, 'Data Analyst', 78000.00),
('Liam', 'Wilson', 29, 'Accountant', 71000.00),
('Sophia', 'White', 38, 'Graphic Designer', 68000.00),
('Ethan', 'Taylor', 42, 'Network Engineer', 81000.00),
('Emma', 'Davis', 27, 'HR Assistant', 50000.00);

*/
USE EmployeeDB;
SELECT *
FROM dbo.Employee;

--Deleting duplicates in SQL u use the following- first u get the duplicate count 

/*
SELECT 
    FirstName,
	LastName,
	Age,
	Salary,
	COUNT(*) AS DuplicateCount
FROM dbo.Employee
GROUP BY FirstName,LastName,Age,Salary
HAVING  COUNT(*)>1;
*/
WITH CTE AS
(
  SELECT 
       FirstName,
	   LastName,
	   Age,
	   Salary,
	   ROW_NUMBER() OVER (PARTITION BY FirstName, LastName, Age, Salary ORDER BY EmployeeID) AS RowNum
	FROM dbo.Employee
)
DELETE FROM CTE
WHERE RowNum >1;

USE EmployeeDB
SELECT*
FROM dbo.Employee



INSERT INTO Employee(FirstName, LastName, Age, JobTitle, Salary)
VALUES
( 'Danel','Dubois',23,'Finance instructor','45000'),
('Caroline','Magu',24,'Data clerk',56000),
('Kelvin','kimani',35,'Program Assistant',90000);

ALTER TABLE dbo.Employee
ADD gender NVARCHAR(10) NOT NULL

UPDATE dbo.Employee
set gender = 'Male'
WHERE FirstName IN ('KELVIN','John','David','Liam','Ethan','Daniel','kelvin');

UPDATE dbo.Employee
SET gender = 'Female'
WHERE gender = 'FEMALE'

USE EmployeeDB
SELECT*
FROM dbo.Employee

SELECT DB_NAME() AS CurrentDatabase; --- used to show the current database

SELECT TABLE_SCHEMA, TABLE_NAME 
FROM INFORMATION_SCHEMA.TABLES 
WHERE TABLE_TYPE = 'BASE TABLE';

USE EmployeeDB
SELECT *
FROM dbo.Employee

SELECT name  AS ColumnName
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.employee');
SELECT TOP 0 *
FROM dbo.employee;
