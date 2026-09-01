/*
 * create time: 2026-08-23 18:29
 */

/* 8.1 函数  Understanding Functions */

/* 函数带来的问题  The Problem with Functions */

-- DBMS 函数的差异
-- 提取字符串的组成部分：未测试
    -- 函数
            -- 语法
    -- SUBSTR()
        -- DB2、Oracle、PostgreSQL 和 SQLite
    -- SUBSTRING()
        -- MariaDB、MySQL 和 SQL Server

-- 数据类型转换：未测试
    -- CAST()
        -- DB2 和 PostgreSQL
    -- CONVERT()
        -- MariaDB、MySQL 和 SQL Server

-- 取当前日期：未测试
    -- CURRENT_DATE
        -- DB2 和 PostgreSQL
    -- CURDATE()
        -- MariaDB 和 MySQL
    -- SYSDATE
        -- Oracle
    -- GETDATE()
        -- SQL Server
    -- DATE()
        -- SQLite

-- DBMS Function Differences
    -- Function
        -- Syntax
-- Extract part of a string
    -- SUBSTR()
        -- DB2, Oracle, PostgreSQL, and SQLite
    -- SUBSTRING()
        -- MariaDB, MySQL, and SQL Server
-- Datatype conversion
    -- CAST()
        -- DB2, PostgreSQL, and SQL Server(备注：SQL Server 都支持)
    -- CONVERT()
        -- MariaDB, MySQL, and SQL Server
-- Get current date
    -- CURRENT_DATE
        -- DB2 and PostgreSQL
    -- CURDATE()
        -- MySQL
    -- SYSDATE
        -- Oracle
    -- GETDATE()
        -- SQL Server
    -- DATE()
        -- SQLite

-- 可移植 portable

/* 8.2 使用函数  Using Functions */

/* 8.2.1 文本处理函数  Text Manipulation Functions */
SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
FROM Vendors
ORDER BY vend_name;

/*
+-----------------+------------------+
| vend_name       | vend_name_upcase |
+-----------------+------------------+
| Bear Emporium   | BEAR EMPORIUM    |
| Bears R Us      | BEARS R US       |
| Doll House Inc. | DOLL HOUSE INC.  |
| Fun and Games   | FUN AND GAMES    |
| Furball Inc.    | FURBALL INC.     |
| Jouets et ours  | JOUETS ET OURS   |
+-----------------+------------------+
6 rows in set (0.01 sec)
*/

-- upper(), UPPER(), Upper(), substr(), SUBSTR(), SubStr()...

-- 常用的文本处理函数
-- 函数
--     说明
-- LEFT()（或使用子字符串函数）               
--     返回字符串左边的字符
-- LENGTH()（也使用 DATA_LENGTH()）
--     返回字符串的长度
-- LOWER()
--     将字符串转化为小写
-- LTRIM()
--     去掉字符串左边的空格
-- RIGHT()（或使用子字符串函数）
--     返回字符串右边的字符
-- RTRIM()
--     去掉字符串右边的空格
-- SUBSTR() 或 SUBSTRING()
--     提取字符串的组成部分
-- SOUNDEX()
--     返回字符串的 SOUNDEX 值    声学索引
-- UPPER()
--     将字符串转换为大写

-- Commonly Used Text Manipulation Functions
-- Function
--     Description
-- LEFT() (or use substring function)
--     Returns characters from left of string
-- LENGTH() (also DATALENGTH() or LEN())
--     Returns the length of a string
-- LOWER()
--     Converts string to lowercase
-- LTRIM()
--     Trims white space from left of string
-- RIGHT() (or use substring function)
--     Returns characters from right of string
-- RTRIM()
--     Trims white space from right of string
-- SUBSTR() or SUBSTRING()
--     Extracts part of a string (as noted in Table 8.1)
-- SOUNDEX()
--     Returns a string’s SOUNDEX value
-- UPPER()
--     Converts string to uppercase

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_contact = 'Michael Green';

/*
Empty set (0.00 sec)
*/

SELECT cust_name, cust_contact
FROM Customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

/*
+------------+----------------+
| cust_name  | cust_contact   |
+------------+----------------+
| Kids Place | Michelle Green |
+------------+----------------+
1 row in set (0.00 sec)
*/

/* 8.2.2 日期和时间处理函数  Date and Time Manipulation Functions */
-- SQL Server: DATEPART()
SELECT order_num
FROM Orders
WHERE DATEPART(yy, order_date) = 2020;

SELECT order_num
FROM Orders
WHERE EXTRACT(year FROM order_date) = 2020;

SELECT order_num
FROM Orders
WHERE order_date BETWEEN DATEPART('2020-01-01', 'yyyy-mm-dd')
    AND DATEPART('2020-12-31', 'yyyy-mm-dd');

-- PostgreSQL: DATE_PART()
SELECT order_num
FROM Orders
WHERE DATE_PART('year', order_date) = 2020;

-- Oracle has no DATEPART()
SELECT order_num
FROM Orders
WHERE EXTRACT(year FROM order_date) = 2020;

SELECT order_num
FROM Orders
WHERE order_date BETWEEN to_date('2020-01-01', 'yyyy-mm-dd')
    AND to_date('2020-12-31', 'yyyy-mm-dd');

-- MySQL, MariaDB
-- YEAR()
SELECT order_num
FROM Orders
WHERE YEAR(order_date) = 2020;

/*
+-----------+
| order_num |
+-----------+
|     20005 |
|     20006 |
|     20007 |
|     20008 |
|     20009 |
+-----------+
5 rows in set (0.00 sec)
*/

-- SQLite
SELECT order_num
FROM Orders
WHERE strftime('%Y', order_date) = '2020';

/*
+-----------+
| order_num |
+-----------+
| 20005     |
| 20006     |
| 20007     |
| 20008     |
| 20009     |
+-----------+
*/

/* 8.2.3 数值处理函数  Numeric Manipulation Functions */
-- 常用数值处理函数  Commonly Used Numeric Manipulation Functions
-- ABS()
--     返回一个数的绝对值  Returns a number’s absolute value
-- COS()
--     返回一个角度的余弦  Returns the trigonometric cosine of a specified angle
-- EXP()
--     返回一个数的指数值  Returns the exponential value of a specific number
-- PI()
--     返回圆周率π的值  Returns the value of PI
-- SIN()
--     返回一个角度的正弦  Returns the trigonometric sine of a specified angle
-- SQRT()
--     返回一个数的平方根  Returns the square root of a specified number
-- TAN()
--     返回一个角度的正切  Returns the trigonometric tangent of a specified angle

/* 8.3 小结 Summary */

/* 8.4 挑战题 Challenges */
