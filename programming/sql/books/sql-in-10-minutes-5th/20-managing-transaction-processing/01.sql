/*
 * create time: 2026-09-16 06:54
 */

/* 20.1 事务处理  Understanding Transaction Processing */
-- 事务处理  transaction processing
-- 事务  transaction
-- 回退  rollback
-- 提交  commit
-- 保留点  savepoint
-- 占位符  placeholder

INSERT/UPDATE/DELETE

/* 20.2 控制事务处理  Controlling Transactions */
-- SQL Server
BEGIN TRANSACTION
...
COMMIT TRANSACTION

-- MariaDB 和 MySQL
START TRANSACTION
...

-- Oracle
SET TRANSACTION
...

-- PostgreSQL  ANSI SQL syntax
BEGIN
...

/* 20.2.1 使用ROLLBACK  Using ROLLBACK */
DELETE FROM Orders;
ROLLBACK;

/* 20.2.2 使用COMMIT  Using COMMIT */
-- 隐式提交  implicit commit

-- SQL Server
BEGIN TRANSACTION
DELETE OrderItems WHERE order_num = 12345
DELETE Orders WHERE order_num = 12345
COMMIT TRANSACTION

-- Oracle
SET TRANSACTION
DELETE OrderItems WHERE order_num = 12345;
DELETE Orders WHERE order_num = 12345;
COMMIT;

/* 20.2.3 使用保留点  Using Savepoints */
-- MariaDB、MySQL 和 Oracle
SAVEPOINT delete1;

-- SQL Server
SAVE TRANSACTION delete1;

-- SQL Server
ROLLBACK TRANSACTION delete1;

-- MariaDB、MySQL 和 Oracle
ROLLBACK TO delete1;

-- SQL Server
BEGIN TRANSACTION
INSERT INTO Customers(cust_id, cust_name)
VALUES(1000000010, 'Toys Emporium');
SAVE TRANSACTION StartOrder;
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20100,'2020/12/1',1000000010);
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder;
INSERT INTO OrderItems(order_num, order_item,
Imageprod_id, quantity, item_price)
VALUES(20100, 1, 'BR01', 100, 5.49);
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder;
INSERT INTO OrderItems(order_num, order_item,
Imageprod_id, quantity, item_price)
VALUES(20100, 2, 'BR03', 100, 10.99);
IF @@ERROR <> 0 ROLLBACK TRANSACTION StartOrder;
COMMIT TRANSACTION

/* 20.3 小结  Summary */
