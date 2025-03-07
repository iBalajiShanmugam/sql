# Library Management System Database Project

## Business Requirements

You are tasked with designing a database for a public library management system. The library needs to track books, library members, book loans, and book categories. The system should be able to:

1. Store information about books including title, author, ISBN, publication date, and category
2. Maintain member information including name, address, phone number, and join date
3. Track book loans including which member borrowed which book, when it was borrowed, and when it was returned
4. Categorize books by genre and subject matter
5. Generate reports about overdue books and popular book categories

## ER Diagram Description

The database should consist of the following entities and relationships:

- **Books**: Contains information about each book in the library
- **Members**: Contains information about library members
- **Loans**: Represents the borrowing transaction between members and books
- **Categories**: Contains different book categories/genres
- **BookCategories**: A junction table that handles the many-to-many relationship between books and categories

Relationships:
- A Book can belong to multiple Categories (many-to-many)
- A Member can borrow multiple Books (one-to-many)
- A Book can be borrowed by multiple Members over time, but only one at a time (one-to-many)
- A Loan connects exactly one Book to one Member (many-to-one with both entities)

## Required Tasks

1. Create all necessary tables with appropriate columns and data types
2. Define primary keys and foreign keys to establish proper relationships
3. Add constraints where necessary (NOT NULL, UNIQUE, CHECK constraints)
4. Write queries to insert sample data
5. Write queries to update and delete data
6. Create queries to retrieve information from multiple tables using JOINs

## Solution

### Step 1: Create Database Tables

```sql
-- Create the Books table
CREATE TABLE Books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(100) NOT NULL,
    isbn VARCHAR(20) UNIQUE NOT NULL,
    publication_date DATE,
    total_copies INTEGER NOT NULL CHECK (total_copies >= 0),
    available_copies INTEGER NOT NULL CHECK (available_copies >= 0),
    CHECK (available_copies <= total_copies)
);

-- Create the Members table
CREATE TABLE Members (
    member_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    join_date DATE NOT NULL DEFAULT CURRENT_DATE,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
);

-- Create the Categories table
CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

-- Create the BookCategories junction table
CREATE TABLE BookCategories (
    book_id INTEGER REFERENCES Books(book_id) ON DELETE CASCADE,
    category_id INTEGER REFERENCES Categories(category_id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, category_id)
);

-- Create the Loans table
CREATE TABLE Loans (
    loan_id SERIAL PRIMARY KEY,
    book_id INTEGER REFERENCES Books(book_id) ON DELETE RESTRICT,
    member_id INTEGER REFERENCES Members(member_id) ON DELETE RESTRICT,
    loan_date DATE NOT NULL DEFAULT CURRENT_DATE,
    due_date DATE NOT NULL,
    return_date DATE,
    CHECK (return_date IS NULL OR return_date >= loan_date),
    CHECK (due_date >= loan_date)
);
```

### Step 2: Add Sample Data

```sql
-- Insert sample categories
INSERT INTO Categories (name, description) VALUES
('Fiction', 'Novels, short stories, and other fictional works'),
('Science Fiction', 'Books about futuristic technology, space exploration, etc.'),
('Mystery', 'Crime and detective novels'),
('Biography', 'Books about real people''s lives'),
('History', 'Books about historical events');

-- Insert sample books
INSERT INTO Books (title, author, isbn, publication_date, total_copies, available_copies) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', '1925-04-10', 5, 3),
('To Kill a Mockingbird', 'Harper Lee', '9780061120084', '1960-07-11', 7, 5),
('1984', 'George Orwell', '9780451524935', '1949-06-08', 10, 8),
('Pride and Prejudice', 'Jane Austen', '9780141439518', '1813-01-28', 4, 4),
('The Hobbit', 'J.R.R. Tolkien', '9780547928227', '1937-09-21', 6, 2);

-- Connect books to categories
INSERT INTO BookCategories (book_id, category_id) VALUES
(1, 1), -- The Great Gatsby - Fiction
(2, 1), -- To Kill a Mockingbird - Fiction
(3, 1), -- 1984 - Fiction
(3, 2), -- 1984 - Science Fiction
(4, 1), -- Pride and Prejudice - Fiction
(5, 1), -- The Hobbit - Fiction
(5, 2); -- The Hobbit - Science Fiction

-- Insert sample members
INSERT INTO Members (first_name, last_name, email, phone, address, join_date) VALUES
('John', 'Smith', 'john.smith@email.com', '555-123-4567', '123 Main St, Anytown', '2023-01-15'),
('Emma', 'Johnson', 'emma.j@email.com', '555-987-6543', '456 Oak Ave, Somewhere', '2023-02-20'),
('Michael', 'Williams', 'michael.w@email.com', '555-456-7890', '789 Pine Rd, Nowhere', '2023-03-10'),
('Sophia', 'Brown', 'sophia.b@email.com', '555-234-5678', '101 Elm St, Anywhere', '2023-04-05');

-- Insert sample loans
INSERT INTO Loans (book_id, member_id, loan_date, due_date, return_date) VALUES
(1, 1, '2023-06-01', '2023-06-15', '2023-06-14'),
(3, 1, '2023-06-20', '2023-07-04', NULL),
(2, 2, '2023-05-25', '2023-06-08', '2023-06-07'),
(5, 3, '2023-06-10', '2023-06-24', NULL),
(4, 4, '2023-05-15', '2023-05-29', '2023-05-27'),
(5, 2, '2023-05-01', '2023-05-15', '2023-05-12');
```

### Step 3: Alter Table Examples

```sql
-- Add a new column to the Books table
ALTER TABLE Books ADD COLUMN publisher VARCHAR(100);

-- Add a constraint to the Loans table
ALTER TABLE Loans ADD CONSTRAINT max_loan_period CHECK (due_date <= loan_date + INTERVAL '30 days');

-- Modify a column's data type
ALTER TABLE Members ALTER COLUMN phone TYPE VARCHAR(30);

-- Add a default value to an existing column
ALTER TABLE Books ALTER COLUMN publication_date SET DEFAULT '1900-01-01';

-- Rename a column
ALTER TABLE Members RENAME COLUMN address TO mailing_address;
```

### Step 4: Update Data

```sql
-- Update the publisher for some books
UPDATE Books SET publisher = 'Scribner' WHERE book_id = 1;
UPDATE Books SET publisher = 'HarperCollins' WHERE book_id = 2;
UPDATE Books SET publisher = 'Penguin Books' WHERE book_id = 3;
UPDATE Books SET publisher = 'Penguin Classics' WHERE book_id = 4;
UPDATE Books SET publisher = 'Houghton Mifflin Harcourt' WHERE book_id = 5;

-- Mark a book as returned
UPDATE Loans SET return_date = CURRENT_DATE WHERE loan_id = 3 AND return_date IS NULL;

-- Deactivate a member
UPDATE Members SET is_active = FALSE WHERE member_id = 2;

-- Decrease available copies when a book is loaned
UPDATE Books SET available_copies = available_copies - 1 WHERE book_id = 2;
```

### Step 5: Delete Data

```sql
-- Delete a category (this won't work if books are assigned to this category due to foreign key constraints)
DELETE FROM Categories WHERE category_id = 5;

-- Delete a book (this won't work if the book is currently on loan due to foreign key constraints)
DELETE FROM Books WHERE book_id = 4;

-- Delete all returned loans older than 1 year
DELETE FROM Loans WHERE return_date < (CURRENT_DATE - INTERVAL '1 year');
```

### Step 6: Complex Queries

```sql
-- Find all currently overdue books with borrower information
SELECT b.title, b.isbn, m.first_name, m.last_name, m.email, 
       l.loan_date, l.due_date, CURRENT_DATE - l.due_date AS days_overdue
FROM Loans l
JOIN Books b ON l.book_id = b.book_id
JOIN Members m ON l.member_id = m.member_id
WHERE l.return_date IS NULL AND l.due_date < CURRENT_DATE
ORDER BY days_overdue DESC;

-- Find the most popular book categories
SELECT c.name AS category, COUNT(l.loan_id) AS loan_count
FROM Categories c
JOIN BookCategories bc ON c.category_id = bc.category_id
JOIN Books b ON bc.book_id = b.book_id
JOIN Loans l ON b.book_id = l.book_id
GROUP BY c.name
ORDER BY loan_count DESC;

-- Find members who have never borrowed a book
SELECT m.member_id, m.first_name, m.last_name, m.email
FROM Members m
LEFT JOIN Loans l ON m.member_id = l.member_id
WHERE l.loan_id IS NULL;
```

### Step 7: Drop Tables

```sql
-- Drop all tables (in reverse order of dependencies)
DROP TABLE Loans;
DROP TABLE BookCategories;
DROP TABLE Books;
DROP TABLE Members;
DROP TABLE Categories;
```