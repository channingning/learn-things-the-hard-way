/*
 *create time: 2026-09-10 09:03
 */

/* 1. */
SELECT prod_id, quantity
FROM OrderItems
WHERE quantity = 100
UNION
SELECT prod_id, quantity
FROM OrderItems
WHERE prod_id LIKE 'BNBG%'
ORDER BY prod_id;

/*
+---------+----------+
| prod_id | quantity |
+---------+----------+
| BNBG01  |      100 |
| BNBG01  |       10 |
| BNBG01  |      250 |
| BNBG02  |      100 |
| BNBG02  |       10 |
| BNBG02  |      250 |
| BNBG03  |      100 |
| BNBG03  |       10 |
| BNBG03  |      250 |
| BR01    |      100 |
| BR03    |      100 |
+---------+----------+
11 rows in set (0.00 sec)
*/

/* 2. */
SELECT prod_id, quantity
FROM OrderItems
WHERE quantity = 100 or prod_id LIKE 'BNBG%'
ORDER BY prod_id;

/*
+---------+----------+
| prod_id | quantity |
+---------+----------+
| BNBG01  |      100 |
| BNBG01  |       10 |
| BNBG01  |      250 |
| BNBG02  |      100 |
| BNBG02  |       10 |
| BNBG02  |      250 |
| BNBG03  |      100 |
| BNBG03  |       10 |
| BNBG03  |      250 |
| BR01    |      100 |
| BR03    |      100 |
+---------+----------+
11 rows in set (0.00 sec)
*/

/* 3. */
SELECT prod_name
FROM Products
UNION
SELECT cust_name
FROM Customers
ORDER BY prod_name;

/*
+---------------------+
| prod_name           |
+---------------------+
| 12 inch teddy bear  |
| 18 inch teddy bear  |
| 8 inch teddy bear   |
| Bird bean bag toy   |
| Fish bean bag toy   |
| Fun4All             |
| Kids Place          |
| King doll           |
| Queen doll          |
| Rabbit bean bag toy |
| Raggedy Ann         |
| The Toy Store       |
| Village Toys        |
+---------------------+
13 rows in set (0.00 sec)
*/

-- my test
SELECT prod_name
FROM Products
UNION
SELECT cust_name AS prod_name
FROM Customers
ORDER BY prod_name;

/*
+---------------------+
| prod_name           |
+---------------------+
| 12 inch teddy bear  |
| 18 inch teddy bear  |
| 8 inch teddy bear   |
| Bird bean bag toy   |
| Fish bean bag toy   |
| Fun4All             |
| Kids Place          |
| King doll           |
| Queen doll          |
| Rabbit bean bag toy |
| Raggedy Ann         |
| The Toy Store       |
| Village Toys        |
+---------------------+
13 rows in set (0.00 sec)
*/

/* 
4.
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state  = 'MI'
ORDER BY cust_name;
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state = 'IL'ORDER BY cust_name;
*/

SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state = 'MI'
-- ORDER BY cust_name;
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state = 'IL'
ORDER BY cust_name;

/*
+---------------+--------------+-----------------------+
| cust_name     | cust_contact | cust_email            |
+---------------+--------------+-----------------------+
| The Toy Store | Kim Howard   | NULL                  |
| Village Toys  | John Smith   | sales@villagetoys.com |
+---------------+--------------+-----------------------+
2 rows in set (0.00 sec)
*/
