/*
 * create time: 2026-08-21 08:52
 */

/* 6.1 LIKE 操作符  Using the LIKE Operator */
-- 通配符 wildcard
-- 搜索模式 search pattern
-- 谓词 predicate

/* 6.1.1 百分号（%）通配符  The Percent Sign (%) Wildcard */
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE 'Fish%';

/*
+---------+-------------------+
| prod_id | prod_name         |
+---------+-------------------+
| BNBG01  | Fish bean bag toy |
+---------+-------------------+
1 row in set (0.01 sec)
*/

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%';

/*
+---------+---------------------+
| prod_id | prod_name           |
+---------+---------------------+
| BNBG01  | Fish bean bag toy   |
| BNBG02  | Bird bean bag toy   |
| BNBG03  | Rabbit bean bag toy |
+---------+---------------------+
3 rows in set (0.00 sec)
*/

SELECT prod_name
FROM Products
WHERE prod_name LIKE 'F%y';

/*
+-------------------+
| prod_name         |
+-------------------+
| Fish bean bag toy |
+-------------------+
1 row in set (0.00 sec)
*/

-- my test
SELECT prod_name
FROM Products
WHERE prod_name LIKE 'F%y%';

/*
+-------------------+
| prod_name         |
+-------------------+
| Fish bean bag toy |
+-------------------+
1 row in set (0.00 sec)
*/

/* 6.1.2 下划线（_）通配符  The Underscore (_) Wildcard */
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '__ inch teddy bear';

/*
+---------+--------------------+
| prod_id | prod_name          |
+---------+--------------------+
| BR02    | 12 inch teddy bear |
| BR03    | 18 inch teddy bear |
+---------+--------------------+
2 rows in set (0.00 sec)
*/

--my test
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '__ inch teddy bear%';

/*
+---------+--------------------+
| prod_id | prod_name          |
+---------+--------------------+
| BR02    | 12 inch teddy bear |
| BR03    | 18 inch teddy bear |
+---------+--------------------+
2 rows in set (0.00 sec)
*/

SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '% inch teddy bear';

/*
+---------+--------------------+
| prod_id | prod_name          |
+---------+--------------------+
| BR01    | 8 inch teddy bear  |
| BR02    | 12 inch teddy bear |
| BR03    | 18 inch teddy bear |
+---------+--------------------+
3 rows in set (0.00 sec)
*/

/* 6.1.3 方括号（[]）通配符  The Brackets ([]) Wildcard */
-- Note: Sets Are Not Commonly Supported
-- Sets are supported in Microsoft SQL Server,
-- not supported in MySQL, Oracle, DB2, and SQLite.
SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[JM]%'
ORDER BY cust_contact;

SELECT cust_contact
FROM Customers
WHERE cust_contact LIKE '[^JM]%'
ORDER BY cust_contact;

SELECT cust_contact
FROM Customers
WHERE NOT cust_contact LIKE '[JM]%'
ORDER BY cust_contact;

-- my test
SELECT cust_contact
FROM Customers
WHERE NOT (cust_contact LIKE 'J%' OR cust_contact LIKE 'M%')
ORDER BY cust_contact;

/*
+--------------------+
| cust_contact       |
+--------------------+
| Denise L. Stephens |
| Kim Howard         |
+--------------------+
2 rows in set (0.00 sec)
*/

/* 6.2 使用通配符的技巧  Tips for Using Wildcards */

/* 6.3 小结 Summary */

/* 6.4 挑战题  Challenges */
