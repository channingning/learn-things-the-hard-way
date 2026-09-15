/*
 * create time: 2026-09-16 07:20
 */

-- MySQL/MariaDB
START TRANSACTION;
-- 先删除子表（外键关联表）中的数据，避免违反外键约束
DELETE FROM OrderItems WHERE order_num = 12345;
-- 再删除主表中的数据
DELETE FROM Orders WHERE order_num = 12345;
COMMIT;

-- SQLite
BEGIN TRANSACTION;
-- 先删除子表中的数据
DELETE FROM OrderItems WHERE order_num = 12345;
-- 再删除主表中的数据
DELETE FROM Orders WHERE order_num = 12345;
COMMIT;

-- 执行顺序：在涉及主外键关联的数据库中，必须先删除子表（OrderItems）的数据，再删除主表（Orders）的数据，否则如果开启了外键约束（Foreign Key Constraints），直接删除主表会报错。
-- 异常处理：在实际编写应用程序代码时，建议在删除过程中捕获异常。如果某一步出错，应当执行 ROLLBACK; 来撤销更改，保证数据一致性。


-- MySQL/MariaDB
START TRANSACTION;

-- 1. 插入客户信息
INSERT INTO Customers(cust_id, cust_name)
VALUES(1000000010, 'Toys Emporium');

-- 2. 设置保留点（MySQL 使用 SAVEPOINT）
SAVEPOINT StartOrder;

-- 3. 插入订单信息
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20100, '2020-12-01', 1000000010);

-- 注：MySQL 没有 @@ERROR。如果此处报错，脚本通常会直接中断。
-- 若在应用程序中，若捕获到异常，应执行：ROLLBACK TO SAVEPOINT StartOrder;

-- 4. 插入订单明细 1
INSERT INTO OrderItems(order_num, order_item, Imageprod_id, quantity, item_price)
VALUES(20100, 1, 'BR01', 100, 5.49);

-- 5. 插入订单明细 2
INSERT INTO OrderItems(order_num, order_item, Imageprod_id, quantity, item_price)
VALUES(20100, 2, 'BR03', 100, 10.99);

-- 一切顺利则提交事务
COMMIT;


-- SQLite
BEGIN TRANSACTION;

-- 1. 插入客户信息
INSERT INTO Customers(cust_id, cust_name)
VALUES(1000000010, 'Toys Emporium');

-- 2. 设置保留点
SAVEPOINT StartOrder;

-- 3. 订单信息插入
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(20100, '2020-12-01', 1000000010);

-- 注：SQLite 同样不支持 @@ERROR。
-- 实际应用中（如 Python 的 sqlite3），若发生异常，应当在代码中捕获并执行：
-- ROLLBACK TO StartOrder;

-- 4. 插入订单明细 1
INSERT INTO OrderItems(order_num, order_item, Imageprod_id, quantity, item_price)
VALUES(20100, 1, 'BR01', 100, 5.49);

-- 5. 插入订单明细 2
INSERT INTO OrderItems(order_num, order_item, Imageprod_id, quantity, item_price)
VALUES(20100, 2, 'BR03', 100, 10.99);

-- 提交事务
COMMIT;
