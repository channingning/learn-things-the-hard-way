/*
 * create time: 2026-08-22 08:49
 */
 
/* 7.1 计算字段  Understanding Calculated Fields */
-- 字段 field
-- 列 column

/* 7.2 拼接字段  Concatenating Fields */
-- 拼接 concatenate

-- SQL Server 使用 +
-- SQL Server uses + for concatenation.
SELECT vend_name + ' (' + vend_country + ')'
FROM Vendors
ORDER BY vend_name;

-- DB2、Oracle、PostgreSQO 和 SQLite 使用 ｜｜
-- DB2, Oracle, PostgreSQL, and SQLite support ||.
SELECT vend_name || ' (' || vend_country || ')'
FROM Vendors
ORDER BY vend_name;

-- MySQL 和 MariaDB 使用 Concat() 函数  补充
-- MySQL and MariaDB use Concat function for concatenation
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

SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
FROM Vendors
ORDER BY vend_name;

SELECT TRTIM(vend_name) || ' (' || RTRIM(vend_country) || ''
FROM Vendors
ORDER BY vend_name;

-- my test
SELECT Concat(RTRIM(vend_name), ' (', RTRIM(vend_country), ')')
FROM Vendors
ORDER BY vend_name;

/*
+----------------------------------------------------------+
| Concat(RTRIM(vend_name), ' (', RTRIM(vend_country), ')') |
+----------------------------------------------------------+
| Bear Emporium (USA)                                      |
| Bears R Us (USA)                                         |
| Doll House Inc. (USA)                                    |
| Fun and Games (England)                                  |
| Furball Inc. (USA)                                       |
| Jouets et ours (France)                                  |
+----------------------------------------------------------+
6 rows in set (0.00 sec)
 */

-- 使用别名  Using Aliases
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')' AS vend_title
FROM Vendors
ORDER BY vend_name;

SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')' AS vend_title
FROM Vendors
ORDER BY vend_name;

SELECT Concat(RTrim(vend_name), ' (',
       RTrim(vend_country), ')') AS vend_title
FROM Vendors
ORDER BY vend_name;

/*
+-------------------------+
| vend_title              |
+-------------------------+
| Bear Emporium (USA)     |
| Bears R Us (USA)        |
| Doll House Inc. (USA)   |
| Fun and Games (England) |
| Furball Inc. (USA)      |
| Jouets et ours (France) |
+-------------------------+
6 rows in set (0.00 sec)
*/

-- 字符串应该括在引号中
-- the string should be enclosed within quotes.
SELECT RTRIM(vend_name) || ' (' || RTRIM(vend_country) || ')' AS "vend title"
FROM Vendors
ORDER BY vend_name;

-- AS "vend title"  标识符引用 （名字，标准写法）  补充
SELECT Concat(RTrim(vend_name), ' (',
       RTrim(vend_country), ')') AS "vend title"
FROM Vendors
ORDER BY vend_name;

/*
+-------------------------+
| vend title              |
+-------------------------+
| Bear Emporium (USA)     |
| Bears R Us (USA)        |
| Doll House Inc. (USA)   |
| Fun and Games (England) |
| Furball Inc. (USA)      |
| Jouets et ours (France) |
+-------------------------+
6 rows in set (0.00 sec)
*/

-- AS 'vend title'  字符串字面量 （数据，非标准用法）  补充
-- 备注：‘vend title’ 复制到 mysql 交互式 命令行中会变成 vend title
SELECT Concat(RTrim(vend_name), ' (',
       RTrim(vend_country), ')') AS ‘vend title’
FROM Vendors
ORDER BY vend_name;

/*
+-------------------------+
| vend title              |
+-------------------------+
| Bear Emporium (USA)     |
| Bears R Us (USA)        |
| Doll House Inc. (USA)   |
| Fun and Games (England) |
| Furball Inc. (USA)      |
| Jouets et ours (France) |
+-------------------------+
6 rows in set (0.00 sec)
*/

/* 7.3 执行算术计算  Performing Mathematical Calculations */
SELECT prod_id, quantity, item_price
FROM OrderItems
WHERE order_num = 20008;

/*
+---------+----------+------------+
| prod_id | quantity | item_price |
+---------+----------+------------+
| RGAN01  |        5 |       4.99 |
| BR03    |        5 |      11.99 |
| BNBG01  |       10 |       3.49 |
| BNBG02  |       10 |       3.49 |
| BNBG03  |       10 |       3.49 |
+---------+----------+------------+
5 rows in set (0.00 sec)
*/

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

-- SQL 算术操作符  SQL Mathematical Operators
-- +    加  Addition
-- -    减  Subtraction
-- *    乘  Multiplication
-- /    除  Division

-- my test
SELECT 3 * 2;

/*
+-------+
| 3 * 2 |
+-------+
|     6 |
+-------+
1 row in set (0.00 sec)
*/

-- my test
SELECT Trim(' abc ');

/*
+---------------+
| Trim(' abc ') |
+---------------+
| abc           |
+---------------+
1 row in set (0.00 sec)
*/

/* 7.4 小结  Summary */

/* 7.5 挑战题  Challenges */
