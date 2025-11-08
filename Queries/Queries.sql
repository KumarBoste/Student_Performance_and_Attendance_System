-- ============================================================
-- BASIC QUERIES
-- ============================================================

-- 1. List all students
SELECT * FROM students;
-- Insight: Displays all student details — used for verification and roster generation.

-- 2. Show all subjects and teachers
SELECT subject_name, teacher_name FROM subjects;
-- Insight: Displays all student details — used for verification and roster generation.

-- 3. Display student attendance details
SELECT s.student_name, sub.subject_name, a.attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
JOIN subjects sub ON a.subject_id = sub.subject_id;
-- Insight: Gives attendance data for each student per subject. 

-- 4. Find students in class ‘10A’z
SELECT student_name FROM students WHERE class = '10A';
-- Insight: Helps teachers or class monitors view class-wise lists.

-- 5. Show all students who scored more than 80 marks
SELECT s.student_name, sub.subject_name, m.marks_obtained
FROM marks m
JOIN students s ON m.student_id = s.student_id
JOIN subjects sub ON m.subject_id = sub.subject_id
WHERE m.marks_obtained > 80;
-- Insight: Identifies top performers in each subject.

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
-- Insight: Observe if students with higher attendance generally have higher marks.

-- 8. Identify students with attendance below 70%
SELECT s.student_name, a.attendance_percentage
FROM attendance a
JOIN students s ON a.student_id = s.student_id
WHERE a.attendance_percentage < 70;
-- Insight: Helps mark students at risk of poor performance due to absenteeism.

-- 9. Rank students by total marks
SELECT s.student_name, SUM(m.marks_obtained) AS total_marks,
       RANK() OVER (ORDER BY SUM(m.marks_obtained) DESC) AS rank
FROM marks m
JOIN students s ON m.student_id = s.student_id
GROUP BY s.student_name;
-- Insight: Gives leaderboard-style ranking — useful for merit lists.

-- 10. Average attendance per class
SELECT s.class, ROUND(AVG(a.attendance_percentage),2) AS avg_attendance
FROM attendance a
JOIN students s ON a.student_id = s.student_id
GROUP BY s.class;
-- Insight: Determines which class maintains better attendance discipline.
