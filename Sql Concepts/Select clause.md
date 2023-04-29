## SELECT

The SELECT statement is used to retrieve data from one or more tables in a database. Here's the basic syntax:

```
SELECT column1, column2, ...
FROM table_name;
```

The SELECT statement retrieves data from one or more columns in a table. You can specify the column names you want to retrieve after the SELECT keyword, separated by commas. If you want to retrieve all columns from the table, you can use the asterisk (*) wildcard character instead of specifying each column name.

Here's an example query that uses the SELECT statement to retrieve all columns from the "employees" table:

```
SELECT *
FROM employees;
```

You can also use the SELECT statement with aggregate functions like SUM, COUNT, AVG, MIN, and MAX to perform calculations on the data in a table. 

Here's an example query that uses the COUNT function to count the number of rows in the "employees" table:

```
SELECT COUNT(*)
FROM employees;
```

You can also use the SELECT statement with the DISTINCT keyword to retrieve only unique values from a column. 

Here's an example query that uses the SELECT statement with the DISTINCT keyword to retrieve all unique values from the "department" column in the "employees" table:

```
SELECT DISTINCT department
FROM employees;
```

You can also use the SELECT statement with the WHERE clause to filter rows based on a specific condition. 

Here's an example query that uses the SELECT statement with the WHERE clause to retrieve all rows from the "employees" table where the "department" column has a value of "Sales":

```
SELECT *
FROM employees
WHERE department = 'Sales';
```

You can also use the SELECT statement with the ORDER BY clause to sort the results of a query in ascending or descending order based on a specific column.

Here's an example query that uses the SELECT statement with the ORDER BY clause to retrieve all rows from the "employees" table sorted in ascending order based on the "last_name" column:

```
SELECT *
FROM employees
ORDER BY last_name ASC;
```

Overall, the SELECT statement is a powerful tool in SQL that allows you to retrieve and manipulate data from one or more tables in a database.