IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'SGART_DB')
BEGIN
    CREATE DATABASE [SGART_DB];
END;

GO
USE [SGART_DB]
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SGART_UsersTable')
BEGIN
Create Table SGART_UsersTable(
    [user_id] uniqueidentifier Primary Key default NEWID(),
    [user_name] nvarchar(50) NOT NULL,
    user_lastName nvarchar(100) NOT NULL,
    user_department nvarchar(100),
    user_center nvarchar(100) NOT NULL,
    user_hiringDate date NOT NULL,
    user_profile nvarchar(255),
    user_email nvarchar(100) UNIQUE NOT NULL,
    user_password nvarchar(255) NOT NULL,
    user_blockedStatus bit NOT NULL default 0, -- 0 Not blocked / 1 Is Blocked,
    user_twoFactorAuthCode char(40) NOT NULL,
    user_validatedStatus bit NOT NULL default 0 -- 0 Not validated / 1 Is validated
);
END

GO
USE [SGART_DB]
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SGART_AdminsTable')
BEGIN
Create Table SGART_AdminsTable(
    admin_id uniqueidentifier Primary Key default NEWID(),
    admin_name nvarchar(50) NOT NULL,
    admin_lastName nvarchar(100) NOT NULL,
    admin_email nvarchar(100) UNIQUE NOT NULL,
    admin_password nvarchar(255) NOT NULL,
    admin_center nvarchar(100) NOT NULL
);
END

GO
USE [SGART_DB]
GO
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SGART_WorkingHours')
BEGIN
CREATE TABLE SGART_WorkingHours (
    id INT IDENTITY(1,1) PRIMARY KEY, 
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);
END

USE [SGART_DB]
GO

-- Tabla de Reuniones
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SGART_MeetingsTable')
BEGIN
    CREATE TABLE SGART_MeetingsTable (
        meeting_id uniqueidentifier PRIMARY KEY DEFAULT NEWID(),
        meeting_title nvarchar(255) NOT NULL,
        meeting_all_day bit NOT NULL DEFAULT 0,
        meeting_start_time time NOT NULL,
        meeting_end_time time NOT NULL,
        organizer_id uniqueidentifier NOT NULL,
        FOREIGN KEY (organizer_id) REFERENCES SGART_UsersTable(user_id) ON DELETE CASCADE
    );
END
GO

-- Tabla de Invitaciones
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SGART_InvitationsTable')
BEGIN
    CREATE TABLE SGART_InvitationsTable (
        invitation_id INT IDENTITY(1,1) PRIMARY KEY,
        meeting_id uniqueidentifier NOT NULL,
        user_id uniqueidentifier NOT NULL,
        invitation_status nvarchar(50) NOT NULL CHECK (invitation_status IN ('Aceptada', 'Pendiente', 'Rechazada')),
        user_attendance bit NOT NULL DEFAULT 0,
        rejection_reason nvarchar(255),
        FOREIGN KEY (meeting_id) REFERENCES SGART_MeetingsTable(meeting_id) ON DELETE NO ACTION,
        FOREIGN KEY (user_id) REFERENCES SGART_UsersTable(user_id) ON DELETE NO ACTION
    );
END
GO

-- Tabla de Ausencias
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SGART_AbsencesTable')
BEGIN
    CREATE TABLE SGART_AbsencesTable (
        absence_id uniqueidentifier PRIMARY KEY DEFAULT NEWID(),
        user_id uniqueidentifier NOT NULL,
        absence_start_date date NOT NULL,
        absence_end_date date NOT NULL,
        absence_all_day bit NOT NULL DEFAULT 0,
        absence_start_time time,
        absence_end_time time,
        absence_reason nvarchar(255),
        FOREIGN KEY (user_id) REFERENCES SGART_UsersTable(user_id) ON DELETE CASCADE
    );
END
GO

-- Tabla de Localizaciones
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'SGART_LocationsTable')
BEGIN
    CREATE TABLE SGART_LocationsTable (
        location_id uniqueidentifier PRIMARY KEY DEFAULT NEWID(),
        location_name nvarchar(255) NOT NULL
    );
END
GO
