### University Course Registration System  

#### **Business Scenario**  
A university needs to manage students, courses, and enrollments. Each course has a code (e.g., "CS101"), title, and credits. Students can enroll in multiple courses, and the system tracks their enrollment dates and grades.  

---

#### **Questions**  
1. Design an ER diagram with `students`, `courses`, and `enrollments`.  
2. Create tables with constraints (PK, FK, UNIQUE for course codes).  
3. Insert 2 courses and 3 students.  
4. Enroll 2 students in one course.  
5. Add a `department` column to the `courses` table.  
6. Update a student’s grade for a course.  
7. Delete a course enrollment.  

---

#### **Answer Script**  
```sql
-- 1. ER Diagram Description:
-- students(student_id, name, email, enrollment_year)
-- courses(course_id, course_code, title, credits, department)
-- enrollments(enrollment_id, student_id, course_id, enrollment_date, grade)

-- 2. Create Tables
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    enrollment_year INT
);

CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) UNIQUE NOT NULL,
    title VARCHAR(100) NOT NULL,
    credits INT CHECK (credits > 0)
);

CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id),
    enrollment_date DATE DEFAULT CURRENT_DATE,
    grade DECIMAL(5,2) CHECK (grade BETWEEN 0 AND 100)
);

-- 3. Insert Sample Data
INSERT INTO courses (course_code, title, credits) 
VALUES 
('CS101', 'Intro to Programming', 3),
('MATH201', 'Calculus II', 4);

INSERT INTO students (name, email, enrollment_year) 
VALUES 
('Alex Carter', 'alex@uni.edu', 2023),
('Maria Gomez', 'maria@uni.edu', 2022),
('Liam Chen', 'liam@uni.edu', 2024);

-- 4. Enroll Students
INSERT INTO enrollments (student_id, course_id) 
VALUES (1, 1), (2, 1);

-- 5. Alter Courses Table
ALTER TABLE courses 
ADD COLUMN department VARCHAR(50);

-- 6. Update a Grade
UPDATE enrollments 
SET grade = 85.5 
WHERE enrollment_id = 1;

-- 7. Delete an Enrollment
DELETE FROM enrollments 
WHERE enrollment_id = 2;
```

---

