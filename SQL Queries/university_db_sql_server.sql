-- Create Database
IF DB_ID('university_db') IS NULL
    CREATE DATABASE university_db;
GO

USE university_db;
GO

-- Enrollment Table
CREATE TABLE enrollment_records (
  student_id VARCHAR(20) PRIMARY KEY, -- natural PK
  enrollment_id VARCHAR(20) NOT NULL UNIQUE,
  enrollment_year INT,
  enrollment_status VARCHAR(16),
  admission_type VARCHAR(20),
  program VARCHAR(120),
  faculty VARCHAR(120)
);

-- Courses Table
CREATE TABLE courses (
  course_code CHAR(8) PRIMARY KEY,
  course_name VARCHAR(120) NOT NULL,
  program VARCHAR(120),
  level VARCHAR(6),
  semester INT
);

-- Student Details Table
CREATE TABLE student_details (
  student_id VARCHAR(20) PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  surname VARCHAR(120) NOT NULL,
  dob DATE NOT NULL,
  gender VARCHAR(6) NOT NULL,
  marital_status VARCHAR(10) NOT NULL,
  address VARCHAR(120) NOT NULL,
  next_of_kin VARCHAR(180) NOT NULL,
  email VARCHAR(120) UNIQUE NOT NULL,
  phone_number VARCHAR(32) NOT NULL,
  CONSTRAINT FK_Student_Enrollment FOREIGN KEY (student_id) REFERENCES enrollment_records(student_id)
);

-- Records Table
CREATE TABLE records (
  student_id VARCHAR(20) NOT NULL,
  course_code CHAR(8) NOT NULL,
  year_enrolled INT NOT NULL,
  semester INT NOT NULL,
  course_gpa DECIMAL(4,2),
  course_credits DECIMAL(5,2),
  year_of_study INT,
  academic_year INT,
  recarried BIT,
  status VARCHAR(15),
  graduation VARCHAR(20),
  degree_class VARCHAR(20),
  CONSTRAINT PK_Records PRIMARY KEY (student_id, course_code, year_enrolled, semester),
  CONSTRAINT FK_Record_Student FOREIGN KEY (student_id) REFERENCES enrollment_records(student_id),
  CONSTRAINT FK_Record_Course FOREIGN KEY (course_code) REFERENCES courses(course_code)
);

-- Academic Records Table
CREATE TABLE academic_records (
  student_id VARCHAR(20) NOT NULL,
  course_code CHAR(8) NOT NULL,
  enrollment_year INT NOT NULL,
  year_of_study INT NOT NULL,
  semester INT NOT NULL,
  program VARCHAR(120),
  duration INT,
  gpa DECIMAL(4,2),
  credits_earned INT,
  status VARCHAR(15),
  graduation_year INT,
  course_gpa DECIMAL(4,2),
  course_credits DECIMAL(5,2),
  degree_class VARCHAR(20),
  recarried BIT,
  CONSTRAINT PK_AcademicRecords PRIMARY KEY (student_id, course_code, year_of_study, semester),
  CONSTRAINT FK_AcademicRecord_Student FOREIGN KEY (student_id) REFERENCES enrollment_records(student_id),
  CONSTRAINT FK_AcademicRecord_Course FOREIGN KEY (course_code) REFERENCES courses(course_code)
);

-- Attendance and Engagement Table
CREATE TABLE attendance (
   student_id VARCHAR(20) NOT NULL,
   course_code CHAR(8) NOT NULL,
   year_of_study INT NOT NULL,
   semester INT NOT NULL,
   physical_attendance_expected INT,
   attendance INT,
   attendance_percentage DECIMAL(5, 2),
   inclass DECIMAL(5, 2),
   presentations DECIMAL(5, 2),
   assignments DECIMAL(5, 2),
   lms_logins DECIMAL(5, 2),
   engagement_score DECIMAL(5, 2),
   participation_score DECIMAL(5, 2),
   CONSTRAINT PK_Attendance PRIMARY KEY (student_id, course_code, year_of_study, semester),
   CONSTRAINT FK_Attendance_Student FOREIGN KEY (student_id) REFERENCES enrollment_records(student_id),
   CONSTRAINT FK_Attendance_Course FOREIGN KEY (course_code) REFERENCES courses(course_code)
);
