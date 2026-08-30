/*
 * create time: 2026-08-19 08:29
 */

/* 4.1 使用 WHERE 子句  Using the WHERE Clause */
-- 搜索条件 search criteria
-- 过滤条件 filter condition
SELECT prod_name, prod_price
FROM Products
WHERE prod_price = 3.49;

/*
+---------------------+------------+
| prod_name           | prod_price |
+---------------------+------------+
| Fish bean bag toy   |       3.49 |
| Bird bean bag toy   |       3.49 |
| Rabbit bean bag toy |       3.49 |
+---------------------+------------+
3 rows in set (0.00 sec)
*/

/* 4.2 WHERE 子句操作符  The WHERE Clause Operators */
-- =        等于  Equality
-- <>       不等于  Nonequality
-- !=       不等于  Nonequality
-- <        小于  Less than
-- <=       小于等于  Less than or equal to
-- !<       不小于  Not less than
-- >        大于  Greater than
-- >=       大于等于  Greater than or equal to
-- !>       不大于  Not greater than
-- BETWEEN  在指定的两个值之间  Between two specified values
-- IS NULL  为 NULL 值  Is a NULL value

/* 4.2.1 检索单个值  Checking Against a Single Value */
SELECT prod_name, prod_price
FROM Products
WHERE prod_price < 10;

/*
+---------------------+------------+
| prod_name           | prod_price |
+---------------------+------------+
| Fish bean bag toy   |       3.49 |
| Bird bean bag toy   |       3.49 |
| Rabbit bean bag toy |       3.49 |
| 8 inch teddy bear   |       5.99 |
| 12 inch teddy bear  |       8.99 |
| Raggedy Ann         |       4.99 |
| King doll           |       9.49 |
| Queen doll          |       9.49 |
+---------------------+------------+
8 rows in set (0.00 sec)
*/

SELECT prod_name, prod_price
FROM Products
WHERE prod_price <= 10;

/*
+---------------------+------------+
| prod_name           | prod_price |
+---------------------+------------+
| Fish bean bag toy   |       3.49 |
| Bird bean bag toy   |       3.49 |
| Rabbit bean bag toy |       3.49 |
| 8 inch teddy bear   |       5.99 |
| 12 inch teddy bear  |       8.99 |
| Raggedy Ann         |       4.99 |
| King doll           |       9.49 |
| Queen doll          |       9.49 |
+---------------------+------------+
8 rows in set (0.00 sec)
*/

/* 4.2.2 不匹配检查  Checking for Nonmatches */
SELECT vend_id, prod_name
FROM Products
WHERE vend_id <> 'DLL01';

/*
+---------+--------------------+
| vend_id | prod_name          |
+---------+--------------------+
| BRS01   | 8 inch teddy bear  |
| BRS01   | 12 inch teddy bear |
| BRS01   | 18 inch teddy bear |
| FNG01   | King doll          |
| FNG01   | Queen doll         |
+---------+--------------------+
5 rows in set (0.00 sec)
*/

SELECT vend_id, prod_name
FROM Products
WHERE vend_id != 'DLL01';

/*
+---------+--------------------+
| vend_id | prod_name          |
+---------+--------------------+
| BRS01   | 8 inch teddy bear  |
| BRS01   | 12 inch teddy bear |
| BRS01   | 18 inch teddy bear |
| FNG01   | King doll          |
| FNG01   | Queen doll         |
+---------+--------------------+
5 rows in set (0.00 sec)
*/

/* 4.2.3 范围检查  Checking for a Range of Values */
SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 5 AND 10;

/*
+--------------------+------------+
| prod_name          | prod_price |
+--------------------+------------+
| 8 inch teddy bear  |       5.99 |
| 12 inch teddy bear |       8.99 |
| King doll          |       9.49 |
| Queen doll         |       9.49 |
+--------------------+------------+
4 rows in set (0.00 sec)
*/

/* 4.2.4 空值检查  Checking for No Value */
SELECT prod_name
FROM Products
WHERE prod_price IS NULL;

/*
Empty set (0.00 sec)
*/

SELECT cust_name
FROM Customers
WHERE cust_email IS NULL;

/*
+---------------+
| cust_name     |
+---------------+
| Kids Place    |
| The Toy Store |
+---------------+
2 rows in set (0.00 sec)
*/

-- my test
SELECT cust_name, cust_email
FROM Customers
WHERE cust_email IS NULL;

/*
+---------------+------------+
| cust_name     | cust_email |
+---------------+------------+
| Kids Place    | NULL       |
| The Toy Store | NULL       |
+---------------+------------+
2 rows in set (0.00 sec)
*/

/* 4.3 小结  Summary*/

/* 4.4  挑战题  Challenges */
