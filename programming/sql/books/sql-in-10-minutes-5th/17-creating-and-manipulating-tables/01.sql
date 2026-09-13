/*
 * creating time: 2026-09-13 08:27
 */

/* 17.1 创建表  Creating Tables */

/* 17.1.1 表创建基础  Basic Table Creation */
CREATE TABLE Products
(
    prod_id      CHAR(10)        NOT NULL,
    vend_id      CHAR(10)        NOT NULL,
    prod_name    CHAR(254)       NOT NULL,
    prod_price   DECIMAL(8,2)    NOT NULL,
    prod_desc    VARCHAR(1000)   NULL
);

/*
Query OK, 0 rows affected (0.02 sec)
*/

/* 17.1.2 使用NULL值  Working with NULL Values */
CREATE TABLE Orders
(
    order_num     INTEGER     NOT NULL,
    order_date    DATETIME    NOT NULL,
    cust_id       CHAR(10)    NOT NULL
);

/*
Query OK, 0 rows affected (0.01 sec)
*/

CREATE TABLE Vendors
(
    vend_id        CHAR(10)    NOT NULL,
    vend_name      CHAR(50)    NOT NULL,
    vend_address   CHAR(50)    ,
    vend_city      CHAR(50)    ,
    vend_state     CHAR(5)     ,
    vend_zip       CHAR(10)    ,
    vend_country   CHAR(50)
);

/*
Query OK, 0 rows affected (0.01 sec)
*/

-- NULL 为默认设置，如果不指定 NOT NULL，就认为指定的是 NULL。
-- NULL is the default setting, so if NOT NULL is not specified, NULL is assumed.

/* 17.1.3 指定默认值  Specifying Default Values */
CREATE TABLE OrderItems
(
    order_num     INTEGER         NOT NULL,
    order_item    INTEGER         NOT NULL,
    prod_id       CHAR(10)        NOT NULL,
    quantity      INTEGER         NOT NULL    DEFAULT 1,
    item_price    DECIMAL(8,2)    NOT NULL
);

-- 获得系统日期  Obtaining the System Date
-- DBMS
    -- 函数/变量  Function/Variable
-- DB2
    -- CURRENT_DATE
-- MySQL
    -- CURRENT_DATE() or Now()
-- Oracle
    -- SYSDATE
-- PostgreSQL
    -- CURRENT_DATE
-- SQL Server
    -- GETDATE()
-- SQLite
    -- date('now')

/* 17.2 更新表  Updating Tables */
ALTER TABLE Vendors
ADD vend_phone CHAR(20);

/*
Query OK, 0 rows affected (0.02 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

-- 注意，下面的例子并非对所有 DBMS 都有效：
-- Note that the following example will not work with all DBMSs:
ALTER TABLE Vendors
DROP COLUMN vend_phone;

/*
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0
*/

/* 17.3 删除表  Deleting Tables */
DROP TABLE CustCopy;

/*
Query OK, 0 rows affected (0.01 sec)
*/

/* 17.4 重命名表  Renaming Tables */
-- DB2、MariaDB、MySQL、Oracle 和 PostgreSQL 用户使用 RENAME 语句
-- SQL Server 用户使用 sp_rename 存储过程
-- SQLite 用户使用 ALTER TABLE 语句

/* 17.5 小结  Summary */

/* 17.6 挑战题  Challenges */
