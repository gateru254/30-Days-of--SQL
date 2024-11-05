USE EmployeeDB
--semicolon operator ;is used to tell the computer it has reachead the end of the query,

Select *
FROM Employee


INSERT INTO Employee(FirstName,LastName,Age,JobTitle,Salary,gender,DepartmentID)
VALUES
('KELVIN','KAIRA','25','DATA ANALYST',90000,'Male',101),
('John','Doe','30','Software Engineer',75000,'Male','101')

--REMOVING Duplicate in SQL Duplicates in data can distort results and lead to incorrect conclusions.
--SQL offers multiple ways to identify and remove duplicates.

-- SOL/ USE DISTINCT OR ROW_NUMBER ()TO ELIMINATE DUPLICATE ROWS.


WITH RankedRows AS ( SELECT *,ROW_NUMBER() OVER ( ORDER BY Age DESC) AS row_num
FROM Employee
)
SELECT * FROM RankedRows
WHERE row_num = 1;

SELECT LastName
FROM Employee
GROUP BY LastName
HAVING COUNT(*) = 1;

WITH RankedRows AS (
SELECT *,
   DENSE_RANK()OVER (ORDER BY Salary  DESC) AS rank
   FROM Employee
   )
   SELECT *
   FROM RankedRows
   WHERE rank =1;
   --- showing duplicate in sql heres the code

SELECT FirstName,LastName,Age, COUNT(*)   AS Number_counts
FROM Employee
GROUP BY FirstName,LastName,Age
HAVING COUNT(*) >1