/*
 * create time: 2026-08-17 09:39
 *

/* 2.1 SELECT 语句  The SELECT Statement */
-- 关键字 keywork

/* 2.2 检索单个列  Retrieving Individual Columns */
SELECT prod_name
FROM Products;

/*
+---------------------+
| prod_name           |
+---------------------+
| Fish bean bag toy   |
| Bird bean bag toy   |
| Rabbit bean bag toy |
| 8 inch teddy bear   |
| 12 inch teddy bear  |
| 18 inch teddy bear  |
| Raggedy Ann         |
| King doll           |
| Queen doll          |
+---------------------+
9 rows in set (0.00 sec)
*/

SELECT prod_name FROM Products;

SELECT
prod_name
FROM
Products;

/* 2.3 检索多个列  Retrieving Multiple Columns */
SELECT prod_id, prod_name, prod_price
FROM Products;

/*
+---------+---------------------+------------+
| prod_id | prod_name           | prod_price |
+---------+---------------------+------------+
| BNBG01  | Fish bean bag toy   |       3.49 |
| BNBG02  | Bird bean bag toy   |       3.49 |
| BNBG03  | Rabbit bean bag toy |       3.49 |
| BR01    | 8 inch teddy bear   |       5.99 |
| BR02    | 12 inch teddy bear  |       8.99 |
| BR03    | 18 inch teddy bear  |      11.99 |
| RGAN01  | Raggedy Ann         |       4.99 |
| RYL01   | King doll           |       9.49 |
| RYL02   | Queen doll          |       9.49 |
+---------+---------------------+------------+
9 rows in set (0.00 sec)
*/

/* 2.4 检索所有列  Retrieving All Columns */
SELECT *
FROM Products;

/*
+---------+---------+---------------------+------------+-----------------------------------------------------------------------+
| prod_id | vend_id | prod_name           | prod_price | prod_desc                                                             |
+---------+---------+---------------------+------------+-----------------------------------------------------------------------+
| BNBG01  | DLL01   | Fish bean bag toy   |       3.49 | Fish bean bag toy, complete with bean bag worms with which to feed it |
| BNBG02  | DLL01   | Bird bean bag toy   |       3.49 | Bird bean bag toy, eggs are not included                              |
| BNBG03  | DLL01   | Rabbit bean bag toy |       3.49 | Rabbit bean bag toy, comes with bean bag carrots                      |
| BR01    | BRS01   | 8 inch teddy bear   |       5.99 | 8 inch teddy bear, comes with cap and jacket                          |
| BR02    | BRS01   | 12 inch teddy bear  |       8.99 | 12 inch teddy bear, comes with cap and jacket                         |
| BR03    | BRS01   | 18 inch teddy bear  |      11.99 | 18 inch teddy bear, comes with cap and jacket                         |
| RGAN01  | DLL01   | Raggedy Ann         |       4.99 | 18 inch Raggedy Ann doll                                              |
| RYL01   | FNG01   | King doll           |       9.49 | 12 inch king doll with royal garments and crown                       |
| RYL02   | FNG01   | Queen doll          |       9.49 | 12 inch queen doll with royal garments and crown                      |
+---------+---------+---------------------+------------+-----------------------------------------------------------------------+
9 rows in set (0.00 sec)
*/

/* 2.5 检索不同的值  Retrieving Distinct Rows */
SELECT vend_id
FROM Products;

/*
+---------+
| vend_id |
+---------+
| BRS01   |
| BRS01   |
| BRS01   |
| DLL01   |
| DLL01   |
| DLL01   |
| DLL01   |
| FNG01   |
| FNG01   |
+---------+
9 rows in set (0.00 sec)
*/

-- 使用 DISTINCT 关键字。
SELECT DISTINCT vend_id
FROM Products;

/*
+---------+
| vend_id |
+---------+
| BRS01   |
| DLL01   |
| FNG01   |
+---------+
3 rows in set (0.00 sec)
*/

SELECT vend_id, prod_price
FROM Products;

/*
+---------+------------+
| vend_id | prod_price |
+---------+------------+
| DLL01   |       3.49 |
| DLL01   |       3.49 |
| DLL01   |       3.49 |
| BRS01   |       5.99 |
| BRS01   |       8.99 |
| BRS01   |      11.99 |
| DLL01   |       4.99 |
| FNG01   |       9.49 |
| FNG01   |       9.49 |
+---------+------------+
9 rows in set (0.00 sec)
*/

-- DISTINCT 作用于所有的列。
SELECT DISTINCT vend_id, prod_price
FROM Products;

/*
+---------+------------+
| vend_id | prod_price |
+---------+------------+
| DLL01   |       3.49 |
| BRS01   |       5.99 |
| BRS01   |       8.99 |
| BRS01   |      11.99 |
| DLL01   |       4.99 |
| FNG01   |       9.49 |
+---------+------------+
6 rows in set (0.00 sec)
*/

/* 2.6 限制结果  Limiting Results */
-- SQL Server
SELECT TOP 5 prod_name
FROM Products;

-- DB2
SELECT prod_name
FROM Products
FETCH FIRST 5 ROWS ONLY;

-- Oracle
SELECT prod_name
FROM Products
WHERE ROWNUM <= 5;

-- MySQL、MariaDB、PostgreSQL、SQLite
-- LIMIT 指定返回的行数。
SELECT prod_name
FROM Products
LIMIT 5;

/*
+---------------------+
| prod_name           |
+---------------------+
| Fish bean bag toy   |
| Bird bean bag toy   |
| Rabbit bean bag toy |
| 8 inch teddy bear   |
| 12 inch teddy bear  |
+---------------------+
5 rows in set (0.00 sec)
*/

-- OFFSET 从 0 开始。
SELECT prod_name
FROM Products
LIMIT 5 OFFSET 5;

/*
+--------------------+
| prod_name          |
+--------------------+
| 18 inch teddy bear |
| Raggedy Ann        |
| King doll          |
| Queen doll         |
+--------------------+
4 rows in set (0.00 sec)
*/

-- LIMIT 4 OFFSET 3 简化为 LIMIT 3, 4
SELECT prod_name
FROM Products
LIMIT 3,4;

/* 2.7 使用注释  Using Comments */
SELECT prod_name  -- 这是一条注释
FROM Products;

-- 部分 DBMS 不支持 #
# 这是一条注释
SELECT prod_name
FROM Products;

/* SELECT prod_name, vend_id
FROM Products; */
SELECT prod_name
FROM Products;

/* 2.8 小节  Summary */

/* 2.9 挑战题  Challenges */
