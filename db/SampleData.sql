USE PatientAccess;

INSERT INTO Clinics (ClinicName, AddressLine1, AddressLine2, City, County, PostCode, Country)
VALUES 
('Central London Clinic', '123 Baker Street', 'Marylebone', 'London', 'Greater London', 'NW1 6XE', 'UK'),
('Manchester Health Centre', '456 King Street', 'City Centre', 'Manchester', 'Greater Manchester', 'M1 2AB', 'UK'),
('Birmingham Medical Practice', '789 High Street', 'Small Heath', 'Birmingham', 'West Midlands', 'B5 6GH', 'UK');

INSERT INTO Doctors (ClinicID, FirstName, LastName, Specialization, Description)
VALUES
-- Clinic 1: Central London Clinic
(1, 'Alice', 'Brown', 'General Practice', 'Experienced GP serving Central London.'),
(1, 'John', 'Davis', 'Cardiology', 'Specialist in heart diseases with over 15 years experience.'),
-- Clinic 2: Manchester Health Centre
(2, 'Emily', 'Smith', 'Dermatology', 'Expert in skin conditions and cosmetic treatments.'),
(2, 'Michael', 'Johnson', 'Orthopedics', 'Orthopedic surgeon with 10 years experience.'),
-- Clinic 3: Birmingham Medical Practice
(3, 'Sophia', 'Williams', 'Pediatrics', 'Caring pediatrician dedicated to child health.'),
(3, 'Oliver', 'Jones', 'General Medicine', 'Friendly and thorough general practitioner.');


INSERT INTO Patients (ClinicID, FirstName, LastName, Email, PhoneNumber, NHSNumber, DateOfBirth, PostCode, Gender, EmergencyContactNumber, PasswordHash, BloodType, ProfileImage, ProfileImagePath)
VALUES
(1, 'Robert', 'King', 'robert.king@example.co.uk', '07123456789', 'NHS100001', '1980-03-15', 'NW1 6XE', 'Male', '07111222333', 'hashedpassword1', 'O+', NULL, 'images/robert.jpg'),
(2, 'Linda', 'Evans', 'linda.evans@example.co.uk', '07234567890', 'NHS100002', '1975-07-20', 'M1 2AB', 'Female', '07222333444', 'hashedpassword2', 'A-', NULL, 'images/linda.jpg'),
(3, 'James', 'Wilson', 'james.wilson@example.co.uk', '07345678901', 'NHS100003', '1990-11-05', 'B5 6GH', 'Male', '07333444555', 'hashedpassword3', 'B+', NULL, 'images/james.jpg'),
(1, 'Emma', 'Taylor', 'emma.taylor@example.co.uk', '07456789012', 'NHS100004', '1985-02-10', 'NW1 6XE', 'Female', '07444555666', 'hashedpassword4', 'AB+', NULL, 'images/emma.jpg');


--Allergies--
-- For Patient 1 (Robert King)
INSERT INTO Allergies (PatientID, AllergyName, Allergen, DateDiagnosed, Severity, Treatment, Notes)
VALUES 
(1, 'Penicillin Allergy', 'Penicillin', '2005-05-10', 'Severe', 'Avoid penicillin', 'Carries an allergy alert card.'),
(1, 'Peanut Allergy', 'Peanuts', '2010-09-15', 'Moderate', 'Antihistamines', 'Seasonal issues noted.'),
(1, 'Dust Allergy', 'Dust', '2012-03-20', 'Mild', 'No treatment', 'Mild irritation on exposure.'),
(1, 'Pollen Allergy', 'Pollen', '2018-04-01', 'Moderate', 'Antihistamines', 'Worse during spring.');

-- For Patient 2 (Linda Evans)
INSERT INTO Allergies (PatientID, AllergyName, Allergen, DateDiagnosed, Severity, Treatment, Notes)
VALUES 
(2, 'Latex Allergy', 'Latex', '2008-07-12', 'Severe', 'Avoid latex products', 'Allergic to latex gloves.'),
(2, 'Shellfish Allergy', 'Shellfish', '2011-11-25', 'Moderate', 'Avoid shellfish', 'Mild reactions observed.'),
(2, 'Gluten Intolerance', 'Gluten', '2015-06-10', 'Mild', 'Gluten-free diet', 'Digestive issues.'),
(2, 'Dust Mite Allergy', 'Dust mites', '2013-03-08', 'Moderate', 'Use air filters', 'Seasonal symptoms.');

-- For Patient 3 (James Wilson)
INSERT INTO Allergies (PatientID, AllergyName, Allergen, DateDiagnosed, Severity, Treatment, Notes)
VALUES 
(3, 'Cat Dander Allergy', 'Cat Dander', '2009-02-20', 'Mild', 'Air purifier', 'Mild symptoms.'),
(3, 'Pollen Allergy', 'Pollen', '2012-05-15', 'Moderate', 'Antihistamines', 'Worsens in summer.'),
(3, 'Mold Allergy', 'Mold', '2016-09-10', 'Moderate', 'Avoid damp areas', 'Managed with medication.'),
(3, 'Dust Allergy', 'Dust', '2018-11-05', 'Mild', 'No treatment', 'Minor irritation.');

-- For Patient 4 (Emma Taylor)
INSERT INTO Allergies (PatientID, AllergyName, Allergen, DateDiagnosed, Severity, Treatment, Notes)
VALUES 
(4, 'Peanut Allergy', 'Peanuts', '2007-03-22', 'Severe', 'EpiPen required', 'High risk of anaphylaxis.'),
(4, 'Soy Allergy', 'Soy', '2010-08-14', 'Mild', 'Avoid soy products', 'Minor reaction.'),
(4, 'Egg Allergy', 'Eggs', '2013-01-30', 'Moderate', 'Avoid eggs', 'Mild rash observed.'),
(4, 'Wheat Allergy', 'Wheat', '2019-04-18', 'Mild', 'Gluten-free diet', 'Digestive issues.');

--Immunizations--
-- For Patient 1 (Robert King)
INSERT INTO Immunizations (PatientID, VaccineName, DateAdministered, Dosage, AdministratorName, ClinicLocation)
VALUES 
(1, 'Influenza Vaccine', '2023-11-15', '0.5 ml', 'Dr. John Smith', 'Central London Clinic'),
(1, 'COVID-19 Vaccine', '2023-06-10', '0.3 ml', 'Dr. Alice Brown', 'Central London Clinic');

-- For Patient 2 (Linda Evans)
INSERT INTO Immunizations (PatientID, VaccineName, DateAdministered, Dosage, AdministratorName, ClinicLocation)
VALUES 
(2, 'Influenza Vaccine', '2023-11-15', '0.5 ml', 'Dr. Michael Johnson', 'Manchester Health Centre'),
(2, 'Hepatitis B Vaccine', '2022-04-20', '1.0 ml', 'Dr. Emily Smith', 'Manchester Health Centre');

-- For Patient 3 (James Wilson)
INSERT INTO Immunizations (PatientID, VaccineName, DateAdministered, Dosage, AdministratorName, ClinicLocation)
VALUES 
(3, 'Influenza Vaccine', '2023-11-15', '0.5 ml', 'Dr. Oliver Jones', 'Birmingham Medical Practice'),
(3, 'COVID-19 Vaccine', '2023-07-01', '0.3 ml', 'Dr. Oliver Jones', 'Birmingham Medical Practice');

-- For Patient 4 (Emma Taylor)
INSERT INTO Immunizations (PatientID, VaccineName, DateAdministered, Dosage, AdministratorName, ClinicLocation)
VALUES 
(4, 'Influenza Vaccine', '2023-11-15', '0.5 ml', 'Dr. John Davis', 'Central London Clinic'),
(4, 'HPV Vaccine', '2021-09-15', '0.5 ml', 'Dr. Alice Brown', 'Central London Clinic');


--ChronicConditions--
-- For Patient 1 (Robert King)
INSERT INTO ChronicConditions (PatientID, ConditionName, DateDiagnosed, Severity, Treatment, Notes)
VALUES 
(1, 'Hypertension', '2015-04-10', 'Moderate', 'Medication, diet', 'Regular monitoring required.'),
(1, 'Type 2 Diabetes', '2018-06-15', 'Severe', 'Insulin, diet, exercise', 'HbA1c monitored quarterly.'),
(1, 'Asthma', '2005-09-20', 'Mild', 'Inhalers', 'Managed with inhalers.'),
(1, 'GERD', '2019-10-12', 'Mild', 'Antacids, lifestyle changes', 'Avoid triggers.');

-- For Patient 2 (Linda Evans)
INSERT INTO ChronicConditions (PatientID, ConditionName, DateDiagnosed, Severity, Treatment, Notes)
VALUES 
(2, 'Hypothyroidism', '2010-05-18', 'Moderate', 'Levothyroxine', 'Monitored with TSH levels.'),
(2, 'Rheumatoid Arthritis', '2017-02-14', 'Severe', 'DMARDs, physiotherapy', 'Flare-ups observed.'),
(2, 'Chronic Kidney Disease', '2020-11-30', 'Moderate', 'Dialysis, diet', 'Regular checkups needed.'),
(2, 'Migraine', '2012-03-25', 'Mild', 'Pain relievers', 'Triggered by stress.');

-- For Patient 3 (James Wilson)
INSERT INTO ChronicConditions (PatientID, ConditionName, DateDiagnosed, Severity, Treatment, Notes)
VALUES 
(3, 'Hypertension', '2016-08-20', 'Moderate', 'Medication', 'Under control.'),
(3, 'Type 1 Diabetes', '2000-01-10', 'Severe', 'Insulin', 'Requires insulin therapy.'),
(3, 'Asthma', '2003-04-05', 'Mild', 'Inhalers', 'Seasonal exacerbations.'),
(3, 'GERD', '2018-07-12', 'Mild', 'Antacids', 'Managed with lifestyle changes.');

-- For Patient 4 (Emma Taylor)
INSERT INTO ChronicConditions (PatientID, ConditionName, DateDiagnosed, Severity, Treatment, Notes)
VALUES 
(4, 'Osteoporosis', '2015-03-15', 'Moderate', 'Calcium, Vitamin D', 'Bone density monitored.'),
(4, 'Hyperlipidemia', '2018-09-10', 'Mild', 'Statins, diet', 'Regular lipid profile checks.'),
(4, 'Asthma', '2007-02-20', 'Mild', 'Inhalers', 'Managed as needed.'),
(4, 'Migraine', '2012-11-30', 'Moderate', 'Pain relievers', 'Stress-triggered.');

--FamilyHistory--
-- For Patient 1 (Robert King)
INSERT INTO FamilyHistory (PatientID, FamilyMember, DateDiagnosed, Relation, Age, HealthConditions, Notes)
VALUES 
(1, 'John King', NULL, 'Father', '65', 'Hypertension, Diabetes', 'Managed with medication.'),
(1, 'Mary King', NULL, 'Mother', '63', 'Breast Cancer', 'Treated with surgery.'),
(1, 'Alice King', NULL, 'Sister', '40', 'Asthma', 'Mild condition.'),
(1, 'Robert Senior', NULL, 'Grandfather', '78', 'Heart Disease', 'Smoker.');

-- For Patient 2 (Linda Evans)
INSERT INTO FamilyHistory (PatientID, FamilyMember, DateDiagnosed, Relation, Age, HealthConditions, Notes)
VALUES 
(2, 'James Evans', NULL, 'Father', '70', 'Hypertension', 'Under treatment.'),
(2, 'Patricia Evans', NULL, 'Mother', '68', 'Diabetes', 'Managed with diet.'),
(2, 'Linda Evans Jr.', NULL, 'Sister', '45', 'None', 'Healthy.'),
(2, 'Mark Evans', NULL, 'Brother', '42', 'Asthma', 'Mild condition.');

-- For Patient 3 (James Wilson)
INSERT INTO FamilyHistory (PatientID, FamilyMember, DateDiagnosed, Relation, Age, HealthConditions, Notes)
VALUES 
(3, 'Thomas Wilson', NULL, 'Father', '72', 'Heart Disease', 'Passed away.'),
(3, 'Elizabeth Wilson', NULL, 'Mother', '70', 'Arthritis', 'Uses pain medication.'),
(3, 'Sarah Wilson', NULL, 'Sister', '38', 'None', 'Healthy.'),
(3, 'Robert Wilson', NULL, 'Brother', '35', 'Hypertension', 'Under observation.');

-- For Patient 4 (Emma Taylor)
INSERT INTO FamilyHistory (PatientID, FamilyMember, DateDiagnosed, Relation, Age, HealthConditions, Notes)
VALUES 
(4, 'Peter Taylor', NULL, 'Father', '68', 'Diabetes', 'Managed with medication.'),
(4, 'Susan Taylor', NULL, 'Mother', '65', 'Hypertension', 'Regular checkups.'),
(4, 'Emma Taylor Jr.', NULL, 'Sister', '42', 'None', 'Healthy.'),
(4, 'John Taylor', NULL, 'Brother', '39', 'Asthma', 'Mild condition.');

