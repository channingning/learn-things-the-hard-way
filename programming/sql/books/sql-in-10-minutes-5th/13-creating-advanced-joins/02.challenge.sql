/*
 * create time: 2026-09-10 07:47
 */

/* 1. */
SELECT cust_name, order_num
FROM Customers
  INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
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

/* 2. */
SELECT cust_name, order_num
FROM Customers
  LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id
  ORDER BY cust_name;

/*
+---------------+-----------+
| cust_name     | order_num |
+---------------+-----------+
| Fun4All       |     20006 |
| Fun4All       |     20007 |
| Kids Place    |      NULL |
| The Toy Store |     20008 |
| Village Toys  |     20005 |
| Village Toys  |     20009 |
+---------------+-----------+
6 rows in set (0.00 sec)
*/

/* 3. */
SELECT prod_name, order_num
FROM Products
  LEFT OUTER JOIN OrderItems ON Products.prod_id = OrderItems.prod_id
ORDER BY prod_name;

/*
+---------------------+-----------+
| prod_name           | order_num |
+---------------------+-----------+
| 12 inch teddy bear  |     20006 |
| 18 inch teddy bear  |     20005 |
| 18 inch teddy bear  |     20006 |
| 18 inch teddy bear  |     20007 |
| 18 inch teddy bear  |     20008 |
| 8 inch teddy bear   |     20005 |
| 8 inch teddy bear   |     20006 |
| Bird bean bag toy   |     20007 |
| Bird bean bag toy   |     20008 |
| Bird bean bag toy   |     20009 |
| Fish bean bag toy   |     20007 |
| Fish bean bag toy   |     20008 |
| Fish bean bag toy   |     20009 |
| King doll           |      NULL |
| Queen doll          |      NULL |
| Rabbit bean bag toy |     20007 |
| Rabbit bean bag toy |     20008 |
| Rabbit bean bag toy |     20009 |
| Raggedy Ann         |     20007 |
| Raggedy Ann         |     20008 |
+---------------------+-----------+
20 rows in set (0.00 sec)
*/

/* 4. */
SELECT prod_name, COUNT(order_num) AS orders
FROM Products
  LEFT OUTER JOIN OrderItems ON Products.prod_id = OrderItems.prod_id
GROUP BY prod_name
ORDER BY prod_name;

/*
+---------------------+--------+
| prod_name           | orders |
+---------------------+--------+
| 12 inch teddy bear  |      1 |
| 18 inch teddy bear  |      4 |
| 8 inch teddy bear   |      2 |
| Bird bean bag toy   |      3 |
| Fish bean bag toy   |      3 |
| King doll           |      0 |
| Queen doll          |      0 |
| Rabbit bean bag toy |      3 |
| Raggedy Ann         |      2 |
+---------------------+--------+
9 rows in set (0.00 sec)
*/

/* 5. */
SELECT Vendors.vend_id, COUNT(prod_id)
FROM Vendors
  LEFT OUTER JOIN Products ON Vendors.vend_id = Products.vend_id
GROUP BY Vendors.vend_id;

/*
+---------+----------------+
| vend_id | COUNT(prod_id) |
+---------+----------------+
| BRE02   |              0 |
| BRS01   |              3 |
| DLL01   |              4 |
| FNG01   |              2 |
| FRB01   |              0 |
| JTS01   |              0 |
+---------+----------------+
6 rows in set (0.00 sec)
*/
