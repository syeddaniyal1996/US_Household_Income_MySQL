CREATE DATABASE ushousehold;

USE ushousehold;

DESCRIBE ushouseholdincome;

SELECT * 
FROM ushouseholdincome;

#ABBREVIATION CLEANING

ALTER TABLE ushouseholdincome
Change Column State_ab State_Abbreviation text;

ALTER TABLE ushouseholdincome
Change Column ALand Avg_Land int;

ALTER TABLE ushouseholdincome
Change Column AWater Avg_Water int;

ALTER TABLE ushouseholdincome
Change Column Lat Latitude int;

ALTER TABLE ushouseholdincome
Change Column Lon Longitude int;

ALTER TABLE ushouseholdincome
Change Column Country_Units County_Units text;

#Total Number Of Records

SELECT 
    COUNT(*) AS total_records
FROM
    ushouseholdincome;

#Distinct State Name

SELECT DISTINCT
    State_Name
FROM
    ushouseholdincome;

#Summary for numerical columns 

SELECT 
    *
FROM
    ushouseholdincome;
    
SELECT 
    MIN(Latitude) AS min_Latitude,
    MAX(Latitude) AS max_Latitude,
    ROUND(AVG(Latitude), 2) AS avg_Latitude,
    MIN(Longitude) AS min_Longitude,
    MAX(Longitude) AS max_Longitude,
    ROUND(AVG(Longitude), 2) AS avg_Longitude
FROM
    ushouseholdincome;

#Count Places by state wise

SELECT 
    *
FROM
    ushouseholdincome;
    
SELECT DISTINCT
    State_Name, COUNT(*) AS place_count
FROM
    ushouseholdincome
GROUP BY State_Name;

#State name with maximum number of places

SELECT 
    State_Name, COUNT(*) AS place_count
FROM
    ushouseholdincome
GROUP BY State_Name
ORDER BY place_count DESC;

#Get the average area (land and water) for each state

SELECT 
    *
FROM
    ushouseholdincome;
    
SELECT Avg_Land, Avg_Water
FROM
    ushouseholdincome;

SELECT 
    State_Name,
    ROUND(AVG(Avg_Land), 2) AS avg_land_area,
    ROUND(AVG(Avg_Water), 2) AS avg_water_area
FROM
    ushouseholdincome
GROUP BY State_Name;

#Find largest and smallest land & water areas in each state

SELECT 
    State_Name,
    MAX(Avg_Land) AS largest_land_area,
    MIN(Avg_Land) AS smallest_land_area,
    MAX(Avg_Water) AS largest_water_area,
    MIN(Avg_Water) AS smallest_water_area
FROM
    ushouseholdincome
GROUP BY State_Name;

#REMOVE DUPLICATES AND ERRORS

SELECT 
    *
FROM
    ushouseholdincome;
    
SELECT 
    State_Code,
    State_Name,
    State_Abbreviation,
    County,
    City,
    Place,
    `Type`,
    `Primary`,
    Zip_Code,
    Area_Code,
    Avg_Land,
    Avg_Water,
    Latitude,
    Longitude,
    COUNT(*) AS Count
FROM
    ushouseholdincome
GROUP BY State_Code , State_Name , State_Abbreviation , County , City , Place , `Type` , `Primary` , Zip_Code , Area_Code , Avg_Land , Avg_Water , Latitude , Longitude
HAVING Count > 1;

-- Full_Address (Merged Columns City, Place, State_Abbreviation & Zip_Code) & Delete Single Columns

SELECT 
    *
FROM
    ushouseholdincome;

ALTER TABLE ushouseholdincome
ADD COLUMN Full_Address varchar(100);

UPDATE ushouseholdincome 
SET 
    Full_Address = CONCAT(City,
            ', ',
            Place,
            ', ',
            State_Abbreviation,
            ', ',
            Zip_Code);
            
ALTER TABLE ushouseholdincome
MODIFY COLUMN State_Abbreviation varchar(100) AFTER Place;

ALTER TABLE ushouseholdincome
MODIFY COLUMN Zip_Code varchar(100) AFTER State_Abbreviation;

ALTER TABLE ushouseholdincome
MODIFY COLUMN Full_Address varchar(100) AFTER Zip_Code;

ALTER TABLE ushouseholdincome
Drop COLUMN Total_Area,
Drop COLUMN Sq_Area;

Alter Table ushouseholdincome
Drop column City,
Drop column Place,
Drop column State_Abbreviation,
Drop column Zip_Code;

SELECT 
    *
FROM
    ushouseholdincome;

#Merge County_Units & City to form County_Information & Delete Separated Columns

SELECT 
    *
FROM
    ushouseholdincome;

ALTER TABLE ushouseholdincome 
ADD COLUMN County_Information VARCHAR(100);

UPDATE ushouseholdincome 
SET 
    County_Information = CONCAT(County_Units, ' in ', City);

ALTER TABLE ushouseholdincome
MODIFY COLUMN County_Information varchar(100) AFTER State_Name;

ALTER TABLE ushouseholdincome
DROP COLUMN County_Info;

#Finalized Table

SELECT 
    *
FROM
    ushouseholdincome;