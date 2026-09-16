/*
 * create time: 2026-09-17 07:11
 */

/* 21.1 游标  Understanding Cursors */
-- 结果集  result set
-- 游标  cursor

-- SQLite 支持的游标称为步骤（step ）
-- SQLite supports a form of cursors called steps. 

/* 21.2 使用游标  Working with Cursors */

/* 21.2.1 创建游标  Creating Cursors */
-- DB2, MariaDB, MySQL, and SQL Server
DECLARE CustCursor CURSOR
FOR
SELECT * FROM Customers
WHERE cust_email IS NULL;

-- Oracle and PostgreSQL
DECLARE CURSOR CustCursor
IS
SELECT * FROM Customers
WHERE cust_email IS NULL;

/* 21.2.2 使用游标  Using Cursors */
OPEN CURSOR CustCursor

-- Oracle
DECLARE TYPE CustCursor IS REF CURSOR
    RETURN Customers%ROWTYPE;
DECLARE CustRecord Customers%ROWTYPE
BEGIN
    OPEN CustCursor;
    FETCH CustCursor INTO CustRecord;
    CLOSE CustCursor;
END;

-- Oracle
DECLARE TYPE CustCursor IS REF CURSOR
    RETURN Customers%ROWTYPE;
DECLARE CustRecord Customers%ROWTYPE
BEGIN
    OPEN CustCursor;
    LOOP
    FETCH CustCursor INTO CustRecord;
    EXIT WHEN CustCursor%NOTFOUND;
       ...  -- 用具体的处理代码替换 ...
    END LOOP;
    CLOSE CustCursor;
END;

-- Microsoft SQL Server
DECLARE @cust_id CHAR(10),
        @cust_name CHAR(50),
        @cust_address CHAR(50),
        @cust_city CHAR(50),
        @cust_state CHAR(5),
        @cust_zip CHAR(10),
        @cust_country CHAR(50),
        @cust_contact CHAR(50),
        @cust_email CHAR(255)
OPEN CustCursor
FETCH NEXT FROM CustCursor
    INTO @cust_id, @cust_name, @cust_address,
         @cust_city, @cust_state, @cust_zip,
         @cust_country, @cust_contact, @cust_email
   ...  -- 用具体的处理代码替换 ...
WHILE @@FETCH_STATUS = 0
BEGIN
FETCH NEXT FROM CustCursor
        INTO @cust_id, @cust_name, @cust_address,
             @cust_city, @cust_state, @cust_zip,
             @cust_country, @cust_contact, @cust_email
...  -- 用具体的处理代码替换 ...
END
CLOSE CustCursor

/* 21.2.3 关闭游标   */
-- DB2, Oracle, and PostgreSQL
CLOSE CustCursor

-- Microsoft SQL Server
CLOSE CustCursor
DEALLOCATE CURSOR CustCursor

/* 21.3 小结  Summary */
