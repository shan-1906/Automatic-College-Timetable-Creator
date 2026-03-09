-- ============================================================
-- College Timetable Generator System — Sample Data
-- ============================================================
-- Run AFTER schema.sql:
--   mysql -u root college_timetable < sample_data.sql
-- ============================================================

USE college_timetable;

-- Admin  (password: admin123)
-- Hash generated with: werkzeug.security.generate_password_hash('admin123')
INSERT INTO admin (username, password) VALUES
('admin', 'pbkdf2:sha256:600000$XsLz7q8K$e5c3f5d0a4b2c1d6e7f8a9b0c1d2e3f4a5b6c7d8e9f0a1b2c3d4e5f6a7b8c9d0');

-- Teachers
INSERT INTO teachers (name, department, availability, max_hours) VALUES
('Dr. Rajesh Kumar',    'Computer Science',    '{"Monday":[1,2,3,4,5,6],"Tuesday":[1,2,3,4,5,6],"Wednesday":[1,2,3,4,5,6],"Thursday":[1,2,3,4,5,6],"Friday":[1,2,3,4,5,6]}', 24),
('Prof. Anita Sharma',  'Computer Science',    '{"Monday":[1,2,3,4,5,6],"Tuesday":[1,2,3,4,5,6],"Wednesday":[1,2,3,4,5,6],"Thursday":[1,2,3,4,5,6],"Friday":[1,2,3,4,5,6]}', 20),
('Dr. Suresh Patel',    'Electronics',         '{"Monday":[1,2,3,4,5,6],"Tuesday":[1,2,3,4,5,6],"Wednesday":[1,2,3,4,5,6],"Thursday":[1,2,3],"Friday":[1,2,3,4,5,6]}', 18),
('Prof. Meena Gupta',   'Electronics',         '{"Monday":[1,2,3,4,5,6],"Tuesday":[1,2,3,4,5,6],"Wednesday":[1,2,3,4,5,6],"Thursday":[1,2,3,4,5,6],"Friday":[1,2,3,4,5,6]}', 22),
('Dr. Vikram Singh',    'Mathematics',         '{"Monday":[1,2,3,4,5,6],"Tuesday":[1,2,3,4,5,6],"Wednesday":[1,2,3,4,5,6],"Thursday":[1,2,3,4,5,6],"Friday":[1,2,3]}', 20),
('Prof. Kavita Reddy',  'Computer Science',    '{"Monday":[1,2,3,4,5,6],"Tuesday":[1,2,3,4,5,6],"Wednesday":[1,2,3,4,5,6],"Thursday":[1,2,3,4,5,6],"Friday":[1,2,3,4,5,6]}', 20);

-- Subjects
INSERT INTO subjects (name, weekly_hours, teacher_id, subject_type) VALUES
('Data Structures',           4, 1, 'theory'),
('Database Management',       3, 2, 'theory'),
('Digital Electronics',       3, 3, 'theory'),
('Microprocessors',           3, 4, 'theory'),
('Engineering Mathematics',   4, 5, 'theory'),
('Programming Lab',           2, 1, 'lab'),
('Electronics Lab',           2, 3, 'lab'),
('Web Development',           3, 6, 'theory');

-- Classes
INSERT INTO classes (department, semester, section) VALUES
('Computer Science', 3, 'A'),
('Computer Science', 3, 'B'),
('Electronics',      5, 'A'),
('Electronics',      5, 'B');

-- Rooms
INSERT INTO rooms (room_number, capacity, room_type) VALUES
('R101', 60, 'classroom'),
('R102', 60, 'classroom'),
('R103', 40, 'classroom'),
('L201', 30, 'lab'),
('L202', 30, 'lab');

-- Timeslots  (Monday–Friday, 6 periods each, with break after period 3)
INSERT INTO timeslots (day, period_num, start_time, end_time, is_break) VALUES
-- Monday
('Monday', 1, '09:00', '09:50', 0),
('Monday', 2, '09:50', '10:40', 0),
('Monday', 3, '10:40', '11:30', 0),
('Monday', 4, '11:45', '12:35', 0),
('Monday', 5, '12:35', '13:25', 0),
('Monday', 6, '14:00', '14:50', 0),
-- Tuesday
('Tuesday', 1, '09:00', '09:50', 0),
('Tuesday', 2, '09:50', '10:40', 0),
('Tuesday', 3, '10:40', '11:30', 0),
('Tuesday', 4, '11:45', '12:35', 0),
('Tuesday', 5, '12:35', '13:25', 0),
('Tuesday', 6, '14:00', '14:50', 0),
-- Wednesday
('Wednesday', 1, '09:00', '09:50', 0),
('Wednesday', 2, '09:50', '10:40', 0),
('Wednesday', 3, '10:40', '11:30', 0),
('Wednesday', 4, '11:45', '12:35', 0),
('Wednesday', 5, '12:35', '13:25', 0),
('Wednesday', 6, '14:00', '14:50', 0),
-- Thursday
('Thursday', 1, '09:00', '09:50', 0),
('Thursday', 2, '09:50', '10:40', 0),
('Thursday', 3, '10:40', '11:30', 0),
('Thursday', 4, '11:45', '12:35', 0),
('Thursday', 5, '12:35', '13:25', 0),
('Thursday', 6, '14:00', '14:50', 0),
-- Friday
('Friday', 1, '09:00', '09:50', 0),
('Friday', 2, '09:50', '10:40', 0),
('Friday', 3, '10:40', '11:30', 0),
('Friday', 4, '11:45', '12:35', 0),
('Friday', 5, '12:35', '13:25', 0),
('Friday', 6, '14:00', '14:50', 0);

-- Default rules
INSERT INTO rules (working_days, periods_per_day, break_after, break_duration, lab_periods) VALUES
(5, 6, 3, 15, 2);
