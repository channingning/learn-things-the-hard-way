/* 
 * create time: 2026-08-25 09:54
 */

/* 1. */
SELECT SUM(quantity) AS items_ordered
FROM OrderItems;

/*
+---------------+
| items_ordered |
+---------------+
|          1430 |
+---------------+
1 row in set (0.00 sec)
*/

/* 2. */
SELECT SUM(quantity) AS items_ordered
FROM OrderItems
WHERE prod_id = 'BR01';

/*
+---------------+
| items_ordered |
+---------------+
|           120 |
+---------------+
1 row in set (0.00 sec)
*/

/* 3. */
SELECT MAX(prod_price) AS max_price
FROM Products
WHERE prod_price <= 10;

/*
+-----------+
| max_price |
+-----------+
|      9.49 |
+-----------+
1 row in set (0.00 sec)
*/
