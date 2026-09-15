/*
 * create time: 2026-09-15 17:29
 */

-- MySQL
-- 1. 修改语句分隔符（MySQL 中编写存储过程必需）
DELIMITER //

-- 2. 创建存储过程，使用 OUT 参数来返回计数
CREATE PROCEDURE MailingListCount(OUT p_cnt INT)
BEGIN
    SELECT COUNT(*) INTO p_cnt
    FROM Customers
    WHERE cust_email IS NOT NULL;
END //

/*
Query OK, 0 rows affected (0.01 sec)
*/

-- 3. 恢复默认的分隔符
DELIMITER ;

-- ==========================================
-- 4. 调用存储过程并查看结果
-- ==========================================
CALL MailingListCount(@ReturnValue);
SELECT @ReturnValue;

/*
CALL MailingListCount(@ReturnValue);
Query OK, 1 row affected (0.01 sec)

SELECT @ReturnValue;
+--------------+
| @ReturnValue |
+--------------+
|            3 |
+--------------+
1 row in set (0.00 sec)
*/

-- 替代方案：使用存储函数 (Function)
DELIMITER //

CREATE FUNCTION MailingListCount() 
RETURNS INT
READS SQL DATA  -- 声明此函数会读取 SQL 数据  读取了数据库表的数据（表数据随时可能被增删改）
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt
    FROM Customers
    WHERE cust_email IS NOT NULL;
    RETURN cnt;
END //

/*
Query OK, 0 rows affected (0.01 sec)
*/

DELIMITER ;

-- 调用函数
SELECT MailingListCount();

/*
+--------------------+
| MailingListCount() |
+--------------------+
|                  3 |
+--------------------+
1 row in set (0.00 sec)
*/

DELIMITER //

CREATE FUNCTION MailingListCount() 
RETURNS INT
DETERMINISTIC  -- 确定性的  加上 DETERMINISTIC 就是在告诉 MySQL：“这个函数在相同输入下结果是恒定的，请放心执行和同步！”
BEGIN
    DECLARE cnt INT;
    SELECT COUNT(*) INTO cnt
    FROM Customers
    WHERE cust_email IS NOT NULL;
    RETURN cnt;
END //

DELIMITER ;

-- 调用函数
SELECT MailingListCount();

-- 删除 DROP PROCEDURE [IF EXISTS] 存储过程名称;
DROP PROCEDURE IF EXISTS MailingListCount;

/*
Query OK, 0 rows affected (0.01 sec)
*/

-- 1. 什么是“确定性”？
-- 确定性（DETERMINISTIC）：如果一个函数，只要给它相同的输入参数，无论调用多少次、在什么时间、什么环境下运行，永远都会返回完全相同的结果，那么它就是确定性的。
  -- 例如：一个计算圆面积的函数 CalculateArea(radius)，只要半径相同，结果永远一样。

-- 非确定性（NOT DETERMINISTIC）：如果函数的输出会随时间、随机数或外部环境变化而变化，它就是非确定性的。
  -- 例如：使用 NOW()（获取当前时间）、RAND()（生成随机数）的函数。

-- 2. 为什么 MySQL 要求或建议指定它？
-- MySQL 引入这个关键字主要是为了主从复制（Replication）和二进制日志（Binary Log）的安全：
  -- 数据一致性：当主数据库（Master）将操作同步给从数据库（Slave）时，如果是 DETERMINISTIC 的函数，主库只需记录输入和结果即可；而如果是 NOT DETERMINISTIC 的函数（比如包含了 NOW()），直接同步可能会导致主从数据不一致。
  -- MySQL 的安全限制：如果你的 MySQL 开启了二进制日志（Binlog），并且没有设置 log_bin_trust_function_creators = 1，你在创建函数时如果不声明它是 DETERMINISTIC、NO SQL 或 READS SQL DATA 之一，MySQL 就会直接报错拒绝创建。

-- 在 MySQL 中，NO SQL 是用来声明存储函数或存储过程的一个数据访问特征（Data Access Characteristic）。

-- 它的字面意思是：这个程序里面完全不包含任何 SQL 语句。
  -- 1. 什么时候使用 NO SQL？
    -- 如果你的函数或存储过程只做纯粹的逻辑计算、字符串处理或数学运算，完全没有和数据库表进行交互（没有 SELECT、INSERT、UPDATE、DELETE 等），就可以声明为 NO SQL。
      CREATE FUNCTION AddNumbers(a INT, b INT) 
      RETURNS INT
      NO SQL
      DETERMINISTIC
      BEGIN
          -- 这里只是纯粹的数学计算，没有操作任何数据库表
          RETURN a + b;
      END;
  -- 2. MySQL 的四大数据访问特征对比
    -- 在编写 MySQL 函数时，为了让优化器和二进制日志知道程序会做什么，你需要（或默认会）指定以下四种特征之一：
      -- NO SQL：不包含任何 SQL 语句（纯计算/逻辑）。
      -- CONTAINS SQL：包含 SQL 语句，但既不读取也不写入表数据（比如调用了某些系统变量或不访问表的语句）。这是默认选项。
      -- READS SQL DATA：包含读取数据的 SQL 语句（比如 SELECT ... FROM ...）。刚才的 MailingListCount 函数就属于这一种，因为它查了 Customers 表。
      -- MODIFIES SQL DATA：包含修改数据的 SQL 语句（比如 INSERT、UPDATE、DELETE）。


-- 1. 设置分隔符
DELIMITER //

-- 2. 创建存储过程（包含一个入参和一个出参）
CREATE PROCEDURE NewOrder(
    IN p_cust_id CHAR(10),       -- 输入参数：客户ID
    OUT p_order_num INT          -- 输出参数：返回生成的新订单号
)
MODIFIES SQL DATA                -- 声明此过程会修改数据
BEGIN
    -- 获取当前最大订单号并加 1
    -- 使用 COALESCE 是为了防止 Orders 表为空时 MAX 返回 NULL 导致计算出错
    SELECT COALESCE(MAX(order_num), 0) + 1 INTO p_order_num
    FROM Orders;
    
    -- 插入新订单（MySQL 使用 NOW() 代替 SQL Server 的 GETDATE()）
    INSERT INTO Orders(order_num, order_date, cust_id)
    VALUES(p_order_num, NOW(), p_cust_id);
    
END //

/*
Query OK, 0 rows affected (0.01 sec)
*/

-- 3. 恢复默认分隔符
DELIMITER ;

-- 调用存储过程，传入客户ID，并将新订单号存入 @new_id 变量
CALL NewOrder('CUST123456', @new_id);

/*
ERROR 1452 (23000): Cannot add or update a child row: a foreign key constraint fails (`sql_in_10_minutes_5th`.`Orders`, CONSTRAINT `FK_Orders_Customers` FOREIGN KEY (`cust_id`) REFERENCES `Customers` (`cust_id`))

外键约束冲突（Foreign Key Constraint Violation）  你试图为客户 ID 'CUST123456' 创建订单，但这个客户在 Customers 表中根本不存在。为了防止出现“幽灵订单”（即订单找不到对应的客户），MySQL 的外键约束阻止了这次插入。

解决这个问题：
  1. 检查客户是否存在  Verification
    SELECT * FROM Customers WHERE cust_id = 'CUST123456';
  2. 向 Customers 表插入该客户（如果客户不存在）
    INSERT INTO Customers (cust_id, cust_name, cust_address, cust_city, cust_state, cust_zip, cust_country, cust_contact, cust_email) 
    VALUES ('CUST123456', '张三', 'zhangsan@example.com');
    验证方式：再次执行上一步的 SELECT 查询，确认能查到这条客户记录。
  3. 重新执行存储过程
    CALL NewOrder('CUST123456', @new_id);
    SELECT @new_id;
*/


-- 查看返回的新订单号
SELECT @new_id;

/*
+------------------+
| @new_id          |
+------------------+
| NULL             |
+------------------+
1 row in set (0.00 sec)
*/

-- 使用表中真实存在的客户 ID
CALL NewOrder('1000000001', @new_id);

/*
Query OK, 1 row affected (0.01 sec)
*/

-- 查看生成的新订单号
SELECT @new_id;

/*
+---------+
| @new_id |
+---------+
|   20010 |
+---------+
1 row in set (0.00 sec)
*/

-- 查看 Orders 表验证一下
SELECT * FROM Orders WHERE order_num = 20010;

/*
+-----------+---------------------+------------+
| order_num | order_date          | cust_id    |
+-----------+---------------------+------------+
|     20010 | 2026-09-15 10:34:42 | 1000000001 |
+-----------+---------------------+------------+
1 row in set (0.00 sec)
*/

-- 时间对不上
-- 查看当前 MySQL 的时区设置  Diagnostics
-- 查看当前的全局和会话时区：
SELECT @@global.time_zone, @@session.time_zone, NOW();

/*
+--------------------+---------------------+---------------------+
| @@global.time_zone | @@session.time_zone | NOW()               |
+--------------------+---------------------+---------------------+
| SYSTEM             | SYSTEM              | 2026-09-15 10:41:40 |
+--------------------+---------------------+---------------------+
1 row in set (0.00 sec)
*/

-- 1. 将当前会话的时区设置为东八区
SET time_zone = '+8:00';

/*
Query OK, 0 rows affected (0.00 sec)
*/

-- 2. 再次检查时间是否正确
SELECT NOW();

/*
+---------------------+
| NOW()               |
+---------------------+
| 2026-09-15 18:44:37 |
+---------------------+
1 row in set (0.00 sec)
*/

-- 测试看看时间对不对
-- 再次测试下单
CALL NewOrder('1000000001', @new_id);

/*
Query OK, 1 row affected (0.00 sec)
*/

-- 查看刚才插入的订单时间
SELECT * FROM Orders ORDER BY order_num DESC LIMIT 1;

/*
+-----------+---------------------+------------+
| order_num | order_date          | cust_id    |
+-----------+---------------------+------------+
|     20011 | 2026-09-15 18:45:02 | 1000000001 |
+-----------+---------------------+------------+
1 row in set (0.00 sec)
*/

-- 删除 NewOrder 增加的最后两条记录
DELETE FROM Orders WHERE order_num IN (20010, 20011);

/*
Query OK, 2 rows affected (0.00 sec)
*/

-- 提示：如果希望永久生效，需要修改 MySQL 的配置文件（my.cnf 或 my.ini），在 [mysqld] 目录下添加 default-time_zone = '+8:00'，然后重启 MySQL 服务。
-- 方法一：通过环境变量设置时区（最推荐）
  docker run --name your_mysql_container \
    -e MYSQL_ROOT_PASSWORD=your_password \
    -e TZ=Asia/Shanghai \
    -d mysql:latest
-- 方法二：启动时传递 MySQL 参数
  docker run --name your_mysql_container \
    -e MYSQL_ROOT_PASSWORD=your_password \
    -d mysql:latest \
    --default-time-zone='+08:00'
-- 方法三：挂载自定义配置文件
-- 如果你已经在使用 Docker Compose 或数据卷挂载，可以在本地写一个简单的配置文件（例如 timezone.cnf），然后挂载到容器的 /etc/mysql/conf.d/ 目录下。
  -- 1. 在本地创建一个名为 timezone.cnf 的文件，内容如下：
    [mysqld]
    default-time_zone = '+08:00'
  -- 2. 在 docker run 中通过 -v 挂载进去：
    docker run --name your_mysql_container \
      -v /path/to/timezone.cnf:/etc/mysql/conf.d/timezone.cnf \
      -e MYSQL_ROOT_PASSWORD=your_password \
      -d mysql:latest
  -- 提示：如果是通过 docker-up（Docker Compose），直接在 environment 里加上 TZ=Asia/Shanghai 或者是通过 command: --default-time-zone='+08:00' 即可最快搞定！
