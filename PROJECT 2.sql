--USE EmployeeDB
--SELECT*
--FROM dbo.Employee

CREATE TABLE Department
(
   DepartmentID INT,
   Department NVARCHAR(50),
   DeptDiv NVARCHAR(50),
   DeptSection NVARCHAR(50),
)
SELECT *
FROM Department

INSERT INTO Department ( DepartmentID,Department,DeptDiv,DeptSection)
VALUES
(100,'CUSTOMS','NCE','SCANNER'),
(101,'DTD','BCE','DTG'),
(102,'CSS','HR','HRD'),
(103,'CSS','IT','SM'),
(104,'CSS','Facilities','FCL');

ALTER TABLE Department
ADD Location NVARCHAR(50)

UPDATE Department
SET  Location = 'JKIA'
WHERE DepartmentID IN ('101','100','103');

UPDATE Department
SET  Location = 'TT'
WHERE DepartmentID = ('104');

USE EmployeeDB
SELECT *
FROM dbo.Department


UPDATE Department
SET Location = 'Namanga'
WHERE Location IS NULL


SELECT name AS ColumnName
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.employee') ;

SELECT name AS ColumnName
FROM sys.columns
WHERE object_id = OBJECT_ID('dbo.Department');

ALTER TABLE dbo.Employee
ADD DepartmentID int;

--giving employees DepartmentID
UPDATE  dbo.Employee
SET DepartmentID = '101'
WHERE gender = 'Male';


UPDATE dbo.employee
SET DepartmentID = '102'
WHERE age = '35';

USE EmployeeDB
SELECT *
FROM dbo.Employee

UPDATE dbo.Employee
SET DepartmentID = '103'
WHERE Age IN (40,38,42);

UPDATE dbo.Employee
SET DepartmentID = '104'
WHERE Age IN (28,32,27,23,24);

--Displaying the two tables so that i can decide which join to use 
 SELECT * FROM dbo.Employee

 SELECT * FROM dbo.Department
 
 SELECT*
 FROM dbo.Employee
 JOIN dbo.Department 
 ON dbo.Employee.DepartmentID = dbo.Department.DepartmentID

 ---here we do an inner join and the two tables are merge together 
 SELECT EmployeeID,FirstName,LastName,Age,Salary,gender,Department,d.DepartmentID,DeptDiv,DeptSection,Location
 FROM dbo.Employee e
 JOIN dbo.Department d
 ON e.DepartmentID =d.DepartmentID;
 --WHERE Age >35;

 

 --- here we are doing the left join and we see the department with ID NUMBER 100 does not have a value.and hence null

 SELECT EmployeeID,Firstname,Lastname,Age,Salary,gender,Department,d.DepartmentID,DeptDiv,DeptSection,Location
 FROM dbo.Department d
 LEFT JOIN dbo.Employee e
 ON d.DepartmentID = e.DepartmentID;

 SELECT EmployeeID,Firstname,Lastname,Age,Salary,gender,Department,d.DepartmentID,DeptDiv,DeptSection,Location
 FROM dbo.Department d
 FULL OUTER JOIN  dbo.Employee e
 ON d.DepartmentID = e.DepartmentID

 -- CTE  REDUCES THE EXECUTION TIME
-- CROSS JOIN USED TO SHOW ALL POSSIBLE COMBINATION
--Alias is like a place holder variable.
 SELECT EmployeeID,FirstName,LastName,Age,Salary,gender,Department,d.DepartmentID,DeptDiv,DeptSection,Location
 FROM dbo.Employee e
 CROSS JOIN dbo.Department d;

--SubQueries is a query inside another query.

USE EmployeeDB

SELECT Firstname
FROM dbo.Employee
WHERE Age = (
    SELECT age
	FROM dbo.department
	WHERE department = 'CSS'
	);
SELECT Salary
FROM Employee
WHERE DepartmentID IN 
(
SELECT DepartmentID 
FROM Department
WHERE Location = 'JKIA'
);



