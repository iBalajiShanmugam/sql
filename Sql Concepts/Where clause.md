## Where Clause

The WHERE clause is used to filter the rows returned by a SELECT statement based on a specified condition or set of conditions. 

Here's an example query that uses a WHERE clause:

```
SELECT *
FROM employees
WHERE department = 'Sales';
```

In this example, the query will only return the rows from the "employees" table where the "department" column has a value of "Sales". 

The WHERE clause can be used to filter rows based on a single condition, or multiple conditions can be combined using logical operators such as AND and OR. 

Here's an example of a query that uses multiple conditions in a WHERE clause:

```
SELECT *
FROM orders
WHERE customer_id = 12345
AND order_date >= '2022-01-01';
```

In this example, the query will only return the rows from the "orders" table where the "customer_id" column has a value of 12345 AND the "order_date" column is on or after January 1st, 2022. 

The WHERE clause can also be used with comparison operators such as LIKE and BETWEEN to filter rows based on patterns or ranges of values, respectively. 

Here's an example of a query that uses the LIKE operator in a WHERE clause:

```
SELECT *
FROM customers
WHERE last_name LIKE 'Smith%';
```

In this example, the query will only return the rows from the "customers" table where the "last_name" column starts with the string "Smith". 

Overall, the WHERE clause is a powerful tool in SQL that allows you to selectively filter and retrieve data from a table based on specific conditions.


here are some common operators used in the WHERE clause:

# 1. Comparison operators: 
- `=` : Equal to
- `<>` or `!=` : Not equal to
- `<` : Less than
- `>` : Greater than
- `<=` : Less than or equal to
- `>=` : Greater than or equal to

Example: 

```
SELECT *
FROM employees
WHERE salary > 50000;
```

# 2. Logical operators: 
- `AND`: Returns true if both conditions are true
- `OR`: Returns true if either of the conditions are true
- `NOT`: Reverses the result of the following condition

Example: 

```
SELECT *
FROM orders
WHERE customer_id = 12345 AND order_date >= '2022-01-01';
```

# 3. IN operator: 

The IN operator allows you to specify a list of values to match against a column. 

Example: 

```
SELECT *
FROM products
WHERE category IN ('Electronics', 'Appliances', 'Office Supplies');
```

# 4. LIKE operator: 

The LIKE operator is used to match a pattern in a column. You can use wildcard characters like `%` and `_` to match any character or a specific character, respectively.

Example: 

```
SELECT *
FROM customers
WHERE last_name LIKE 'S%';
```

# 5. BETWEEN operator: 

The BETWEEN operator is used to match a range of values.

Example: 

```
SELECT *
FROM orders
WHERE order_date BETWEEN '2022-01-01' AND '2022-01-31';
```