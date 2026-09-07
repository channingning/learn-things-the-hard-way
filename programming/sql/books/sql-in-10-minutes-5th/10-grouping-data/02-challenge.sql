/* 
 * create time: 2026-09-07 18:30
 */

/* 1. */
SELECT order_num, COUNT(*) AS order_lines
FROM OrderItems
GROUP BY order_num
ORDER BY order_lines;

/*
+-----------+-------------+
| order_num | order_lines |
+-----------+-------------+
|     20005 |           2 |
|     20006 |           3 |
|     20009 |           3 |
|     20007 |           5 |
|     20008 |           5 |
+-----------+-------------+
5 rows in set (0.00 sec)
*/

/* 2. */
SELECT vend_id, MIN(prod_price) AS cheapest_item
FROM Products
GROUP BY vend_id
ORDER BY cheapest_item;

/*
+---------+---------------+
| vend_id | cheapest_item |
+---------+---------------+
| DLL01   |          3.49 |
| BRS01   |          5.99 |
| FNG01   |          9.49 |
+---------+---------------+
3 rows in set (0.00 sec)
*/

/* 3.  */
SELECT order_num
FROM OrderItems
GROUP BY order_num
HAVING SUM(quantity) >= 100
ORDER BY order_num;

/*
+-----------+
| order_num |
+-----------+
|     20005 |
|     20007 |
|     20009 |
+-----------+
3 rows in set (0.00 sec)
*/

/* 4. */
SELECT order_num, SUM(quantity*item_price) AS total_price
FROM OrderItems
GROUP BY order_num
HAVING total_price >= 1000
ORDER BY order_num;

/*
+-----------+-------------+
| order_num | total_price |
+-----------+-------------+
|     20005 |     1648.00 |
|     20007 |     1696.00 |
|     20009 |     1867.50 |
+-----------+-------------+
3 rows in set (0.00 sec)
*/

SELECT order_num, SUM(quantity*item_price) AS total_price
FROM OrderItems
GROUP BY order_num
HAVING SUM(quantity*item_price) >= 1000
ORDER BY order_num;

/*
+-----------+-------------+
| order_num | total_price |
+-----------+-------------+
|     20005 |     1648.00 |
|     20007 |     1696.00 |
|     20009 |     1867.50 |
+-----------+-------------+
3 rows in set (0.00 sec)
*/

/* 
5.
SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY items
HAVING COUNT(*) >= 3
ORDER BY items, order_num;
*/

-- GROUP BY items is incorrect. GROUP BY must be an actual column, not the one being used to perform the aggregate calculations. GROUP BY order_num would be allowed.
-- 使用 GROUP BY items 语句不正确。GROUP BY 必须指向一个实际存在的列，而不是用于执行聚合计算的列。可以使用 GROUP BY order_num 语句。

-- GROUP BY items 改为 GROUP BY order_num。
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
