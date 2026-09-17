/*
 * create time: 2026-09-17 07:52
 */

-- MySQL
-- MySQL 的游标必须在存储过程、函数或触发器内部使用，不能直接在命令行或普通 SQL 脚本中单独运行。

-- 1. 创建存储过程
DELIMITER //

CREATE PROCEDURE ProcessNullEmailCustomers()
BEGIN
    -- 1. 定义变量，对应 Customers 表中的字段类型
    DECLARE v_cust_id INT;
    DECLARE v_cust_name VARCHAR(50);
    DECLARE v_cust_email VARCHAR(50);
    
    -- 2. 定义循环结束标志变量
    DECLARE done INT DEFAULT 0;

    -- 3. 声明游标（筛选出邮箱为空的客户）
    DECLARE CustCursor CURSOR FOR 
        SELECT cust_id, cust_name, cust_email 
        FROM Customers 
        WHERE cust_email IS NULL;

    -- 4. 声明异常处理：当游标没有数据时，将 done 设为 1
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- 5. 打开游标
    OPEN CustCursor;

    -- 6. 开始循环读取
    read_loop: LOOP
        -- 将游标当前行的值存入变量（顺序必须和 SELECT 字段一致）
        FETCH CustCursor INTO v_cust_id, v_cust_name, v_cust_email;
        
        -- 如果读到底了，退出循环
        IF done = 1 THEN
            LEAVE read_loop;
        END IF;

        -- ==========================================
        -- 7. 编写你的业务逻辑
        -- 例如：这里简单打印出正在处理的客户信息
        -- ==========================================
        SELECT CONCAT('Processing ID: ', v_cust_id, ' | Name: ', v_cust_name) AS Process_Log;

    END LOOP;

    -- 8. 关闭游标
    CLOSE CustCursor;

END //

/*
Query OK, 0 rows affected (0.00 sec)
*/
  
DELIMITER ;

-- 2. 调用存储过程
CALL ProcessNullEmailCustomers();

/*
+----------------------------------------------+
| Process_Log                                  |
+----------------------------------------------+
| Processing ID: 1000000002 | Name: Kids Place |
+----------------------------------------------+
1 row in set (0.00 sec)

+-------------------------------------------------+
| Process_Log                                     |
+-------------------------------------------------+
| Processing ID: 1000000005 | Name: The Toy Store |
+-------------------------------------------------+
1 row in set (0.00 sec)

+--------------------------------------------+
| Process_Log                                |
+--------------------------------------------+
| Processing ID: 1000000006 | Name: Toy Land |
+--------------------------------------------+
1 row in set (0.00 sec)

+--------------------------------------------+
| Process_Log                                |
+--------------------------------------------+
| Processing ID: 1000000007 | Name: Toy Land |
+--------------------------------------------+
1 row in set (0.00 sec)

+--------------------------------------------+
| Process_Log                                |
+--------------------------------------------+
| Processing ID: 1000000008 | Name: Toy Land |
+--------------------------------------------+
1 row in set (0.00 sec)

+--------------------------------------------+
| Process_Log                                |
+--------------------------------------------+
| Processing ID: 1000000009 | Name: Toy Land |
+--------------------------------------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)
*/

-- 3. 删除存储过程
DROP PROCEDURE IF EXISTS ProcessNullEmailCustomers;

/*
Query OK, 0 rows affected (0.01 sec)
*/
