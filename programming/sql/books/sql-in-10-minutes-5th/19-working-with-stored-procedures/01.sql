/*
 * create time: 2026-09-15 16:50
 */

/* 19.1 存储过程  Understanding Stored Procedures */

-- SQLite 不支持存储过程。
-- SQLite does not support stored procedures.

/* 19.2 为什么要使用存储过程  Understanding Why to Use Stored Procedures */

/* 19.3 执行存储过程  Executing Stored Procedures */
EXECUTE AddNewProduct('JTS01',
                      'Stuffed Eiffel Tower',
                      6.49,
                      'Plush stuffed toy with
Imagethe text La Tour Eiffel in red white and blue');

/* 19.4 创建存储过程  Creating Stored Procedures */
-- Oracle
CREATE PROCEDURE MailingListCount  (
  ListCount OUT INTEGER
)
IS
v_rows INTEGER;
BEGIN
    SELECT COUNT(*) INTO v_rows
    FROM Customers
    WHERE NOT cust_email IS NULL;
    ListCount := v_rows;
END;

var ReturnValue NUMBER
EXEC MailingListCount(:ReturnValue);
SELECT ReturnValue;

-- SQL Server
CREATE PROCEDURE MailingListCount
AS
DECLARE @cnt INTEGER
SELECT @cnt = COUNT(*)
FROM Customers
WHERE NOT cust_email IS NULL;
RETURN @cnt;

DECLARE @ReturnValue INT
EXECUTE @ReturnValue=MailingListCount;
SELECT @ReturnValue;

-- SQL Server
CREATE PROCEDURE NewOrder @cust_id CHAR(10)
AS
-- 为订单号声明一个变量
DECLARE @order_num INTEGER
-- 获取当前最大订单号
SELECT @order_num=MAX(order_num)
FROM Orders
-- 决定下一个订单号
SELECT @order_num=@order_num+1
-- 插入新订单
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(@order_num, GETDATE(), @cust_id)
-- 返回订单号
RETURN @order_num;

CREATE PROCEDURE NewOrder @cust_id CHAR(10)
AS
-- Declare variable for order number
DECLARE @order_num INTEGER
-- Get current highest order number
SELECT @order_num=MAX(order_num)
FROM Orders
-- Determine next order number
SELECT @order_num=@order_num+1
-- Insert new order
INSERT INTO Orders(order_num, order_date, cust_id)
VALUES(@order_num, GETDATE(), @cust_id)
-- Return order number
RETURN @order_num;

-- SQL Server
CREATE PROCEDURE NewOrder @cust_id CHAR(10)
AS
-- 插入新订单
INSERT INTO Orders(cust_id)
VALUES(@cust_id)
-- 返回订单号
SELECT order_num = @@IDENTITY;

CREATE PROCEDURE NewOrder @cust_id CHAR(10)
AS
-- Insert new order
INSERT INTO Orders(cust_id)
VALUES(@cust_id)
-- Return order number
SELECT order_num = @@IDENTITY;

-- SQL Server 自动增量的列 标识字段  identity field
-- 自动编号  auto number
-- 序列  sequence

/* 19.5 小结  Summary */
