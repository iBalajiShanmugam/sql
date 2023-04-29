## window functions:

Window functions are a type of analytic function in SQL that allow you to perform calculations across a set of rows that are related to the current row. They are useful for calculating running totals, moving averages, rankings, and other types of summary statistics.

Window functions operate on a window of rows, which is defined using the OVER() clause. The window can be defined in various ways, such as by specifying a range of rows based on their position relative to the current row, or by specifying a logical grouping of rows based on a column or set of columns.

Window functions can be used in conjunction with other SQL statements like SELECT, FROM, WHERE, GROUP BY, and ORDER BY. Here are some of the most commonly used window functions:

# 1. ROW_NUMBER: 

The ROW_NUMBER function assigns a unique integer value to each row in the result set, based on the order specified in the ORDER BY clause.

Syntax: 

```
ROW_NUMBER() OVER (ORDER BY column1, column2, ...)
```

Example: 

```
SELECT name, age, ROW_NUMBER() OVER (ORDER BY age DESC) as rank FROM customers
```

# 2. RANK: 

The RANK function assigns a rank to each row in the result set based on the value of a specified column. Rows with the same value in the specified column are assigned the same rank, and the next rank is skipped.

Syntax: 

```
RANK() OVER (ORDER BY column1 DESC)
```

Example: 

```
SELECT name, age, RANK() OVER (ORDER BY age DESC) as rank FROM customers
```

# 3. DENSE_RANK: 

The DENSE_RANK function is similar to RANK, but it does not skip ranks for rows with the same value in the specified column. Instead, it assigns consecutive ranks to these rows.

Syntax: 

```
DENSE_RANK() OVER (ORDER BY column1 DESC)
```

Example: 

```
SELECT name, age, DENSE_RANK() OVER (ORDER BY age DESC) as rank FROM customers
```

# 4. SUM: 

The SUM function calculates the sum of a specified column over a window of rows.

Syntax: 

```
SUM(column1) OVER (PARTITION BY column2 ORDER BY column3)
```

Example: 

```
SELECT date, revenue, SUM(revenue) OVER (ORDER BY date) as running_total FROM sales
```

# 5. AVG: 

The AVG function calculates the average of a specified column over a window of rows.

Syntax: 

```
AVG(column1) OVER (PARTITION BY column2 ORDER BY column3)
```

Example: 

```
SELECT date, revenue, AVG(revenue) OVER (PARTITION BY category ORDER BY date) as category_avg FROM sales
```

# 6. LEAD and LAG: 

The LEAD and LAG functions return the value of a specified column for a row that is offset a specified number of rows from the current row.

Syntax: 

```
LEAD(column1, offset, default_value) OVER (ORDER BY column2)
LAG(column1, offset, default_value) OVER (ORDER BY column2)
```

Example: 

```
SELECT date, revenue, LEAD(revenue, 1, 0) OVER (ORDER BY date) as next_month_revenue FROM sales
```

In summary, window functions allow you to perform complex calculations on a subset of rows in your result set, without the need for subqueries or temporary tables. They are a powerful tool for data analysis and reporting in SQL.