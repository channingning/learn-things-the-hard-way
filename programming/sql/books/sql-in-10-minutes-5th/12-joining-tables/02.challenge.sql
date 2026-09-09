/* 
 * create time: 2026-09-09 13:13
 */

/* 1. */
-- Equijoin syntax
SELECT cust_name, order_num
FROM Customers, Orders
WHERE Customers.cust_id = Orders.cust_id
ORDER BY cust_name;

/*
+---------------+-----------+
| cust_name     | order_num |
+---------------+-----------+
| Fun4All       |     20006 |
| Fun4All       |     20007 |
| The Toy Store |     20008 |
| Village Toys  |     20005 |
| Village Toys  |     20009 |
+---------------+-----------+
5 rows in set (0.00 sec)
*/

-- ANSI INNER JOIN syntax
SELECT cust_name, order_num
FROM Customers INNER JOIN Orders
  ON Customers.cust_id = Orders.cust_id
ORDER BY cust_name;

/*
+---------------+-----------+
| cust_name     | order_num |
+---------------+-----------+
| Fun4All       |     20006 |
| Fun4All       |     20007 |
| The Toy Store |     20008 |
| Village Toys  |     20005 |
| Village Toys  |     20009 |
+---------------+-----------+
5 rows in set (0.00 sec)
*/

SELECT cust_name, order_num
FROM Customers INNER JOIN Orders
  ON Orders.cust_id = Customers.cust_id
ORDER BY cust_name;

/*
+---------------+-----------+
| cust_name     | order_num |
+---------------+-----------+
| Fun4All       |     20006 |
| Fun4All       |     20007 |
| The Toy Store |     20008 |
| Village Toys  |     20005 |
| Village Toys  |     20009 |
+---------------+-----------+
5 rows in set (0.00 sec)
*/

SELECT cust_name, order_num
FROM Orders INNER JOIN Customers
  ON Orders.cust_id = Customers.cust_id
ORDER BY cust_name;

/*
+---------------+-----------+
| cust_name     | order_num |
+---------------+-----------+
| Fun4All       |     20006 |
| Fun4All       |     20007 |
| The Toy Store |     20008 |
| Village Toys  |     20005 |
| Village Toys  |     20009 |
+---------------+-----------+
5 rows in set (0.00 sec)
*/

SELECT cust_name, order_num
FROM Orders INNER JOIN Customers
  ON Customers.cust_id = Orders.cust_id
ORDER BY cust_name;

/*
+---------------+-----------+
| cust_name     | order_num |
+---------------+-----------+
| Fun4All       |     20006 |
| Fun4All       |     20007 |
| The Toy Store |     20008 |
| Village Toys  |     20005 |
| Village Toys  |     20009 |
+---------------+-----------+
5 rows in set (0.01 sec)
*/

/* 2. */
-- Solution using subqueries
SELECT cust_name,
       order_num,
       (SELECT SUM(item_price * quantity)
        FROM OrderItems
        WHERE Orders.order_num = OrderItems.order_num) AS OrderTotal
FROM Customers, Orders
WHERE Customers.cust_id = Orders.cust_id
ORDER BY cust_name, order_num;

/*
+---------------+-----------+------------+
| cust_name     | order_num | OrderTotal |
+---------------+-----------+------------+
| Fun4All       |     20006 |     329.60 |
| Fun4All       |     20007 |    1696.00 |
| The Toy Store |     20008 |     189.60 |
| Village Toys  |     20005 |    1648.00 |
| Village Toys  |     20009 |    1867.50 |
+---------------+-----------+------------+
5 rows in set (0.00 sec)
*/

-- Solution using joins
SELECT cust_name,
       Orders.order_num,
       SUM(item_price * quantity) AS OrderTotal
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
  AND Orders.order_num = OrderItems.order_num
GROUP BY cust_name, Orders.order_num
ORDER BY cust_name, order_num;

/*
+---------------+-----------+------------+
| cust_name     | order_num | OrderTotal |
+---------------+-----------+------------+
| Fun4All       |     20006 |     329.60 |
| Fun4All       |     20007 |    1696.00 |
| The Toy Store |     20008 |     189.60 |
| Village Toys  |     20005 |    1648.00 |
| Village Toys  |     20009 |    1867.50 |
+---------------+-----------+------------+
5 rows in set (0.00 sec)
*/

/* 3. */
SELECT cust_id, order_date
FROM Orders, OrderItems
WHERE Orders.order_num = OrderItems.order_num
  AND OrderItems.prod_id = 'BR01'
ORDER BY order_date;

/*
+------------+---------------------+
| cust_id    | order_date          |
+------------+---------------------+
| 1000000003 | 2020-01-12 00:00:00 |
| 1000000001 | 2020-05-01 00:00:00 |
+------------+---------------------+
2 rows in set (0.01 sec)
*/

/* 4. */
SELECT cust_email
FROM Customers
 INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
 INNER JOIN OrderItems ON Orders.order_num = OrderItems.order_num
WHERE prod_id = 'BR01';

/*
+-----------------------+
| cust_email            |
+-----------------------+
| sales@villagetoys.com |
| jjones@fun4all.com    |
+-----------------------+
2 rows in set (0.00 sec)
*/

/* 5. */
-- ANSI INNER JOIN syntax
SELECT cust_name, SUM(item_price * quantity) AS total_price
FROM Customers
  INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
  INNER JOIN OrderItems ON Orders.order_num = OrderItems.order_num
GROUP BY cust_name
HAVING SUM(item_price * quantity) >= 1000
ORDER BY cust_name;
/*
+--------------+-------------+
| cust_name    | total_price |
+--------------+-------------+
| Fun4All      |     2025.60 |
| Village Toys |     3515.50 |
+--------------+-------------+
2 rows in set (0.00 sec)
*/

-- Equijoin syntax
SELECT cust_name, SUM(item_price * quantity) AS total_price
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
  AND Orders.order_num = OrderItems.order_num
GROUP BY cust_name
HAVING SUM(item_price * quantity) >= 1000
ORDER BY cust_name;

/*
+--------------+-------------+
| cust_name    | total_price |
+--------------+-------------+
| Fun4All      |     2025.60 |
| Village Toys |     3515.50 |
+--------------+-------------+
2 rows in set (0.00 sec)
*/
