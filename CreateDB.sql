--\c postgres;
--drop database zoo; create database zoo; \c zoo; \ir CreateDB.sql;

-- create enumeration for gender, used in two tables (STAFF and ANIMAL)
CREATE TYPE GENDER AS ENUM ('F', 'M');

CREATE TABLE STAFF (
StaffID SERIAL NOT NULL,
Lname VARCHAR(40) NOT NULL,
Fname VARCHAR(40) NOT NULL,
DateofBirth DATE CHECK (DateofBirth > '1900-01-01'),
DateOfEmployment DATE NOT NULL CHECK (DateOfEmployment > '2000-01-01'),
Gender GENDER NOT NULL,
Address VARCHAR(250) NOT NULL,
Email VARCHAR(150),
Phone VARCHAR(12) NOT NULL,
DepartmentID INT,
SupervisorID INT,
PRIMARY KEY (StaffID)
);

CREATE TABLE DEPARTMENT (
DepartmentID SERIAL NOT NULL,
Name VARCHAR(150),
SupervisorID INT NOT NULL,
PRIMARY KEY (DepartmentID),
FOREIGN KEY (SupervisorID) REFERENCES STAFF(StaffID),
UNIQUE (Name)
);

CREATE TABLE ZONE (
ZoneID SERIAL NOT NULL,
Name VARCHAR(150),
DepartmentID INT NOT NULL,
PRIMARY KEY (ZoneID),
FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID),
UNIQUE (Name)
);

CREATE TABLE ANIMAL (
AnimalID SERIAL NOT NULL,
Name VARCHAR(125) NOT NULL,
Type VARCHAR(125) NOT NULL,
DateAquired DATE NOT NULL CHECK (DateAquired > '2000-01-01'),
DateofBirth DATE CHECK (DateofBirth > '1900-01-01'),
Gender GENDER NOT NULL,
ZoneID INT NOT NULL,
Primary_Caregiver INT NOT NULL,
PRIMARY KEY (AnimalID),
FOREIGN KEY (ZoneID) REFERENCES ZONE(ZoneID),
FOREIGN KEY (Primary_Caregiver) REFERENCES STAFF(StaffID)
);

CREATE TABLE SHOW (
ShowID SERIAL NOT NULL,
Name VARCHAR(150) NOT NULL,
Description TEXT,
Capacity SMALLINT NOT NULL CHECK (Capacity > 0 and Capacity < 1000),
PRIMARY KEY (ShowID),
UNIQUE (Name)
);

CREATE TABLE SHOW_HAS_ANIMALS (
ShowID INT REFERENCES SHOW(ShowID),
AnimalID INT REFERENCES ANIMAL(AnimalID)
);

CREATE TABLE SHOW_HAS_STAFF (
ShowID INT REFERENCES SHOW(ShowID),
StaffID INT REFERENCES STAFF(StaffID)
);

CREATE TABLE SHOP (
ShopID SERIAL NOT NULL,
Name VARCHAR(150) NOT NULL,
Description TEXT,
OpenTime TIME NOT NULL,
CloseTime TIME NOT NULL,
ZoneID INT NOT NULL, 
SupervisorID INT NOT NULL,
PRIMARY KEY (ShopID),
FOREIGN KEY (ZoneID) REFERENCES ZONE(ZoneID),
FOREIGN KEY (SupervisorID) REFERENCES STAFF(StaffID)
);

CREATE TABLE SHOP_HAS_STAFF (
ShopID INT REFERENCES SHOP(ShopID),
StaffID INT REFERENCES STAFF(StaffID)
);

CREATE TABLE ITEMS (
ItemID SERIAL NOT NULL,
Name VARCHAR(150) NOT NULL,
Description TEXT,
Cost NUMERIC NOT NULL CHECK (Cost > 0.00),
DateLastStocked DATE CHECK (DateLastStocked > '2000-01-01'),
CurrentStock SMALLINT NOT NULL CHECK (CurrentStock >= 0),
RequiredStock SMALLINT NOT NULL CHECK (RequiredStock > 0),
PRIMARY KEY (ItemID),
UNIQUE (Name)
);

CREATE TABLE SHOP_HAS_ITEMS (
ShopID INT REFERENCES SHOP(ShopID),
ItemID INT REFERENCES ITEMS(ItemID)
);

CREATE TABLE CATEGORY (
CategoryID SERIAL NOT NULL,
Name VARCHAR(150) NOT NULL,
PRIMARY KEY (CategoryID),
UNIQUE (Name)
);

CREATE TABLE ITEM_HAS_CATEGORIES (
ItemID INT REFERENCES ITEMS(ItemID),
CategoryID INT REFERENCES CATEGORY(CategoryID)
);

-- add foreign keys
ALTER TABLE STAFF ADD FOREIGN KEY (DepartmentID) REFERENCES DEPARTMENT(DepartmentID);
ALTER TABLE STAFF ADD FOREIGN KEY (SupervisorID) REFERENCES STAFF(StaffID); 

-- triggers

CREATE FUNCTION updateEmploymentDate() RETURNS TRIGGER AS $updateEmploymentDate$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        UPDATE STAFF
        SET DateOfEmployment = current_timestamp
        WHERE staffid = NEW.StaffID;
END IF;
RETURN NULL;    
END;
$updateEmploymentDate$ LANGUAGE plpgsql;

CREATE TRIGGER updateEmploymentDateTgr
AFTER INSERT ON STAFF
FOR EACH ROW 
EXECUTE PROCEDURE updateEmploymentDate();

CREATE FUNCTION updateDateLastStocked() RETURNS TRIGGER AS $updateDateLastStocked$
BEGIN
    IF (TG_OP = 'INSERT' AND NEW.CurrentStock < NEW.RequiredStock) THEN
        UPDATE ITEMS
        SET DateLastStocked = current_timestamp,
        CurrentStock = CurrentStock + RequiredStock
        WHERE ItemID = NEW.ItemID;
END IF;
RETURN NULL;    
END;
$updateDateLastStocked$ LANGUAGE plpgsql;

CREATE TRIGGER updateEmploymentDateTgr
AFTER INSERT ON ITEMS
FOR EACH ROW 
EXECUTE PROCEDURE updateDateLastStocked();

CREATE OR REPLACE FUNCTION getMonthBirthdays(month integer) 
RETURNS TABLE (
	last_name VARCHAR,
	first_name VARCHAR,
	birth_date DATE,
	age double precision
) AS $$
BEGIN
    RETURN QUERY 
    SELECT fname, lname, DateofBirth, date_part('year', age(current_timestamp, DateofBirth))
    FROM STAFF
    WHERE date_part('month', DateofBirth) = month
    ORDER BY DateofBirth DESC;
END; $$
LANGUAGE 'plpgsql';

