/* 
 * create time: 2026-08-25 09:13
 */

/* 9.1 聚集函数  Using Aggregate Functions */

-- SQL 聚集函数
-- 函数
    -- 说明
-- AVG()   
    -- 返回某列的平均值
-- COUNT()  
    -- 返回某列的行数
-- MAX()   
    -- 返回某列的最大值
-- MIN()   
    -- 返回某列的最小值
-- SUM()  
    -- 返回某列值之和

-- SQL Aggregate Functions
-- Function
    -- Description
-- AVG()
    -- Returns a column’s average value
-- COUNT()
    -- Returns the number of rows in a column
-- MAX()
    -- Returns a column’s highest value
-- MIN()
    -- Returns a column’s lowest value
-- SUM()
    -- Returns the sum of a column’s values

/* 9.1.1 AVG() 函数  The AVG() Function */
SELECT AVG(prod_price) AS avg_price
FROM Products;

/*
+-----------+
| avg_price |
+-----------+
|  6.823333 |
+-----------+
1 row in set (0.00 sec)
*/

SELECT AVG(prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

/*
+-----------+
| avg_price |
+-----------+
|  3.865000 |
+-----------+
1 row in set (0.00 sec)
*/

-- my test
SELECT AVG(order_item), AVG(item_price)
FROM OrderItems;

/*
+-----------------+-----------------+
| AVG(order_item) | AVG(item_price) |
+-----------------+-----------------+
|          2.5000 |        5.740000 |
+-----------------+-----------------+
1 row in set (0.00 sec)
*/

-- 说明：NULL 值
-- AVG() 函数会忽略值为 NULL 的行。
-- Note: NULL Values
-- Column rows containing NULL values are ignored by the AVG() function.

/* 9.1.2 COUNT() 函数  The COUNT() Function */

-- 备注：包含 NULL 值的行
SELECT COUNT(*) AS num_cust
FROM Customers;

/*
+----------+
| num_cust |
+----------+
|        5 |
+----------+
1 row in set (0.00 sec)
*/

-- 备注：不包含 NULL 值的行
SELECT COUNT(cust_email) AS num_cust
FROM Customers;

/*
+----------+
| num_cust |
+----------+
|        3 |
+----------+
1 row in set (0.00 sec)
*/

-- my test
SELECT cust_email
FROM Customers;

/*
+-----------------------+
| cust_email            |
+-----------------------+
| sales@villagetoys.com |
| NULL                  |
| jjones@fun4all.com    |
| dstephens@fun4all.com |
| NULL                  |
+-----------------------+
5 rows in set (0.00 sec)
*/

-- 说明：NULL 值 
-- 如果指定列名，则 COUNT()函数会忽略指定列的值为 NULL 的行，但如果 COUNT()函数中用的是星号（*），则不忽略。
-- Note: NULL Values
-- Column rows with NULL values in them are ignored by the COUNT() function if a column name is specified, but not if the asterisk (*) is used.

/* 9.1.3 MAX()函数  The MAX() Function */
SELECT MAX(prod_price) AS max_price 
FROM Products;

/*
+-----------+
| max_price |
+-----------+
|     11.99 |
+-----------+
1 row in set (0.00 sec)
*/

-- 提示：对非数值数据使用 MAX()
-- 在用于文本数据时，MAX()返回按该列排序后的最后一行。
-- Tip: Using MAX() with Nonnumeric Data
-- When used with textual data, MAX() returns the row that would be the last if the data were sorted by that column.

-- 说明：NULL 值 
-- MAX()函数忽略列值为 NULL 的行。
-- Note: NULL Values
-- Column rows with NULL values in them are ignored by the MAX() function.

/* 9.1.4 MIN()函数  The MIN() Function */
SELECT MIN(prod_price) AS min_price
FROM Products;

/*
+-----------+
| min_price |
+-----------+
|      3.49 |
+-----------+
1 row in set (0.00 sec)
*/

-- 提示：对非数值数据使用 MIN()
-- 在用于文本数据时，MIN()返回该列排序后最前面的行。
-- Tip: Using MIN() with Nonnumeric Data
-- When used with textual data, MIN() will return the row that would be first if the data were sorted by that column.

-- 说明：NULL 值
-- MIN()函数忽略列值为 NULL 的行。
-- Note: NULL Values
-- Column rows with NULL values in them are ignored by the MIN() function.

/* 9.1.5 SUM()函数  The SUM() Function */
SELECT SUM(quantity) AS items_ordered
FROM OrderItems
WHERE order_num = 20005;

/*
+---------------+
| items_ordered |
+---------------+
|           200 |
+---------------+
1 row in set (0.00 sec)
*/

SELECT SUM(item_price*quantity) AS total_price
FROM OrderItems
WHERE order_num = 20005;

/*
+-------------+
| total_price |
+-------------+
|     1648.00 |
+-------------+
1 row in set (0.00 sec)
*/

-- 说明：NULL 值
-- SUM()函数忽略列值为 NULL 的行。
-- Note: NULL Values
-- Column rows with NULL values in them are ignored by the SUM() function.

/* 9.2 聚集不同值  Aggregates on Distinct Values */
-- 提示：ALL 为默认
-- Tip: ALL Is Default

SELECT AVG(DISTINCT prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

/*
+-----------+
| avg_price |
+-----------+
|  4.240000 |
+-----------+
1 row in set (0.00 sec)
*/

-- 注意：DISTINCT 不能用于 COUNT(*) 
-- Caution: No DISTINCT with COUNT(*)

/* 9.3 组合聚集函数  Combining Aggregate Functions */
SELECT COUNT(*) AS num_items,
       MIN(prod_price) AS price_min,
       MAX(prod_price) AS price_max,
       AVG(prod_price) AS price_avg
FROM Products;

/*
+-----------+-----------+-----------+-----------+
| num_items | price_min | price_max | price_avg |
+-----------+-----------+-----------+-----------+
|         9 |      3.49 |     11.99 |  6.823333 |
+-----------+-----------+-----------+-----------+
1 row in set (0.00 sec)
*/

-- 注意：取别名
-- Caution: Naming Aliases

/* 9.4 小结  Summary */

/* 9.5 挑战题  Challenges */
