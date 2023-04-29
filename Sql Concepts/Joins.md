Joins are used in SQL to combine rows from two or more tables based on a related column between them. There are several types of joins in SQL, including inner join, left join, right join, and full outer join. Here's a brief explanation of each type of join with multiple examples:

# 1. Inner Join:

An inner join returns only the rows that have matching values in both tables being joined.

Example:

```
SELECT *
FROM orders
INNER JOIN customers
ON orders.customer_id = customers.customer_id;
```

In this example, we are joining the `orders` and `customers` tables on the `customer_id` column. The result set will only contain the rows where there is a match between the `customer_id` column in both tables.

# 2. Left Join:

A left join returns all the rows from the left table and the matched rows from the right table. If there are no matching rows in the right table, NULL values will be returned for the columns in the right table.

Example:

```
SELECT *
FROM customers
LEFT JOIN orders
ON customers.customer_id = orders.customer_id;
```

In this example, we are joining the `customers` and `orders` tables on the `customer_id` column using a left join. The result set will contain all the rows from the `customers` table and the matching rows from the `orders` table. If there are no matching rows in the `orders` table, NULL values will be returned for the columns in the `orders` table.

# 3. Right Join:

A right join returns all the rows from the right table and the matched rows from the left table. If there are no matching rows in the left table, NULL values will be returned for the columns in the left table.

Example:

```
SELECT *
FROM customers
RIGHT JOIN orders
ON customers.customer_id = orders.customer_id;
```

In this example, we are joining the `customers` and `orders` tables on the `customer_id` column using a right join. The result set will contain all the rows from the `orders` table and the matching rows from the `customers` table. If there are no matching rows in the `customers` table, NULL values will be returned for the columns in the `customers` table.

# 4. Full Outer Join:

A full outer join returns all the rows from both tables and NULL values for the columns where there is no matching row in the other table.

Example:

```
SELECT *
FROM customers
FULL OUTER JOIN orders
ON customers.customer_id = orders.customer_id;
```

In this example, we are joining the `customers` and `orders` tables on the `customer_id` column using a full outer join. The result set will contain all the rows from both tables and NULL values for the columns where there is no matching row in the other table.

These are just a few examples of how you can use joins in SQL. Joins are a powerful tool for combining data from multiple tables and are a fundamental part of SQL querying.