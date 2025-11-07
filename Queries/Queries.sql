-- 5 Basic Queries
-- Query 1: Student Basic Information
-- Question: "Show me all students with their basic details"
sql
SELECT student_id, first_name, last_name, email, 
       EXTRACT(YEAR FROM AGE(date_of_birth)) as age,
       gender
FROM students;
-- Insight: Provides a complete student roster with demographic information for administrative purposes and communication.

-- Query 2: Course Enrollment Count
-- Question: "How many students are enrolled in each course?"
sql
SELECT c.course_code, c.course_name, COUNT(sc.student_id) as enrolled_students
FROM courses c
LEFT JOIN student_courses sc ON c.course_id = sc.course_id
GROUP BY c.course_id, c.course_code, c.course_name
ORDER BY enrolled_students DESC;
--Insight: Helps identify popular courses and optimize resource allocation for different subjects.

-- Query 3: Student Performance Overview
-- Question: "What are the grades of all students in each course?"
sql
SELECT s.first_name, s.last_name, c.course_name, p.total_score, p.grade
FROM performance p
JOIN students s ON p.student_id = s.student_id
JOIN courses c ON p.course_id = c.course_id
ORDER BY p.total_score DESC;
-- Insight: Gives a quick overview of academic performance across all students and courses.

-- Query 4: Attendance Summary
-- Question: "What is the attendance status count for each student?"
sql
SELECT s.first_name, s.last_name, 
       COUNT(*) as total_classes,
       COUNT(CASE WHEN a.status = 'Present' THEN 1 END) as present_count,
       COUNT(CASE WHEN a.status = 'Absent' THEN 1 END) as absent_count,
       ROUND(COUNT(CASE WHEN a.status = 'Present' THEN 1 END) * 100.0 / COUNT(*), 2) as attendance_percentage
FROM students s
JOIN attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.first_name, s.last_name;
-- Insight: Calculates attendance percentages to identify students with poor attendance records.

-- Query 5: Top Performing Students
-- Question: "Who are the top 3 students based on average scores?"
sql
SELECT s.first_name, s.last_name,
       ROUND(AVG(p.total_score), 2) as average_score,
       COUNT(p.performance_id) as courses_taken
FROM students s
JOIN performance p ON s.student_id = p.student_id
GROUP BY s.student_id, s.first_name, s.last_name
ORDER BY average_score DESC
LIMIT 3;
-- Insight: Identifies high-achieving students for recognition and potential leadership roles.

-- 5 Advanced Queries
-- Query 6: Attendance Impact on Performance
-- Question: "Is there a correlation between attendance percentage and academic performance?"
sql
WITH attendance_summary AS (
    SELECT s.student_id,
           ROUND(COUNT(CASE WHEN a.status IN ('Present', 'Late') THEN 1 END) * 100.0 / COUNT(*), 2) as attendance_rate
    FROM students s
    JOIN attendance a ON s.student_id = a.student_id
    GROUP BY s.student_id
),
performance_summary AS (
    SELECT student_id, ROUND(AVG(total_score), 2) as average_score
    FROM performance
    GROUP BY student_id
)
SELECT s.first_name, s.last_name,
       a.attendance_rate,
       p.average_score,
       CASE 
           WHEN a.attendance_rate >= 90 AND p.average_score >= 85 THEN 'High Attendance, High Performance'
           WHEN a.attendance_rate < 75 AND p.average_score < 70 THEN 'Low Attendance, Low Performance'
           ELSE 'Mixed Pattern'
       END as performance_category
FROM students s
JOIN attendance_summary a ON s.student_id = a.student_id
JOIN performance_summary p ON s.student_id = p.student_id
ORDER BY a.attendance_rate DESC, p.average_score DESC;
-- Insight: Reveals the relationship between attendance and performance, helping identify students who need intervention.

-- Query 7: Student At-Risk Identification
-- Question: "Which students are at risk based on poor attendance and low grades?"
sql
WITH risk_indicators AS (
    SELECT s.student_id,
           s.first_name,
           s.last_name,
           COUNT(DISTINCT p.course_id) as courses_with_grades,
           AVG(p.total_score) as avg_score,
           COUNT(CASE WHEN p.grade IN ('D', 'F') THEN 1 END) as failing_courses,
           (SELECT COUNT(CASE WHEN status = 'Absent' THEN 1 END) * 100.0 / COUNT(*)
            FROM attendance att 
            WHERE att.student_id = s.student_id) as absence_rate
    FROM students s
    LEFT JOIN performance p ON s.student_id = p.student_id
    GROUP BY s.student_id, s.first_name, s.last_name
)
SELECT student_id, first_name, last_name, avg_score, absence_rate,
       CASE 
           WHEN avg_score < 70 OR absence_rate > 30 OR failing_courses > 0 THEN 'High Risk'
           WHEN avg_score BETWEEN 70 AND 75 OR absence_rate BETWEEN 20 AND 30 THEN 'Medium Risk'
           ELSE 'Low Risk'
       END as risk_level
FROM risk_indicators
WHERE avg_score < 75 OR absence_rate > 20
ORDER BY risk_level, avg_score ASC;
-- Insight: Proactively identifies students needing academic support and intervention.

-- Query 8: Department-wise Performance Analysis
-- Question: "How do different departments perform in terms of student grades?"
sql
SELECT 
    c.department,
    COUNT(p.performance_id) as total_grades,
    ROUND(AVG(p.total_score), 2) as department_avg_score,
    COUNT(CASE WHEN p.grade = 'A' THEN 1 END) as A_grades,
    COUNT(CASE WHEN p.grade IN ('D', 'F') THEN 1 END) as failing_grades,
    ROUND(COUNT(CASE WHEN p.grade = 'A' THEN 1 END) * 100.0 / COUNT(p.performance_id), 2) as A_percentage
FROM performance p
JOIN courses c ON p.course_id = c.course_id
GROUP BY c.department
ORDER BY department_avg_score DESC;
-- Insight: Helps identify departments with teaching excellence or those needing curriculum improvement.

-- Query 9: Progressive Performance Tracking
-- Question: "How do student scores progress through different evaluation components?"
sql
SELECT 
    s.first_name || ' ' || s.last_name as student_name,
    c.course_name,
    p.assignment_score,
    p.midterm_score,
    p.final_score,
    p.total_score,
    CASE 
        WHEN p.final_score > p.midterm_score AND p.midterm_score > p.assignment_score THEN 'Improving'
        WHEN p.final_score < p.midterm_score AND p.midterm_score < p.assignment_score THEN 'Declining'
        ELSE 'Fluctuating'
    END as performance_trend,
    p.final_score - p.assignment_score as improvement_from_assignments
FROM performance p
JOIN students s ON p.student_id = s.student_id
JOIN courses c ON p.course_id = c.course_id
ORDER BY improvement_from_assignments DESC;
-- Insight: Tracks student performance trends throughout the semester to identify learning patterns.

-- Query 10: Comprehensive Student Analytics
-- Question: "Provide a complete analytics dashboard for student performance and attendance"
sql
WITH student_stats AS (
    SELECT 
        s.student_id,
        s.first_name,
        s.last_name,
        COUNT(DISTINCT sc.course_id) as total_courses,
        COUNT(DISTINCT p.course_id) as graded_courses,
        ROUND(AVG(p.total_score), 2) as avg_score,
        MAX(p.total_score) as best_score,
        MIN(p.total_score) as worst_score
    FROM students s
    LEFT JOIN student_courses sc ON s.student_id = sc.student_id
    LEFT JOIN performance p ON s.student_id = p.student_id
    GROUP BY s.student_id, s.first_name, s.last_name
),
attendance_stats AS (
    SELECT 
        student_id,
        COUNT(*) as total_attendance_records,
        ROUND(COUNT(CASE WHEN status = 'Present' THEN 1 END) * 100.0 / COUNT(*), 2) as attendance_percentage,
        COUNT(CASE WHEN status = 'Absent' THEN 1 END) as total_absences
    FROM attendance
    GROUP BY student_id
)
SELECT 
    ss.first_name,
    ss.last_name,
    ss.total_courses,
    ss.graded_courses,
    ss.avg_score,
    ss.best_score,
    ss.worst_score,
    COALESCE(as.attendance_percentage, 0) as attendance_percentage,
    COALESCE(as.total_absences, 0) as total_absences,
    CASE 
        WHEN ss.avg_score >= 85 AND COALESCE(as.attendance_percentage, 0) >= 90 THEN 'Excellent'
        WHEN ss.avg_score < 70 OR COALESCE(as.attendance_percentage, 0) < 75 THEN 'Needs Improvement'
        ELSE 'Satisfactory'
    END as overall_status
FROM student_stats ss
LEFT JOIN attendance_stats as ON ss.student_id = as.student_id
ORDER BY ss.avg_score DESC NULLS LAST;
-- Insight: Provides a comprehensive view of each student's academic journey for personalized counseling and support.
