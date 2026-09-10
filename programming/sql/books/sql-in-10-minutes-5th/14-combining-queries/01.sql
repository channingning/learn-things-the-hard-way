/*
 * create time: 2026-09-10 08:44
 */

/* 14.1 组合查询  Understanding Combined Queries */
-- 并 union
-- 复合查询 compound query

/* 14.2 创建组合查询  Creating Combined Queries */

/* 14.2.1 使用UNION  Using UNION */
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL','IN','MI');

/*
+---------------+--------------+-----------------------+
| cust_name     | cust_contact | cust_email            |
+---------------+--------------+-----------------------+
| Village Toys  | John Smith   | sales@villagetoys.com |
| Fun4All       | Jim Jones    | jjones@fun4all.com    |
| The Toy Store | Kim Howard   | NULL                  |
+---------------+--------------+-----------------------+
3 rows in set (0.00 sec)
*/

SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';

/*
+-----------+--------------------+-----------------------+
| cust_name | cust_contact       | cust_email            |
+-----------+--------------------+-----------------------+
| Fun4All   | Jim Jones          | jjones@fun4all.com    |
| Fun4All   | Denise L. Stephens | dstephens@fun4all.com |
+-----------+--------------------+-----------------------+
2 rows in set (0.00 sec)
*/

SELECT cust_name, cust_contact, cust_email 
FROM Customers 
WHERE cust_state IN ('IL','IN','MI') 
UNION 
SELECT cust_name, cust_contact, cust_email 
FROM Customers 
WHERE cust_name = 'Fun4All';

/*
+---------------+--------------------+-----------------------+
| cust_name     | cust_contact       | cust_email            |
+---------------+--------------------+-----------------------+
| Village Toys  | John Smith         | sales@villagetoys.com |
| Fun4All       | Jim Jones          | jjones@fun4all.com    |
| The Toy Store | Kim Howard         | NULL                  |
| Fun4All       | Denise L. Stephens | dstephens@fun4all.com |
+---------------+--------------------+-----------------------+
4 rows in set (0.00 sec)
*/

/* 14.2.2 UNION规则  UNION Rules */

/* 14.2.3 包含或取消重复的行  Including or Eliminating Duplicate Rows */
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL','IN','MI')
UNION ALL
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';

/*
+---------------+--------------------+-----------------------+
| cust_name     | cust_contact       | cust_email            |
+---------------+--------------------+-----------------------+
| Village Toys  | John Smith         | sales@villagetoys.com |
| Fun4All       | Jim Jones          | jjones@fun4all.com    |
| The Toy Store | Kim Howard         | NULL                  |
| Fun4All       | Jim Jones          | jjones@fun4all.com    |
| Fun4All       | Denise L. Stephens | dstephens@fun4all.com |
+---------------+--------------------+-----------------------+
5 rows in set (0.00 sec)
*/

/* 14.2.4 对组合查询结果排序  Sorting Combined Query Results */
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL','IN','MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All'
ORDER BY cust_name, cust_contact;

/*
+---------------+--------------------+-----------------------+
| cust_name     | cust_contact       | cust_email            |
+---------------+--------------------+-----------------------+
| Fun4All       | Denise L. Stephens | dstephens@fun4all.com |
| Fun4All       | Jim Jones          | jjones@fun4all.com    |
| The Toy Store | Kim Howard         | NULL                  |
| Village Toys  | John Smith         | sales@villagetoys.com |
+---------------+--------------------+-----------------------+
4 rows in set (0.00 sec)
*/

/* 14.3 小结  Summary */

/* 14.4 挑战题  Challenges */
