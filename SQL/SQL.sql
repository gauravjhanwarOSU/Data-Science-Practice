/*Q1:
 Let’s say that you’re a data scientist working on a distribution team at Amazon.
 Create a report displaying which shipments were delivered to customers during their membership period.
 If the transaction is shipped during the membership period, column is_member should have the value Y. If not, the column should have the value N.
 Hint: You may assume that customer_id is unique and that shipments are made only to registered customers. */
SELECT
    s.*,
    CASE
        WHEN ship_date BETWEEN membership_start_date
        AND membership_end_date THEN 'Y'
        ELSE 'N'
    END AS is_member
FROM
    shipments s
    LEFT JOIN customers c ON s.customer_id = c.customer_id;

/* Q2:
 You have a table containing information about the projects employees have worked on and the time period in which they worked on the project. Each project can be assigned to more than one employee, and an employee can be working on more than one project at a time.
 Write a query to find how many unique days each employee worked. Order your query by the employee_id. */
WITH DAYS_TB AS (
    SELECT
        a.Dates
    FROM
        (
            SELECT
                curdate() - INTERVAL (a.a + (10 * b.a) + (100 * c.a) + (1000 * d.a)) DAY AS Dates
            FROM
                (
                    SELECT
                        0 AS a
                    UNION
                    ALL
                    SELECT
                        1
                    UNION
                    ALL
                    SELECT
                        2
                    UNION
                    ALL
                    SELECT
                        3
                    UNION
                    ALL
                    SELECT
                        4
                    UNION
                    ALL
                    SELECT
                        5
                    UNION
                    ALL
                    SELECT
                        6
                    UNION
                    ALL
                    SELECT
                        7
                    UNION
                    ALL
                    SELECT
                        8
                    UNION
                    ALL
                    SELECT
                        9
                ) AS a
                CROSS JOIN (
                    SELECT
                        0 AS a
                    UNION
                    ALL
                    SELECT
                        1
                    UNION
                    ALL
                    SELECT
                        2
                    UNION
                    ALL
                    SELECT
                        3
                    UNION
                    ALL
                    SELECT
                        4
                    UNION
                    ALL
                    SELECT
                        5
                    UNION
                    ALL
                    SELECT
                        6
                    UNION
                    ALL
                    SELECT
                        7
                    UNION
                    ALL
                    SELECT
                        8
                    UNION
                    ALL
                    SELECT
                        9
                ) AS b
                CROSS JOIN (
                    SELECT
                        0 AS a
                    UNION
                    ALL
                    SELECT
                        1
                    UNION
                    ALL
                    SELECT
                        2
                    UNION
                    ALL
                    SELECT
                        3
                    UNION
                    ALL
                    SELECT
                        4
                    UNION
                    ALL
                    SELECT
                        5
                    UNION
                    ALL
                    SELECT
                        6
                    UNION
                    ALL
                    SELECT
                        7
                    UNION
                    ALL
                    SELECT
                        8
                    UNION
                    ALL
                    SELECT
                        9
                ) AS c
                CROSS JOIN (
                    SELECT
                        0 AS a
                    UNION
                    ALL
                    SELECT
                        1
                    UNION
                    ALL
                    SELECT
                        2
                    UNION
                    ALL
                    SELECT
                        3
                    UNION
                    ALL
                    SELECT
                        4
                    UNION
                    ALL
                    SELECT
                        5
                    UNION
                    ALL
                    SELECT
                        6
                    UNION
                    ALL
                    SELECT
                        7
                    UNION
                    ALL
                    SELECT
                        8
                    UNION
                    ALL
                    SELECT
                        9
                ) AS d
        ) a
    WHERE
        a.Dates BETWEEN (
            SELECT
                min(start_date)
            FROM
                projects
        )
        AND (
            SELECT
                max(start_date)
            FROM
                projects
        )
    ORDER BY
        1
),
employee_worked_temp AS (
    SELECT
        employee_id,
        Dates AS day_worked
    FROM
        projects,
        DAYS_TB
    WHERE
        Dates BETWEEN start_date
        AND end_date
)
SELECT
    employee_id,
    count(DISTINCT day_worked) AS days_worked
FROM
    employee_worked_temp
GROUP BY
    1
ORDER BY
    1;