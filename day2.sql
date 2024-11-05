USE ANALYST
/*
SELECT TABLE_SCHEMA,TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';
*/

USE ANALYST
SELECT*
FROM dbo.Employees

/*
CREATE TABLE Employees
  (
  EmployeeID SERIAL PRIMARY KEY,
   Firstname NVARCHAR,
   Lastname NVARCHAR,
   DepartmentID INT,
   Salary DECIMAL(10,2),
   Hiredate DATE,
   Country, NVARCHAR (50)
   Age INT,
   HoursWorked INT
   );
   */

--Question 1 . Retrieve all columns and rows from the Employees table */

 SELECT * FROM Employees

 --QUESTION 2 SELECT SPECIFIC COLUMNS LASTNAME,FIRSTNAME,SALARY,AGE

 SELECT Firstname,Lastname,Salary,Age
 FROM Employees
 
 CREATE TABLE Dept
   (
   DepartmentID INT PRIMARY KEY IDENTITY (1,1),
   Departmentname NVARCHAR (50));

SELECT * FROM Dept
 --FIND ALL EMPLOYEES IN THE IT DEPARTMENT 
 --QUESTION3 FILTER ROWS WITH WHERE 

 SELECT*
 FROM Employees
 WHERE DepartmentID = '3';

 --QUESTION 4 Retrieve employees with a salary greater than 50000.

 SELECT *
 FROM INFORMATION_SCHEMA.COLUMNS
 WHERE TABLE_NAME = 'Employees';

--NOW U NEED TO  CONVERT THE COLUMN AGE TO INT

ALTER TABLE Employees
ALTER COLUMN  Salary INT


---  show employees earning 50000.00 and are 38 years .
SELECT *
FROM Employees
WHERE Salary >50000.00
 AND Age IN (
 SELECT Age
 FROM Employees 
 WHERE Age=38
 );


--QUESTION 5 LIST ALL employees by  hiredate in descending .

SELECT *FROM Employees
ORDER by HireDate DESC


--QUESTION 6 DISPLAY the top 5 highest-paid employeess 
--IN Microsoft SQL WE USE TOP rather than LIMIT like in MySQL and postgre
--THE LIMIT CLAUSE Sometimes you want only the first few rows.THE LIMIT KEYWORD COMES IN HANDY.Imagine that you wanted to only 
--get the model of the first five products that were produced by the company 


SELECT TOP 10 Firstname,Age,Salary
FROM Employees
ORDER BY Salary ASC ,Age DESC;

-- Question 7 Retrieve the top 5 highest paid employees for each department sorted by salary in descending order.
-- CTE  AND THE ROW NUMBER ()

WITH RankEmployees AS
(
  SELECT FirstName,LastName,Age,Salary,
  ROW_NUMBER() OVER (PARTITION BY Age ORDER BY salary DESC) AS rank 
  FROM Employees
  )
  SELECT FirstName,LastName,Age,Salary
  FROM RankEmployees
  WHERE rank <=5
  ORDER BY Age, rank;


  ---question 8 SELECT THE SECOND HIGHEST EARNING EMPLOYEE
  SELECT MAX (Salary) AS SECOND_HIGHESTSAL 
  FROM Employees
  WHERE SALARY<(SELECT MAX(Salary)FROM Employees);

  --QUESTION 9 Display the highest payed employees in each department?
  SELECT MAX (SALARY) AS MAX_Salary_perage, Age FROM Employees
  GROUP BY Age

--question 10 Find Duplicate values and its frequency of a column?
SELECT Country,COUNT(*)FROM Employees
GROUP BY Country
HAVING COUNT(*)=100;

--Display nth row in SQL
--Display the 2nd postition in sql 

SELECT * FROM 
(SELECT ROW_NUMBER() OVER (ORDER BY  Salary) AS R,
Age,Salary,Country
FROM Employees ) AS subquery
WHERE r=4;

--DISPLAY first  and last rows of the table 
SELECT *FROM (SELECT ROW_NUMBER () OVER (ORDER BY Country) AS rowno,
Age,Salary,Country,FirstName,LastName FROM Employees ) AS subquery
WHERE rowno = 1 or rowno =(SELECT COUNT(*) FROM Employees)

--Display last two rows of the table
SELECT * FROM Employees
ORDER BY EmployeeID DESC
OFFSET 0 ROWS FETCH NEXT 2 ROWS ONLY;

--Display first and last 2 rows of the table employees

---WEEK 2
--AGGREGATE FUNCTIONS 
--CALCAULATE THE AVERAGE SALARY AND AGE OF THE EMPLOYEES 

SELECT AVG (CAST(Salary AS DECIMAL(10,2))) AS Avg_Salary
FROM Employees;

SELECT *
FROM Employees


ALTER TABLE Employees
ADD weight INT ;

ALTER TABLE Employees
ADD Height INT NOT NULL;


ALTER TABLE Employees
DROP Column weight;


USE EmployeeDB

SELECT *
FROM Department

CREATE TABLE dprt
 ( DptID INT, 
   DptName NVARCHAR (50)
   );

INSERT INTO dprt (DptID,DptName)
VALUES (1,'Sales'),
       (2,'HR'),
	   (3,'IT'),
	   (4,'Marketing'),
	   (5,'Finance'),
	   (6,'Operations');

SELECT *
FROM dprt


USE EmployeeDB
SELECT *
FROM EMP

EXEC sp_rename 'EMP.DepartmentID','DptID','COLUMN';  -- RENAMING THE COLUMN

ALTER TABLE EMP
ALTER COLUMN Salary INT;

ALTER TABLE EMP
ALTER COLUMN Salary DECIMAL(10, 2);

-----QUESTION DAY 9 FIND THE TOTAL SAlARY EXPENDITURE PER DEPARTMENT

SELECT dprt.DptName AS DT ,SUM(Salary) AS Total_Salary --
FROM EMP
JOIN dprt
ON EMP.DptID = dprt.DptID
GROUP BY dprt.DptName;


--HAVING CLAUSE
--QUESTION 10 LIST DEPARTMENTS WITH TOTAL SALARY EXCEEDING 200,000

SELECT dprt.DptName AS DT,SUM(Salary) AS Total_Salary 
FROM EMP
JOIN dprt
ON EMP.DptID = dprt.DptID
GROUP BY dprt.DptName
HAVING SUM(Salary) >=500000;


---Question 11 Count the number of employees per department.

USE EmployeeDB
SELECT*
FROM dprt

USE EmployeeDB
SELECT *
FROM EMP

--AFTER doing the join u can use the select INTO  to create a  new table which the store the output.

SELECT 
    EMP.DptID AS Employee_DptID,    ---Selecting departmentID from employee table
    dprt.DptName,                   ---Selecting Department _name from Department Table
    EMP.Salary,                     ---Selecting  Salary from Employee Table
    EMP.FirstName,                  ---Selecting  Firstname from  Employee Table
    EMP.LastName,                   ---Selecting  Lastname from  Employee Table
    EMP.Country                     ---Selecting Country column from  Employee Table
INTO Employee_dept                  --- Creating a New_table(Employee_dept) which will store the result the join output
FROM EMP                         --- table 1
JOIN dprt                  ---Table 2 
ON EMP.DptID = dprt.DptID;        ---- Doing the join on the columns Employee_ID on Department_ID 


SELECT*
FROM Employee_dept
ORDER BY EMployee_DptID,FirstName,LastName,DptName,Salary,Country

---Question 11 Count the number of employees per department.

USE EmployeeDB
SELECT *
FROM Employee_dept

SELECT DptName,Salary,
        COUNT (*) AS Employee_count
FROM Employee_dept
GROUP BY DptName,Salary
ORDER BY Salary DESC;


---DAY 12 DISTINCT KEYWORD
--QUESTION LIST all unique counties where employees are located.

SELECT DISTINCT Country
FROM Employee_dept

--question show the count of employees  per country
SELECT Country,Salary,
COUNT (*) AS County_count
FROM Employee_dept
GROUP BY Country ,Salary
ORDER BY Country DESC

--DAY 13 
--Using IN and NOT IN 
--Question Find employees who work in sales, IT or HR departments 

SELECT FirstName,LastName,DptName
FROM Employee_dept
WHERE DptName  NOT IN ('Sales','IT','HR');

SELECT FirstName,LastName,DptName
FROM Employee_dept
WHERE DptName IN ('Sales','IT','HR');

---Aggregate function can be used with the where clause to calculate  aggregate values for specific subsets of data
---for example if you want to known how many employees US has

SELECT COUNT (*) AS Employee_in_USA
FROM Employee_dept
WHERE Country = 'USA';

---USE THE AGGREGATE FUNCTIONS TO GET THE MAX AND MIN SALARY EARNED BY EMPLOYEES
SELECT 
MIN (Salary) AS Min_Sal,
MAX(Salary) AS Max_Sal
FROM Employee_dept

--- selcting 5 percentage of the 600 rows  
SELECT top  5 PERCENT *
FROM Employee_dept

---Select from multiple value in where clause we use in 
---AGGREGATING DATA COUNT,
--- JOINING both the firstname + lastname to get the fullname  we go this way
SELECT FirstName,LastName,FirstName + ' ' + LastName AS "Full Name"
FROM Employee_dept
---day 14 
---Combine Multiple intermediate concepts by writing queries that involve GROUP BY,HAVING AND JOIN CLAUSES.


USE EmployeeDB
SELECT EMP.Country,EMP.HireDate,EMP.Salary,EMP.HoursWorked,dprt.DptName,dprt.DptID
FROM EMP
JOIN dprt
ON EMP.DptID =dprt.DptID
GROUP BY Country,Salary,HireDate,HoursWorked
HAVING Salary > 90000

USE EmployeeDB

SELECT*
FROM [Product 2]

--day 15 JOIN Operations (INNER JOIN )
--QUESTION Retreive employee details along with their department names .

SELECT*
FROM [Product 2]
WHERE Category LIKE '%Books%'


SELECT * 
FROM EMP
--- HOW TO ANSWER QUESTION NUMBER 14,

SELECT EMP.Country,dprt.DptName,
COUNT(EMP.EmployeeID) AS Num_Employees,
AVG(EMP.Salary) AS AVG_Salary
SUM(EMP.Hoursworked ) AS Total_Hours


dprt.DptName;


USE EmployeeDB
;WITH HireCounts AS (
    SELECT 
        HireDate, 
        COUNT(EmployeeID) AS HiredCount
    FROM 
        EMP
    GROUP BY 
        HireDate
), AvgHired AS (
    SELECT 
        AVG(HiredCount) AS AvgEmployeesHiredPerDate
    FROM 
        HireCounts
)
SELECT 
    EMP.Country, 
    dprt.DptName, 
    COUNT(EMP.EmployeeID) AS NumEmployees, 
    AVG(EMP.Salary) AS AvgSalary, 
    SUM(EMP.HoursWorked) AS TotalHours, 
    SUM(EMP.HoursWorked) / COUNT(EMP.EmployeeID) AS AvgHoursPerEmployee, 
    AvgHired.AvgEmployeesHiredPerDate
FROM 
    EMP
JOIN 
    dprt ON EMP.DptID = dprt.DptID
CROSS JOIN 
    AvgHired
GROUP BY 
    EMP.Country, dprt.DptName
HAVING 
    AVG(EMP.Salary) > 90000;

--QUESTION 16.
--List all departments and their employees,including departments with no employees
--here we are going to use LEFT JOIN since we care .

----WHEN TO USE WHICH QUERY IF YOU care about all departments even those without employees,use:
----IF you care about all employees even those who don't belong to a department ,use;
SELECT dprt.DptName,EMP.EmployeeID,EMP.FirstName,EMP.Country
FROM EMP
LEFT JOIN dprt
ON dprt.DptID=EMP.DptID

--QUESTION 17
--RIGHT JOIN 
--LIST all employees and their department names,including employees without a department.

SELECT EMP.FirstName + '  ' + LastName AS "Full Name" ,EMP.Country,EMP.HoursWorked,EMP.Salary,dprt.DptName 
FROM dprt
RIGHT JOIN EMP
ON EMP.DptID=dprt.DptID;

---QUESTION 18
---FULL OUTER JOIN.
--Combine both LEFT and RIGHT joins to display all employees and departments.

SELECT *
FROM EMP
FULL JOIN dprt
ON EMP.DptID=dprt.DptID;

--QUESTION 19 
--FIND employees who earn more than the average salary.
-- here we first create a subquery to calculate the overall average salary from the EMP table,and then compare each employee's salary

SELECT FirstName + ' '+ LastName AS "Full Name",Country,Salary,HireDate
FROM EMP
WHERE Salary >( SELECT AVG(Salary) FROM EMP);

SELECT FirstName + ' ' + LastName  AS "Full Name",Country,DptName,Salary
FROM Employee_dept
WHERE Salary >(SELECT AVG (Salary) FROM EMP );

SELECT AVG(Salary) AS AVG_Salary
FROM EMP

SELECT*
FROM Employee_dept

Select DISTINCT Salary
FROM EMP


--QUESTION 20 
-- CASE STATEMENTS
--QUESTION categorize employees based on their salary HIGH, MEDIUM ,LOW EARNERS,

--USE EmployeeDB 

SELECT Salary,
CASE
WHEN Salary < (Select AVG(Salary) FROM EMP) THEN 'LOW'
WHEN Salary >(Select AVG(Salary) FROM EMP ) THEN 'HIGH'
ELSE 'MEDIUM'
END AS 'SALARIED WORKER'
FROM EMP 



--QUESTION 22 WINDOW FUNCTIONS
--ASSIGN A unique row number to each employee within their department based on salary.

SELECT*
FROM EMP

use EmployeeDB
SELECT FirstName,LastName,Salary,Age,
ROW_NUMBER()OVER(PARTITION BY EMP.DptID ORDER BY Salary) AS RN
FROM EMP
JOIN dprt
ON EMP.DptID =dprt.DptID;

use EmployeeDB


SELECT year, SUM(precipitation) 
FROM station _data
WHERE tornado = 1
GROUP BY year 
ORDER  BY year DESC

--SELECT the year and max snow depth,but only years where the max snow depth is at least 50

---Remember we dont use the where statement for aggregate functions 
---SELECT year ,MAX(snow_depth)
--FROM Station_data
--WHERE Max(Snow_depth) >= 50

--so the correct code is here 

/*SELECT year,MAX(snow_depth) AS Max_Snow_Depth
FROM Station_Data
GROUP BY year
HAVING Max_snow_Depth >= 50 
*/

SELECT DISTINCT Age
FROM EMP

use EmployeeDB
SELECT --FirstName + ' ' +  LastName AS "Full Name", Age,

CASE 
    WHEN Age BETWEEN 30 AND 40 THEN  'Newbie'
	WHEN Age BETWEEN 40 AND 50 THEN   'Intermediate'
	WHEN Age BETWEEN 50 AND 60 THEN   'Expert'
	ELSE 'other'
END AS Experience,

COUNT (*) AS Experience_count

FROM EMP

GROUP BY

CASE
 WHEN Age BETWEEN 30 AND 40 THEN  'Newbie'
	WHEN Age BETWEEN 40 AND 50 THEN   'Intermediate'
	WHEN Age BETWEEN 50 AND 60 THEN   'Expert'
	ELSE 'other'
END 

--QUESTION  23 Window Functions (RANK and DENSE_RANK)
--Question Rank Employees within their departments based on salary handling ties.

SELECT EMP.Salary,dprt.DptName,
RANK()OVER(PARTITION BY dprt.DptName ORDER BY salary DESC) AS Salary_rank ,
DENSE_RANK() OVER(PARTITION BY dprt.DptName ORDER BY Salary DESC ) AS Salary
FROM EMP
     JOIN dprt
ON EMP.DptID =dprt.DptID;


SELECT Salary,
RANK() OVER(PARTITION BY EMP.Salary ORDER BY SALARY ) as salary
FROM EMP 

--DAY 24 USE CTE 
--QUESTION USE A CTE TO find Departments with more than 10 employees,

WITH DepartmentEmployeeCounts AS ( 
    SELECT EMP.DptID ,
	       COUNT (EmployeeID  ) AS employee_count
    FROM EMP
	GROUP BY EMP.DptID
)
SELECT dprt.DptName,Employee_count
FROM dprt D
JOIN DepartmentsEmployeeCounts dec ON dprt.DptID =EMP.DptID
WHERE employee_count >10;


SELECT*
FROM EMP


SELECT COUNT (DISTINCT EmployeeID )
FROM EMP