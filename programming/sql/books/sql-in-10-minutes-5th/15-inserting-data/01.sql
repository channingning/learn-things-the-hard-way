/*
 * create time: 2026-09-11 08:26
 */

/* 15.1 数据插入  Understanding Data Insertion */

/* 15.1.1 插入完整的行  Inserting Complete Rows */
INSERT INTO Customers
VALUES(1000000006,
       'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111',
       'USA',
       NULL,
       NULL);

/*
Query OK, 1 row affected (0.00 sec)
*/

-- 使用列的列表
-- Use a Columns List
INSERT INTO Customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country,
                      cust_contact,
                      cust_email)
VALUES(1000000007,
       'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111',
       'USA',
       NULL,
       NULL);

/*
Query OK, 1 row affected (0.02 sec)
*/

-- 以一种不同的次序填充所有列
-- populates all the row columns in a different order
INSERT INTO Customers(cust_id,
                      cust_contact,
                      cust_email,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip)
VALUES(1000000008,
       NULL,
       NULL,
       'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111');

/*
Query OK, 1 row affected (0.00 sec)
*/

/* 15.1.2 插入部分行  Inserting Partial Rows */
INSERT INTO Customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country)
VALUES(1000000009,
       'Toy Land',
       '123 Any Street',
       'New York',
       'NY',
       '11111',
       'USA');

/*
Query OK, 1 row affected (0.00 sec)
*/

/* 15.1.3 插入检索出的数据  Inserting Retrieved Data */
INSERT INTO Customers(cust_id,
                      cust_contact,
                      cust_email,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country)
SELECT cust_id,
       cust_contact,
       cust_email,
       cust_name,
       cust_address,
       cust_city,
       cust_state,
       cust_zip,
       cust_country
FROM CustNew;

-- CustNew 是一个空表
/*
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

-- my test
select * from Customers;

/*
+------------+---------------+----------------------+-----------+------------+----------+--------------+--------------------+-----------------------+
| cust_id    | cust_name     | cust_address         | cust_city | cust_state | cust_zip | cust_country | cust_contact       | cust_email            |
+------------+---------------+----------------------+-----------+------------+----------+--------------+--------------------+-----------------------+
| 1000000001 | Village Toys  | 200 Maple Lane       | Detroit   | MI         | 44444    | USA          | John Smith         | sales@villagetoys.com |
| 1000000002 | Kids Place    | 333 South Lake Drive | Columbus  | OH         | 43333    | USA          | Michelle Green     | NULL                  |
| 1000000003 | Fun4All       | 1 Sunny Place        | Muncie    | IN         | 42222    | USA          | Jim Jones          | jjones@fun4all.com    |
| 1000000004 | Fun4All       | 829 Riverside Drive  | Phoenix   | AZ         | 88888    | USA          | Denise L. Stephens | dstephens@fun4all.com |
| 1000000005 | The Toy Store | 4545 53rd Street     | Chicago   | IL         | 54545    | USA          | Kim Howard         | NULL                  |
| 1000000006 | Toy Land      | 123 Any Street       | New York  | NY         | 11111    | USA          | NULL               | NULL                  |
| 1000000007 | Toy Land      | 123 Any Street       | New York  | NY         | 11111    | USA          | NULL               | NULL                  |
| 1000000008 | Toy Land      | 123 Any Street       | New York  | NY         | 11111    | NULL         | NULL               | NULL                  |
| 1000000009 | Toy Land      | 123 Any Street       | New York  | NY         | 11111    | USA          | NULL               | NULL                  |
+------------+---------------+----------------------+-----------+------------+----------+--------------+--------------------+-----------------------+
9 rows in set (0.00 sec)
*/

/* 15.2 从一个表复制到另一个表  Copying from One Table to Another */
CREATE TABLE CustCopy AS SELECT * FROM Customers;

/*
Query OK, 9 rows affected (0.02 sec)
Records: 9  Duplicates: 0  Warnings: 0
*/

-- SQL Server
SELECT * INTO CustCopy FROM Customers;

/* 15.3 小结  Summary */

/* 15.4 挑战题  Challenges */
