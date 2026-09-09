/*
 * create time: 2026-09-09 18:00
 */

/* 13.1 使用表别名  Using Table Aliases */
SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
    AS vend_title 
FROM Vendors
ORDER BY vend_name;

SELECT cust_name, cust_contact
FROM Customers AS C, Orders AS O, OrderItems AS OI
WHERE C.cust_id = O.cust_id
  AND OI.order_num = O.order_num
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

/* 13.2 使用不同类型的联结  Using Different Join Types */
-- 自联结 self-join
-- 自然联结 natural join
-- 外联结 outer join

/* 13.2.1 自联结  Self Joins */
SELECT cust_id, cust_name, cust_contact
FROM Customers
WHERE cust_name = (SELECT cust_name
                   FROM Customers
                   WHERE cust_contact = 'Jim Jones');

/*
+------------+-----------+--------------------+
| cust_id    | cust_name | cust_contact       |
+------------+-----------+--------------------+
| 1000000003 | Fun4All   | Jim Jones          |
| 1000000004 | Fun4All   | Denise L. Stephens |
+------------+-----------+--------------------+
2 rows in set (0.01 sec)
*/

SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1, Customers AS c2
WHERE c1.cust_name = c2.cust_name
  AND c2.cust_contact = 'Jim Jones';

/*
+------------+-----------+--------------------+
| cust_id    | cust_name | cust_contact       |
+------------+-----------+--------------------+
| 1000000003 | Fun4All   | Jim Jones          |
| 1000000004 | Fun4All   | Denise L. Stephens |
+------------+-----------+--------------------+
2 rows in set (0.00 sec)
*/

/* 13.2.2 自然联结  Natural Joins */
SELECT C.*, O.order_num, O.order_date,
       OI.prod_id, OI.quantity, OI.item_price
FROM Customers AS C, Orders AS O,
     OrderItems AS OI
WHERE C.cust_id = O.cust_id
 AND OI.order_num = O.order_num
 AND prod_id = 'RGAN01';

/*
+------------+---------------+---------------------+-----------+------------+----------+--------------+--------------------+-----------------------+-----------+---------------------+---------+----------+------------+
| cust_id    | cust_name     | cust_address        | cust_city | cust_state | cust_zip | cust_country | cust_contact       | cust_email            | order_num | order_date          | prod_id | quantity | item_price |
+------------+---------------+---------------------+-----------+------------+----------+--------------+--------------------+-----------------------+-----------+---------------------+---------+----------+------------+
| 1000000004 | Fun4All       | 829 Riverside Drive | Phoenix   | AZ         | 88888    | USA          | Denise L. Stephens | dstephens@fun4all.com |     20007 | 2020-01-30 00:00:00 | RGAN01  |       50 |       4.49 |
| 1000000005 | The Toy Store | 4545 53rd Street    | Chicago   | IL         | 54545    | USA          | Kim Howard         | NULL                  |     20008 | 2020-02-03 00:00:00 | RGAN01  |        5 |       4.99 |
+------------+---------------+---------------------+-----------+------------+----------+--------------+--------------------+-----------------------+-----------+---------------------+---------+----------+------------+
2 rows in set (0.00 sec)
*/

/* 13.2.3 外联结  Outer Joins */
SELECT Customers.cust_id, Orders.order_num
FROM Customers
 INNER JOIN Orders ON Customers.cust_id = Orders.cust_id;

/*
+------------+-----------+
| cust_id    | order_num |
+------------+-----------+
| 1000000001 |     20005 |
| 1000000001 |     20009 |
| 1000000003 |     20006 |
| 1000000004 |     20007 |
| 1000000005 |     20008 |
+------------+-----------+
5 rows in set (0.00 sec)
*/
SELECT Customers.cust_id, Orders.order_num
FROM Customers
  LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;

/*
+------------+-----------+
| cust_id    | order_num |
+------------+-----------+
| 1000000001 |     20005 |
| 1000000001 |     20009 |
| 1000000002 |      NULL |
| 1000000003 |     20006 |
| 1000000004 |     20007 |
| 1000000005 |     20008 |
+------------+-----------+
6 rows in set (0.00 sec)
*/

-- 记忆口诀："保左弃右"（左表全保留，右表不匹配的丢弃）
| A.id | A.name | B.a_id | B.score |
|  1   |  Alice |   1    |   90    |
|  2   |   Bob  |  NULL  |   NULL  | ← B中无匹配，填NULL
|  3   |  Carol |   3    |   85    |

SELECT Customers.cust_id, Orders.order_num
FROM Customers
  RIGHT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;

/*
+------------+-----------+
| cust_id    | order_num |
+------------+-----------+
| 1000000001 |     20005 |
| 1000000001 |     20009 |
| 1000000003 |     20006 |
| 1000000004 |     20007 |
| 1000000005 |     20008 |
+------------+-----------+
5 rows in set (0.00 sec)
*/

-- -- 记忆口诀： "保右弃左"（右表全保留，左表不匹配的丢弃）
| A.id | A.name | B.a_id | B.score |
|   1  |  Alice |   1    |   90    |
| NULL |  NULL  |   4    |   70    | ← A中无匹配，填NULL
|   3  |  Carol |   3    |   85    |

-- 全外联结 full outer join
SELECT Customers.cust_id, Orders.order_num
FROM Customers
  FULL OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;
-- MySQL / MariaDB 不支持
-- ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id' at line 3

-- sqlie
/*
+------------+-----------+
|  cust_id   | order_num |
+------------+-----------+
| 1000000001 | 20005     |
| 1000000001 | 20009     |
| 1000000002 |           |
| 1000000003 | 20006     |
| 1000000004 | 20007     |
| 1000000005 | 20008     |
+------------+-----------+
*/

-- my test  MySQL/MariaDB 另一种实现
-- 左表全部 + 右表匹配
SELECT Customers.cust_id, Orders.order_num
FROM Customers
LEFT JOIN Orders ON Customers.cust_id = Orders.cust_id

UNION

-- 右表全部 + 左表匹配（即左表中未匹配的部分）
SELECT Customers.cust_id, Orders.order_num
FROM Customers
RIGHT JOIN Orders ON Customers.cust_id = Orders.cust_id;

/*
+------------+-----------+
| cust_id    | order_num |
+------------+-----------+
| 1000000001 |     20005 |
| 1000000001 |     20009 |
| 1000000002 |      NULL |
| 1000000003 |     20006 |
| 1000000004 |     20007 |
| 1000000005 |     20008 |
+------------+-----------+
6 rows in set (0.01 sec)
*/

/* 13.3 使用带聚集函数的联结  Using Joins with Aggregate Functions */
SELECT Customers.cust_id,
       COUNT(Orders.order_num) AS num_ord
FROM Customers
  INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

/*
+------------+---------+
| cust_id    | num_ord |
+------------+---------+
| 1000000001 |       2 |
| 1000000003 |       1 |
| 1000000004 |       1 |
| 1000000005 |       1 |
+------------+---------+
4 rows in set (0.00 sec)
*/

SELECT Customers.cust_id,
       COUNT(Orders.order_num) AS num_ord
FROM Customers
  LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

/*
+------------+---------+
| cust_id    | num_ord |
+------------+---------+
| 1000000001 |       2 |
| 1000000002 |       0 |
| 1000000003 |       1 |
| 1000000004 |       1 |
| 1000000005 |       1 |
+------------+---------+
5 rows in set (0.00 sec)
*/

/* 13.4 使用联结和联结条件  Using Joins and Join Conditions */

/* 13.5 小结  Summary */

/* 13.6 挑战题  Challenges */
