### Fitness Center Management

#### **Business Scenario**  
A fitness center tracks members, workout sessions, and attendance. Members can attend multiple sessions. Each session has a type (e.g., Yoga, Cardio) and a trainer.

---

#### **Questions**  
1. Design an ER diagram with `members`, `workouts`, and `attendance`.  
2. Create tables with PKs/FKs. Ensure session times are in the future.  
3. Insert 2 workout types and 3 members.  
4. Record a member attending a session.  
5. Add a `status` column to members (Active/Inactive).  
6. Delete a workout session and cascade changes.  

---

#### **Answer Script**  
```sql
-- 1. ER Diagram Description:
-- members(member_id, name, join_date, status)
-- workouts(workout_id, type, trainer, session_time)
-- attendance(attendance_id, member_id, workout_id)

-- 2. Create Tables
CREATE TABLE members (
    member_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    join_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE workouts (
    workout_id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    trainer VARCHAR(50),
    session_time TIMESTAMP CHECK (session_time > CURRENT_TIMESTAMP)
);

CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    member_id INT REFERENCES members(member_id),
    workout_id INT REFERENCES workouts(workout_id) ON DELETE CASCADE
);

-- 3. Insert Sample Data
INSERT INTO workouts (type, trainer, session_time) 
VALUES 
('Yoga', 'Lisa Park', '2024-03-25 09:00:00'),
('Cardio', 'Mark Lee', '2024-03-26 17:00:00');

INSERT INTO members (name) 
VALUES 
('Emma Davis'), ('James White'), ('Olivia Clark');

-- 4. Record Attendance
INSERT INTO attendance (member_id, workout_id) 
VALUES (1, 1), (2, 1);

-- 5. Alter Members Table
ALTER TABLE members 
ADD COLUMN status VARCHAR(10) DEFAULT 'Active';

-- 6. Delete a Workout (Cascades to Attendance)
DELETE FROM workouts 
WHERE workout_id = 1;
```

---

