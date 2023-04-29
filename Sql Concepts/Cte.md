CTE stands for Common Table Expressions, which is a temporary result set that can be referenced within a SELECT, INSERT, UPDATE, or DELETE statement. CTEs are mainly used to simplify complex queries and make them more readable and manageable.

Here's an example of how to create a simple CTE:

```
WITH employee_cte AS (
    SELECT
        first_name,
        last_name,
        salary
    FROM employees
    WHERE department_id = 10
)
SELECT *
FROM employee_cte;
```

In this example, we are using the CTE to select employees from the employees table who belong to department 10. The CTE is defined using the WITH clause, and its result set is then selected in the second part of the query.

CTEs can also be used to recursively query hierarchical data, such as organizational charts or family trees. Here's an example of how to use a recursive CTE to find all the ancestors of a given employee:

```
WITH RECURSIVE employee_cte AS (
    SELECT
        employee_id,
        first_name,
        last_name,
        manager_id,
        1 AS level
    FROM employees
    WHERE employee_id = 100
    UNION ALL
    SELECT
        e.employee_id,
        e.first_name,
        e.last_name,
        e.manager_id,
        ec.level + 1
    FROM employees e
    INNER JOIN employee_cte ec
        ON e.employee_id = ec.manager_id
)
SELECT *
FROM employee_cte;
```

In this example, we are using a recursive CTE to find all the ancestors of employee ID 100. The CTE first selects the employee with ID 100 and assigns a level of 1. Then, it recursively selects all the employees whose manager ID matches the previous employee's ID and increments the level by 1. This process continues until there are no more matches.

CTEs can also be used in conjunction with aggregate functions to perform complex calculations. Here's an example of how to use a CTE to calculate the average salary of employees in each department:

```
WITH department_salary_cte AS (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT *
FROM department_salary_cte;
```

In this example, we are using a CTE to calculate the average salary of employees in each department. The CTE first groups the employees by department and calculates the average salary using the AVG function. The result set is then selected in the second part of the query.

These are just a few examples of how you can use CTEs in SQL. CTEs are a powerful tool for simplifying complex queries and making them more readable and manageable.