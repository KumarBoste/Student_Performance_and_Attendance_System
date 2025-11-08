# Student Performance & Attendance System 
**Using PostgreSQL**


![LOGO](https://github.com/KumarBoste/Student_Performance_and_Attendance_System-/blob/main/LOGO.png)

## Project Overview
The Student Performance & Attendance System is designed to track students’ academic results and attendance details to evaluate their overall performance. This system helps educational institutions analyze how attendance impacts academic outcomes and identify students who need support.

## Problem Statement
Educational institutions often face challenges in evaluating the link between student attendance and academic performance. Manual tracking makes it difficult to:
- Identify students with low attendance or grades.
- Analyze subject-wise performance trends.
- Support teachers with actionable insights.
This system aims to solve these issues by maintaining a structured database in PostgreSQL that connects students, subjects, attendance, and marks.

## DataBase & Tools:
- PostgreSQL
- PgAdmin4
- 
## Database Schema 

``` sql
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
```
## SWOT Analysis
| Factor | Description |
|--------|-------------|
|Strengths|Efficient tracking of attendance and performance, easily scalable, supports detailed insights.|
|Weaknesses|Depends on data accuracy; manual data entry can introduce errors.|
|Opportunities|Integration with dashboards, machine learning for predicting performance trends.|
|Threats|Data privacy and security if student data is mishandled.|

## Conclusion
The Student Performance & Attendance System effectively demonstrates how data-driven insights can enhance educational decision-making.
By integrating attendance and academic performance, teachers can identify patterns, intervene early, and improve outcomes. PostgreSQL’s relational capabilities make it ideal for such structured educational data management.
