/*
 * create time: 2026-09-12 09:03
 */

/* 1. */
UPDATE Vendors
SET vend_state = UPPER(vend_state)
WHERE vend_country = 'USA';

/*
Query OK, 0 rows affected (0.00 sec)
Rows matched: 4  Changed: 0  Warnings: 0
*/

UPDATE Customers
SET cust_state = UPPER(cust_state)
WHERE cust_country = 'USA';

/*
Query OK, 0 rows affected (0.00 sec)
Rows matched: 8  Changed: 0  Warnings: 0
*/

/* 2. */
-- First test the WHERE to make sure it selects only what you want to delete
SELECT * FROM Customers
WHERE cust_id = 1000000042;

/*
+------------+------------+-----------------+-----------+------------+----------+--------------+--------------+---------------------------------+
| cust_id    | cust_name  | cust_address    | cust_city | cust_state | cust_zip | cust_country | cust_contact | cust_email                      |
+------------+------------+-----------------+-----------+------------+----------+--------------+--------------+---------------------------------+
| 1000000042 | Ben's Toys | 123 Main Street | Oak Park  | MI         | 48237    | USA          | NULL         | ben@fortabbwpc.wpcomstaging.com |
+------------+------------+-----------------+-----------+------------+----------+--------------+--------------+---------------------------------+
1 row in set (0.00 sec)
*/

-- Then do it!
DELETE FROM Customers
WHERE cust_id = 1000000042;

/*
Query OK, 1 row affected (0.01 sec)
*/
