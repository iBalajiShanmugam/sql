## CASE statement in SQL with some examples:

The CASE statement is a conditional expression that can be used to perform different actions based on different conditions. It allows you to specify a condition and then execute different code depending on whether the condition is true or false.

The basic syntax of the CASE statement is:

```
CASE
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE resultN
END
```

Here's an example of how to use the CASE statement to categorize employees based on their salary:

```
SELECT 
    first_name,
    last_name,
    CASE
        WHEN salary >= 100000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category
FROM employees;
```

In this example, the CASE statement checks the salary of each employee and assigns them to one of three categories based on their salary.

You can also use the CASE statement in the WHERE clause to filter results based on a condition:

```
SELECT 
    first_name,
    last_name,
    salary
FROM employees
WHERE
    CASE
        WHEN department_id = 10 THEN salary * 1.1
        WHEN department_id = 20 THEN salary * 1.2
        ELSE salary
    END > 50000;
```

In this example, the CASE statement multiplies the salary by a factor depending on the department ID and then checks if the result is greater than 50000. This allows you to filter the results based on a calculated value.

The CASE statement can also be used in conjunction with aggregate functions like COUNT, SUM, and AVG. Here's an example of how to use the CASE statement with COUNT to count the number of employees in each salary category:

```
SELECT 
    CASE
        WHEN salary >= 100000 THEN 'High'
        WHEN salary >= 50000 THEN 'Medium'
        ELSE 'Low'
    END AS salary_category,
    COUNT(*) AS employee_count
FROM employees
GROUP BY salary_category;
```

In this example, the CASE statement categorizes employees based on their salary, and then the COUNT function is used to count the number of employees in each category.

These are just a few examples of how you can use the CASE statement in SQL. It is a versatile and powerful tool that can help you perform complex calculations and filter data based on conditional logic.