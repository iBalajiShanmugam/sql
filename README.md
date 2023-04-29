## SQL Problems and Solutions
This repository contains a collection of SQL problems and solutions to help you improve your SQL skills. Each problem includes a description of the problem and a solution that demonstrates how to write SQL code to solve the problem. The SQL code is written using MySQL syntax, but the concepts can be applied to other SQL variants.

## 1. SELECT: 

The SELECT statement is used to retrieve data from one or more tables. It specifies which columns to retrieve, and can also include aggregate functions like COUNT, SUM, or AVG to calculate summary information about the data. 

Syntax: 

```
SELECT column1, column2, ... FROM table_name
```

Example: 

```
SELECT name, age, email FROM customers
```

## 2. FROM: 

The FROM statement specifies which table(s) to retrieve data from. It can also include JOIN clauses to combine data from multiple tables.

Syntax: 

```
SELECT column1, column2, ... FROM table1 JOIN table2 ON table1.column = table2.column
```

Example: 

```
SELECT orders.order_id, customers.name FROM orders JOIN customers ON orders.customer_id = customers.customer_id
```

## 3. WHERE:

The WHERE statement is used to filter rows based on a specific condition. It can include logical operators like AND, OR, and NOT, and comparison operators like =, <, >, and <>.

Syntax: 

```
SELECT column1, column2, ... FROM table_name WHERE condition
```

Example: 

```
SELECT name, age FROM customers WHERE age > 30 AND email LIKE '%@gmail.com'
```

## 4. GROUP BY: 

The GROUP BY statement is used to group rows based on a specific column(s). It is often used with aggregate functions to calculate summary information about each group.

Syntax: 

```
SELECT column1, aggregate_function(column2) FROM table_name GROUP BY column1
```

Example: 

```
SELECT category, COUNT(*) as num_products FROM products GROUP BY category
```

## 5. HAVING: 

The HAVING statement is used to filter groups based on a specific condition. It is similar to the WHERE statement, but operates on groups rather than individual rows.

Syntax: 

```
SELECT column1, aggregate_function(column2) FROM table_name GROUP BY column1 HAVING condition
```

Example: 

```
SELECT category, AVG(price) as avg_price FROM products GROUP BY category HAVING AVG(price) > 100
```

## 6. ORDER BY: 

The ORDER BY statement is used to sort the result set by one or more columns. It can specify ASC (ascending) or DESC (descending) order, and can include multiple columns to sort by.

Syntax: 

```
SELECT column1, column2, ... FROM table_name ORDER BY column1 ASC/DESC, column2 ASC/DESC, ...
```

Example: 

```
SELECT name, age FROM customers ORDER BY age DESC
```
