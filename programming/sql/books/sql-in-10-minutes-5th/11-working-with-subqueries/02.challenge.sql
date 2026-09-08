/* 
 * create time: 2026-09-08 08:37
 */

/* 1. */
SELECT cust_id
FROM Orders
WHERE order_num IN (SELECT order_num
                   FROM OrderItems
                   WHERE item_price >=10);

/*
+------------+
| cust_id    |
+------------+
| 1000000001 |
| 1000000003 |
| 1000000004 |
| 1000000005 |
+------------+
4 rows in set (0.00 sec)
*/

/* 2. */
SELECT cust_id, order_date
FROM Orders
WHERE order_num IN (SELECT order_num
                    FROM OrderItems
                    WHERE prod_id = 'BR01')
ORDER BY order_date;

/*
+------------+---------------------+
| cust_id    | order_date          |
+------------+---------------------+
| 1000000003 | 2020-01-12 00:00:00 |
| 1000000001 | 2020-05-01 00:00:00 |
+------------+---------------------+
2 rows in set (0.00 sec)
*/

/* 3. */
SELECT cust_email
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN (SELECT order_num
                                      FROM OrderItems
                                      WHERE prod_id = 'BR01'));

/*
+-----------------------+
| cust_email            |
+-----------------------+
| sales@villagetoys.com |
| jjones@fun4all.com    |
+-----------------------+
2 rows in set (0.00 sec)
*/

/* 4. */
SELECT cust_id,
    (SELECT SUM(quantity * item_price) 
    FROM OrderItems 
    WHERE order_num IN (SELECT order_num
                        FROM Orders
                        WHERE Orders.cust_id = Customers.cust_id)) AS total_ordered
FROM Customers
ORDER BY total_ordered DESC;

/*
+------------+---------------+
| cust_id    | total_ordered |
+------------+---------------+
| 1000000001 |       3515.50 |
| 1000000004 |       1696.00 |
| 1000000003 |        329.60 |
| 1000000005 |        189.60 |
| 1000000002 |          NULL |
+------------+---------------+
5 rows in set (0.00 sec)
*/

/* 5. */
SELECT prod_name,
    (SELECT SUM(quantity)
     FROM OrderItems
     WHERE OrderItems.prod_id = Products.prod_id) AS quant_sold
FROM Products;

/*
+---------------------+------------+
| prod_name           | quant_sold |
+---------------------+------------+
| Fish bean bag toy   |        360 |
| Bird bean bag toy   |        360 |
| Rabbit bean bag toy |        360 |
| 8 inch teddy bear   |        120 |
| 12 inch teddy bear  |         10 |
| 18 inch teddy bear  |        165 |
| Raggedy Ann         |         55 |
| King doll           |       NULL |
| Queen doll          |       NULL |
+---------------------+------------+
9 rows in set (0.00 sec)
*/
