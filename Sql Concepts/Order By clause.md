## ORDER BY 

The ORDER BY clause is used to sort the query results in either ascending or descending order based on one or more columns. Here's the basic syntax of a query that uses the ORDER BY clause:

```
SELECT column1, column2, ...
FROM table_name
ORDER BY column1 [ASC|DESC], column2 [ASC|DESC], ...;
```

The ORDER BY clause is placed at the end of the query and specifies the columns that the results should be sorted by. You can sort the results in ascending order by default, or you can specify "DESC" to sort the results in descending order.

Here's an example query that uses the ORDER BY clause to sort the employees table by the salary column in descending order:

```
SELECT *
FROM employees
ORDER BY salary DESC;
```

In this example, the query returns all columns from the employees table and sorts the results by the salary column in descending order.

You can also sort the results based on multiple columns. Here's an example query that sorts the employees table by the salary column in descending order and then by the department column in ascending order:

```
SELECT *
FROM employees
ORDER BY salary DESC, department ASC;
```

In this example, the query first sorts the results by the salary column in descending order, and then by the department column in ascending order. If two employees have the same salary, they will be sorted by their department in alphabetical order.

You can also use the ORDER BY clause with aggregate functions. Here's an example query that uses the SUM function to calculate the total sales for each region and sorts the results by the total sales in descending order:

```
SELECT region, SUM(sales) AS total_sales
FROM sales
GROUP BY region
ORDER BY total_sales DESC;
```

In this example, the query uses the GROUP BY clause to group the rows in the sales table by the region column and calculates the total sales for each region using the SUM function. The results are then sorted by the total sales column in descending order.

You can also use the ORDER BY clause with expressions. Here's an example query that calculates the commission for each employee based on their sales and sorts the results by the commission in descending order:

```
SELECT name, sales, commission_percentage * sales AS commission
FROM employees
ORDER BY commission DESC;
```

In this example, the query calculates the commission for each employee by multiplying their sales by their commission percentage, and then sorts the results by the commission column in descending order.

Overall, the ORDER BY clause is a powerful tool in SQL that allows you to sort the query results based on one or more columns, whether they are actual columns in the table or expressions.