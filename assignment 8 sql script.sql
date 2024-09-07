CREATE DATABASE EnergyManagement;
USE EnergyManagement;

-- Create Household table
CREATE TABLE Household (
    HouseholdID INT PRIMARY KEY,
    Address VARCHAR(255),
    NumberOfResidents INT
);

-- Create EnergySource table
CREATE TABLE EnergySource (
    EnergySourceID INT PRIMARY KEY,
    SourceName VARCHAR(255)
);

-- Create Appliance table
CREATE TABLE Appliance (
    ApplianceID INT PRIMARY KEY,
    HouseholdID INT,
    ApplianceName VARCHAR(255),
    EnergySourceID INT,
    FOREIGN KEY (HouseholdID) REFERENCES Household(HouseholdID),
    FOREIGN KEY (EnergySourceID) REFERENCES EnergySource(EnergySourceID)
);

-- Create EnergyConsumption table
CREATE TABLE EnergyConsumption (
    ConsumptionID INT PRIMARY KEY,
    HouseholdID INT,
    Date DATE,
    ConsumptionAmount DECIMAL(10, 2),
    FOREIGN KEY (HouseholdID) REFERENCES Household(HouseholdID)
);

-- Insert sample data into Household
INSERT INTO Household (HouseholdID, Address, NumberOfResidents) VALUES (1, '123 Elm St', 4);
INSERT INTO Household (HouseholdID, Address, NumberOfResidents) VALUES (2, '456 Oak St', 3);

-- Insert sample data into EnergySource
INSERT INTO EnergySource (EnergySourceID, SourceName) VALUES (1, 'Electricity');
INSERT INTO EnergySource (EnergySourceID, SourceName) VALUES (2, 'Gas');

-- Insert sample data into Appliance
INSERT INTO Appliance (ApplianceID, HouseholdID, ApplianceName, EnergySourceID) VALUES (1, 1, 'Refrigerator', 1);
INSERT INTO Appliance (ApplianceID, HouseholdID, ApplianceName, EnergySourceID) VALUES (2, 1, 'Heater', 2);
INSERT INTO Appliance (ApplianceID, HouseholdID, ApplianceName, EnergySourceID) VALUES (3, 2, 'Washing Machine', 1);

-- Insert sample data into EnergyConsumption
INSERT INTO EnergyConsumption (ConsumptionID, HouseholdID, Date, ConsumptionAmount) VALUES (1, 1, '2024-09-01', 120.50);
INSERT INTO EnergyConsumption (ConsumptionID, HouseholdID, Date, ConsumptionAmount) VALUES (2, 2, '2024-09-01', 80.75);

-- Retrieve energy consumption data for all households
SELECT * FROM EnergyConsumption;

-- Retrieve all appliances and their energy sources
SELECT a.ApplianceName, es.SourceName
FROM Appliance a
JOIN EnergySource es ON a.EnergySourceID = es.EnergySourceID;

-- Calculate total energy consumption by household
SELECT h.Address, SUM(ec.ConsumptionAmount) AS TotalConsumption
FROM Household h
JOIN EnergyConsumption ec ON h.HouseholdID = ec.HouseholdID
GROUP BY h.Address;

-- Average consumption per household
SELECT h.Address, AVG(ec.ConsumptionAmount) AS AverageConsumption
FROM Household h
JOIN EnergyConsumption ec ON h.HouseholdID = ec.HouseholdID
GROUP BY h.Address;


