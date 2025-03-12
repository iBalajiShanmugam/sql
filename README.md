# Introduction to SQL and PostgreSQL

SQL (Structured Query Language) is the standard language for interacting with relational databases. PostgreSQL (often called "Postgres") is an advanced, open-source relational database system that extends the SQL language while adding many features that safely store and scale complex data workloads.

## What is SQL?

SQL is a domain-specific language designed for managing data held in relational database management systems. It was developed in the 1970s by IBM researchers and has since become the standard language for database interaction. SQL allows you to:

- Create database structures (tables, views, indexes)
- Insert, update, and delete data
- Query data with sophisticated selection criteria
- Control access to the database and its objects

## What is PostgreSQL?

PostgreSQL is a powerful, open-source object-relational database system with over 30 years of active development. It has earned a strong reputation for reliability, feature robustness, and performance.

Key features of PostgreSQL include:

- ACID (Atomicity, Consistency, Isolation, Durability) compliance for reliable transactions
- Support for various data types beyond standard SQL (arrays, JSON, geometric data)
- Extensibility through user-defined types, functions, and procedural languages
- Multi-version concurrency control (MVCC) for efficient handling of concurrent operations
- Robust security features including SSL support and column/row-level security
- Full text search capabilities
- Spatial data support through PostGIS extension

## SQL Standards and PostgreSQL Extensions

The SQL language is defined by ISO/IEC standards, with the most recent major revision being SQL:2016. While PostgreSQL aims to conform to the SQL standard, it also offers many extensions and additional features beyond the standard.

Some PostgreSQL-specific features include:
- Custom data types
- Table inheritance
- Rules system
- Event triggers
- Foreign data wrappers
- Advanced indexing methods

## Benefits of Learning SQL with PostgreSQL

Learning SQL with PostgreSQL provides several advantages:

1. **Transferable skills**: Core SQL knowledge is transferable across different database systems.
2. **Advanced features**: PostgreSQL's rich feature set allows you to learn beyond basic SQL.
3. **Open-source ecosystem**: Access to a wealth of community resources, extensions, and tools.
4. **Industry relevance**: PostgreSQL is widely used in industry, from startups to large enterprises.
5. **Career opportunities**: Skills in SQL and PostgreSQL are in high demand in the job market.

## Who Uses PostgreSQL?

PostgreSQL is used by organizations of all sizes and across various industries:

- Technology companies (Apple, Cisco, Fujitsu, Red Hat)
- Financial services (Mastercard, Nasdaq)
- Government agencies
- Research institutions
- Streaming services (Netflix)
- Geospatial applications
- Educational institutions

As we progress through this training, you'll develop practical skills that are directly applicable to real-world database development and management using PostgreSQL.

# Setting Up PostgreSQL

Before diving into SQL queries and database concepts, we need to set up PostgreSQL on your system. This guide covers installation and initial configuration across different operating systems.

## Installation

### Windows

1. Download the installer from the [official PostgreSQL website](https://www.postgresql.org/download/windows/)
2. Run the installer and follow the setup wizard
3. Components to install:
   - PostgreSQL Server
   - pgAdmin (graphical administration tool)
   - Command Line Tools
   - Stack Builder
4. Choose a password for the postgres superuser account
5. Keep the default port (5432) unless you have a specific reason to change it
6. Select your locale or keep the default
7. Click Install to begin the installation process

After installation, you can verify it by:
1. Opening the Start menu and finding PostgreSQL in the program list
2. Running pgAdmin to connect to your local server
3. Using the command prompt to run `psql -U postgres`

### macOS

#### Using Homebrew (Recommended)

If you don't have Homebrew installed, install it first:
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install PostgreSQL:
```bash
# Install PostgreSQL
brew install postgresql

# Start the PostgreSQL service
brew services start postgresql

# Verify installation
postgres --version
```

#### Using the Postgres.app

Alternatively, you can download and install [Postgres.app](https://postgresapp.com/) which provides a simple, user-friendly installation:

1. Download Postgres.app from the official website
2. Drag to your Applications folder
3. Double-click to start the app
4. Click "Initialize" to create a PostgreSQL database

### Linux (Ubuntu/Debian)

```bash
# Update package lists
sudo apt update

# Install PostgreSQL and contrib package with additional utilities
sudo apt install postgresql postgresql-contrib

# Verify installation
psql --version

# Start the service
sudo systemctl start postgresql

# Enable PostgreSQL to start on boot
sudo systemctl enable postgresql
```

### Linux (Red Hat/Fedora/CentOS)

```bash
# Install PostgreSQL
sudo dnf install postgresql-server postgresql-contrib

# Initialize the database
sudo postgresql-setup --initdb

# Start the service
sudo systemctl start postgresql

# Enable PostgreSQL to start on boot
sudo systemctl enable postgresql
```

## Post-Installation Setup

### Accessing PostgreSQL

After installation, you can access PostgreSQL through:

1. **psql command-line interface**:
   ```bash
   # Login as postgres user (on Linux)
   sudo -u postgres psql
   
   # Or on Windows
   psql -U postgres
   ```

2. **pgAdmin**: A graphical administration tool included with PostgreSQL

3. **DBeaver**: A cross-platform database tool that supports PostgreSQL

### Creating Your First Database

Using psql:
```sql
-- Connect to the default postgres database
psql -U postgres

-- Create a new database
CREATE DATABASE mydb;

-- Connect to your new database
\c mydb

-- Verify connection
SELECT current_database();
```

Using pgAdmin:
1. Right-click on "Databases" in the browser panel
2. Select "Create" > "Database..."
3. Enter a name for your database
4. Click "Save"

### Managing Users

PostgreSQL uses role-based access control. Roles can be users (with login privileges) or groups.

```sql
-- Create a new user (role with login privilege)
CREATE USER myuser WITH PASSWORD 'securepassword';

-- Grant database access
GRANT ALL PRIVILEGES ON DATABASE mydb TO myuser;

-- Connect as the new user
\c mydb myuser
```

## PostgreSQL Command Line Tools

PostgreSQL comes with several command-line utilities:

1. **psql**: Interactive terminal for working with PostgreSQL
   ```bash
   # Connect to a database
   psql -U username -d database_name -h hostname -p port
   ```

2. **pg_dump**: Backup utility
   ```bash
   # Backup a database to a file
   pg_dump -U username -d database_name -f backup.sql
   ```

3. **pg_restore**: Restore from backup
   ```bash
   # Restore from a backup file
   pg_restore -U username -d database_name -f backup.sql
   ```

4. **createdb/dropdb**: Create or drop databases
   ```bash
   # Create a database
   createdb -U username database_name
   
   # Drop a database
   dropdb -U username database_name
   ```

## Essential psql Commands

Once connected to PostgreSQL through psql, you can use these helpful commands:

| Command | Description |
|---------|-------------|
| `\?` | Show psql command help |
| `\h [command]` | Get syntax help on a specific SQL command |
| `\l` | List all databases |
| `\c database_name` | Connect to a specific database |
| `\dt` | List all tables in the current database |
| `\d table_name` | Describe a table's structure |
| `\du` | List all users and their roles |
| `\i filename` | Execute SQL commands from a file |
| `\e` | Open text editor to write multiline queries |
| `\q` | Quit psql |

## Configuration Files

PostgreSQL has several important configuration files:

1. **postgresql.conf**: Main configuration file that controls database server parameters
2. **pg_hba.conf**: Client authentication configuration
3. **pg_ident.conf**: User name mapping for external authentication methods

These files are typically located in the PostgreSQL data directory:
- Windows: `C:\Program Files\PostgreSQL\[version]\data`
- macOS (Homebrew): `/usr/local/var/postgres`
- Linux: `/etc/postgresql/[version]/main` or `/var/lib/pgsql/data`

## Troubleshooting Common Installation Issues

### Connection Refused Errors
- Ensure the PostgreSQL service is running
- Check `pg_hba.conf` for proper client authentication settings
- Verify firewall settings aren't blocking port 5432

### Authentication Errors
- Confirm you're using the correct username and password
- Check that the role has appropriate login privileges
- Ensure `pg_hba.conf` is configured correctly

### Port Conflicts
- Change the PostgreSQL port in `postgresql.conf` if port 5432 is already in use
- Restart the PostgreSQL service after changing the port

## Next Steps

Now that PostgreSQL is installed and configured, you're ready to start creating databases, tables, and writing SQL queries. The subsequent sections will guide you through these fundamental database operations.

# Data Defenition Language (DDL) in PostgresSQL

## Database Concepts

A database is an organized collection of structured data, typically stored electronically in a computer system. A database management system (DBMS) like PostgreSQL is software that interacts with the database, applications, and users to capture and analyze data.

### Relational Database Model

PostgreSQL follows the relational model, which organizes data into tables (relations) with rows and columns:

- **Tables**: Represent entities or concepts (e.g., students, courses)
- **Rows**: Individual records in a table (e.g., a specific student)
- **Columns**: Attributes or properties of the entity (e.g., student name, ID)
- **Primary Keys**: Unique identifiers for each row
- **Foreign Keys**: References to primary keys in other tables, establishing relationships

### Database Schemas

A schema is a logical container for database objects (tables, views, functions, etc.). Schemas help organize database objects and control access permissions. PostgreSQL creates a default schema called `public`.

```sql
-- Create a new schema
CREATE SCHEMA school;

-- Create a table in the schema
CREATE TABLE school.students (
    student_id SERIAL PRIMARY KEY,
    name VARCHAR(100)
);

-- List schemas in the current database
\dn
```

## Creating a Database

Before creating tables, you need to create a database. In PostgreSQL, you can create a database using the `CREATE DATABASE` command:

```sql
-- Create a new database
CREATE DATABASE student_records;

-- Connect to the database
\c student_records
```

You can also specify additional parameters:

```sql
CREATE DATABASE student_records
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TEMPLATE = template0
    CONNECTION LIMIT = -1;
```

## Data Types in PostgreSQL

PostgreSQL supports a rich set of data types. Understanding these types is crucial for designing efficient database schemas.

### Numeric Types

| Data Type | Description | Size | Range |
|-----------|-------------|------|-------|
| SMALLINT | Small integer | 2 bytes | -32,768 to 32,767 |
| INTEGER | Regular integer | 4 bytes | -2,147,483,648 to 2,147,483,647 |
| BIGINT | Large integer | 8 bytes | -9,223,372,036,854,775,808 to 9,223,372,036,854,775,807 |
| DECIMAL(p,s) | Exact decimal with precision p and scale s | Variable | Up to 131,072 digits before decimal point; up to 16,383 after |
| NUMERIC(p,s) | Same as DECIMAL | Variable | Same as DECIMAL |
| REAL | Single precision floating-point | 4 bytes | 6 decimal digits precision |
| DOUBLE PRECISION | Double precision floating-point | 8 bytes | 15 decimal digits precision |
| SERIAL | Auto-incrementing integer | 4 bytes | 1 to 2,147,483,647 |
| BIGSERIAL | Auto-incrementing big integer | 8 bytes | 1 to 9,223,372,036,854,775,807 |

### Character Types

| Data Type | Description | Size |
|-----------|-------------|------|
| CHAR(n) | Fixed-length character string | n characters |
| VARCHAR(n) | Variable-length character string with limit | Up to n characters |
| TEXT | Variable-length character string, unlimited length | Unlimited |

### Date/Time Types

| Data Type | Description | Size | Range |
|-----------|-------------|------|-------|
| DATE | Calendar date (year, month, day) | 4 bytes | 4713 BC to 5874897 AD |
| TIME | Time of day (without time zone) | 8 bytes | 00:00:00 to 24:00:00 |
| TIMESTAMP | Date and time (without time zone) | 8 bytes | 4713 BC to 294276 AD |
| TIMESTAMPTZ | Date and time with time zone | 8 bytes | 4713 BC to 294276 AD |
| INTERVAL | Time interval | 16 bytes | -178,000,000 years to 178,000,000 years |

### Boolean Type

| Data Type | Description | Size | Values |
|-----------|-------------|------|--------|
| BOOLEAN | Logical Boolean (true/false) | 1 byte | true, false, null |

### Special Types

| Data Type | Description | Size |
|-----------|-------------|------|
| UUID | Universally unique identifier | 16 bytes |
| JSON | JSON data stored as text | Variable |
| JSONB | JSON data stored in binary format | Variable |
| ARRAY | Array of values | Variable |
| CIDR | IPv4 or IPv6 network address | 7 or 19 bytes |
| INET | IPv4 or IPv6 host address | 7 or 19 bytes |
| MACADDR | MAC address | 6 bytes |

### Geometric Types

| Data Type | Description |
|-----------|-------------|
| POINT | Point on a plane |
| LINE | Infinite line |
| LSEG | Line segment |
| BOX | Rectangular box |
| PATH | Closed and open paths |
| POLYGON | Polygon |
| CIRCLE | Circle |

## Creating Tables

Tables are the fundamental structure for storing data in PostgreSQL. The `CREATE TABLE` statement defines a new table structure.

### Basic Table Creation

```sql
CREATE TABLE students (
    student_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Creating Tables with Constraints

Constraints enforce rules on data in tables:

```sql
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_code VARCHAR(10) NOT NULL UNIQUE,
    course_name VARCHAR(100) NOT NULL,
    credits INTEGER CHECK (credits > 0 AND credits <= 6),
    department VARCHAR(50),
    active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

### Temporary Tables

Temporary tables exist only for the duration of a session:

```sql
CREATE TEMPORARY TABLE temp_students (
    id INTEGER,
    name VARCHAR(100)
);
```

## Constraints

Constraints enforce rules on data to maintain integrity.

### Primary Key Constraint

Uniquely identifies each record in a table:

```sql
CREATE TABLE departments (
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL
);
```

### Foreign Key Constraint

Establishes a relationship between tables:

```sql
CREATE TABLE enrollments (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INTEGER NOT NULL,
    course_id INTEGER NOT NULL,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES students (student_id),
    FOREIGN KEY (course_id) REFERENCES courses (course_id)
);
```

### Unique Constraint

Ensures all values in a column are different:

```sql
CREATE TABLE instructors (
    instructor_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20) UNIQUE
);
```

### Check Constraint

Ensures values meet a specific condition:

```sql
CREATE TABLE grades (
    grade_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    grade NUMERIC(3,1) CHECK (grade >= 0 AND grade <= 100)
);
```

### Not Null Constraint

Ensures a column cannot have NULL values:

```sql
CREATE TABLE assignments (
    assignment_id SERIAL PRIMARY KEY,
    course_id INTEGER NOT NULL REFERENCES courses(course_id),
    title VARCHAR(200) NOT NULL,
    due_date DATE NOT NULL
);
```

### Default Values

Specifies a default value for a column:

```sql
CREATE TABLE attendance (
    attendance_id SERIAL PRIMARY KEY,
    student_id INTEGER REFERENCES students(student_id),
    course_id INTEGER REFERENCES courses(course_id),
    attendance_date DATE DEFAULT CURRENT_DATE,
    present BOOLEAN DEFAULT TRUE
);
```

## Altering Table Structure

After creating a table, you might need to modify its structure.

### Adding Columns

```sql
ALTER TABLE students ADD COLUMN phone VARCHAR(20);
```

### Removing Columns

```sql
ALTER TABLE students DROP COLUMN phone;
```

### Renaming Columns

```sql
ALTER TABLE students RENAME COLUMN email TO contact_email;
```

### Changing Column Data Types

```sql
ALTER TABLE courses ALTER COLUMN credits TYPE NUMERIC(3,1);
```

### Adding Constraints

```sql
ALTER TABLE students ADD CONSTRAINT email_format CHECK (email LIKE '%@%.%');
```

### Dropping Constraints

```sql
ALTER TABLE students DROP CONSTRAINT email_format;
```

## Dropping Database Objects

When you no longer need a database object, you can remove it.

### Dropping Tables

```sql
DROP TABLE IF EXISTS temp_students;
```

### Dropping Databases

```sql
-- Must be connected to a different database first
DROP DATABASE IF EXISTS old_database;
```

## Best Practices for Database Design

1. **Normalization**: Organize data to reduce redundancy and improve integrity
   - First Normal Form (1NF): No repeating groups, each column contains atomic values
   - Second Normal Form (2NF): 1NF plus all non-key attributes depend on the entire primary key
   - Third Normal Form (3NF): 2NF plus all attributes depend directly on the primary key

2. **Naming Conventions**:
   - Use lowercase with underscores for table and column names
   - Choose descriptive names
   - Be consistent with plural/singular naming (usually singular for entities)

3. **Data Types**:
   - Choose appropriate data types for columns
   - Use fixed-length types (CHAR, INTEGER) when values have fixed size
   - Use variable-length types (VARCHAR, TEXT) for variable content

4. **Constraints**:
   - Always define primary keys
   - Use foreign keys to maintain referential integrity
   - Apply NOT NULL constraints where appropriate
   - Use CHECK constraints to enforce business rules

5. **Documentation**:
   - Add comments to document tables and columns
   ```sql
   COMMENT ON TABLE students IS 'Students enrolled in courses';
   COMMENT ON COLUMN students.email IS 'Student email address used for communications';
   ```

# Data Manipulation Language (DML) in PostgreSQL

Data Manipulation Language (DML) consists of SQL commands that handle data operations in a database. These commands allow you to insert, update, delete, and retrieve data from database tables.

## INSERT Statement

The INSERT statement adds new rows to a table.

### Basic INSERT Syntax

```sql
INSERT INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

### Inserting a Single Row

```sql
INSERT INTO students (first_name, last_name, email, date_of_birth)
VALUES ('John', 'Smith', 'john.smith@example.com', '1998-05-15');
```

If you're inserting values for all columns in the table, you can omit the column list:

```sql
INSERT INTO students 
VALUES (DEFAULT, 'Maria', 'Garcia', 'maria.garcia@example.com', '1999-08-23', CURRENT_TIMESTAMP);
```
The `DEFAULT` keyword uses the default value for the column (useful for auto-incrementing IDs).

### Inserting Multiple Rows

PostgreSQL allows inserting multiple rows in a single statement:

```sql
INSERT INTO students (first_name, last_name, email)
VALUES 
    ('Robert', 'Johnson', 'robert.j@example.com'),
    ('Emily', 'Williams', 'emily.w@example.com'),
    ('Michael', 'Brown', 'michael.b@example.com');
```

### INSERT with RETURNING Clause

The RETURNING clause returns data from the rows affected by the INSERT:

```sql
INSERT INTO students (first_name, last_name, email)
VALUES ('David', 'Wilson', 'david.w@example.com')
RETURNING student_id, first_name, last_name;
```

This is useful for getting auto-generated values like IDs without making a separate query.

### Inserting Data from a SELECT Statement

You can insert data from another table or query:

```sql
INSERT INTO active_students (student_id, first_name, last_name, email)
SELECT student_id, first_name, last_name, email
FROM students
WHERE status = 'active';
```

This is powerful for copying or migrating data between tables.

### INSERT with ON CONFLICT Clause (Upsert)

PostgreSQL supports "upsert" operations (insert or update if exists) using the ON CONFLICT clause:

```sql
INSERT INTO students (student_id, first_name, last_name, email)
VALUES (101, 'Thomas', 'Anderson', 'thomas.a@example.com')
ON CONFLICT (student_id) 
DO UPDATE SET 
    first_name = EXCLUDED.first_name,
    last_name = EXCLUDED.last_name,
    email = EXCLUDED.email;
```

You can also choose to do nothing if a conflict occurs:

```sql
INSERT INTO students (student_id, first_name, last_name, email)
VALUES (101, 'Thomas', 'Anderson', 'thomas.a@example.com')
ON CONFLICT (student_id) DO NOTHING;
```

## UPDATE Statement

The UPDATE statement modifies existing data in a table.

### Basic UPDATE Syntax

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

### Updating a Single Row

```sql
UPDATE students
SET email = 'new.email@example.com'
WHERE student_id = 101;
```

### Updating Multiple Columns

```sql
UPDATE students
SET 
    last_name = 'Smith-Jones',
    status = 'inactive',
    updated_at = CURRENT_TIMESTAMP
WHERE student_id = 102;
```

### Updating Multiple Rows

```sql
UPDATE courses
SET credits = 4
WHERE department = 'Computer Science' AND credits = 3;
```

### UPDATE with FROM Clause

PostgreSQL allows updating data based on values from another table:

```sql
UPDATE enrollments
SET grade = new_grades.grade
FROM new_grades
WHERE enrollments.student_id = new_grades.student_id
AND enrollments.course_id = new_grades.course_id;
```

### UPDATE with Subqueries

You can use subqueries in the SET clause and WHERE conditions:

```sql
UPDATE students
SET total_credits = (
    SELECT SUM(courses.credits)
    FROM enrollments
    JOIN courses ON enrollments.course_id = courses.course_id
    WHERE enrollments.student_id = students.student_id
)
WHERE status = 'active';
```

### UPDATE with RETURNING Clause

Like INSERT, UPDATE can return data from modified rows:

```sql
UPDATE students
SET status = 'graduated'
WHERE credits_earned >= 120
RETURNING student_id, first_name, last_name, status;
```

## DELETE Statement

The DELETE statement removes rows from a table.

### Basic DELETE Syntax

```sql
DELETE FROM table_name
WHERE condition;
```

### Deleting Specific Rows

```sql
DELETE FROM students
WHERE student_id = 103;
```

### Deleting Multiple Rows

```sql
DELETE FROM enrollments
WHERE enrollment_date < '2020-01-01';
```

### Deleting with Subqueries

```sql
DELETE FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    GROUP BY student_id
    HAVING COUNT(*) = 0
);
```

This removes students who have no enrollments.

### Deleting All Rows from a Table

To delete all rows without removing the table structure:

```sql
DELETE FROM temporary_logs;
```

### DELETE with RETURNING Clause

Return information about the deleted rows:

```sql
DELETE FROM inactive_accounts
WHERE last_login < CURRENT_DATE - INTERVAL '1 year'
RETURNING account_id, username, last_login;
```

### DELETE with USING Clause

Delete rows based on a join condition:

```sql
DELETE FROM enrollments
USING students
WHERE enrollments.student_id = students.student_id
AND students.status = 'withdrawn';
```

## TRUNCATE Statement

TRUNCATE removes all rows from a table quickly. It's faster than DELETE for removing all rows because it doesn't scan the table.

### Basic TRUNCATE Syntax

```sql
TRUNCATE TABLE table_name;
```

### Truncating Multiple Tables

```sql
TRUNCATE TABLE temporary_logs, audit_trails;
```

### TRUNCATE with CASCADE Option

If tables are connected by foreign keys, you might need the CASCADE option:

```sql
TRUNCATE TABLE courses CASCADE;
```

This truncates the courses table and any table with foreign key references to it.

### TRUNCATE with RESTART IDENTITY

Reset auto-incrementing columns:

```sql
TRUNCATE TABLE log_entries RESTART IDENTITY;
```

## MERGE Statement (Supported in PostgreSQL 15+)

PostgreSQL 15 added support for the SQL standard MERGE statement, which combines INSERT, UPDATE, and DELETE operations.

### Basic MERGE Syntax

```sql
MERGE INTO target_table AS t
USING source_table AS s
ON t.key_column = s.key_column
WHEN MATCHED THEN
    UPDATE SET column1 = s.column1, column2 = s.column2
WHEN NOT MATCHED THEN
    INSERT (column1, column2) VALUES (s.column1, s.column2);
```

### Example MERGE Operation

```sql
MERGE INTO students AS t
USING student_updates AS s
ON t.student_id = s.student_id
WHEN MATCHED AND s.status = 'inactive' THEN
    DELETE
WHEN MATCHED THEN
    UPDATE SET 
        first_name = s.first_name,
        last_name = s.last_name,
        email = s.email,
        status = s.status
WHEN NOT MATCHED THEN
    INSERT (student_id, first_name, last_name, email, status)
    VALUES (s.student_id, s.first_name, s.last_name, s.email, s.status);
```

This performs different actions based on whether the record exists and its status value.

## Transaction Control

DML statements operate within transactions, which ensure data integrity.

### Transaction Basics

```sql
-- Start a transaction
BEGIN;

-- Perform operations
INSERT INTO students (first_name, last_name) VALUES ('Jane', 'Doe');
UPDATE courses SET active = false WHERE course_id = 101;

-- Commit changes
COMMIT;

-- Or roll back changes
-- ROLLBACK;
```

### Savepoints

For more granular control, you can set savepoints within a transaction:

```sql
BEGIN;

INSERT INTO students (first_name, last_name) VALUES ('Alex', 'Smith');

SAVEPOINT after_insert;

UPDATE courses SET active = false WHERE course_id = 101;

-- Oops, wrong update - roll back to savepoint
ROLLBACK TO after_insert;

-- Perform correct update
UPDATE courses SET credits = 4 WHERE course_id = 101;

COMMIT;
```

## Best Practices for DML Operations

1. **Use Transactions**: Wrap related DML operations in transactions to maintain data integrity.

2. **Include WHERE Clauses**: Always include a WHERE clause in UPDATE and DELETE statements unless you genuinely want to modify all rows.

3. **Test with SELECT First**: Before running UPDATE or DELETE, test your WHERE condition with a SELECT to verify which rows will be affected.

4. **Use RETURNING for Visibility**: The RETURNING clause provides visibility into affected rows without requiring a separate query.

5. **Consider Performance for Bulk Operations**: For large data operations, consider batch processing to avoid locking issues and memory constraints.

6. **Prefer Parameterized Queries**: When executing DML from application code, use parameterized queries to prevent SQL injection attacks.

7. **Use ON CONFLICT for Upserts**: Instead of separate EXISTS checks and conditionals, use PostgreSQL's ON CONFLICT for more efficient upsert operations.

8. **Add Constraints**: Utilize constraints like UNIQUE, NOT NULL, and FOREIGN KEY to prevent invalid data operations at the database level.


# Data Query Language (DQL) in PostgreSQL

SQL queries allow you to retrieve, filter, and manipulate data from your database. Learning to write effective queries is essential for working with relational databases like PostgreSQL.

## The SELECT Statement

The `SELECT` statement is the most common SQL command, used to retrieve data from one or more tables.

### Basic SELECT Syntax

```sql
SELECT column1, column2, ...
FROM table_name;
```

### Retrieving All Columns

To retrieve all columns from a table, use the asterisk (*) wildcard:

```sql
-- Retrieve all columns and all rows from the students table
SELECT * FROM students;
```

While convenient for exploration, using `SELECT *` in production code is generally not recommended as it:
- Returns unnecessary data, impacting performance
- Makes code less maintainable when table structures change
- Can expose sensitive data

### Selecting Specific Columns

Instead, specify only the columns you need:

```sql
-- Retrieve only student names and emails
SELECT first_name, last_name, email FROM students;
```

### Column Aliases

You can rename columns in the result set using aliases:

```sql
-- Rename columns in the result set
SELECT 
    first_name AS "First Name",
    last_name AS "Last Name",
    email AS "Contact Email"
FROM students;
```

The `AS` keyword is optional:

```sql
SELECT first_name "First Name", last_name "Last Name" FROM students;
```

### Expressions in SELECT

You can include expressions in your SELECT statement:

```sql
-- Concatenate first and last names
SELECT 
    student_id,
    first_name || ' ' || last_name AS full_name,
    EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_of_birth) AS approximate_age
FROM students;
```

### Retrieving Distinct Values

To eliminate duplicates from your results, use the `DISTINCT` keyword:

```sql
-- Get a list of unique departments
SELECT DISTINCT department FROM courses;

-- Get unique combinations of values
SELECT DISTINCT department, credits FROM courses;
```

## Filtering Data with WHERE

The `WHERE` clause filters rows based on specified conditions.

### Basic WHERE Syntax

```sql
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

### Comparison Operators

PostgreSQL supports standard comparison operators:

```sql
-- Equal to
SELECT * FROM students WHERE first_name = 'John';

-- Not equal to
SELECT * FROM students WHERE first_name <> 'John';  -- or !=

-- Greater than
SELECT * FROM courses WHERE credits > 3;

-- Less than
SELECT * FROM courses WHERE credits < 3;

-- Greater than or equal to
SELECT * FROM courses WHERE credits >= 3;

-- Less than or equal to
SELECT * FROM courses WHERE credits <= 3;
```

### Logical Operators

Combine multiple conditions using logical operators:

```sql
-- AND: Both conditions must be true
SELECT * FROM students 
WHERE date_of_birth >= '2000-01-01' AND date_of_birth <= '2005-12-31';

-- OR: At least one condition must be true
SELECT * FROM courses 
WHERE department = 'Computer Science' OR department = 'Mathematics';

-- NOT: Negates a condition
SELECT * FROM students 
WHERE NOT email LIKE '%@gmail.com';
```

### BETWEEN Operator

The `BETWEEN` operator tests if a value is within a range (inclusive):

```sql
-- Equivalent to value >= lower_bound AND value <= upper_bound
SELECT * FROM students 
WHERE date_of_birth BETWEEN '2000-01-01' AND '2005-12-31';

SELECT * FROM courses 
WHERE credits BETWEEN 3 AND 5;
```

### IN Operator

The `IN` operator tests if a value matches any value in a list:

```sql
-- Equivalent to value = value1 OR value = value2 OR ...
SELECT * FROM courses 
WHERE department IN ('Computer Science', 'Mathematics', 'Physics');

-- Can also use with subqueries (covered later)
SELECT * FROM students 
WHERE student_id IN (SELECT student_id FROM enrollments WHERE course_id = 101);
```

### LIKE Operator for Pattern Matching

The `LIKE` operator performs pattern matching using wildcards:

```sql
-- % represents zero or more characters
SELECT * FROM students WHERE email LIKE '%@gmail.com';
SELECT * FROM students WHERE first_name LIKE 'J%';  -- Names starting with J

-- _ represents a single character
SELECT * FROM students WHERE last_name LIKE 'Sm_th';  -- Matches Smith, Smyth
```

### ILIKE for Case-Insensitive Matching

PostgreSQL provides `ILIKE` for case-insensitive matching:

```sql
-- Case-insensitive matching
SELECT * FROM students WHERE first_name ILIKE 'john';  -- Matches John, JOHN, john
```

### IS NULL / IS NOT NULL

To test for NULL values (missing or undefined data):

```sql
-- Find students with no email address
SELECT * FROM students WHERE email IS NULL;

-- Find students with an email address
SELECT * FROM students WHERE email IS NOT NULL;
```

Remember that `NULL` represents an unknown or missing value and cannot be compared using `=` or `!=`.

## Sorting Results with ORDER BY

The `ORDER BY` clause sorts the result set:

```sql
-- Sort by a single column (ascending by default)
SELECT * FROM students ORDER BY last_name;

-- Explicitly specify ascending order
SELECT * FROM students ORDER BY last_name ASC;

-- Sort in descending order
SELECT * FROM students ORDER BY date_of_birth DESC;

-- Sort by multiple columns
SELECT * FROM students ORDER BY last_name ASC, first_name ASC;

-- Sort using column position in the result set
SELECT first_name, last_name FROM students ORDER BY 2, 1;  -- Order by last_name, then first_name
```

## Limiting Results

To restrict the number of rows returned, use the `LIMIT` clause:

```sql
-- Return only the first 10 rows
SELECT * FROM students LIMIT 10;

-- Combine with ORDER BY for "top N" queries
SELECT * FROM courses ORDER BY credits DESC LIMIT 5;  -- Top 5 courses by credits
```

## Pagination with OFFSET

For pagination, combine `LIMIT` with `OFFSET`:

```sql
-- Skip the first 10 rows, return the next 10
SELECT * FROM students ORDER BY student_id LIMIT 10 OFFSET 10;

-- Page 3 with 10 records per page (returns records 21-30)
SELECT * FROM students ORDER BY student_id LIMIT 10 OFFSET 20;
```

## Aggregate Functions

Aggregate functions perform calculations on a set of values and return a single value:

### COUNT

Counts the number of rows:

```sql
-- Count all rows
SELECT COUNT(*) FROM students;

-- Count non-NULL values in a column
SELECT COUNT(email) FROM students;

-- Count distinct values
SELECT COUNT(DISTINCT department) FROM courses;
```

### SUM

Calculates the sum of numeric values:

```sql
-- Total credits of all courses
SELECT SUM(credits) FROM courses;

-- Sum using a condition
SELECT SUM(credits) FROM courses WHERE department = 'Computer Science';
```

### AVG

Calculates the average (mean) of numeric values:

```sql
-- Average credits per course
SELECT AVG(credits) FROM courses;

-- Note: AVG ignores NULL values
```

### MIN and MAX

Find the minimum or maximum values:

```sql
-- Youngest student
SELECT MIN(date_of_birth) FROM students;

-- Oldest student
SELECT MAX(date_of_birth) FROM students;

-- Courses with minimum and maximum credits
SELECT MIN(credits), MAX(credits) FROM courses;
```

### Group Concatenation

In PostgreSQL, you can concatenate values from multiple rows using `string_agg`:

```sql
-- Get a comma-separated list of course codes
SELECT string_agg(course_code, ', ') FROM courses;

-- Group by department
SELECT department, string_agg(course_code, ', ') 
FROM courses 
GROUP BY department;
```

## Grouping Data with GROUP BY

The `GROUP BY` clause groups rows that have the same values:

```sql
-- Count students born each year
SELECT 
    EXTRACT(YEAR FROM date_of_birth) AS birth_year,
    COUNT(*) AS student_count
FROM students
GROUP BY birth_year
ORDER BY birth_year;

-- Calculate average credits by department
SELECT 
    department,
    COUNT(*) AS course_count,
    AVG(credits) AS avg_credits
FROM courses
GROUP BY department
ORDER BY department;
```

### HAVING Clause

The `HAVING` clause filters groups based on aggregate values (similar to `WHERE` but for groups):

```sql
-- Find departments with more than 5 courses
SELECT 
    department,
    COUNT(*) AS course_count
FROM courses
GROUP BY department
HAVING COUNT(*) > 5
ORDER BY course_count DESC;

-- Find average credits by department for departments with average > 3.0
SELECT 
    department,
    AVG(credits) AS avg_credits
FROM courses
GROUP BY department
HAVING AVG(credits) > 3.0
ORDER BY avg_credits DESC;
```

## FETCH and OFFSET (SQL Standard Alternative to LIMIT)

PostgreSQL supports the SQL standard `FETCH` clause as an alternative to `LIMIT`:

```sql
-- Equivalent to LIMIT 10
SELECT * FROM students
FETCH FIRST 10 ROWS ONLY;

-- Equivalent to LIMIT 10 OFFSET 20
SELECT * FROM students
OFFSET 20 ROWS
FETCH FIRST 10 ROWS ONLY;

-- WITH TIES returns extra rows that tie with the last row
SELECT * FROM courses
ORDER BY credits DESC
FETCH FIRST 5 ROWS WITH TIES;
```

## Handling NULL Values

### COALESCE Function

`COALESCE` returns the first non-NULL value in a list:

```sql
-- Replace NULL emails with 'No Email'
SELECT 
    first_name,
    last_name,
    COALESCE(email, 'No Email') AS contact
FROM students;
```

### NULLIF Function

`NULLIF` compares two expressions and returns NULL if they're equal, otherwise the first expression:

```sql
-- Avoid division by zero
SELECT 
    course_id,
    registered_students,
    max_students,
    registered_students / NULLIF(max_students, 0) AS fill_rate
FROM course_stats;
```

## Common Query Examples

### Finding Records with a Specific Pattern

```sql
-- Find students with gmail or yahoo email addresses
SELECT * FROM students
WHERE email LIKE '%@gmail.com' OR email LIKE '%@yahoo.com';
```

### Date Ranges

```sql
-- Find students who enrolled in the past 30 days
SELECT * FROM students
WHERE enrollment_date >= CURRENT_DATE - INTERVAL '30 days';
```

### Top N in Each Group

```sql
-- Find the course with the highest credits in each department
SELECT department, course_name, credits
FROM (
    SELECT 
        department,
        course_name,
        credits,
        RANK() OVER (PARTITION BY department ORDER BY credits DESC) AS credit_rank
    FROM courses
) ranked
WHERE credit_rank = 1;
```

### Calculating Age

```sql
-- Calculate the age of each student
SELECT 
    first_name,
    last_name,
    date_of_birth,
    AGE(date_of_birth) AS age,
    DATE_PART('year', AGE(date_of_birth)) AS age_years
FROM students;
```



# PostgreSQL Commonly Used Functions

PostgreSQL offers a rich set of built-in functions that make data manipulation and transformation more efficient. This guide covers the most commonly used PostgreSQL functions with examples and explanations.

## Table of Contents
- [String Functions](#string-functions)
- [Date and Time Functions](#date-and-time-functions)
- [Numeric Functions](#numeric-functions)
- [Aggregate Functions](#aggregate-functions)
- [Conditional Expressions](#conditional-expressions)
- [JSON Functions](#json-functions)
- [Type Conversion Functions](#type-conversion-functions)

## String Functions

### CONCAT and CONCAT_WS
The `CONCAT` function combines multiple strings, while `CONCAT_WS` (Concatenate With Separator) joins strings with a specified separator.

```sql
-- Basic concatenation
SELECT CONCAT('Hello', ' ', 'World'); -- Output: 'Hello World'

-- Concatenate with separator (first argument is the separator)
SELECT CONCAT_WS(', ', 'John', 'Doe', 'New York'); -- Output: 'John, Doe, New York'
```

### SUBSTRING
Extracts a portion of a string.

```sql
-- Extract characters from position 1 for 5 characters
SELECT SUBSTRING('PostgreSQL', 1, 5); -- Output: 'Postg'

-- Extract from position 7 to the end
SELECT SUBSTRING('PostgreSQL', 7); -- Output: 'SQL'
```

### UPPER, LOWER, and INITCAP
Change the case of strings.

```sql
SELECT UPPER('postgresql'); -- Output: 'POSTGRESQL'
SELECT LOWER('PostgreSQL'); -- Output: 'postgresql'
SELECT INITCAP('hello world'); -- Output: 'Hello World'
```

### LENGTH and CHAR_LENGTH
Return the length of a string.

```sql
SELECT LENGTH('PostgreSQL'); -- Output: 10
SELECT CHAR_LENGTH('PostgreSQL'); -- Output: 10
```

### TRIM, LTRIM, and RTRIM
Remove characters (spaces by default) from strings.

```sql
SELECT TRIM('  PostgreSQL  '); -- Output: 'PostgreSQL'
SELECT LTRIM('  PostgreSQL  '); -- Output: 'PostgreSQL  '
SELECT RTRIM('  PostgreSQL  '); -- Output: '  PostgreSQL'

-- Trim specific characters
SELECT TRIM(BOTH 'x' FROM 'xxxPostgreSQLxxx'); -- Output: 'PostgreSQL'
```

### REPLACE
Replaces all occurrences of a substring with another substring.

```sql
SELECT REPLACE('PostgreSQL Database', 'Database', 'DBMS'); -- Output: 'PostgreSQL DBMS'
```

### POSITION and STRPOS
Find the position of a substring within a string.

```sql
SELECT POSITION('SQL' IN 'PostgreSQL'); -- Output: 7
SELECT STRPOS('PostgreSQL', 'SQL'); -- Output: 7
```

### SPLIT_PART
Splits a string on a delimiter and returns the specified field.

```sql
-- Split on delimiter and return the specified part (1-indexed)
SELECT SPLIT_PART('2023-03-15', '-', 1); -- Output: '2023'
SELECT SPLIT_PART('2023-03-15', '-', 2); -- Output: '03'
```

## Date and Time Functions

### CURRENT_DATE, CURRENT_TIME, and CURRENT_TIMESTAMP
Return the current date, time, or timestamp.

```sql
SELECT CURRENT_DATE; -- Output: '2025-03-12'
SELECT CURRENT_TIME; -- Output: '14:30:45.123456+00'
SELECT CURRENT_TIMESTAMP; -- Output: '2025-03-12 14:30:45.123456+00'
```

### DATE_PART and EXTRACT
Extract components from date/time values.

```sql
SELECT DATE_PART('year', TIMESTAMP '2025-03-12 14:30:45'); -- Output: 2025
SELECT DATE_PART('month', TIMESTAMP '2025-03-12 14:30:45'); -- Output: 3

-- EXTRACT is equivalent to DATE_PART
SELECT EXTRACT(YEAR FROM TIMESTAMP '2025-03-12 14:30:45'); -- Output: 2025
SELECT EXTRACT(HOUR FROM TIMESTAMP '2025-03-12 14:30:45'); -- Output: 14
```

### DATE_TRUNC
Truncates a timestamp to a specified precision.

```sql
SELECT DATE_TRUNC('hour', TIMESTAMP '2025-03-12 14:30:45'); -- Output: '2025-03-12 14:00:00'
SELECT DATE_TRUNC('day', TIMESTAMP '2025-03-12 14:30:45'); -- Output: '2025-03-12 00:00:00'
SELECT DATE_TRUNC('month', TIMESTAMP '2025-03-12 14:30:45'); -- Output: '2025-03-01 00:00:00'
```

### Age
Calculates the difference between two timestamps.

```sql
-- Calculate age between two timestamps
SELECT AGE(TIMESTAMP '2025-03-12', TIMESTAMP '2020-01-01'); -- Output: '5 years 2 mons 11 days'

-- Calculate age from current date
SELECT AGE(TIMESTAMP '1990-05-15'); -- Output depends on current date
```

### Interval Manipulation
Add or subtract time intervals.

```sql
-- Add 1 day to a date
SELECT DATE '2025-03-12' + INTERVAL '1 day'; -- Output: '2025-03-13 00:00:00'

-- Add 3 hours to a timestamp
SELECT TIMESTAMP '2025-03-12 14:30:00' + INTERVAL '3 hours'; -- Output: '2025-03-12 17:30:00'

-- Complex interval addition
SELECT TIMESTAMP '2025-03-12 14:30:00' + INTERVAL '1 year 2 months 3 days 4 hours'; -- Output: '2026-05-15 18:30:00'
```

### TO_CHAR
Formats date/time values as strings.

```sql
SELECT TO_CHAR(CURRENT_DATE, 'DD-Mon-YYYY'); -- Output: '12-Mar-2025'
SELECT TO_CHAR(TIMESTAMP '2025-03-12 14:30:45', 'HH24:MI:SS'); -- Output: '14:30:45'
SELECT TO_CHAR(TIMESTAMP '2025-03-12 14:30:45', 'Month DD, YYYY HH12:MI:SS AM'); -- Output: 'March 12, 2025 02:30:45 PM'
```

## Numeric Functions

### Mathematical Operations
Basic arithmetic operations and mathematical functions.

```sql
SELECT ABS(-42); -- Output: 42
SELECT ROUND(42.4); -- Output: 42
SELECT ROUND(42.5); -- Output: 43
SELECT ROUND(42.4567, 2); -- Output: 42.46
SELECT CEIL(42.1); -- Output: 43
SELECT FLOOR(42.9); -- Output: 42
SELECT TRUNC(42.9); -- Output: 42
SELECT POWER(2, 3); -- Output: 8
SELECT SQRT(25); -- Output: 5
```

### Random Numbers
Generate random values.

```sql
-- Random value between 0 and 1
SELECT RANDOM(); -- Output: a value between 0 and 1

-- Random integer between 1 and 100
SELECT FLOOR(RANDOM() * 100) + 1; -- Output: a value between 1 and 100
```

## Aggregate Functions

### COUNT, SUM, AVG, MIN, and MAX
Basic aggregate functions for data analysis.

```sql
-- Assuming a table named 'orders' with columns 'order_id', 'amount', etc.
SELECT 
    COUNT(*) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    SUM(amount) AS total_amount,
    AVG(amount) AS average_amount,
    MIN(amount) AS minimum_amount,
    MAX(amount) AS maximum_amount
FROM orders;
```

### Statistical Aggregates
Functions for statistical analysis.

```sql
SELECT 
    STDDEV(amount) AS standard_deviation,
    VARIANCE(amount) AS variance,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY amount) AS median
FROM orders;
```

### STRING_AGG
Concatenates string values with a separator.

```sql
-- Concatenate all customer names with a comma separator
SELECT STRING_AGG(customer_name, ', ') FROM customers;

-- Concatenate with ordering
SELECT STRING_AGG(customer_name, ', ' ORDER BY created_at) FROM customers;
```

### ARRAY_AGG
Aggregates values into an array.

```sql
-- Create an array of product IDs ordered by a customer
SELECT 
    customer_id,
    ARRAY_AGG(product_id ORDER BY order_date) AS ordered_products
FROM orders
GROUP BY customer_id;
```

## Conditional Expressions

### CASE
Implements if-then-else logic.

```sql
-- Simple CASE expression
SELECT 
    product_name,
    CASE category
        WHEN 'Electronics' THEN 'Tech'
        WHEN 'Clothing' THEN 'Apparel'
        ELSE 'Other'
    END AS simplified_category
FROM products;

-- Searched CASE expression
SELECT 
    order_id,
    CASE 
        WHEN amount < 50 THEN 'Small'
        WHEN amount BETWEEN 50 AND 200 THEN 'Medium'
        ELSE 'Large'
    END AS order_size
FROM orders;
```

### COALESCE
Returns the first non-NULL value in a list.

```sql
-- Replace NULL with a default value
SELECT COALESCE(shipping_address, billing_address, 'No address provided') FROM customers;

-- Use in calculations to handle NULLs
SELECT product_name, COALESCE(discount, 0) * price AS discount_amount FROM products;
```

### NULLIF
Returns NULL if the two specified expressions are equal.

```sql
-- Avoid division by zero
SELECT 
    amount / NULLIF(quantity, 0) AS unit_price
FROM order_items;
```

### GREATEST and LEAST
Return the largest or smallest value from a list of expressions.

```sql
SELECT GREATEST(10, 20, 30); -- Output: 30
SELECT LEAST(10, 20, 30); -- Output: 10

-- Use with columns
SELECT 
    order_id,
    GREATEST(standard_delivery_date, express_delivery_date) AS latest_possible_delivery
FROM shipments;
```

## JSON Functions

### JSON Creation and Extraction
Create and manipulate JSON data.

```sql
-- Create a JSON object
SELECT JSON_BUILD_OBJECT('name', 'John', 'age', 30); -- Output: {"name": "John", "age": 30}

-- Extract a field from a JSON object
SELECT customer_data->'name' FROM customers; -- Returns the name as JSON
SELECT customer_data->>'name' FROM customers; -- Returns the name as text

-- Extract a nested field
SELECT customer_data->'address'->>'city' FROM customers;
```

### JSON Arrays
Work with JSON arrays.

```sql
-- Create a JSON array
SELECT JSON_BUILD_ARRAY(1, 2, 3, 'text'); -- Output: [1, 2, 3, "text"]

-- Extract an element from a JSON array
SELECT product_tags->0 FROM products; -- First element as JSON
SELECT product_tags->>0 FROM products; -- First element as text
```

### JSON_EACH and JSON_ARRAY_ELEMENTS
Expand JSON objects and arrays.

```sql
-- Expand a JSON object into key-value pairs
SELECT * FROM JSON_EACH('{"name": "John", "age": 30}');

-- Expand a JSON array into rows
SELECT * FROM JSON_ARRAY_ELEMENTS('[1, 2, 3, 4]');
```

## Type Conversion Functions

### CAST and :: Operator
Convert values from one data type to another.

```sql
-- Using CAST
SELECT CAST('42' AS INTEGER); -- Output: 42
SELECT CAST(42 AS TEXT); -- Output: '42'

-- Using :: operator (PostgreSQL-specific syntax)
SELECT '42'::INTEGER; -- Output: 42
SELECT 42::TEXT; -- Output: '42'

-- Date conversions
SELECT CAST('2025-03-12' AS DATE); -- Output: 2025-03-12
SELECT '2025-03-12'::DATE; -- Output: 2025-03-12
```

### TO_NUMBER, TO_CHAR, TO_DATE, and TO_TIMESTAMP
Format-aware conversions.

```sql
-- String to number with format
SELECT TO_NUMBER('1,234.56', '9,999.99'); -- Output: 1234.56

-- Number to string with format
SELECT TO_CHAR(1234.56, '9,999.99'); -- Output: ' 1,234.56'

-- String to date with format
SELECT TO_DATE('12-Mar-2025', 'DD-Mon-YYYY'); -- Output: 2025-03-12

-- String to timestamp with format
SELECT TO_TIMESTAMP('12-Mar-2025 14:30:45', 'DD-Mon-YYYY HH24:MI:SS'); -- Output: 2025-03-12 14:30:45
```

## Best Practices

1. **Choose the Right Function**: Select functions that match your specific needs to avoid unnecessary transformations.

2. **Index Considerations**: Be aware that using functions on indexed columns in WHERE clauses can prevent index usage. Consider creating functional indexes when necessary.

3. **Performance**: Complex functions or operations on large datasets may impact performance. Test and optimize queries with large data volumes.

4. **NULL Handling**: Always consider how your functions handle NULL values and use COALESCE or NULLIF when needed.

5. **Type Safety**: Ensure proper type casting to avoid unexpected results or errors.

6. **Version Compatibility**: Some functions may vary across PostgreSQL versions. Check the documentation for your specific version.

---

These functions form the backbone of PostgreSQL data manipulation capabilities. By mastering them, you'll be able to transform, analyze, and extract insights from your data more effectively.

# PostgreSQL Joins and Relationships

Joins are powerful SQL operations that connect data between different tables in a relational database. They're a fundamental concept in relational database design and allow you to retrieve related data from multiple tables in a single query.

## Understanding Table Relationships

Before diving into joins, it's important to understand the types of relationships between tables:

1. **One-to-One**: Each row in Table A relates to exactly one row in Table B.
   - Example: A student and their student ID card

2. **One-to-Many**: Each row in Table A relates to multiple rows in Table B.
   - Example: A course and its enrollments

3. **Many-to-Many**: Each row in Table A relates to multiple rows in Table B, and vice versa.
   - Example: Students and courses (a student takes many courses, and a course has many students)

In relational databases, these relationships are typically implemented using foreign keys.

## Types of Joins

PostgreSQL supports various types of joins, each serving different purposes:

### INNER JOIN

An inner join returns rows only when there's a match in both tables. It's the most common join type.

```sql
SELECT students.first_name, students.last_name, courses.course_name
FROM students
INNER JOIN enrollments ON students.student_id = enrollments.student_id
INNER JOIN courses ON enrollments.course_id = courses.course_id;
```

You can simplify this by using table aliases:

```sql
SELECT s.first_name, s.last_name, c.course_name
FROM students s
INNER JOIN enrollments e ON s.student_id = e.student_id
INNER JOIN courses c ON e.course_id = c.course_id;
```

Visual representation of INNER JOIN:
```
Table A    Table B
  1          1     ← These rows are returned
  2          2     ← These rows are returned
  3                 (No match, not returned)
              4     (No match, not returned)
```

### LEFT JOIN (or LEFT OUTER JOIN)

A left join returns all rows from the left table and matching rows from the right table. When there's no match, NULL values are used for columns from the right table.

```sql
SELECT s.first_name, s.last_name, c.course_name
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN courses c ON e.course_id = c.course_id;
```

This returns all students, even those not enrolled in any courses (their course_name will be NULL).

Visual representation of LEFT JOIN:
```
Table A    Table B
  1          1     ← Match, returned with values from both tables
  2          2     ← Match, returned with values from both tables
  3                 ← No match, returned with NULLs for Table B columns
              4     (Not included)
```

### RIGHT JOIN (or RIGHT OUTER JOIN)

A right join is the opposite of a left join. It returns all rows from the right table and matching rows from the left table.

```sql
SELECT s.first_name, s.last_name, c.course_name
FROM students s
RIGHT JOIN enrollments e ON s.student_id = e.student_id
RIGHT JOIN courses c ON e.course_id = c.course_id;
```

This returns all courses, even those without student enrollments.

Visual representation of RIGHT JOIN:
```
Table A    Table B
  1          1     ← Match, returned with values from both tables
  2          2     ← Match, returned with values from both tables
                4  ← No match, returned with NULLs for Table A columns
  3                 (Not included)
```

### FULL JOIN (or FULL OUTER JOIN)

A full join returns all rows when there's a match in either the left or right table. It combines the results of both LEFT and RIGHT joins.

```sql
SELECT s.first_name, s.last_name, c.course_name
FROM students s
FULL JOIN enrollments e ON s.student_id = e.student_id
FULL JOIN courses c ON e.course_id = c.course_id;
```

This includes all students and all courses, regardless of whether there are enrollments connecting them.

Visual representation of FULL JOIN:
```
Table A    Table B
  1          1     ← Match, returned with values from both tables
  2          2     ← Match, returned with values from both tables
  3                 ← No match, returned with NULLs for Table B columns
              4     ← No match, returned with NULLs for Table A columns
```

### CROSS JOIN

A cross join creates a Cartesian product, combining each row from the first table with every row from the second table. No join condition is needed.

```sql
SELECT s.first_name, c.course_name
FROM students s
CROSS JOIN courses c;
```

If students has 10 rows and courses has 5 rows, the result will have 50 rows.

Visual representation of CROSS JOIN:
```
Table A    Table B    Result
  1          A         1,A
  1          B         1,B
  2          A         2,A
  2          B         2,B
```

### SELF JOIN

A self join is when a table is joined with itself. This is useful for hierarchical or related data within the same table.

```sql
-- Find all pairs of students from the same city
SELECT s1.first_name AS student1, s2.first_name AS student2, s1.city
FROM students s1
JOIN students s2 ON s1.city = s2.city AND s1.student_id < s2.student_id;
```

The `s1.student_id < s2.student_id` condition prevents duplicate pairs and self-matches.

### NATURAL JOIN

A natural join automatically joins tables based on columns with the same name. While convenient, it can be unpredictable if tables share column names that aren't intended for joining.

```sql
SELECT * FROM students NATURAL JOIN student_details;
```

This automatically joins on all columns with the same name in both tables.

## Join Syntax Variations

### Traditional Join Syntax

The syntax shown above uses the modern ANSI SQL join syntax. An older syntax puts the join conditions in the WHERE clause:

```sql
-- Modern syntax
SELECT s.first_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

-- Older syntax
SELECT s.first_name, c.course_name
FROM students s, enrollments e, courses c
WHERE s.student_id = e.student_id
AND e.course_id = c.course_id;
```

The modern syntax is preferred because it clearly separates join conditions from filtering conditions.

### USING Clause

When join columns have the same name, you can use the USING clause to simplify:

```sql
-- With ON clause
SELECT students.first_name, courses.course_name
FROM students
JOIN enrollments ON students.student_id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.course_id;

-- With USING clause
SELECT students.first_name, courses.course_name
FROM students
JOIN enrollments USING (student_id)
JOIN courses USING (course_id);
```

The USING clause works only when the join columns have identical names.

## Advanced Join Techniques

### Joining with Additional Conditions

You can add extra conditions to your join to filter relationships:

```sql
SELECT s.first_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
  AND e.enrollment_date > '2023-01-01'
JOIN courses c ON e.course_id = c.course_id;
```

### Multiple Join Paths

You can join the same table multiple times to explore different relationships:

```sql
-- Find courses that share prerequisites
SELECT c1.course_name AS course, c2.course_name AS shares_prereq_with
FROM courses c1
JOIN course_prerequisites cp1 ON c1.course_id = cp1.course_id
JOIN course_prerequisites cp2 ON cp1.prerequisite_id = cp2.prerequisite_id
JOIN courses c2 ON cp2.course_id = c2.course_id
WHERE c1.course_id < c2.course_id;
```

### Lateral Joins

PostgreSQL supports LATERAL joins, which allow the right-hand side of the join to reference columns from tables on the left:

```sql
-- For each student, find their top 3 highest grades
SELECT s.first_name, s.last_name, c.course_name, e.grade
FROM students s
CROSS JOIN LATERAL (
    SELECT c.course_name, e.grade
    FROM enrollments e
    JOIN courses c ON e.course_id = c.course_id
    WHERE e.student_id = s.student_id
    ORDER BY e.grade DESC
    LIMIT 3
) AS c;
```

This is powerful for correlated subqueries that need access to the outer table.

### Non-Equi Joins

Not all joins are based on equality conditions. For example:

```sql
-- Match students with courses appropriate for their grade level
SELECT s.first_name, c.course_name
FROM students s
JOIN courses c ON s.grade_level BETWEEN c.min_grade_level AND c.max_grade_level;
```

### Full Text Search Joins

PostgreSQL supports full-text search, which can be used in joins:

```sql
SELECT s.first_name, s.last_name, d.document_title
FROM students s
JOIN documents d ON to_tsvector(d.document_text) @@ to_tsquery(s.first_name);
```

This would find documents containing students' first names.

## Join Performance Considerations

Joins can impact query performance, especially with large tables:

1. **Indexing**: Ensure joined columns are properly indexed.

2. **Join Order**: PostgreSQL's query planner generally optimizes join order, but sometimes explicit ordering through CTEs or subqueries can help.

3. **Statistics**: Keep your database statistics updated (`ANALYZE` command) to help the query planner make good decisions.

4. **Query Analysis**: Use `EXPLAIN` or `EXPLAIN ANALYZE` to understand how joins are executed.

```sql
EXPLAIN ANALYZE
SELECT s.first_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;
```

## Common Join Problems and Solutions

### Duplicate Rows

Joining tables with one-to-many relationships can produce duplicate rows:

```sql
-- May produce duplicates if a student has multiple enrollments
SELECT s.first_name, s.last_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id;
```

Solution: Use DISTINCT or GROUP BY:

```sql
SELECT DISTINCT s.first_name, s.last_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id;
```

### Missing Rows

If you're missing expected rows, check that you're using the right join type. An INNER JOIN might exclude rows that a LEFT JOIN would include.

### Slow Joins

For slow joins:
1. Ensure joined columns are indexed
2. Consider denormalizing if appropriate
3. Use `EXPLAIN ANALYZE` to identify bottlenecks
4. Consider partitioning large tables
5. Filter data early in the query to reduce join size

## Real-World Join Examples

### Hierarchical Data with Recursive Joins

For organizational charts or categories:

```sql
WITH RECURSIVE employee_hierarchy AS (
  -- Base case: top-level employees (no manager)
  SELECT employee_id, name, manager_id, 0 AS level
  FROM employees
  WHERE manager_id IS NULL
  
  UNION ALL
  
  -- Recursive case: employees with managers
  SELECT e.employee_id, e.name, e.manager_id, eh.level + 1
  FROM employees e
  JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy ORDER BY level, name;
```

### Aggregating Related Data

```sql
-- For each student, count enrollments and calculate GPA
SELECT 
    s.student_id,
    s.first_name,
    s.last_name,
    COUNT(e.enrollment_id) AS num_courses,
    AVG(e.grade) AS gpa
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.first_name, s.last_name;
```

### Finding Unmatched Records

```sql
-- Find students with no enrollments
SELECT s.*
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
WHERE e.enrollment_id IS NULL;
```

### Many-to-Many Relationship

Many-to-many relationships typically use a junction table:

```sql
-- Find all students in a specific course
SELECT s.first_name, s.last_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_code = 'CS101';
```

## Summary

Joins are essential for working with relational data across multiple tables. PostgreSQL offers a rich set of join types and capabilities to handle various relationship scenarios. Understanding when to use each type of join and how to optimize their performance will significantly enhance your ability to work effectively with relational databases.

# PostgreSQL: Views, CTEs, and Stored Procedures

## Table of Contents
- [Introduction](#introduction)
- [SQL Views](#sql-views)
  - [Creating Views](#creating-views)
  - [Materialized Views](#materialized-views)
  - [Updating Views](#updating-views)
  - [View Best Practices](#view-best-practices)
- [Common Table Expressions (CTEs)](#common-table-expressions-ctes)
  - [Basic CTE Syntax](#basic-cte-syntax)
  - [Recursive CTEs](#recursive-ctes)
  - [Modifying Data with CTEs](#modifying-data-with-ctes)
  - [CTE vs Subqueries](#cte-vs-subqueries)
- [Stored Procedures](#stored-procedures)
  - [Creating Stored Procedures](#creating-stored-procedures)
  - [Stored Procedures vs Functions](#stored-procedures-vs-functions)
  - [Transaction Management](#transaction-management)
  - [Error Handling](#error-handling)
- [Practical Examples](#practical-examples)

## Introduction

PostgreSQL is a powerful open-source object-relational database system with over 35 years of active development. It has earned a strong reputation for reliability, feature robustness, and performance. This document explores three crucial PostgreSQL features that help manage complex queries and database operations: views, common table expressions (CTEs), and stored procedures.

## SQL Views

A view in PostgreSQL is a virtual table representing the result of a stored query. Views don't store data themselves but provide a way to encapsulate complex queries and present them as if they were tables.

### Creating Views

The basic syntax for creating a view is:

```sql
CREATE [OR REPLACE] VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;
```

Let's create a sample database to work with:

```sql
-- Create sample tables
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    amount DECIMAL(10, 2),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO customers (name, email) VALUES 
('John Doe', 'john@example.com'),
('Jane Smith', 'jane@example.com'),
('Michael Johnson', 'michael@example.com');

INSERT INTO orders (customer_id, amount) VALUES 
(1, 150.50),
(2, 245.75),
(1, 50.25),
(3, 300.00),
(2, 125.40);
```

Now, let's create a simple view that joins these tables:

```sql
CREATE VIEW customer_orders AS
SELECT 
    c.customer_id,
    c.name,
    c.email,
    o.order_id,
    o.amount,
    o.order_date
FROM 
    customers c
JOIN 
    orders o ON c.customer_id = o.customer_id;
```

After creating this view, you can query it like a regular table:

```sql
SELECT * FROM customer_orders;
SELECT name, SUM(amount) FROM customer_orders GROUP BY name;
```

### Materialized Views

Unlike regular views, materialized views physically store the result set. This can significantly improve performance for complex queries, especially those involving aggregations or joins, at the cost of data freshness.

```sql
CREATE MATERIALIZED VIEW customer_order_summary AS
SELECT 
    c.customer_id,
    c.name,
    COUNT(o.order_id) AS order_count,
    SUM(o.amount) AS total_spend
FROM 
    customers c
LEFT JOIN 
    orders o ON c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.name;
```

Materialized views need to be manually refreshed to update their data:

```sql
REFRESH MATERIALIZED VIEW customer_order_summary;

-- With CONCURRENTLY option (requires unique index)
CREATE UNIQUE INDEX customer_id_idx ON customer_order_summary (customer_id);
REFRESH MATERIALIZED VIEW CONCURRENTLY customer_order_summary;
```

### Updating Views

In PostgreSQL, some views are automatically updatable if they meet certain conditions:
- The view must not contain WITH, DISTINCT, GROUP BY, HAVING, LIMIT, or OFFSET clauses
- The view must not use set operations (UNION, INTERSECT, EXCEPT)
- The FROM list must contain exactly one entry which must be a table

Example of an updatable view:

```sql
CREATE VIEW high_value_customers AS
SELECT customer_id, name, email
FROM customers
WHERE customer_id IN (
    SELECT customer_id FROM orders WHERE amount > 200
);

-- This works because the view meets updatable criteria
UPDATE high_value_customers SET email = 'michael.new@example.com' WHERE customer_id = 3;
```

For more complex views, you can define INSTEAD OF triggers to handle updates:

```sql
CREATE OR REPLACE FUNCTION update_customer_orders()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE customers SET name = NEW.name, email = NEW.email
    WHERE customer_id = NEW.customer_id;
    
    UPDATE orders SET amount = NEW.amount
    WHERE order_id = NEW.order_id;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER customer_orders_update
INSTEAD OF UPDATE ON customer_orders
FOR EACH ROW EXECUTE FUNCTION update_customer_orders();
```

### View Best Practices

1. **Use descriptive names** that indicate the purpose of the view
2. **Document views** with comments:
   ```sql
   COMMENT ON VIEW customer_orders IS 'Joins customers and their orders for reporting';
   ```
3. **Consider performance implications** for views joining multiple large tables
4. **Use materialized views** for expensive computations that don't need real-time data
5. **Create indexes on materialized views** to speed up queries

## Common Table Expressions (CTEs)

Common Table Expressions (CTEs) provide a way to write auxiliary statements for use in a larger query. Think of them as temporary result sets or views that exist only for the duration of the query.

### Basic CTE Syntax

The basic syntax for a CTE is:

```sql
WITH cte_name AS (
    SELECT ...
)
SELECT * FROM cte_name;
```

A simple example:

```sql
WITH customer_spending AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_spent
    FROM 
        orders
    GROUP BY 
        customer_id
)
SELECT 
    c.name,
    COALESCE(cs.total_spent, 0) AS total_spent
FROM 
    customers c
LEFT JOIN 
    customer_spending cs ON c.customer_id = cs.customer_id
ORDER BY 
    total_spent DESC;
```

You can also define multiple CTEs in a single query:

```sql
WITH order_stats AS (
    SELECT 
        customer_id,
        COUNT(*) AS order_count,
        SUM(amount) AS total_spent,
        AVG(amount) AS avg_order_value
    FROM 
        orders
    GROUP BY 
        customer_id
),
customer_categories AS (
    SELECT 
        customer_id,
        CASE 
            WHEN total_spent > 300 THEN 'Premium'
            WHEN total_spent > 100 THEN 'Regular'
            ELSE 'Basic'
        END AS category
    FROM 
        order_stats
)
SELECT 
    c.name,
    os.order_count,
    os.total_spent,
    os.avg_order_value,
    cc.category
FROM 
    customers c
JOIN 
    order_stats os ON c.customer_id = os.customer_id
JOIN 
    customer_categories cc ON c.customer_id = cc.customer_id;
```

### Recursive CTEs

One of the most powerful features of CTEs is recursion, which allows you to solve hierarchical or graph-traversal problems:

```sql
-- Create a table for hierarchical data
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    manager_id INT REFERENCES employees(employee_id)
);

-- Insert sample data
INSERT INTO employees (employee_id, name, manager_id) VALUES 
(1, 'CEO', NULL),
(2, 'CTO', 1),
(3, 'CFO', 1),
(4, 'Lead Developer', 2),
(5, 'Developer 1', 4),
(6, 'Developer 2', 4),
(7, 'Accountant', 3);

-- Recursive CTE to traverse the hierarchy
WITH RECURSIVE org_hierarchy AS (
    -- Base case: employees with no manager (root)
    SELECT 
        employee_id, 
        name, 
        manager_id, 
        0 AS level,
        name AS path
    FROM 
        employees
    WHERE 
        manager_id IS NULL
    
    UNION ALL
    
    -- Recursive case: find employees managed by previous iteration
    SELECT 
        e.employee_id, 
        e.name, 
        e.manager_id, 
        oh.level + 1,
        oh.path || ' > ' || e.name
    FROM 
        employees e
    JOIN 
        org_hierarchy oh ON e.manager_id = oh.employee_id
)
SELECT 
    employee_id,
    level,
    REPEAT('  ', level) || name AS employee,
    path
FROM 
    org_hierarchy
ORDER BY 
    path;
```

### Modifying Data with CTEs

CTEs can be used for data modification (INSERT, UPDATE, DELETE) operations:

```sql
-- Update customer emails based on certain conditions
WITH customers_to_update AS (
    SELECT 
        customer_id,
        REPLACE(email, '@example.com', '@newdomain.com') AS new_email
    FROM 
        customers
    WHERE 
        email LIKE '%@example.com'
)
UPDATE customers c
SET email = ctu.new_email
FROM customers_to_update ctu
WHERE c.customer_id = ctu.customer_id;

-- Delete orders and return information about deleted records
WITH deleted_orders AS (
    DELETE FROM orders
    WHERE amount < 100
    RETURNING *
)
SELECT 
    customer_id,
    COUNT(*) AS small_orders_removed,
    SUM(amount) AS total_removed
FROM 
    deleted_orders
GROUP BY 
    customer_id;
```

### CTE vs Subqueries

While subqueries can often achieve the same result as CTEs, CTEs offer several advantages:

1. **Improved readability**: CTEs make complex queries more readable by breaking them into named blocks
2. **Reusability within the query**: A CTE can be referenced multiple times in the same query
3. **Recursion**: Only CTEs support recursive queries
4. **Optimization**: The PostgreSQL optimizer may handle CTEs differently from subqueries

Example comparing CTE vs subquery approach:

```sql
-- Using a CTE
WITH high_value_orders AS (
    SELECT customer_id, COUNT(*) AS order_count
    FROM orders
    WHERE amount > 200
    GROUP BY customer_id
)
SELECT 
    c.name,
    COALESCE(hvo.order_count, 0) AS high_value_orders
FROM 
    customers c
LEFT JOIN 
    high_value_orders hvo ON c.customer_id = hvo.customer_id;

-- Using a subquery
SELECT 
    c.name,
    COALESCE(
        (SELECT COUNT(*) 
         FROM orders 
         WHERE customer_id = c.customer_id AND amount > 200
        ), 0
    ) AS high_value_orders
FROM 
    customers c;
```

## Stored Procedures

Stored procedures in PostgreSQL are database objects containing a set of SQL statements that can be executed as a single unit. PostgreSQL added proper stored procedure support in version 11 with the introduction of `CREATE PROCEDURE`.

### Creating Stored Procedures

Basic syntax for creating a stored procedure:

```sql
CREATE [OR REPLACE] PROCEDURE procedure_name(parameter_list)
LANGUAGE language_name
AS $$
  -- procedure body
$$;
```

Let's create a simple stored procedure:

```sql
CREATE OR REPLACE PROCEDURE create_new_customer(
    p_name VARCHAR,
    p_email VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO customers (name, email)
    VALUES (p_name, p_email);
    
    COMMIT;
END;
$$;

-- Call the procedure
CALL create_new_customer('Alice Brown', 'alice@example.com');
```

A more complex procedure with transaction management:

```sql
CREATE OR REPLACE PROCEDURE place_order(
    p_customer_id INT,
    p_amount DECIMAL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_exists BOOLEAN;
BEGIN
    -- Check if customer exists
    SELECT EXISTS(SELECT 1 FROM customers WHERE customer_id = p_customer_id) INTO v_customer_exists;
    
    IF NOT v_customer_exists THEN
        RAISE EXCEPTION 'Customer with ID % does not exist', p_customer_id;
    END IF;
    
    -- Insert new order
    INSERT INTO orders (customer_id, amount)
    VALUES (p_customer_id, p_amount);
    
    -- If we get here, commit the transaction
    COMMIT;
END;
$$;

-- Call the procedure
CALL place_order(1, 75.25);
```

### Stored Procedures vs Functions

PostgreSQL has both stored procedures and functions. The key differences are:

1. **Transaction control**: Procedures can manage transactions (`COMMIT`, `ROLLBACK`), functions cannot
2. **Return values**: Functions must return a value, procedures don't have to
3. **Calling syntax**: Use `CALL` for procedures, `SELECT` for functions
4. **Usage context**: Functions can be used in queries, procedures cannot

Example of a function vs procedure:

```sql
-- Function (returns total orders for a customer)
CREATE OR REPLACE FUNCTION get_customer_order_count(p_customer_id INT)
RETURNS INT
LANGUAGE plpgsql
AS $$
DECLARE
    v_count INT;
BEGIN
    SELECT COUNT(*) INTO v_count
    FROM orders
    WHERE customer_id = p_customer_id;
    
    RETURN v_count;
END;
$$;

-- Call the function
SELECT get_customer_order_count(1);

-- Procedure (processes a return for an order)
CREATE OR REPLACE PROCEDURE process_order_return(
    p_order_id INT,
    p_refund_amount DECIMAL DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_order_exists BOOLEAN;
    v_order_amount DECIMAL;
BEGIN
    -- Check if order exists
    SELECT 
        EXISTS(SELECT 1 FROM orders WHERE order_id = p_order_id),
        amount
    INTO 
        v_order_exists, v_order_amount
    FROM 
        orders
    WHERE 
        order_id = p_order_id;
    
    IF NOT v_order_exists THEN
        RAISE EXCEPTION 'Order with ID % does not exist', p_order_id;
    END IF;
    
    -- If refund amount not specified, use full order amount
    IF p_refund_amount IS NULL THEN
        p_refund_amount := v_order_amount;
    END IF;
    
    -- Create a record of the return (in a real system)
    RAISE NOTICE 'Processing return for order % with refund amount %', p_order_id, p_refund_amount;
    
    -- We could update the order status here
    -- UPDATE orders SET status = 'RETURNED' WHERE order_id = p_order_id;
    
    COMMIT;
END;
$$;

-- Call the procedure
CALL process_order_return(1);
CALL process_order_return(2, 100.00);
```

### Transaction Management

One of the primary benefits of stored procedures is transaction management:

```sql
CREATE OR REPLACE PROCEDURE transfer_funds(
    p_from_account INT,
    p_to_account INT,
    p_amount DECIMAL
)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Start a transaction block
    BEGIN
        -- Deduct from source account
        UPDATE accounts SET balance = balance - p_amount
        WHERE account_id = p_from_account;
        
        -- Add to destination account
        UPDATE accounts SET balance = balance + p_amount
        WHERE account_id = p_to_account;
        
        -- Check for sufficient funds
        IF (SELECT balance FROM accounts WHERE account_id = p_from_account) < 0 THEN
            RAISE EXCEPTION 'Insufficient funds';
        END IF;
        
        -- If we get here, commit the transaction
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            -- If any error occurs, roll back the transaction
            ROLLBACK;
            RAISE;
    END;
END;
$$;
```

### Error Handling

Effective error handling in stored procedures:

```sql
CREATE OR REPLACE PROCEDURE bulk_insert_orders(
    p_customer_id INT,
    p_amounts DECIMAL[]
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_amount DECIMAL;
    v_order_id INT;
    v_success_count INT := 0;
    v_error_count INT := 0;
BEGIN
    -- Start a transaction
    BEGIN
        -- Check if customer exists
        IF NOT EXISTS (SELECT 1 FROM customers WHERE customer_id = p_customer_id) THEN
            RAISE EXCEPTION 'Customer with ID % does not exist', p_customer_id;
        END IF;
        
        -- Process each amount
        FOREACH v_amount IN ARRAY p_amounts LOOP
            BEGIN
                IF v_amount <= 0 THEN
                    RAISE EXCEPTION 'Order amount must be positive';
                END IF;
                
                INSERT INTO orders (customer_id, amount)
                VALUES (p_customer_id, v_amount)
                RETURNING order_id INTO v_order_id;
                
                v_success_count := v_success_count + 1;
                RAISE NOTICE 'Created order % with amount %', v_order_id, v_amount;
                
            EXCEPTION
                WHEN OTHERS THEN
                    v_error_count := v_error_count + 1;
                    RAISE WARNING 'Failed to create order with amount %: %', v_amount, SQLERRM;
                    -- Continue with next order
            END;
        END LOOP;
        
        RAISE NOTICE 'Processed % orders: % successful, % failed', 
            array_length(p_amounts, 1), v_success_count, v_error_count;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE;
    END;
END;
$$;

-- Call the procedure
CALL bulk_insert_orders(1, ARRAY[50.00, -10.00, 75.50, 100.00]);
```

## Practical Examples

### Example 1: Sales Report Generation

A complete example combining views, CTEs, and a stored procedure:

```sql
-- Create additional tables for a more complete example
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category VARCHAR(50)
);

CREATE TABLE order_items (
    item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id),
    product_id INT REFERENCES products(product_id),
    quantity INT,
    price DECIMAL(10, 2)
);

-- Insert sample data
INSERT INTO products (name, price, category) VALUES 
('Laptop', 1200.00, 'Electronics'),
('Smartphone', 800.00, 'Electronics'),
('Desk Chair', 150.00, 'Furniture'),
('Coffee Table', 250.00, 'Furniture'),
('Headphones', 100.00, 'Electronics');

INSERT INTO order_items (order_id, product_id, quantity, price) VALUES 
(1, 1, 1, 1200.00),
(2, 2, 1, 800.00),
(2, 5, 1, 100.00),
(3, 3, 2, 150.00),
(4, 4, 1, 250.00),
(4, 5, 2, 100.00),
(5, 2, 1, 800.00);

-- Create a view for order details
CREATE OR REPLACE VIEW order_details AS
SELECT 
    o.order_id,
    o.order_date,
    c.customer_id,
    c.name AS customer_name,
    oi.item_id,
    p.product_id,
    p.name AS product_name,
    p.category,
    oi.quantity,
    oi.price,
    (oi.quantity * oi.price) AS item_total
FROM 
    orders o
JOIN 
    customers c ON o.customer_id = c.customer_id
JOIN 
    order_items oi ON o.order_id = oi.order_id
JOIN 
    products p ON oi.product_id = p.product_id;

-- Create a materialized view for category performance
CREATE MATERIALIZED VIEW category_performance AS
WITH category_sales AS (
    SELECT 
        category,
        COUNT(DISTINCT order_id) AS order_count,
        COUNT(*) AS item_count,
        SUM(quantity) AS units_sold,
        SUM(item_total) AS total_sales
    FROM 
        order_details
    GROUP BY 
        category
)
SELECT 
    category,
    order_count,
    item_count,
    units_sold,
    total_sales,
    ROUND(total_sales / units_sold, 2) AS avg_unit_price,
    ROUND((total_sales / (SELECT SUM(total_sales) FROM category_sales)) * 100, 2) AS sales_percentage
FROM 
    category_sales
ORDER BY 
    total_sales DESC;

-- Create a stored procedure to generate sales reports
CREATE OR REPLACE PROCEDURE generate_sales_report(
    p_start_date TIMESTAMP,
    p_end_date TIMESTAMP,
    p_include_details BOOLEAN DEFAULT FALSE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_report_id INT;
    v_total_sales DECIMAL;
    v_order_count INT;
    v_customer_count INT;
BEGIN
    -- Check date range
    IF p_start_date >= p_end_date THEN
        RAISE EXCEPTION 'Start date must be before end date';
    END IF;
    
    -- Calculate summary statistics
    WITH date_range_sales AS (
        SELECT 
            *
        FROM 
            order_details
        WHERE 
            order_date BETWEEN p_start_date AND p_end_date
    )
    SELECT 
        COUNT(DISTINCT order_id),
        COUNT(DISTINCT customer_id),
        SUM(item_total)
    INTO 
        v_order_count, v_customer_count, v_total_sales
    FROM 
        date_range_sales;
    
    -- Print summary
    RAISE NOTICE 'Sales Report: % to %', p_start_date, p_end_date;
    RAISE NOTICE 'Total Sales: $%', v_total_sales;
    RAISE NOTICE 'Order Count: %', v_order_count;
    RAISE NOTICE 'Customer Count: %', v_customer_count;
    
    -- Category breakdown
    RAISE NOTICE 'Category Breakdown:';
    FOR rec IN (
        WITH date_range_sales AS (
            SELECT 
                *
            FROM 
                order_details
            WHERE 
                order_date BETWEEN p_start_date AND p_end_date
        )
        SELECT 
            category,
            SUM(item_total) AS category_sales,
            ROUND((SUM(item_total) / v_total_sales) * 100, 2) AS percentage
        FROM 
            date_range_sales
        GROUP BY 
            category
        ORDER BY 
            category_sales DESC
    ) LOOP
        RAISE NOTICE '  % - $% (% %%)', rec.category, rec.category_sales, rec.percentage;
    END LOOP;
    
    -- Detailed breakdown if requested
    IF p_include_details THEN
        RAISE NOTICE 'Top Products:';
        FOR rec IN (
            WITH date_range_sales AS (
                SELECT 
                    *
                FROM 
                    order_details
                WHERE 
                    order_date BETWEEN p_start_date AND p_end_date
            )
            SELECT 
                product_name,
                SUM(quantity) AS units_sold,
                SUM(item_total) AS product_sales
            FROM 
                date_range_sales
            GROUP BY 
                product_name
            ORDER BY 
                product_sales DESC
            LIMIT 5
        ) LOOP
            RAISE NOTICE '  % - % units - $%', rec.product_name, rec.units_sold, rec.product_sales;
        END LOOP;
        
        RAISE NOTICE 'Top Customers:';
        FOR rec IN (
            WITH date_range_sales AS (
                SELECT 
                    *
                FROM 
                    order_details
                WHERE 
                    order_date BETWEEN p_start_date AND p_end_date
            )
            SELECT 
                customer_name,
                COUNT(DISTINCT order_id) AS order_count,
                SUM(item_total) AS customer_sales
            FROM 
                date_range_sales
            GROUP BY 
                customer_name
            ORDER BY 
                customer_sales DESC
            LIMIT 5
        ) LOOP
            RAISE NOTICE '  % - % orders - $%', rec.customer_name, rec.order_count, rec.customer_sales;
        END LOOP;
    END IF;
    
    -- Commit (not strictly necessary in this case but good practice)
    COMMIT;
END;
$$;

-- Call the procedure
CALL generate_sales_report('2023-01-01', '2023-12-31', TRUE);
```

### Example 2: Data Maintenance Procedures

A set of procedures for database maintenance:

```sql
-- Procedure to archive old data
CREATE OR REPLACE PROCEDURE archive_old_orders(
    p_cutoff_date TIMESTAMP,
    p_dry_run BOOLEAN DEFAULT TRUE
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_order_count INT;
    v_item_count INT;
BEGIN
    -- Count records to be archived
    SELECT COUNT(*) INTO v_order_count
    FROM orders
    WHERE order_date < p_cutoff_date;
    
    SELECT COUNT(*) INTO v_item_count
    FROM order_items oi
    JOIN orders o ON oi.order_id = o.order_id
    WHERE o.order_date < p_cutoff_date;
    
    RAISE NOTICE 'Found % orders and % order items before %', 
        v_order_count, v_item_count, p_cutoff_date;
    
    IF p_dry_run THEN
        RAISE NOTICE 'DRY RUN ONLY - No changes made';
        RETURN;
    END IF;
    
    -- Create archive tables if they don't exist
    BEGIN
        EXECUTE '
        CREATE TABLE IF NOT EXISTS orders_archive (
            LIKE orders INCLUDING ALL
        )';
        
        EXECUTE '
        CREATE TABLE IF NOT EXISTS order_items_archive (
            LIKE order_items INCLUDING ALL
        )';
    EXCEPTION
        WHEN OTHERS THEN
            RAISE EXCEPTION 'Failed to create archive tables: %', SQLERRM;
    END;
    
    -- Start a transaction for the actual archiving
    BEGIN
        -- Archive order items first (to maintain referential integrity)
        INSERT INTO order_items_archive
        SELECT oi.*
        FROM order_items oi
        JOIN orders o ON oi.order_id = o.order_id
        WHERE o.order_date < p_cutoff_date;
        
        -- Then archive orders
        INSERT INTO orders_archive
        SELECT * FROM orders
        WHERE order_date < p_cutoff_date;
        
        -- Delete archived records (in reverse order to maintain referential integrity)
        DELETE FROM order_items
        WHERE order_id IN (
            SELECT order_id FROM orders WHERE order_date < p_cutoff_date
        );
        
        DELETE FROM orders
        WHERE order_date < p_cutoff_date;
        
        RAISE NOTICE 'Successfully archived % orders and % order items', 
            v_order_count, v_item_count;
        
        COMMIT;
    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            RAISE EXCEPTION 'Archiving failed: %', SQLERRM;
    END;
END;
$$;

-- Procedure to analyze database and update statistics
CREATE OR REPLACE PROCEDURE analyze_database(
    p_verbose BOOLEAN DEFAULT FALSE
)
LANGUAGE plpgsql
AS $$
DECLARE
    rec RECORD;
BEGIN
    FOR rec IN (
        SELECT table_schema, table_name
        FROM information_schema.tables
        WHERE table_schema NOT IN ('pg_catalog', 'information_schema')
        AND table_type = 'BASE TABLE'
        ORDER BY table_schema, table_name
    ) LOOP
        IF p_verbose THEN
            RAISE NOTICE 'Analyzing table %.%', rec.table_schema, rec.table_name;
        END IF;
        
        EXECUTE 'ANALYZE VERBOSE ' || quote_ident(rec.table_schema) || '.' || quote_ident(rec.table_name);
    END LOOP;
    
    RAISE NOTICE 'Database analysis complete.';
END;
$$;
```

These comprehensive examples demonstrate how views, CTEs, and stored procedures work together to provide powerful database management capabilities in PostgreSQL.