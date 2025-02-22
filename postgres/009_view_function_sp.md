# PostgreSQL: Views, CTEs, Functions, and Stored Procedures

## 1. Introduction
PostgreSQL provides powerful tools for organizing and managing data effectively. This guide explores Views, Common Table Expressions (CTEs), Functions, and Stored Procedures—explaining why and when to use them with multiple examples and comparisons.

---

## 2. Views
### **What are Views?**
Views are virtual tables that represent the result of a query. They simplify complex queries, enhance security, and improve maintainability.

### **Why Use Views?**
- Encapsulate complex queries.
- Restrict data access by exposing only specific columns.
- Improve performance by caching query results (materialized views).

### **Creating a View**
```sql
CREATE VIEW movie_ratings AS
SELECT title, rating FROM bms.movies;
```

### **Using a View**
```sql
SELECT * FROM movie_ratings;
```

### **Updating a View**
```sql
CREATE OR REPLACE VIEW movie_ratings AS
SELECT title, rating, genre FROM bms.movies;
```

### **Dropping a View**
```sql
DROP VIEW movie_ratings;
```

### **Materialized Views**
Unlike standard views, materialized views store query results, improving performance for expensive queries.
```sql
CREATE MATERIALIZED VIEW top_movies AS
SELECT title, rating FROM bms.movies WHERE rating > 8;
```

To refresh a materialized view:
```sql
REFRESH MATERIALIZED VIEW top_movies;
```

---

## 3. Common Table Expressions (CTEs)
### **What are CTEs?**
CTEs simplify complex queries by breaking them into smaller, manageable parts using `WITH`.

### **Why Use CTEs?**
- Improve query readability.
- Reuse query results in the same statement.
- Replace subqueries for better performance.

### **Example of a CTE**
```sql
WITH top_movies AS (
    SELECT title, rating FROM bms.movies WHERE rating > 8
)
SELECT * FROM top_movies;
```

### **Recursive CTEs**
Useful for hierarchical data like organizational structures.
```sql
WITH RECURSIVE employee_hierarchy AS (
    SELECT employee_id, name, manager_id FROM employees WHERE manager_id IS NULL
    UNION ALL
    SELECT e.employee_id, e.name, e.manager_id
    FROM employees e
    INNER JOIN employee_hierarchy h ON e.manager_id = h.employee_id
)
SELECT * FROM employee_hierarchy;
```

---

## 4. Functions
### **What are Functions?**
Functions in PostgreSQL encapsulate logic into reusable blocks.

### **Why Use Functions?**
- Reduce code duplication.
- Improve maintainability.
- Perform calculations and transformations within SQL.

### **Creating a Function**
```sql
CREATE FUNCTION get_movie_count() RETURNS INT AS $$
BEGIN
    RETURN (SELECT COUNT(*) FROM bms.movies);
END;
$$ LANGUAGE plpgsql;
```

### **Using a Function**
```sql
SELECT get_movie_count();
```

### **Function with Parameters**
```sql
CREATE FUNCTION get_movies_by_genre(genre_name TEXT) RETURNS TABLE(title TEXT, rating DECIMAL) AS $$
BEGIN
    RETURN QUERY SELECT title, rating FROM bms.movies WHERE genre = genre_name;
END;
$$ LANGUAGE plpgsql;
```

```sql
SELECT * FROM get_movies_by_genre('Action');
```

---

## 5. Stored Procedures
### **What are Stored Procedures?**
Stored procedures are similar to functions but can execute multiple SQL commands, including transactions.

### **Why Use Stored Procedures?**
- Perform multiple operations in a single call.
- Handle transactions inside the database.
- Improve performance by reducing round trips to the database.

### **Creating a Stored Procedure**
```sql
CREATE PROCEDURE add_movie(movie_title TEXT, movie_genre TEXT, movie_rating DECIMAL)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO bms.movies (title, genre, rating) VALUES (movie_title, movie_genre, movie_rating);
END;
$$;
```

### **Calling a Stored Procedure**
```sql
CALL add_movie('Matrix', 'Sci-Fi', 9.0);
```

---

## 6. Comparison Table

| Feature          | Views | CTEs | Functions | Stored Procedures |
|-----------------|-------|------|-----------|-------------------|
| Purpose        | Simplifies query execution | Improves query readability | Encapsulates logic | Executes multiple SQL statements |
| Returns Data?  | Yes | Yes | Yes | No (modifies data) |
| Supports Transactions? | No | No | No | Yes |
| Performance Impact | Can improve performance (materialized views) | Improves readability, but executes each time | Can be optimized for repeated execution | Reduces database calls |

---

## 7. Best Practices
✅ Use Views for reusable queries and security.
✅ Use CTEs to simplify complex queries and replace subqueries.
✅ Use Functions for reusable logic and calculations.
✅ Use Stored Procedures for transactional operations and batch processing.

This guide provides a detailed understanding of Views, CTEs, Functions, and Stored Procedures in PostgreSQL. Let me know if you need further clarifications! 🚀

