/* 
 * create time: 2026-09-09 12:46
 */

/* 12.1 联结  Understanding Joins */

/* 12.1.1 关系表  Understanding Relational Tables */
-- 可伸缩 scale
-- 可伸缩性好 scale well

/* 12.1.2 为什么使用联结  Why Use Joins? */

/* 12.2 创建联结  Creating a Join */
SELECT vend_name, prod_name, prod_price
FROM Vendors, Products
WHERE Vendors.vend_id = Products.vend_id;

/*
+-----------------+---------------------+------------+
| vend_name       | prod_name           | prod_price |
+-----------------+---------------------+------------+
| Doll House Inc. | Fish bean bag toy   |       3.49 |
| Doll House Inc. | Bird bean bag toy   |       3.49 |
| Doll House Inc. | Rabbit bean bag toy |       3.49 |
| Bears R Us      | 8 inch teddy bear   |       5.99 |
| Bears R Us      | 12 inch teddy bear  |       8.99 |
| Bears R Us      | 18 inch teddy bear  |      11.99 |
| Doll House Inc. | Raggedy Ann         |       4.99 |
| Fun and Games   | King doll           |       9.49 |
| Fun and Games   | Queen doll          |       9.49 |
+-----------------+---------------------+------------+
9 rows in set (0.00 sec)
*/

/* 12.2.1 WHERE子句的重要性  The Importance of the WHERE Clause */
-- 笛卡儿积 cartesian product

SELECT vend_name, prod_name, prod_price 
FROM Vendors, Products;

/*
+-----------------+---------------------+------------+
| vend_name       | prod_name           | prod_price |
+-----------------+---------------------+------------+
| Jouets et ours  | Fish bean bag toy   |       3.49 |
| Furball Inc.    | Fish bean bag toy   |       3.49 |
| Fun and Games   | Fish bean bag toy   |       3.49 |
| Doll House Inc. | Fish bean bag toy   |       3.49 |
| Bears R Us      | Fish bean bag toy   |       3.49 |
| Bear Emporium   | Fish bean bag toy   |       3.49 |
| Jouets et ours  | Bird bean bag toy   |       3.49 |
| Furball Inc.    | Bird bean bag toy   |       3.49 |
| Fun and Games   | Bird bean bag toy   |       3.49 |
| Doll House Inc. | Bird bean bag toy   |       3.49 |
| Bears R Us      | Bird bean bag toy   |       3.49 |
| Bear Emporium   | Bird bean bag toy   |       3.49 |
| Jouets et ours  | Rabbit bean bag toy |       3.49 |
| Furball Inc.    | Rabbit bean bag toy |       3.49 |
| Fun and Games   | Rabbit bean bag toy |       3.49 |
| Doll House Inc. | Rabbit bean bag toy |       3.49 |
| Bears R Us      | Rabbit bean bag toy |       3.49 |
| Bear Emporium   | Rabbit bean bag toy |       3.49 |
| Jouets et ours  | 8 inch teddy bear   |       5.99 |
| Furball Inc.    | 8 inch teddy bear   |       5.99 |
| Fun and Games   | 8 inch teddy bear   |       5.99 |
| Doll House Inc. | 8 inch teddy bear   |       5.99 |
| Bears R Us      | 8 inch teddy bear   |       5.99 |
| Bear Emporium   | 8 inch teddy bear   |       5.99 |
| Jouets et ours  | 12 inch teddy bear  |       8.99 |
| Furball Inc.    | 12 inch teddy bear  |       8.99 |
| Fun and Games   | 12 inch teddy bear  |       8.99 |
| Doll House Inc. | 12 inch teddy bear  |       8.99 |
| Bears R Us      | 12 inch teddy bear  |       8.99 |
| Bear Emporium   | 12 inch teddy bear  |       8.99 |
| Jouets et ours  | 18 inch teddy bear  |      11.99 |
| Furball Inc.    | 18 inch teddy bear  |      11.99 |
| Fun and Games   | 18 inch teddy bear  |      11.99 |
| Doll House Inc. | 18 inch teddy bear  |      11.99 |
| Bears R Us      | 18 inch teddy bear  |      11.99 |
| Bear Emporium   | 18 inch teddy bear  |      11.99 |
| Jouets et ours  | Raggedy Ann         |       4.99 |
| Furball Inc.    | Raggedy Ann         |       4.99 |
| Fun and Games   | Raggedy Ann         |       4.99 |
| Doll House Inc. | Raggedy Ann         |       4.99 |
| Bears R Us      | Raggedy Ann         |       4.99 |
| Bear Emporium   | Raggedy Ann         |       4.99 |
| Jouets et ours  | King doll           |       9.49 |
| Furball Inc.    | King doll           |       9.49 |
| Fun and Games   | King doll           |       9.49 |
| Doll House Inc. | King doll           |       9.49 |
| Bears R Us      | King doll           |       9.49 |
| Bear Emporium   | King doll           |       9.49 |
| Jouets et ours  | Queen doll          |       9.49 |
| Furball Inc.    | Queen doll          |       9.49 |
| Fun and Games   | Queen doll          |       9.49 |
| Doll House Inc. | Queen doll          |       9.49 |
| Bears R Us      | Queen doll          |       9.49 |
| Bear Emporium   | Queen doll          |       9.49 |
+-----------------+---------------------+------------+
54 rows in set (0.01 sec)
*/

-- 返回笛卡儿积的联结，也称叉联结（cross join）。

/* 12.2.2 内联结  Inner Joins */
-- 等值联结 equijoin
-- 基于两个表之间的相等测试

SELECT vend_name, prod_name, prod_price
FROM Vendors
INNER JOIN Products ON Vendors.vend_id = Products.vend_id;

/*
+-----------------+---------------------+------------+
| vend_name       | prod_name           | prod_price |
+-----------------+---------------------+------------+
| Doll House Inc. | Fish bean bag toy   |       3.49 |
| Doll House Inc. | Bird bean bag toy   |       3.49 |
| Doll House Inc. | Rabbit bean bag toy |       3.49 |
| Bears R Us      | 8 inch teddy bear   |       5.99 |
| Bears R Us      | 12 inch teddy bear  |       8.99 |
| Bears R Us      | 18 inch teddy bear  |      11.99 |
| Doll House Inc. | Raggedy Ann         |       4.99 |
| Fun and Games   | King doll           |       9.49 |
| Fun and Games   | Queen doll          |       9.49 |
+-----------------+---------------------+------------+
9 rows in set (0.00 sec)
*/

/* 12.2.3 联结多个表  Joining Multiple Tables */
SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems, Products, Vendors
WHERE Products.vend_id = Vendors.vend_id
  AND OrderItems.prod_id = Products.prod_id
  AND order_num = 20007;

/*
+---------------------+-----------------+------------+----------+
| prod_name           | vend_name       | prod_price | quantity |
+---------------------+-----------------+------------+----------+
| 18 inch teddy bear  | Bears R Us      |      11.99 |       50 |
| Fish bean bag toy   | Doll House Inc. |       3.49 |      100 |
| Bird bean bag toy   | Doll House Inc. |       3.49 |      100 |
| Rabbit bean bag toy | Doll House Inc. |       3.49 |      100 |
| Raggedy Ann         | Doll House Inc. |       4.99 |       50 |
+---------------------+-----------------+------------+----------+
5 rows in set (0.00 sec)
*/

SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN (SELECT order_num
                                      FROM OrderItems
                                      WHERE prod_id = 'RGAN01'));
/*
+---------------+--------------------+
| cust_name     | cust_contact       |
+---------------+--------------------+
| Fun4All       | Denise L. Stephens |
| The Toy Store | Kim Howard         |
+---------------+--------------------+
2 rows in set (0.00 sec)
*/

SELECT cust_name, cust_contact
FROM Customers, Orders, OrderItems
WHERE Customers.cust_id = Orders.cust_id
  AND OrderItems.order_num = Orders.order_num
  AND prod_id = 'RGAN01';

/*
+---------------+--------------------+
| cust_name     | cust_contact       |
+---------------+--------------------+
| Fun4All       | Denise L. Stephens |
| The Toy Store | Kim Howard         |
+---------------+--------------------+
2 rows in set (0.00 sec)
*/

/* 12.3 小结  Summary */

/* 12.4 挑战题  Challenges */
