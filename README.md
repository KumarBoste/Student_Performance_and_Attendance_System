# Student Performance & Attendance System 
**Using PostgreSQL**


![LOGO](https://github.com/KumarBoste/Student_Performance_and_Attendance_System-/blob/main/LOGO.png)

## Project Overview
The Student Performance & Attendance System is designed to track student attendance patterns and correlate them with academic performance. This system helps educational institutions identify at-risk students, optimize teaching strategies, and improve overall educational outcomes by analyzing the relationship between attendance and academic achievement.

## Problem Statement
- Educational institutions often struggle with:
  Manual tracking of student attendance and performance
- Lack of data-driven insights into how attendance affects grades
- Difficulty identifying students needing early intervention
- Inefficient monitoring of attendance patterns across different subjects
- Limited ability to correlate external factors with academic performance

## DataBase & Tools:
- PostgreSQL
- PgAdmin4
## Database Schema 

``` sql
-- Create database
CREATE DATABASE student_performance_system;

-- Connect to database
\c student_performance_system;

-- Student Table :
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

-- Course Table :
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER DEFAULT 3,
    department VARCHAR(50)
);

-- Attendance Table :
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    attendance_date DATE NOT NULL,
    status VARCHAR(10) CHECK (status IN ('Present', 'Absent', 'Late')),
    remarks TEXT
);

-- Performance Table :
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

-- Student Course Table :
CREATE TABLE student_courses (
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    enrollment_date DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (student_id, course_id)
);
```
## SWOT Analysis
### Strengths
- Data-Driven Decisions: Enables evidence-based interventions for at-risk students
- Comprehensive Tracking: Monitors both attendance and performance metrics
- Early Warning System: Identifies struggling students before final exams
- Automated Reporting: Reduces manual work for faculty and administration
- Historical Analysis: Tracks trends over multiple semesters

### Weaknesses
- Data Quality Dependency: Relies on accurate and timely data entry
- Limited Context: Doesn't capture external factors affecting performance
- Implementation Complexity: Requires technical expertise to set up and maintain
- Privacy Concerns: Handles sensitive student data requiring strict security

### Opportunities
- Predictive Analytics: Could incorporate machine learning for early prediction
- Parent Portal: Extend access to parents for better involvement
- Mobile Integration: Develop mobile apps for real-time attendance tracking
- Curriculum Optimization: Use data to improve course structures and teaching methods

### Threats
- Data Security Risks: Potential breaches of student information
- Resistance to Change: Faculty reluctance to adopt new systems
- System Downtime: Technical issues affecting critical academic processes
- Regulatory Compliance: Changing data protection laws and educational regulations

## Conclusion
The Student Performance & Attendance System provides a robust foundation for educational institutions to monitor and improve student outcomes. By leveraging PostgreSQL's powerful querying capabilities, the system offers valuable insights into the correlation between attendance and academic performance.

## Key Benefits:
- Proactive Intervention: Identifies at-risk students early
- Resource Optimization: Helps allocate teaching resources effectively
- Performance Tracking: Monitors individual and group progress
- Data-Driven Strategy: Supports institutional decision-making

## Future Enhancements:
- Integration with learning management systems
- Real-time notifications for poor attendance
- Advanced predictive analytics
- Mobile application development
- Automated report generation
