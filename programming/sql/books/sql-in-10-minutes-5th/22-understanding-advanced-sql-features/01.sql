/*
 * create time: 2026-09-18 15:30
 */

/* 22.1 约束  Understanding Constraints */
-- 引用完整性  referential integrity
-- 约束  constraint

/* 22.1.1 主键  Primary Keys */
CREATE TABLE Vendors
(
    vend_id        CHAR(10)    NOT NULL PRIMARY KEY,
    vend_name      CHAR(50)    NOT NULL,
    vend_address   CHAR(50)    NULL,
    vend_city      CHAR(50)    NULL,
    vend_state     CHAR(5)     NULL,
    vend_zip       CHAR(10)    NULL,
    vend_country   CHAR(50)    NULL
);

/*
Query OK, 0 rows affected (0.02 sec)
*/

ALTER TABLE Vendors
ADD CONSTRAINT PRIMARY KEY (vend_id);  -- 补充：在语法中一般不需要显式写 CONSTRAINT 关键字。

/*
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

-- SQLite 不允许使用 ALTER TABLE 定义键，要求在初始的 CREATE TABLE 语句中定义它们。
-- SQLite does not allow keys to be defined using ALTER TABLE and requires that they be defined as part of the initial CREATE TABLE.

-- my test: 删除主键（Primary Key）
-- 1. 如果该主键被其他表的外键引用了，必须先删除那些外键，否则无法删除主键。
-- 2. 如果主键列带有 AUTO_INCREMENT（自增）属性，需要先修改该列去掉自增属性，或者直接删。

-- my test: 查看主键
-- 方法一：使用 SHOW CREATE TABLE（最推荐，能看清完整结构）
SHOW CREATE TABLE Vendors;

/*
+---------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table   | Create Table                                                                                                                                                                                                                                                                                                                                                                        |
+---------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Vendors | CREATE TABLE `Vendors` (
  `vend_id` char(10) NOT NULL,
  `vend_name` char(50) NOT NULL,
  `vend_address` char(50) DEFAULT NULL,
  `vend_city` char(50) DEFAULT NULL,
  `vend_state` char(5) DEFAULT NULL,
  `vend_zip` char(10) DEFAULT NULL,
  `vend_country` char(50) DEFAULT NULL,
  PRIMARY KEY (`vend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+---------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
*/

-- 方法二：使用 DESCRIBE（快速查看表结构）
DESCRIBE Vendors;
-- 或者简写为：
DESC Vendors;

/*
+--------------+----------+------+-----+---------+-------+
| Field        | Type     | Null | Key | Default | Extra |
+--------------+----------+------+-----+---------+-------+
| vend_id      | char(10) | NO   | PRI | NULL    |       |
| vend_name    | char(50) | NO   |     | NULL    |       |
| vend_address | char(50) | YES  |     | NULL    |       |
| vend_city    | char(50) | YES  |     | NULL    |       |
| vend_state   | char(5)  | YES  |     | NULL    |       |
| vend_zip     | char(10) | YES  |     | NULL    |       |
| vend_country | char(50) | YES  |     | NULL    |       |
+--------------+----------+------+-----+---------+-------+
7 rows in set (0.00 sec)
*/

-- my test: 通过查询 MySQL 的系统数据库（INFORMATION_SCHEMA）来精准找出是哪张表的哪个外键引用了 Vendors 表。
-- 1. 查询系统表
SELECT 
    TABLE_NAME AS '引用表(子表)',
    COLUMN_NAME AS '外键列',
    CONSTRAINT_NAME AS '外键约束名',
    REFERENCED_COLUMN_NAME AS '被引用的主键列'
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    REFERENCED_TABLE_NAME = 'Vendors'
    AND TABLE_SCHEMA = DATABASE();

/*
+------------+---------+---------------------+-------------+
| 引用表(子表) | 外键列   | 外键约束名           | 被引用的主键列 |
+------------+---------+---------------------+-------------+
| Products   | vend_id | FK_Products_Vendors | vend_id     |
+------------+---------+---------------------+-------------+
1 row in set (0.00 sec)
*/

SELECT 
    TABLE_NAME,
    COLUMN_NAME,
    CONSTRAINT_NAME,
    REFERENCED_COLUMN_NAME
FROM
    INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE
    REFERENCED_TABLE_NAME = 'Vendors'
    AND TABLE_SCHEMA = DATABASE();

/*
+------------+-------------+---------------------+------------------------+
| TABLE_NAME | COLUMN_NAME | CONSTRAINT_NAME     | REFERENCED_COLUMN_NAME |
+------------+-------------+---------------------+------------------------+
| Products   | vend_id     | FK_Products_Vendors | vend_id                |
+------------+-------------+---------------------+------------------------+
1 row in set (0.00 sec)
*/

-- my test: 删除外键约束  ALTER TABLE 引用表名 DROP FOREIGN KEY 外键约束名;
-- 2. 解除依赖 
ALTER TABLE Products DROP FOREIGN KEY FK_Products_Vendors;

/*
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

-- my test: 执行删除主键
-- 3. 执行删除
ALTER TABLE Vendors DROP PRIMARY KEY;

/*
Query OK, 6 rows affected (0.02 sec)
Records: 6  Duplicates: 0  Warnings: 0
*/

-- my test: 查看约束
-- MySQL
-- 1. 最常用、最直观的命令：SHOW CREATE TABLE
SHOW CREATE TABLE Vendors;

/*
+---------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table   | Create Table                                                                                                                                                                                                                                                                                                                                                                        |
+---------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Vendors | CREATE TABLE `Vendors` (
  `vend_id` char(10) NOT NULL,
  `vend_name` char(50) NOT NULL,
  `vend_address` char(50) DEFAULT NULL,
  `vend_city` char(50) DEFAULT NULL,
  `vend_state` char(5) DEFAULT NULL,
  `vend_zip` char(10) DEFAULT NULL,
  `vend_country` char(50) DEFAULT NULL,
  PRIMARY KEY (`vend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+---------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
*/

-- 2. 精准查询系统表（INFORMATION_SCHEMA）
SELECT 
    CONSTRAINT_NAME AS '约束名',
    CONSTRAINT_TYPE AS '约束类型',
    TABLE_NAME AS '表名'
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE 
    TABLE_SCHEMA = DATABASE() -- 当前数据库
    AND TABLE_NAME = 'Vendors';

/*
+---------+-------------+---------+
| 约束名   | 约束类型     | 表名     |
+---------+-------------+---------+
| PRIMARY | PRIMARY KEY | Vendors |
+---------+-------------+---------+
1 row in set (0.01 sec)
*/

SELECT 
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE,
    TABLE_NAME
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE 
    TABLE_SCHEMA = DATABASE()
    AND TABLE_NAME = 'Vendors';

/*
+-----------------+-----------------+------------+
| CONSTRAINT_NAME | CONSTRAINT_TYPE | TABLE_NAME |
+-----------------+-----------------+------------+
| PRIMARY         | PRIMARY KEY     | Vendors    |
+-----------------+-----------------+------------+
1 row in set (0.01 sec)
*/

/* 22.1.2 外键  Foreign Keys */
CREATE TABLE Orders
(
    order_num    INTEGER    NOT NULL PRIMARY KEY,
    order_date   DATETIME   NOT NULL,
    cust_id      CHAR(10)   NOT NULL REFERENCES Customers (cust_id)
);

/*
Query OK, 0 rows affected (0.01 sec)
*/

ALTER TABLE Orders
ADD CONSTRAINT
FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);

/*
Query OK, 0 rows affected (0.03 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

-- 级联删除  cascading delete

-- my test: 查看外键约束名
SHOW CREATE TABLE Orders;

/*
+--------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table  | Create Table                                                                                                                                                                                                                                                                                                                                                |
+--------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Orders | CREATE TABLE `Orders` (
  `order_num` int NOT NULL,
  `order_date` datetime NOT NULL,
  `cust_id` char(10) NOT NULL,
  PRIMARY KEY (`order_num`),
  KEY `FK_Orders_Customers` (`cust_id`),
  CONSTRAINT `FK_Orders_Customers` FOREIGN KEY (`cust_id`) REFERENCES `Customers` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+--------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
*/

-- my test: 执行删除外键
ALTER TABLE Orders DROP FOREIGN KEY FK_Orders_Customers;

/*
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

-- KEY `FK_Orders_Customers` (`cust_id`) 是什么
-- 补充：在 MySQL 中，当你在一个列上添加外键时，如果该列本身没有索引，MySQL 会自动为它创建一个普通索引。

/* 22.1.3 唯一约束  Unique Constraints */

-- my test: 1. 列级约束（直接写在字段后面）
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50) UNIQUE, -- 这里的 username 加上了唯一约束
    email VARCHAR(100) UNIQUE    -- 邮箱也必须唯一
);

-- my test: 2. 表级约束（写在所有字段的最后）
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    username VARCHAR(50),
    email VARCHAR(100),
    -- 自定义一个名为 uk_username 的唯一约束
    CONSTRAINT uk_username UNIQUE (username),
    -- 也可以联合多个字段唯一（即：这几个字段组合起来必须是唯一的）
    CONSTRAINT uk_name_email UNIQUE (username, email)
);

-- my test: 使用 ALTER TABLE 来为某个列追加唯一约束
-- 语法：ALTER TABLE 表名 ADD UNIQUE (列名);
ALTER TABLE Users ADD UNIQUE (username);
-- 或者给约束起个名字：
ALTER TABLE Users ADD CONSTRAINT uk_email UNIQUE (email);

-- my test: 删除唯一约束
-- MySQL 中唯一约束通常会自动创建一个同名的索引，删除时用 DROP INDEX
ALTER TABLE Users DROP INDEX username; 
-- 如果你刚才指定了自定义名称（如 uk_email）：
ALTER TABLE Users DROP INDEX uk_email;

/* 22.1.4 检查约束  Check Constraints */
-- 补充：SQL Server、PostgreSQL 等数据库中的类型
CREATE TABLE OrderItems
(
    order_num     INTEGER    NOT NULL,
    order_item    INTEGER    NOT NULL,
    prod_id       CHAR(10)   NOT NULL,
    quantity      INTEGER    NOT NULL CHECK (quantity > 0),
    item_price    MONEY      NOT NULL
);

-- my test: MySQL
CREATE TABLE OrderItems
(
     order_num     INTEGER    NOT NULL,
     order_item    INTEGER    NOT NULL,
     prod_id       CHAR(10)   NOT NULL,
     quantity      INTEGER    NOT NULL CHECK (quantity > 0),
     item_price    DECIMAL(8,2) NOT NULL
);

/*
Query OK, 0 rows affected (0.01 sec)
*/

-- 备注：SQL Server
ALTER TABLE table_name  -- 补充 ALTER TABLE
ADD CONSTRAINT CHECK (gender LIKE '[MF]');

-- my test: MySQL with in
ALTER TABLE table_name
ADD CONSTRAINT chk_gender CHECK (gender IN ('M', 'F'));  -- gender = 'M' OR gender = 'F'

-- my test: MySQL with REGEXP
ALTER TABLE table_name
ADD CONSTRAINT chk_gender CHECK (gender REGEXP '^[MF]$');

-- my test: 查看检查约束的名称
SHOW CREATE TABLE OrderItems;

/*
+-------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table       | Create Table                                                                                                                                                                                                                                                                                                       |
+-------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| OrderItems | CREATE TABLE `OrderItems` (
  `order_num` int NOT NULL,
  `order_item` int NOT NULL,
  `prod_id` char(10) NOT NULL,
  `quantity` int NOT NULL,
  `item_price` decimal(8,2) NOT NULL,
  CONSTRAINT `OrderItems1_chk_1` CHECK ((`quantity` > 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+-------------+--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
*/

-- my test: 执行删除命令
ALTER TABLE OrderItems DROP CHECK OrderItems1_chk_1;

/*
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

/* 22.2 索引  Understanding Indexes */
CREATE INDEX prod_name_ind
ON Products (prod_name);

/*
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

-- my test: 1. 查看索引名称
SHOW INDEX FROM Products;

/*
mysql> SHOW INDEX FROM Products;
+----------+------------+---------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Table    | Non_unique | Key_name            | Seq_in_index | Column_name | Collation | Cardinality | Sub_part | Packed | Null | Index_type | Comment | Index_comment | Visible | Expression |
+----------+------------+---------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
| Products |          0 | PRIMARY             |            1 | prod_id     | A         |           9 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| Products |          1 | FK_Products_Vendors |            1 | vend_id     | A         |           3 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
| Products |          1 | prod_name_ind       |            1 | prod_name   | A         |           9 |     NULL |   NULL |      | BTREE      |         |               | YES     | NULL       |
+----------+------------+---------------------+--------------+-------------+-----------+-------------+----------+--------+------+------------+---------+---------------+---------+------------+
3 rows in set (0.01 sec)*/

-- 或者通过查看建表语句找名字：
SHOW CREATE TABLE Products;

/*
+----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table    | Create Table                                                                                                                                                                                                                                                                                                                                                                                                                                                |
+----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Products | CREATE TABLE `Products` (
  `prod_id` char(10) NOT NULL,
  `vend_id` char(10) NOT NULL,
  `prod_name` char(255) NOT NULL,
  `prod_price` decimal(8,2) NOT NULL,
  `prod_desc` text,
  PRIMARY KEY (`prod_id`),
  KEY `FK_Products_Vendors` (`vend_id`),
  KEY `prod_name_ind` (`prod_name`),
  CONSTRAINT `FK_Products_Vendors` FOREIGN KEY (`vend_id`) REFERENCES `Vendors` (`vend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci |
+----------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
*/

-- my test: 2. 执行删除命令
ALTER TABLE Products DROP INDEX prod_name_ind;

/*
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

/* 22.3 触发器  Understanding Triggers */
-- 触发器是特殊的存储过程，它在特定的数据库活动发生时自动执行。
-- Triggers are special stored procedures that are executed automatically when specific database activity occurs.

-- SQL Server
CREATE TRIGGER customer_state
ON Customers
FOR INSERT, UPDATE
AS
UPDATE Customers
SET cust_state = Upper(cust_state)
WHERE Customers.cust_id = inserted.cust_id;

-- Oracle and PostgreSQL
CREATE TRIGGER customer_state
AFTER INSERT OR UPDATE
FOR EACH ROW
BEGIN
UPDATE Customers
SET cust_state = Upper(cust_state)
WHERE Customers.cust_id = :OLD.cust_id
END;

-- 提示：约束比触发器更快
-- Constraints Are Faster Than Triggers

-- my test: MySQL
DELIMITER //

-- 1. 插入前触发器
CREATE TRIGGER trg_customers_before_insert
BEFORE INSERT ON Customers
FOR EACH ROW
BEGIN
    SET NEW.cust_state = UPPER(NEW.cust_state);
END //

-- 2. 更新前触发器
CREATE TRIGGER trg_customers_before_update
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    SET NEW.cust_state = UPPER(NEW.cust_state);
END //

DELIMITER ;

-- my test: SQLite
-- 1. 插入后触发器
CREATE TRIGGER trg_customers_after_insert
AFTER INSERT ON Customers
FOR EACH ROW
WHEN NEW.cust_state IS NOT NULL
BEGIN
    UPDATE Customers 
    SET cust_state = UPPER(cust_state) 
    WHERE cust_id = NEW.cust_id AND cust_state <> UPPER(cust_state);
END;

-- 2. 更新后触发器
CREATE TRIGGER trg_customers_after_update
AFTER UPDATE ON Customers
FOR EACH ROW
WHEN NEW.cust_state IS NOT NULL
BEGIN
    UPDATE Customers 
    SET cust_state = UPPER(cust_state) 
    WHERE cust_id = NEW.cust_id AND cust_state <> UPPER(cust_state);
END;

-- my test: 1. 查看现有的触发器名称
SHOW TRIGGERS;  -- MySQL
SELECT name FROM sqlite_master WHERE type = 'trigger';  -- SQLite

-- my test: 2. 执行删除命令
-- MySQL
DROP TRIGGER IF EXISTS trg_customers_before_insert;
DROP TRIGGER IF EXISTS trg_customers_before_update;

-- SQLite
DROP TRIGGER IF EXISTS trg_customers_after_insert;
DROP TRIGGER IF EXISTS trg_customers_after_update;

/* 22.4 数据库安全  Database Security */

/* 22.5 小结  Summary */
