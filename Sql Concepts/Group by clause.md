## GROUP BY

The GROUP BY clause is used to group rows in a table based on the values in one or more columns. Here's the basic syntax:

```
SELECT column1, column2, ..., aggregate_function(column)
FROM table_name
GROUP BY column1, column2, ...;
```

The GROUP BY clause groups the rows in a table based on the specified column or columns, and then applies an aggregate function to each group of rows. The aggregate function can be any of the following: SUM, COUNT, AVG, MIN, MAX, etc.

Here's an example query that uses the GROUP BY clause to group the rows in the "sales" table by the "region" column and calculate the total sales for each region:

```
SELECT region, SUM(sales)
FROM sales
GROUP BY region;
```

In this example, the GROUP BY clause groups the rows in the "sales" table by the "region" column, and the SUM function calculates the total sales for each region.

You can also use the GROUP BY clause with multiple columns to group the rows in a table by more than one column. 

Here's an example query that uses the GROUP BY clause to group the rows in the "sales" table by the "region" and "year" columns and calculate the total sales for each region and year:

```
SELECT region, year, SUM(sales)
FROM sales
GROUP BY region, year;
```

In this example, the GROUP BY clause groups the rows in the "sales" table by the "region" and "year" columns, and the SUM function calculates the total sales for each region and year.

You can also use the GROUP BY clause with the HAVING clause to filter the groups based on a specific condition.

Here's an example query that uses the GROUP BY clause with the HAVING clause to group the rows in the "sales" table by the "region" column and calculate the total sales for each region, but only include regions with total sales greater than $1,000,000:

```
SELECT region, SUM(sales)
FROM sales
GROUP BY region
HAVING SUM(sales) > 1000000;
```

In this example, the HAVING clause filters the groups based on the condition that the total sales for each region must be greater than $1,000,000.

Overall, the GROUP BY clause is a powerful tool in SQL that allows you to group rows in a table based on specific columns and apply aggregate functions to each group of rows.