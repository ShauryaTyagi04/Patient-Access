USE PatientAccess;


CREATE TABLE BookedAppointments (
    AppointmentID INT IDENTITY(1,1) PRIMARY KEY,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,  -- a one-hour slot (e.g. 09:00, 10:00, etc.)
    DoctorID INT NOT NULL,
    ClinicID INT NOT NULL,
    PatientID INT NOT NULL,
    CONSTRAINT FK_Booked_Doctors FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID),
    CONSTRAINT FK_Booked_Clinics FOREIGN KEY (ClinicID)
        REFERENCES Clinics(ClinicID),
    CONSTRAINT FK_Booked_Patients FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID)
);

CREATE TABLE AvailableBookings (
    AvailableBookingID INT IDENTITY(1,1) PRIMARY KEY,
    BookingDate DATE NOT NULL,
    BookingTime TIME NOT NULL,  -- a one-hour slot
    DoctorID INT NOT NULL,
	ClinicID INT NOT NULL,
    CONSTRAINT FK_Available_Doctors FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID),
		CONSTRAINT FK_Available_Clinics FOREIGN KEY (ClinicID)
        REFERENCES Clinics(ClinicID)
);


--Procedure populate the available bookings table--
GO
CREATE PROCEDURE FillAvailableBookings
AS
BEGIN
    -- Define the period for available bookings: from 3 weeks from now to 6 weeks from now.
    DECLARE @StartDate DATE = DATEADD(WEEK, 3, CAST(GETDATE() AS DATE));
    DECLARE @EndDate DATE = DATEADD(WEEK, 6, CAST(GETDATE() AS DATE));
    DECLARE @CurrentDate DATE = @StartDate;

    -- Clear any slots scheduled before the new start date.
    DELETE FROM AvailableBookings WHERE BookingDate < @StartDate;

    WHILE @CurrentDate <= @EndDate
    BEGIN
        -- Skip weekends (assuming DATEFIRST is set so Sunday = 1 and Saturday = 7)
        IF DATEPART(WEEKDAY, @CurrentDate) NOT IN (1, 7)
        BEGIN
            DECLARE @ClinicID INT;
            DECLARE clinic_cursor CURSOR FOR
                SELECT ClinicID FROM Clinics;

            OPEN clinic_cursor;
            FETCH NEXT FROM clinic_cursor INTO @ClinicID;
            
            WHILE @@FETCH_STATUS = 0
            BEGIN
                INSERT INTO AvailableBookings (BookingDate, BookingTime, DoctorID, ClinicID)
                SELECT 
                    @CurrentDate, 
                    TimeSlot, 
                    d.DoctorID,
                    @ClinicID
                FROM 
                (
                    VALUES
                        (CAST('09:00:00' AS TIME)),
                        (CAST('10:00:00' AS TIME)),
                        (CAST('11:00:00' AS TIME)),
                        (CAST('12:00:00' AS TIME)),
                        (CAST('13:00:00' AS TIME)),
                        (CAST('14:00:00' AS TIME)),
                        (CAST('15:00:00' AS TIME)),
                        (CAST('16:00:00' AS TIME))
                ) AS T(TimeSlot)
                CROSS JOIN Doctors d
                WHERE d.ClinicID = @ClinicID;

                FETCH NEXT FROM clinic_cursor INTO @ClinicID;
            END

            CLOSE clinic_cursor;
            DEALLOCATE clinic_cursor;
        END

        SET @CurrentDate = DATEADD(DAY, 1, @CurrentDate);
    END
END
GO

--Procedure to clean the available bookings table--
GO
CREATE PROCEDURE DeleteBookingsWithinThreeWeeks
AS
BEGIN
    DECLARE @Threshold DATE = DATEADD(WEEK, 3, CAST(GETDATE() AS DATE));

    DELETE FROM AvailableBookings
    WHERE BookingDate < @Threshold;
END
GO

--Procedure to clean the booked appointments table--
GO
CREATE PROCEDURE CleanExpiredAppointments
AS
BEGIN
    DELETE FROM BookedAppointments
    WHERE AppointmentDate < CAST(GETDATE() AS DATE) 
       OR (AppointmentDate = CAST(GETDATE() AS DATE) AND AppointmentTime < CAST(GETDATE() AS TIME));
END
GO



--Trigger to update the booked appointments table--
CREATE TRIGGER trg_RemoveAvailableSlot
ON BookedAppointments
AFTER INSERT
AS
BEGIN
    DELETE ab
    FROM AvailableBookings ab
    INNER JOIN inserted i
        ON ab.BookingDate = i.AppointmentDate
       AND ab.BookingTime = i.AppointmentTime
       AND ab.DoctorID = i.DoctorID;
END

--Trigger to update the available bookings table--
CREATE TRIGGER trg_RemoveBookedAppointment
ON AvailableBookings
AFTER INSERT
AS
BEGIN
    DELETE ba
    FROM BookedAppointments ba
    INNER JOIN inserted i
        ON ba.AppointmentDate = i.BookingDate
       AND ba.AppointmentTime = i.BookingTime
       AND ba.DoctorID = i.DoctorID;
END;


EXEC FillAvailableBookings; --Carefull!!!!, Delete the exisitng bookings before running--
EXEC DeleteBookingsWithinThreeWeeks; --Carefull!!!!--
EXEC CleanExpiredAppointments; --Carefull!!!!--
