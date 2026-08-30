/*
 * create time: 2026-08-20 09:56
 */

/* 1. */
SELECT vend_name
FROM Vendors
WHERE vend_country = 'USA' AND vend_state = 'CA';

/*
+-----------------+
| vend_name       |
+-----------------+
| Doll House Inc. |
+-----------------+
1 row in set (0.00 sec)
*/

/* 2. */
SELECT order_num, prod_id, quantity
FROM OrderItems
WHERE prod_id IN ('BR01', 'BR02', 'BR03') AND quantity >= 100;

/*
+-----------+---------+----------+
| order_num | prod_id | quantity |
+-----------+---------+----------+
|     20005 | BR01    |      100 |
|     20005 | BR03    |      100 |
+-----------+---------+----------+
2 rows in set (0.00 sec)
*/

SELECT order_num, prod_id, quantity
FROM OrderItems
WHERE (prod_id='BR01' OR prod_id='BR02' OR prod_id='BR03')
      AND quantity >=100;

/*
+-----------+---------+----------+
| order_num | prod_id | quantity |
+-----------+---------+----------+
|     20005 | BR01    |      100 |
|     20005 | BR03    |      100 |
+-----------+---------+----------+
2 rows in set (0.00 sec)
*/

/* 3. */
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

SELECT prod_name, prod_price
FROM Products
WHERE prod_price >= 3 AND prod_price <= 6
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

/*
4.
SELECT vend_name
FROM Vendors
ORDER BY vend_name
WHERE vend_country = 'USA' AND vend_state = 'CA';

1. ORDER BY 应该在 WHERE 后面
 */

SELECT vend_name
FROM Vendors
WHERE vend_country = 'USA' AND vend_state = 'CA'
ORDER BY vend_name;

/*
+-----------------+
| vend_name       |
+-----------------+
| Doll House Inc. |
+-----------------+
1 row in set (0.00 sec)
*/
