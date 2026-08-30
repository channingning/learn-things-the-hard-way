/*
 * create time: 2026-08-19 09:35
 */

/* 1. */
SELECT prod_id, prod_name
FROM Products
WHERE prod_price = 9.49;

/*
+---------+------------+
| prod_id | prod_name  |
+---------+------------+
| RYL01   | King doll  |
| RYL02   | Queen doll |
+---------+------------+
2 rows in set (0.00 sec)
*/

/* 2. */
SELECT prod_id, prod_name
FROM Products
WHERE prod_price >= 9;

/*
+---------+--------------------+
| prod_id | prod_name          |
+---------+--------------------+
| BR03    | 18 inch teddy bear |
| RYL01   | King doll          |
| RYL02   | Queen doll         |
+---------+--------------------+
3 rows in set (0.00 sec)
*/

/* 3. */
SELECT DISTINCT order_num
FROM OrderItems
WHERE quantity >=100;

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
SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 3 AND 6
ORDER BY prod_price;

/*
+---------------------+------------+
| prod_name           | prod_price |
+---------------------+------------+
| Fish bean bag toy   |       3.49 |
| Bird bean bag toy   |       3.49 |
| Rabbit bean bag toy |       3.49 |
| Raggedy Ann         |       4.99 |
| 8 inch teddy bear   |       5.99 |
+---------------------+------------+
5 rows in set (0.00 sec)
*/
