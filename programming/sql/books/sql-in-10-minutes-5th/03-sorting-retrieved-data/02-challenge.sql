/*
 * create time: 2026-08-18 09:17
 */

/* 1. */
SELECT cust_name
FROM Customers
ORDER BY cust_name DESC;

/*
+---------------+
| cust_name     |
+---------------+
| Village Toys  |
| The Toy Store |
| Kids Place    |
| Fun4All       |
| Fun4All       |
+---------------+
5 rows in set (0.01 sec)
*/

/* 2. */
SELECT cust_id, order_num
FROM Orders
ORDER BY cust_id, order_num DESC;

/*
+------------+-----------+
| cust_id    | order_num |
+------------+-----------+
| 1000000001 |     20009 |
| 1000000001 |     20005 |
| 1000000003 |     20006 |
| 1000000004 |     20007 |
| 1000000005 |     20008 |
+------------+-----------+
5 rows in set (0.01 sec)
*/

/* 3. */
SELECT order_num, item_price
FROM OrderItems
ORDER BY order_num DESC, item_price DESC;

/*
+-----------+------------+
| order_num | item_price |
+-----------+------------+
|     20009 |       2.49 |
|     20009 |       2.49 |
|     20009 |       2.49 |
|     20008 |      11.99 |
|     20008 |       4.99 |
|     20008 |       3.49 |
|     20008 |       3.49 |
|     20008 |       3.49 |
|     20007 |      11.49 |
|     20007 |       4.49 |
|     20007 |       2.99 |
|     20007 |       2.99 |
|     20007 |       2.99 |
|     20006 |      11.99 |
|     20006 |       8.99 |
|     20006 |       5.99 |
|     20005 |      10.99 |
|     20005 |       5.49 |
+-----------+------------+
18 rows in set (0.00 sec)
*/

/*
4. 
SELECT vend_name,
FROM Vendors
ORDER vend_name DESC;

1. vend_name 后面多个的 ,
2. ORDER 后面没有 BY
 */

SELECT vend_name
FROM Vendors
ORDER BY vend_name DESC;

/*
+-----------------+
| vend_name       |
+-----------------+
| Jouets et ours  |
| Furball Inc.    |
| Fun and Games   |
| Doll House Inc. |
| Bears R Us      |
| Bear Emporium   |
+-----------------+
6 rows in set (0.01 sec)
*/
