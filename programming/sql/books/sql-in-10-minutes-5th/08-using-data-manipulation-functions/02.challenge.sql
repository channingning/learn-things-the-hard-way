/*
 * create time: 2026-08-24 10:06
 */

/* 1. */
-- DB2, PostgreSQL
SELECT cust_id, cust_name,
    UPPER(LEFT(cust_contact, 2)) || UPPER(LEFT(cust_city, 3)) AS user_login
FROM Customers;

-- Oracle, SQLite
SELECT cust_id, cust_name,
    UPPER(SUBSTR(cust_contact, 1, 2)) || UPPER(SUBSTR(cust_city, 1, 3)) AS user_login
FROM Customers;

/* 
SQLite
+------------+---------------+------------+
|  cust_id   |   cust_name   | user_login |
+------------+---------------+------------+
| 1000000001 | Village Toys  | JODET      |
| 1000000002 | Kids Place    | MICOL      |
| 1000000003 | Fun4All       | JIMUN      |
| 1000000004 | Fun4All       | DEPHO      |
| 1000000005 | The Toy Store | KICHI      |
+------------+---------------+------------+
*/

-- MySQL
SELECT cust_id, cust_name,
    CONCAT(UPPER(LEFT(cust_contact, 2)), UPPER(LEFT(cust_city, 3))) AS user_login
FROM Customers;

/*
+------------+---------------+------------+
| cust_id    | cust_name     | user_login |
+------------+---------------+------------+
| 1000000001 | Village Toys  | JODET      |
| 1000000002 | Kids Place    | MICOL      |
| 1000000003 | Fun4All       | JIMUN      |
| 1000000004 | Fun4All       | DEPHO      |
| 1000000005 | The Toy Store | KICHI      |
+------------+---------------+------------+
5 rows in set (0.00 sec)
*/

-- SQL Server
SELECT cust_id, cust_name,
        UPPER(LEFT(cust_contact, 2)) + UPPER(LEFT(cust_city, 3)) AS user_login
FROM customers;

/* 2. */
-- DB2, MariaDB, MySQL
SELECT order_num, order_date
FROM Orders
WHERE YEAR(order_date) = 2020 AND MONTH(order_date) = 1
ORDER BY order_date;

/*
MariaDB
+-----------+---------------------+
| order_num | order_date          |
+-----------+---------------------+
|     20006 | 2020-01-12 00:00:00 |
|     20007 | 2020-01-30 00:00:00 |
+-----------+---------------------+
2 rows in set (0.00 sec)
*/

-- Oracle, PostgreSQL
SELECT order_num, order_date
FROM Orders
WHERE EXTRACT(year FROM order_date) = 2020 AND EXTRACT(month FROM order_date) = 1
ORDER BY order_date;

-- PostgreSQL
SELECT order_num, order_date
FROM Orders
WHERE DATE_PART('year', order_date) = 2020
AND DATE_PART('month', order_date) = 1
ORDER BY order_date;

-- SQL Server
SELECT order_num, order_date
FROM Orders
WHERE DATEPART(yy, order_date) = 2020 AND DATEPART(mm, order_date) = 1
ORDER BY order_date;

-- SQLite
SELECT order_num, order_date
FROM Orders
WHERE strftime('%Y', order_date) = '2020'
  AND strftime('%m', order_date) = '01'
ORDER BY order_date;

/*
+-----------+------------+
| order_num | order_date |
+-----------+------------+
| 20006     | 2020-01-12 |
| 20007     | 2020-01-30 |
+-----------+------------+
*/
