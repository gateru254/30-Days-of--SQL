CREATE DATABASE Murife
SELECT @@LANGUAGE;
CREATE TABLE [dbo].[Sheet1] (
    [Attrition] NVARCHAR(255),
    -- Add other columns here as necessary
);

CREATE TABLE countries
 (
   KE INT PRIMARY KEY,
   NAME TEXT UNIQUE,
   founding_year INT,
   Capital text
   );
