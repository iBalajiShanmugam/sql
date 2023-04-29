## SQL aggregate, date, and text functions with multiple examples:

# 1. Aggregate functions:

Aggregate functions are used to perform calculations on a set of values and return a single value. The most commonly used aggregate functions are COUNT, SUM, AVG, MIN, and MAX, as explained in my previous answer.

Example:

```
SELECT COUNT(*) FROM employees;
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
```

# 2. Date functions:

Date functions are used to manipulate and format dates in SQL. Some commonly used date functions are DATEADD, DATEDIFF, YEAR, MONTH, DAY, and GETDATE.

Example:

```
SELECT DATEADD(day, 7, '2022-05-01') AS next_week_date;
SELECT DATEDIFF(day, '2022-05-01', '2022-05-15') AS days_between;
SELECT YEAR('2022-05-01') AS year;
SELECT MONTH('2022-05-01') AS month;
SELECT DAY('2022-05-01') AS day;
SELECT GETDATE() AS current_date_time;
```

# 3. Text functions:

Text functions are used to manipulate and format text data in SQL. Some commonly used text functions are CONCAT, LEN, LEFT, RIGHT, UPPER, and LOWER.

Example:

```
SELECT CONCAT(first_name, ' ', last_name) AS full_name;
SELECT LEN('Hello world!') AS length;
SELECT LEFT('Hello world!', 5) AS left_text;
SELECT RIGHT('Hello world!', 6) AS right_text;
SELECT UPPER('hello world!') AS upper_case_text;
SELECT LOWER('HELLO WORLD!') AS lower_case_text;
```

In these examples, the CONCAT function is used to combine the first name and last name columns into a full name column, the LEN function is used to calculate the length of a text string, the LEFT and RIGHT functions are used to extract a specified number of characters from the beginning or end of a text string, and the UPPER and LOWER functions are used to convert text to upper or lower case.