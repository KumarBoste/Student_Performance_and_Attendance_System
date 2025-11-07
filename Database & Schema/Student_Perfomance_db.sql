-- Create database
CREATE DATABASE student_performance_system;

-- Connect to database
\c student_performance_system;

-- Create tables
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    date_of_birth DATE,
    gender CHAR(1),
    enrollment_date DATE DEFAULT CURRENT_DATE,
    address TEXT
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER DEFAULT 3,
    department VARCHAR(50)
);

CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    attendance_date DATE NOT NULL,
    status VARCHAR(10) CHECK (status IN ('Present', 'Absent', 'Late')),
    remarks TEXT
);

CREATE TABLE performance (
    performance_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    semester VARCHAR(20),
    assignment_score DECIMAL(5,2),
    midterm_score DECIMAL(5,2),
    final_score DECIMAL(5,2),
    total_score DECIMAL(5,2) GENERATED ALWAYS AS (
        COALESCE(assignment_score, 0) * 0.3 + 
        COALESCE(midterm_score, 0) * 0.3 + 
        COALESCE(final_score, 0) * 0.4
    ) STORED,
    grade CHAR(2)
);

CREATE TABLE student_courses (
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    enrollment_date DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (student_id, course_id)
);
