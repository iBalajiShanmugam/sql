# PostgreSQL JSON & JSONB Data Types

## 1. Introduction
PostgreSQL provides support for JSON and JSONB data types, which allow users to store and manipulate structured JSON data within the database. These data types are useful for handling semi-structured data, document storage, and integrating with APIs.

- **JSON**: Stores data in text format (preserves formatting but is slower for querying).
- **JSONB**: Stores data in a binary format (optimized for querying and indexing).

## 2. Creating Tables with JSON/JSONB Columns
You can define columns as `JSON` or `JSONB` when creating a table.

```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    details JSONB
);
```

## 3. Inserting JSON Data
You can insert JSON-formatted data into a JSONB column.

```sql
INSERT INTO products (name, details)
VALUES ('Laptop', '{"brand": "Dell", "specs": {"ram": "16GB", "storage": "512GB SSD"}}');
```

## 4. Querying JSON Data
### **Retrieving Entire JSON Object**
```sql
SELECT name, details FROM products;
```

### **Accessing JSON Keys**
- Using `->` returns a JSON object.
- Using `->>` returns a text value.

```sql
SELECT name, details->'brand' AS brand FROM products;
```

```sql
SELECT name, details->'specs'->>'ram' AS ram FROM products;
```

## 5. Updating JSON Data
To update a JSON field, you can use the `jsonb_set` function.

```sql
UPDATE products
SET details = jsonb_set(details, '{specs,ram}', '"32GB"')
WHERE name = 'Laptop';
```

## 6. Filtering JSON Data
You can filter rows using JSON attributes.

```sql
SELECT * FROM products WHERE details->>'brand' = 'Dell';
```

## 7. Indexing JSONB for Performance
JSONB supports indexing for faster queries.

```sql
CREATE INDEX idx_products_details ON products USING GIN (details);
```

## 8. Removing JSON Keys
```sql
UPDATE products
SET details = details - 'specs'
WHERE name = 'Laptop';
```

## 9. JSON Aggregation and Functions
### **Converting Rows to JSON**
```sql
SELECT json_agg(details) FROM products;
```

### **Creating JSON Objects from Query Results**
```sql
SELECT json_build_object('product', name, 'info', details) FROM products;
```

## 10. When to Use JSON vs. JSONB
| Feature  | JSON  | JSONB  |
|----------|------|------|
| Storage  | Text  | Binary  |
| Query Speed  | Slow  | Fast  |
| Indexing  | No  | Yes (GIN/BTREE)  |
| Retains Formatting  | Yes  | No  |
| Supports Partial Updates  | No  | Yes  |

## 11. Best Practices
✅ Use `JSONB` for performance and indexing.
✅ Use `->` and `->>` for efficient querying.
✅ Avoid unnecessary nesting in JSON structures.
✅ Always validate JSON data before insertion.

---
This guide provides an overview of using JSON and JSONB in PostgreSQL with practical examples. 🚀

