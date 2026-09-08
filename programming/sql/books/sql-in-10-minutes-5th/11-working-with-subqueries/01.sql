/* 
 * create time: 2026-09-08 08:10
 */

/* 11.1 子查询  Understanding Subqueries */
-- 查询 query
-- 子查询 subquery

/* 11.2 利用子查询进行过滤  Filtering by Subquery */
SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01';

/*
+-----------+
| order_num |
+-----------+
|     20007 |
|     20008 |
+-----------+
2 rows in set (0.00 sec)
*/

SELECT cust_id
FROM Orders
WHERE order_num IN (20007,20008);

/*
+------------+
| cust_id    |
+------------+
| 1000000004 |
| 1000000005 |
+------------+
2 rows in set (0.00 sec)
*/

SELECT cust_id
FROM Orders
WHERE order_num IN (SELECT order_num
                    FROM OrderItems
                    WHERE prod_id = 'RGAN01');

/*
+------------+
| cust_id    |
+------------+
| 1000000004 |
| 1000000005 |
+------------+
2 rows in set (0.00 sec)
*/
-- 在 SELECT 语句中，子查询总是从内向外处理。
-- Subqueries are always processed starting with the innermost SELECT statement and working outward.

SELECT cust_name, cust_contact 
FROM Customers 
WHERE cust_id IN (1000000004,1000000005);

/*
+---------------+--------------------+
| cust_name     | cust_contact       |
+---------------+--------------------+
| Fun4All       | Denise L. Stephens |
| The Toy Store | Kim Howard         |
+---------------+--------------------+
2 rows in set (0.01 sec)
*/

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN (SELECT order_num
                                      FROM OrderItems
                                      WHERE prod_id = 'RGAN01'));

/*
+---------------+--------------------+
| cust_name     | cust_contact       |
+---------------+--------------------+
| Fun4All       | Denise L. Stephens |
| The Toy Store | Kim Howard         |
+---------------+--------------------+
2 rows in set (0.00 sec)
*/

-- 注意：只能是单列
-- Caution: Single Column Only

/* 11.3 作为计算字段使用子查询  Using Subqueries as Calculated Fields */
SELECT COUNT(*) AS orders 
FROM Orders 
WHERE cust_id = 1000000001;

/*
+--------+
| orders |
+--------+
|      2 |
+--------+
1 row in set (0.00 sec)
*/

SELECT cust_name,
       cust_state,
       (SELECT COUNT(*)
        FROM Orders
        WHERE Orders.cust_id = Customers.cust_id) AS orders
FROM Customers
ORDER BY cust_name;

/*
+---------------+------------+--------+
| cust_name     | cust_state | orders |
+---------------+------------+--------+
| Fun4All       | IN         |      1 |
| Fun4All       | AZ         |      1 |
| Kids Place    | OH         |      0 |
| The Toy Store | IL         |      1 |
| Village Toys  | MI         |      2 |
+---------------+------------+--------+
5 rows in set (0.00 sec)
*/

SELECT COUNT(*)  FROM Orders WHERE cust_id = cust_id;

/*
+----------+
| COUNT(*) |
+----------+
|        5 |
+----------+
1 row in set (0.00 sec)
*/

SELECT cust_name,
       cust_state,
       (SELECT COUNT(*)
        FROM Orders
        WHERE cust_id = cust_id) AS orders
FROM Customers
ORDER BY cust_name;

/*
+---------------+------------+--------+
| cust_name     | cust_state | orders |
+---------------+------------+--------+
| Fun4All       | IN         |      5 |
| Fun4All       | AZ         |      5 |
| Kids Place    | OH         |      5 |
| The Toy Store | IL         |      5 |
| Village Toys  | MI         |      5 |
+---------------+------------+--------+
5 rows in set (0.00 sec)
*/

/* 11.4 小结  Summary */

/* 11.5 挑战题  Challenges */
