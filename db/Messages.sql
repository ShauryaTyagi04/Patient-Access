--Executed--
CREATE TABLE Messages (
    MessageID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    ClinicID INT NOT NULL,
    SenderRole NVARCHAR(20) CHECK (SenderRole IN ('Patient', 'Clinic')) NOT NULL,
    MessageText NVARCHAR(MAX) NOT NULL,
    SentAt DATETIME DEFAULT GETDATE(),
    IsRead BIT DEFAULT 0,
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (ClinicID) REFERENCES Clinics(ClinicID)
);

