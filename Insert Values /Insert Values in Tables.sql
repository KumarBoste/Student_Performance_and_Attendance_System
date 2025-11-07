-- Insert sample data
INSERT INTO students (first_name, last_name, email, date_of_birth, gender) VALUES
('John', 'Smith', 'john.smith@email.com', '2000-05-15', 'M'),
('Sarah', 'Johnson', 'sarah.johnson@email.com', '2001-02-20', 'F'),
('Michael', 'Brown', 'michael.brown@email.com', '2000-11-08', 'M'),
('Emily', 'Davis', 'emily.davis@email.com', '2001-07-30', 'F'),
('David', 'Wilson', 'david.wilson@email.com', '2000-09-12', 'M');

INSERT INTO courses (course_code, course_name, credits, department) VALUES
('MATH101', 'Calculus I', 4, 'Mathematics'),
('PHYS101', 'Physics I', 4, 'Physics'),
('CS101', 'Introduction to Programming', 3, 'Computer Science'),
('ENG101', 'English Composition', 3, 'English'),
('HIST101', 'World History', 3, 'History');

INSERT INTO student_courses (student_id, course_id) VALUES
(1, 1), (1, 2), (1, 3),
(2, 1), (2, 3), (2, 4),
(3, 2), (3, 3), (3, 5),
(4, 1), (4, 4), (4, 5),
(5, 2), (5, 3), (5, 4);

-- Insert attendance data
INSERT INTO attendance (student_id, course_id, attendance_date, status) VALUES
(1, 1, '2024-01-10', 'Present'), (1, 1, '2024-01-12', 'Present'),
(1, 1, '2024-01-15', 'Absent'), (2, 1, '2024-01-10', 'Present'),
(2, 1, '2024-01-12', 'Late'), (3, 2, '2024-01-11', 'Present');

-- Insert performance data
INSERT INTO performance (student_id, course_id, semester, assignment_score, midterm_score, final_score, grade) VALUES
(1, 1, 'Spring2024', 85, 78, 82, 'B'),
(1, 2, 'Spring2024', 92, 88, 90, 'A'),
(2, 1, 'Spring2024', 78, 82, 80, 'B'),
(2, 3, 'Spring2024', 65, 70, 68, 'C'),
(3, 2, 'Spring2024', 88, 85, 86, 'B');
