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
- **Database :** PostgreSQL
- **Tool :** PgAdmin4

## Database Schema 
### Overview of the Schema :
The Schema consists of 4 interconnected tables that provide insights into the **"Student Performance & Attendance System"**.

The Project involves multiple tables :
- Students
- Subjects
- Attendance
- Marks

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
## ER Diagram 
![Er diagram](https://github.com/KumarBoste/Student_Performance_and_Attendance_System/blob/main/ER%20Diagram/ER%20Diagram.png)

## Analysis 1 - Basic Queries
```sql
-- ============================================================
-- BASIC QUERIES
-- ============================================================

-- 1. List all students
SELECT * FROM students;
-- Question: Show all details of students in the database.
-- Insight: Displays all student details — used for verification and roster generation.

-- 2. Show all subjects and teachers
SELECT subject_name, teacher_name FROM subjects;
-- Question: Which subjects are taught, and who teaches them?
-- Insight: Displays all student details — used for verification and roster generation.

-- 3. Display student attendance details
SELECT s.student_name, sub.subject_name, a.attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
JOIN subjects sub ON a.subject_id = sub.subject_id;
-- Question: Show each student’s attendance percentage per subject
-- Insight: Gives attendance data for each student per subject. 

-- 4. Find students in class ‘10A’z
SELECT student_name FROM students WHERE class = '10A';
-- Question: List the names of all students belonging to class 10A.
-- Insight: Helps teachers or class monitors view class-wise lists.

-- 5. Show all students who scored more than 80 marks
SELECT s.student_name, sub.subject_name, m.marks_obtained
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN subjects sub ON m.subject_id = sub.subject_id
WHERE m.marks_obtained > 80;
-- Question: Which students scored above 80 in any subject?
-- Insight: Identifies top performers in each subject.
```

## Analysis 2 - Advance Queries
```sql
-- ============================================================
-- ADVANCED QUERIES
-- ============================================================

-- 6. Average marks of each subject
SELECT sub.subject_name, ROUND(AVG(m.marks_obtained),2) AS avg_marks
FROM marks m
JOIN subjects sub ON m.subject_id = sub.subject_id
GROUP BY sub.subject_name;
-- Question: Which subject has the highest average marks?
-- Insight: Helps evaluate subject difficulty and teaching effectiveness.


-- 7. Correlation between attendance and performance
SELECT s.student_name, a.attendance_percentage, m.marks_obtained
FROM attendance a
JOIN marks m ON a.student_id = m.student_id AND a.subject_id = m.subject_id
JOIN students s ON s.student_id = a.student_id
ORDER BY a.attendance_percentage DESC;
-- Question: Is there a link between attendance percentage and marks obtained?
-- Insight: Observe if students with higher attendance generally have higher marks.

-- 8. Identify students with attendance below 70%
SELECT s.student_name, a.attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
WHERE a.attendance_percentage < 70;
-- Question: Which students have poor attendance (less than 70%)?
-- Insight: Helps mark students at risk of poor performance due to absenteeism.

-- 9. Rank students by total marks
SELECT s.student_name, SUM(m.marks_obtained) AS total_marks,
       RANK() OVER (ORDER BY SUM(m.marks_obtained) DESC) AS rank
FROM marks m
JOIN students s ON m.student_id = s.student_id
GROUP BY s.student_name;
-- Question: Rank students based on their overall total marks.
-- Insight: Gives leaderboard-style ranking — useful for merit lists.

-- 10. Average attendance per class
SELECT s.class, ROUND(AVG(a.attendance_percentage),2) AS avg_attendance
FROM attendance a
JOIN students s ON a.student_id = s.student_id
GROUP BY s.class;
-- Question: Which class maintains better average attendance overall?
-- Insight: Determines which class maintains better attendance discipline.
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
