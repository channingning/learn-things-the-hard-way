/*
 * create time: 2026-09-13
 */

/* 18.1 视图  Understanding Views */
-- 视图是虚拟的表。视图只包含使用时动态检索数据的查询。
-- Views are virtual tables. views simply contain queries that dynamically retrieve data when used.

SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
 AND OrderItems.order_num = Orders.order_num
 AND prod_id = 'RGAN01';

/*
+---------------+--------------------+
| cust_name     | cust_contact       |
+---------------+--------------------+
| Fun4All       | Denise L. Stephens |
| The Toy Store | Kim Howard         |
+---------------+--------------------+
2 rows in set (0.00 sec)
*/

SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01';

/* 18.1.1 为什么使用视图  Why Use Views */

/* 18.1.2 视图的规则和限制  View Rules and Restrictions */

/* 18.2 创建视图  Creating Views */
CREATE VIEW viewname;

DROP VIEW viewname;

/* 18.2.1 利用视图简化复杂的联结  Using Views to Simplify Complex Joins */
CREATE VIEW ProductCustomers AS
SELECT cust_name, cust_contact, prod_id
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
 AND OrderItems.order_num = Orders.order_num;

/*
Query OK, 0 rows affected (0.01 sec)
*/

SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01';

/*
+---------------+--------------------+
| cust_name     | cust_contact       |
+---------------+--------------------+
| Fun4All       | Denise L. Stephens |
| The Toy Store | Kim Howard         |
+---------------+--------------------+
2 rows in set (0.01 sec)
*/

/* 18.2.2 用视图重新格式化检索出的数据  Using Views to Reformat Retrieved Data */
-- SQL Server
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
       AS vend_title
FROM Vendors
ORDER BY vend_name;

-- DB2、Oracle、PostgreSQO 和 SQLite 使用 ｜｜
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')'
       AS vend_title
FROM Vendors
ORDER BY vend_name;

-- MySQL 和 MariaDB 使用 Concat() 函数
SELECT Concat(vend_name, ' (', vend_country, ')')
FROM Vendors
ORDER BY vend_name;

/*
+--------------------------------------------+
| Concat(vend_name, ' (', vend_country, ')') |
+--------------------------------------------+
| Bear Emporium (USA)                        |
| Bears R Us (USA)                           |
| Doll House Inc. (USA)                      |
| Fun and Games (England)                    |
| Furball Inc. (USA)                         |
| Jouets et ours (France)                    |
+--------------------------------------------+
6 rows in set (0.00 sec)
*/

CREATE VIEW VendorLocations AS 
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')' 
AS vend_title 
FROM Vendors; 

CREATE VIEW VendorLocations AS 
SELECT Concat(vend_name, ' (', vend_country, ')')
FROM Vendors
ORDER BY vend_name;

/*
Query OK, 0 rows affected (0.01 sec)
*/

SELECT * FROM VendorLocations;

/*
+--------------------------------------------+
| Concat(vend_name, ' (', vend_country, ')') |
+--------------------------------------------+
| Bear Emporium (USA)                        |
| Bears R Us (USA)                           |
| Doll House Inc. (USA)                      |
| Fun and Games (England)                    |
| Furball Inc. (USA)                         |
| Jouets et ours (France)                    |
+--------------------------------------------+
6 rows in set (0.00 sec)
*/

/* 18.2.3 用视图过滤不想要的数据  Using Views to Filter Unwanted Data */
CREATE VIEW CustomerEMailList AS
SELECT cust_id, cust_name, cust_email
FROM Customers
WHERE cust_email IS NOT NULL;

/*
Query OK, 0 rows affected (0.01 sec)
*/

SELECT *
FROM CustomerEMailList;

/*
+------------+--------------+-----------------------+
| cust_id    | cust_name    | cust_email            |
+------------+--------------+-----------------------+
| 1000000001 | Village Toys | sales@villagetoys.com |
| 1000000003 | Fun4All      | jjones@fun4all.com    |
| 1000000004 | Fun4All      | dstephens@fun4all.com |
+------------+--------------+-----------------------+
3 rows in set (0.00 sec)
*/

/* 18.2.4 使用视图与计算字段  Using Views with Calculated Fields */
SELECT prod_id,
       quantity,
       item_price,
       quantity*item_price AS expanded_price
FROM OrderItems
WHERE order_num = 20008;

/*
+---------+----------+------------+----------------+
| prod_id | quantity | item_price | expanded_price |
+---------+----------+------------+----------------+
| RGAN01  |        5 |       4.99 |          24.95 |
| BR03    |        5 |      11.99 |          59.95 |
| BNBG01  |       10 |       3.49 |          34.90 |
| BNBG02  |       10 |       3.49 |          34.90 |
| BNBG03  |       10 |       3.49 |          34.90 |
+---------+----------+------------+----------------+
5 rows in set (0.00 sec)
*/

CREATE VIEW OrderItemsExpanded AS
SELECT order_num,
       prod_id,
       quantity,
       item_price,
       quantity*item_price AS expanded_price
FROM OrderItems;

/*
Query OK, 0 rows affected (0.01 sec)
*/

SELECT *
FROM OrderItemsExpanded
WHERE order_num = 20008;

/*
+-----------+---------+----------+------------+----------------+
| order_num | prod_id | quantity | item_price | expanded_price |
+-----------+---------+----------+------------+----------------+
|     20008 | RGAN01  |        5 |       4.99 |          24.95 |
|     20008 | BR03    |        5 |      11.99 |          59.95 |
|     20008 | BNBG01  |       10 |       3.49 |          34.90 |
|     20008 | BNBG02  |       10 |       3.49 |          34.90 |
|     20008 | BNBG03  |       10 |       3.49 |          34.90 |
+-----------+---------+----------+------------+----------------+
5 rows in set (0.00 sec)
*/

/* 18.3 小结  Summary */

/* 18.4 挑战题  Challenges */
