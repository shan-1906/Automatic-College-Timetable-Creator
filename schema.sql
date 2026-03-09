-- ============================================================
-- College Timetable Generator System — MySQL Database Schema
-- ============================================================
-- Run this file in XAMPP phpMyAdmin or MySQL CLI:
--   mysql -u root < schema.sql
-- ============================================================

CREATE DATABASE IF NOT EXISTS college_timetable;
USE college_timetable;

-- -----------------------------------------------
-- 1. Admin table
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS admin (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    username    VARCHAR(50)  NOT NULL UNIQUE,
    password    VARCHAR(255) NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- -----------------------------------------------
-- 2. Teachers table
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS teachers (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    department      VARCHAR(100) NOT NULL,
    availability    JSON,                           -- e.g. {"Monday":[1,2,3], "Tuesday":[1,2,3,4]}
    max_hours       INT NOT NULL DEFAULT 20,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- -----------------------------------------------
-- 3. Subjects table
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS subjects (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    name            VARCHAR(100) NOT NULL,
    weekly_hours    INT NOT NULL DEFAULT 3,
    teacher_id      INT,
    subject_type    ENUM('theory', 'lab') DEFAULT 'theory',
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (teacher_id) REFERENCES teachers(id) ON DELETE SET NULL
) ENGINE=InnoDB;

-- -----------------------------------------------
-- 4. Classes table
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS classes (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    department  VARCHAR(100) NOT NULL,
    semester    INT NOT NULL,
    section     VARCHAR(10) NOT NULL DEFAULT 'A',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- -----------------------------------------------
-- 5. Rooms table
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS rooms (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    room_number VARCHAR(20) NOT NULL UNIQUE,
    capacity    INT NOT NULL DEFAULT 60,
    room_type   ENUM('classroom', 'lab') DEFAULT 'classroom',
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- -----------------------------------------------
-- 6. Timeslots table
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS timeslots (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    day         VARCHAR(15) NOT NULL,
    period_num  INT NOT NULL,
    start_time  VARCHAR(10) NOT NULL,
    end_time    VARCHAR(10) NOT NULL,
    is_break    TINYINT(1) DEFAULT 0,
    UNIQUE KEY unique_day_period (day, period_num)
) ENGINE=InnoDB;

-- -----------------------------------------------
-- 7. Rules table  (single-row configuration)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS rules (
    id              INT AUTO_INCREMENT PRIMARY KEY,
    working_days    INT NOT NULL DEFAULT 5,
    periods_per_day INT NOT NULL DEFAULT 6,
    break_after     INT DEFAULT 3,               -- break after period N
    break_duration  INT DEFAULT 30,              -- minutes
    lab_periods     INT DEFAULT 2,               -- consecutive periods for labs
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- -----------------------------------------------
-- 8. Timetable table (generated schedule)
-- -----------------------------------------------
CREATE TABLE IF NOT EXISTS timetable (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    class_id    INT NOT NULL,
    subject_id  INT NOT NULL,
    teacher_id  INT NOT NULL,
    room_id     INT NOT NULL,
    timeslot_id INT NOT NULL,
    created_at  TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (class_id)    REFERENCES classes(id)   ON DELETE CASCADE,
    FOREIGN KEY (subject_id)  REFERENCES subjects(id)  ON DELETE CASCADE,
    FOREIGN KEY (teacher_id)  REFERENCES teachers(id)  ON DELETE CASCADE,
    FOREIGN KEY (room_id)     REFERENCES rooms(id)     ON DELETE CASCADE,
    FOREIGN KEY (timeslot_id) REFERENCES timeslots(id) ON DELETE CASCADE,

    -- Clash prevention constraints
    UNIQUE KEY no_teacher_clash  (teacher_id, timeslot_id),
    UNIQUE KEY no_room_clash     (room_id, timeslot_id),
    UNIQUE KEY no_class_clash    (class_id, timeslot_id)
) ENGINE=InnoDB;
