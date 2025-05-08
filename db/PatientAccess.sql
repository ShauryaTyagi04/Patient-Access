CREATE DATABASE PatientAccess;
USE PatientAccess;

CREATE TABLE Patients (
    PatientID INT IDENTITY(1,1) PRIMARY KEY,
	ClinicID INT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(15) UNIQUE NOT NULL,
    NHSNumber NVARCHAR(20) UNIQUE NOT NULL,
    DateOfBirth DATE NOT NULL,
    PostCode NVARCHAR(10) NOT NULL,
    Gender NVARCHAR(10) CHECK (Gender IN ('Male', 'Female', 'Other')) NOT NULL,
    EmergencyContactNumber NVARCHAR(15) NOT NULL,
    PasswordHash NVARCHAR(255) NOT NULL,
    BloodType NVARCHAR(3) CHECK (BloodType IN ('A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-')),
	ProfileImage VARBINARY(MAX),
	ProfileImagePath NVARCHAR(255),
	CONSTRAINT FK_Patients_Clinics FOREIGN KEY (ClinicID)
        REFERENCES Clinics(ClinicID) ON DELETE CASCADE
);

--Patient ID Foreign key--

CREATE TABLE Allergies (
    AllergyID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    AllergyName NVARCHAR(100) NOT NULL,
    Allergen NVARCHAR(50) NOT NULL,
    DateDiagnosed DATE,
    Severity NVARCHAR(20) CHECK (Severity IN ('Mild', 'Moderate', 'Severe')),
    Treatment NVARCHAR(255),
    Notes NVARCHAR(MAX),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE
);

CREATE TABLE Immunizations (
    ImmunizationID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    VaccineName NVARCHAR(100) NOT NULL,
    DateAdministered DATE,
    Dosage NVARCHAR(20),
    AdministratorName NVARCHAR(100),
    ClinicLocation NVARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE
);

CREATE TABLE ChronicConditions (
    ConditionID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    ConditionName NVARCHAR(100) NOT NULL,
    DateDiagnosed DATE,
    Severity NVARCHAR(20) CHECK (Severity IN ('Mild', 'Moderate', 'Severe')),
    Treatment NVARCHAR(255),
    Notes NVARCHAR(MAX),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE
);

CREATE TABLE FamilyHistory (
    HistoryID INT IDENTITY(1,1) PRIMARY KEY,
    PatientID INT NOT NULL,
    FamilyMember NVARCHAR(100) NOT NULL,
    DateDiagnosed DATE,
    Relation NVARCHAR(20),
    Age NVARCHAR(100),
    HealthConditions NVARCHAR(255),
    Notes NVARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID) ON DELETE CASCADE
);

--Patient ID Foreign key--

CREATE TABLE Clinics (
    ClinicID INT IDENTITY(1,1) PRIMARY KEY,
    ClinicName NVARCHAR(255) NOT NULL,
    AddressLine1 NVARCHAR(255) NOT NULL,
    AddressLine2 NVARCHAR(255) NULL,
    City NVARCHAR(100) NOT NULL,
    County NVARCHAR(100) NULL,
    PostCode NVARCHAR(20) NOT NULL,
    Country NVARCHAR(100) NOT NULL
);



CREATE TABLE Doctors (
    DoctorID INT IDENTITY(1,1) PRIMARY KEY,
    ClinicID INT NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Specialization NVARCHAR(255) NOT NULL,
    Description NVARCHAR(MAX) NULL,
    CONSTRAINT FK_Doctors_Clinics FOREIGN KEY (ClinicID)
        REFERENCES Clinics(ClinicID) ON DELETE CASCADE
);




