-- ============================================================
-- PROJECT: Student Performance & Attendance System
-- DATABASE: PostgreSQL
-- ============================================================

--  CREATE DATABASE
CREATE DATABASE student_performance_db;

-- Connect to the database
\c student_performance_db;

-- ============================================================
--  CREATE TABLES
-- ============================================================

-- Students Table
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(50),
    class VARCHAR(20),
    gender VARCHAR(10)
);

-- Subjects Table
CREATE TABLE subjects (
    subject_id SERIAL PRIMARY KEY,
    subject_name VARCHAR(50),
    teacher_name VARCHAR(50)
);

-- Attendance Table
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    subject_id INT REFERENCES subjects(subject_id) ON DELETE CASCADE,
    attendance_percentage DECIMAL(5,2)
);

-- Marks Table
CREATE TABLE marks (
    mark_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id) ON DELETE CASCADE,
    subject_id INT REFERENCES subjects(subject_id) ON DELETE CASCADE,
    marks_obtained INT CHECK (marks_obtained BETWEEN 0 AND 100)
);

-- ============================================================
--  INSERT DATA
-- ============================================================

-- Students
INSERT INTO students (student_name, class, gender) VALUES
('Amit Sharma', '10A', 'Male'),
('Priya Singh', '10A', 'Female'),
('Rahul Verma', '10B', 'Male'),
('Sneha Patel', '10B', 'Female'),
('Vikram Joshi', '10A', 'Male'),
('Neha Gupta', '10B', 'Female'),
('Ravi Kumar', '10C', 'Male'),
('Pooja Mehta', '10C', 'Female'),
('Karan Yadav', '10A', 'Male'),
('Anjali Das', '10B', 'Female');

-- Subjects
INSERT INTO subjects (subject_name, teacher_name) VALUES
('Mathematics', 'Mr. Rao'),
('Science', 'Mrs. Iyer'),
('English', 'Mr. Sinha'),
('Social Studies', 'Ms. Thomas');

-- Attendance
INSERT INTO attendance (student_id, subject_id, attendance_percentage) VALUES
(1, 1, 92.5),
(2, 1, 88.0),
(3, 2, 75.0),
(4, 2, 95.0),
(5, 3, 80.0),
(6, 3, 85.5),
(7, 4, 60.0),
(8, 4, 70.0),
(9, 1, 50.0),
(10, 2, 96.0);

-- Marks
INSERT INTO marks (student_id, subject_id, marks_obtained) VALUES
(1, 1, 88),
(2, 1, 90),
(3, 2, 65),
(4, 2, 92),
(5, 3, 75),
(6, 3, 80),
(7, 4, 55),
(8, 4, 60),
(9, 1, 40),
(10, 2, 95);

-- ============================================================
-- BASIC QUERIES
-- ============================================================

-- 1. List all students
SELECT * FROM students;

-- 2. Show all subjects and teachers
SELECT subject_name, teacher_name FROM subjects;

-- 3. Display student attendance details
SELECT s.student_name, sub.subject_name, a.attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
JOIN subjects sub ON a.subject_id = sub.subject_id;

-- 4. Find students in class ‘10A’z
SELECT student_name FROM students WHERE class = '10A';

-- 5. Show all students who scored more than 80 marks
SELECT s.student_name, sub.subject_name, m.marks_obtained
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN subjects sub ON m.subject_id = sub.subject_id
WHERE m.marks_obtained > 80;

-- ============================================================
-- ADVANCED QUERIES
-- ============================================================

-- 6. Average marks of each subject
SELECT sub.subject_name, ROUND(AVG(m.marks_obtained),2) AS avg_marks
FROM marks m
JOIN subjects sub ON m.subject_id = sub.subject_id
GROUP BY sub.subject_name;

-- 7. Correlation between attendance and performance
SELECT s.student_name, a.attendance_percentage, m.marks_obtained
FROM attendance a
JOIN marks m ON a.student_id = m.student_id AND a.subject_id = m.subject_id
JOIN students s ON s.student_id = a.student_id
ORDER BY a.attendance_percentage DESC;

-- 8. Identify students with attendance below 70%
SELECT s.student_name, a.attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
WHERE a.attendance_percentage < 70;

-- 9. Rank students by total marks
SELECT s.student_name, SUM(m.marks_obtained) AS total_marks,
       RANK() OVER (ORDER BY SUM(m.marks_obtained) DESC) AS rank
FROM marks m
JOIN students s ON m.student_id = s.student_id
GROUP BY s.student_name;

-- 10. Average attendance per class
SELECT s.class, ROUND(AVG(a.attendance_percentage),2) AS avg_attendance
FROM attendance a
JOIN students s ON a.student_id = s.student_id
GROUP BY s.class;

-- ============================================================
-- END 
-- ============================================================

