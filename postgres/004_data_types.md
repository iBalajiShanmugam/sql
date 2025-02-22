# PostgreSQL Data Types

PostgreSQL provides a rich set of data types to handle different types of data efficiently. They can be broadly classified into the following categories:

## 1. Numeric Data Types
Used to store numerical values.

| Data Type  | Description | Example |
|------------|------------|---------|
| `SMALLINT` | Stores small-range integers (-32,768 to 32,767) | `SMALLINT 100` |
| `INTEGER` (`INT`) | Stores standard integers (-2,147,483,648 to 2,147,483,647) | `INTEGER 5000` |
| `BIGINT` | Stores large integers (-9 quintillion to 9 quintillion) | `BIGINT 9999999999` |
| `DECIMAL(p, s)` / `NUMERIC(p, s)` | Stores fixed precision numbers | `DECIMAL(10,2) 12345.67` |
| `REAL` | Stores single-precision floating-point numbers | `REAL 3.14` |
| `DOUBLE PRECISION` | Stores double-precision floating-point numbers | `DOUBLE PRECISION 3.14159265359` |
| `SERIAL` | Auto-incrementing integer (used for primary keys) | `SERIAL` |

### **Best Practices:**
- Use `INTEGER` for general cases unless a larger range is needed.
- Use `DECIMAL` for financial calculations to avoid floating-point precision errors.
- Use `SERIAL` for auto-incrementing IDs.

---

## 2. Character Data Types
Used to store text values.

| Data Type  | Description | Example |
|------------|------------|---------|
| `CHAR(n)`  | Fixed-length character string (padded with spaces if shorter) | `CHAR(10) 'hello '` |
| `VARCHAR(n)` | Variable-length character string (up to `n` characters) | `VARCHAR(50) 'PostgreSQL'` |
| `TEXT` | Unlimited-length character string | `TEXT 'Long text data'` |

### **Best Practices:**
- Use `VARCHAR(n)` when a maximum length is known.
- Use `TEXT` for large text fields.
- Avoid `CHAR(n)` unless you require fixed-length strings.

---

## 3. Date and Time Data Types
Used to store date and time values.

| Data Type  | Description | Example |
|------------|------------|---------|
| `DATE` | Stores date (YYYY-MM-DD) | `DATE '2025-02-22'` |
| `TIME` | Stores time (HH:MI:SS) | `TIME '14:30:00'` |
| `TIMESTAMP` | Stores date and time | `TIMESTAMP '2025-02-22 14:30:00'` |
| `TIMESTAMPTZ` | Stores date and time with time zone | `TIMESTAMPTZ '2025-02-22 14:30:00+05:30'` |
| `INTERVAL` | Stores time interval | `INTERVAL '2 days'` |

### **Best Practices:**
- Use `TIMESTAMP` or `TIMESTAMPTZ` for date-time values.
- Use `INTERVAL` for time differences.

---

## 4. Boolean Data Type
Used to store true/false values.

| Data Type  | Description | Example |
|------------|------------|---------|
| `BOOLEAN` | Stores TRUE, FALSE, or NULL | `BOOLEAN TRUE` |

### **Best Practices:**
- Use `BOOLEAN` instead of `INTEGER (0/1)` for better readability.

---

## 5. JSON and JSONB Data Types
Used to store JSON data.

| Data Type  | Description | Example |
|------------|------------|---------|
| `JSON` | Stores JSON in text format | `JSON '{"name": "John"}'` |
| `JSONB` | Stores JSON in binary format (faster queries) | `JSONB '{"name": "John"}'` |

### **Best Practices:**
- Use `JSONB` over `JSON` for efficient indexing and queries.

---

## 6. Array Data Type
Stores multiple values of the same data type in a single column.

| Data Type  | Description | Example |
|------------|------------|---------|
| `INTEGER[]` | Stores an array of integers | `INTEGER[] '{1,2,3,4}'` |
| `TEXT[]` | Stores an array of text values | `TEXT[] '{"apple", "banana"}'` |

### **Best Practices:**
- Use arrays for multiple values in a single field, but prefer normalization when possible.

---

## 7. UUID Data Type
Stores universally unique identifiers.

| Data Type  | Description | Example |
|------------|------------|---------|
| `UUID` | Stores 128-bit unique identifiers | `UUID '550e8400-e29b-41d4-a716-446655440000'` |

### **Best Practices:**
- Use `UUID` for distributed systems where uniqueness is critical.

---

## 8. Other Data Types

| Data Type  | Description | Example |
|------------|------------|---------|
| `CIDR`, `INET`, `MACADDR` | Stores network addresses | `INET '192.168.1.1'` |
| `BYTEA` | Stores binary data (files, images) | `BYTEA '\xDEADBEEF'` |
| `TSVECTOR` | Used for full-text search | `TSVECTOR 'PostgreSQL'` |

### **Best Practices:**
- Use `BYTEA` for storing images/files.
- Use `TSVECTOR` for full-text search indexing.

---

## Summary
- **Use appropriate data types** to optimize performance and storage.
- **Prefer fixed precision (`DECIMAL`) for financial data**.
- **Use `VARCHAR(n)` instead of `TEXT` when length limits are known**.
- **Use `JSONB` for faster JSON queries**.
- **Use indexes (`GIN`, `BTREE`) on JSONB and ARRAY types** for faster lookup.

This covers the essential PostgreSQL data types. Next, we will move on to DML (Data Manipulation Language). 🚀

