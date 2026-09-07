/* 
 * create time: 2026-09-07 09:15
 */

/* 10.1 数据分组  Grouping Data */
SELECT COUNT(*) AS num_prods
FROM Products
WHERE vend_id ='DLL01';

/*
+-----------+
| num_prods |
+-----------+
|         4 |
+-----------+
1 row in set (0.00 sec)
*/

/* 10.2 创建分组  Creating Groups */
SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id;

/*
+---------+-----------+
| vend_id | num_prods |
+---------+-----------+
| BRS01   |         3 |
| DLL01   |         4 |
| FNG01   |         2 |
+---------+-----------+
3 rows in set (0.00 sec)
*/

/* 10.3 过滤分组  Filtering Groups */
-- WHERE 过滤行，而 HAVING 过滤分组。
-- The only difference is that WHERE filters rows and HAVING filters groups.
SELECT cust_id, COUNT(*) AS orders
FROM Orders
GROUP BY cust_id
HAVING COUNT(*) >= 2;

/*
+------------+--------+
| cust_id    | orders |
+------------+--------+
| 1000000001 |      2 |
+------------+--------+
1 row in set (0.00 sec)
*/
-- WHERE 在数据分组前进行过滤，HAVING 在数据分组后进行过滤。
-- WHERE filters before data is grouped, and HAVING filters after data is grouped.

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
WHERE prod_price >= 4
GROUP BY vend_id
HAVING COUNT(*) >= 2;

/*
+---------+-----------+
| vend_id | num_prods |
+---------+-----------+
| BRS01   |         3 |
| FNG01   |         2 |
+---------+-----------+
2 rows in set (0.00 sec)
*/

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id
HAVING COUNT(*) >= 2;

/*
+---------+-----------+
| vend_id | num_prods |
+---------+-----------+
| BRS01   |         3 |
| DLL01   |         4 |
| FNG01   |         2 |
+---------+-----------+
3 rows in set (0.00 sec)
*/

/* 10.4 分组和排序  Grouping and Sorting */
SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3;

/*
+-----------+-------+
| order_num | items |
+-----------+-------+
|     20006 |     3 |
|     20007 |     5 |
|     20008 |     5 |
|     20009 |     3 |
+-----------+-------+
4 rows in set (0.01 sec)
*/

SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;

/*
+-----------+-------+
| order_num | items |
+-----------+-------+
|     20006 |     3 |
|     20009 |     3 |
|     20007 |     5 |
|     20008 |     5 |
+-----------+-------+
4 rows in set (0.00 sec)
*/

/* 10.5 SELECT 子句顺序   */
-- SELECT子句及其顺序
-- 子句             说明              是否必须使用
-- SELECT     要返回的列或表达式           是
-- FROM       从中检索数据的表    仅在从表选择数据时使用
-- WHERE      行级过滤                   否
-- GROUP BY   分组说明           仅在按组计算聚集时使用 
-- HAVING     组级过滤                   否
-- ORDER BY   输出排序顺序                否

-- SELECT Clauses and Their Sequence
-- Clause        Description                                         Required
-- SELECT      Columns or expressions to be returned                    Yes
-- FROM        Table to retrieve data from              Only if selecting data from a table
-- WHERE       Row-level filtering                                      No
-- GROUP BY    Group specification                      Only if calculating aggregates by group
-- HAVING      Group-level filtering                                    No
-- ORDER BY    Output sort order                                        No

/* 10.6 小结  Summary */

/* 10.7 挑战题  Challenges */
