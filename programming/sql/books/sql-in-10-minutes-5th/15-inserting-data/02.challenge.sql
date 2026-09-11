/*
 * create time: 2026-09-11 09:47
 */

/* 1. */
-- Obviously replace the details with your own
INSERT INTO Customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country,
                      cust_email)
VALUES(1000000042,
       'Ben''s Toys',
       '123 Main Street',
       'Oak Park',
       'MI',
       '48237',
       'USA',
       'ben@fortabbwpc.wpcomstaging.com');

/* 2. */
-- MySQL, MariaDB, Oracle, PostgreSQL, SQLite
CREATE TABLE OrdersBackup AS SELECT * FROM Orders;

/*
Query OK, 5 rows affected (0.01 sec)
Records: 5  Duplicates: 0  Warnings: 0
*/

CREATE TABLE OrderItemsBackup AS SELECT * FROM OrderItems;

/*
Query OK, 18 rows affected (0.02 sec)
Records: 18  Duplicates: 0  Warnings: 0
*/

-- SQL Server
SELECT * INTO OrdersBackup FROM Orders;
SELECT * INTO OrderItemsBackup FROM OrderItems;
