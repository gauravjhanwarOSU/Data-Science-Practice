-- Q1:
-- Let’s say that you’re a data scientist working on a distribution team at Amazon.
-- Create a report displaying which shipments were delivered to customers during their membership period.
-- If the transaction is shipped during the membership period, column is_member should have the value Y. If not, the column should have the value N.
-- Hint: You may assume that customer_id is unique and that shipments are made only to registered customers.
SELECT
    s.*,
    CASE
        WHEN ship_date BETWEEN membership_start_date
        AND membership_end_date THEN 'Y'
        ELSE 'N'
    END AS is_member
FROM
    shipments s
    LEFT JOIN customers c ON s.customer_id = c.customer_id