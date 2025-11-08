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
