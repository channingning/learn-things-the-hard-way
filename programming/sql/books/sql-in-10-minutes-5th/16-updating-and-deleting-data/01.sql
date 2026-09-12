/*
 * create time: 2026-09-12
 */

/* 16.1 更新数据  Updating Data */
-- 更新单个列
-- update a single column
UPDATE Customers
SET cust_email = 'kim@thetoystore.com'
WHERE cust_id = 1000000005;

/*
Query OK, 1 row affected (0.01 sec)
Rows matched: 1  Changed: 1  Warnings: 0
*/

-- my test
UPDATE Customers
SET cust_email = 'kim@thetoystore.com';

/*
Query OK, 9 rows affected (0.01 sec)
Rows matched: 9  Changed: 9  Warnings: 0
*/

-- 更新多个列
-- Updating multiple columns
UPDATE Customers
SET cust_contact = 'Sam Roberts',
    cust_email = 'sam@toyland.com'
WHERE cust_id = 1000000006;

/*
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0
*/

/* 16.2 删除数据  Deleting Data */
DELETE FROM Customers
WHERE cust_id = 1000000006;

/*
Query OK, 1 row affected (0.01 sec)
*/

-- 更快的删除
-- Faster Deletes
TRUNCATE TABLE Customers
WHERE cust_id = 1000000006;

/*
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'WHERE cust_id = 1000000006' at line 1
*/

/* 16.3 更新和删除的指导原则  Guidelines for Updating and Deleting Data */

/* 16.4 小结  Summary */

/* 16.5 挑战题  Challenges */
