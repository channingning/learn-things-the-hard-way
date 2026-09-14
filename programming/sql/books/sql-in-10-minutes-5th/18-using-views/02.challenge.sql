/*
 * create time: 2026-09-14 13:56
 */

/* 1. */
CREATE VIEW CustomersWithOrders AS
SELECT Customers.cust_id,
       Customers.cust_name,
       Customers.cust_address,
       Customers.cust_city,
       Customers.cust_state,
       Customers.cust_zip,
       Customers.cust_country,
       Customers.cust_contact,
       Customers.cust_email
FROM Customers
INNER JOIN Orders ON Customers.cust_id = Orders.cust_id;

/*
Query OK, 0 rows affected (0.01 sec)
*/

SELECT * FROM CustomersWithOrders;

/*
+------------+---------------+---------------------+-----------+------------+----------+--------------+--------------------+-----------------------+
| cust_id    | cust_name     | cust_address        | cust_city | cust_state | cust_zip | cust_country | cust_contact       | cust_email            |
+------------+---------------+---------------------+-----------+------------+----------+--------------+--------------------+-----------------------+
| 1000000001 | Village Toys  | 200 Maple Lane      | Detroit   | MI         | 44444    | USA          | John Smith         | sales@villagetoys.com |
| 1000000001 | Village Toys  | 200 Maple Lane      | Detroit   | MI         | 44444    | USA          | John Smith         | sales@villagetoys.com |
| 1000000003 | Fun4All       | 1 Sunny Place       | Muncie    | IN         | 42222    | USA          | Jim Jones          | jjones@fun4all.com    |
| 1000000004 | Fun4All       | 829 Riverside Drive | Phoenix   | AZ         | 88888    | USA          | Denise L. Stephens | dstephens@fun4all.com |
| 1000000005 | The Toy Store | 4545 53rd Street    | Chicago   | IL         | 54545    | USA          | Kim Howard         | NULL                  |
+------------+---------------+---------------------+-----------+------------+----------+--------------+--------------------+-----------------------+
5 rows in set (0.00 sec)
*/

/*
2.
CREATE VIEW OrderItemsExpanded AS
SELECT order_num,
       prod_id,
       quantity,
       item_price,
       quantity*item_price AS expanded_price
FROM OrderItems
ORDER BY order_num;
*/

CREATE VIEW OrderItemsExpanded AS
SELECT order_num,
       prod_id,
       quantity,
       item_price,
       quantity*item_price AS expanded_price
FROM OrderItems;

/*
Query OK, 0 rows affected (0.01 sec)
*/

-- ORDER BY order_num
-- ORDER BY is not allowed in views. Views are used like tables, if you need sorted data use ORDER BY in the SELECT that retrieves data from the view.

SELECT * FROM OrderItemsExpanded
ORDER BY order_num;

/*
+-----------+---------+----------+------------+----------------+
| order_num | prod_id | quantity | item_price | expanded_price |
+-----------+---------+----------+------------+----------------+
|     20005 | BR01    |      100 |       5.49 |         549.00 |
|     20005 | BR03    |      100 |      10.99 |        1099.00 |
|     20006 | BR01    |       20 |       5.99 |         119.80 |
|     20006 | BR02    |       10 |       8.99 |          89.90 |
|     20006 | BR03    |       10 |      11.99 |         119.90 |
|     20007 | BR03    |       50 |      11.49 |         574.50 |
|     20007 | BNBG01  |      100 |       2.99 |         299.00 |
|     20007 | BNBG02  |      100 |       2.99 |         299.00 |
|     20007 | BNBG03  |      100 |       2.99 |         299.00 |
|     20007 | RGAN01  |       50 |       4.49 |         224.50 |
|     20008 | RGAN01  |        5 |       4.99 |          24.95 |
|     20008 | BR03    |        5 |      11.99 |          59.95 |
|     20008 | BNBG01  |       10 |       3.49 |          34.90 |
|     20008 | BNBG02  |       10 |       3.49 |          34.90 |
|     20008 | BNBG03  |       10 |       3.49 |          34.90 |
|     20009 | BNBG01  |      250 |       2.49 |         622.50 |
|     20009 | BNBG02  |      250 |       2.49 |         622.50 |
|     20009 | BNBG03  |      250 |       2.49 |         622.50 |
+-----------+---------+----------+------------+----------------+
18 rows in set (0.00 sec)
*/
