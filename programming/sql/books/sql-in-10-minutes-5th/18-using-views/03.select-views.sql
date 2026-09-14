/*
 * create time: 2026-09-14 14:31
 * AI: gemini
 */

-- 1. MySQL
-- 标准查询（推荐）：
SELECT table_name AS view_name 
FROM information_schema.views 
WHERE table_schema = '你的数据库名';

/*
+--------------------+
| view_name          |
+--------------------+
| VendorLocations    |
| CustomerEMailList  |
| OrderItemsExpanded |
+--------------------+
3 rows in set (0.00 sec)
*/

-- 快捷命令（会同时显示表和视图，但可以通过 Table_type 过滤）：
SHOW FULL TABLES WHERE Table_type = 'VIEW';
/*
+---------------------------------+------------+
| Tables_in_sql_in_10_minutes_5th | Table_type |
+---------------------------------+------------+
| CustomerEMailList               | VIEW       |
| OrderItemsExpanded              | VIEW       |
| VendorLocations                 | VIEW       |
+---------------------------------+------------+
3 rows in set (0.00 sec)
*/

-- my test
SHOW FULL TABLES;

/*
+---------------------------------+------------+
| Tables_in_sql_in_10_minutes_5th | Table_type |
+---------------------------------+------------+
| CustomerEMailList               | VIEW       |
| Customers                       | BASE TABLE |
| OrderItems                      | BASE TABLE |
| OrderItemsExpanded              | VIEW       |
| Orders                          | BASE TABLE |
| Products                        | BASE TABLE |
| VendorLocations                 | VIEW       |
| Vendors                         | BASE TABLE |
+---------------------------------+------------+
8 rows in set (0.00 sec)
*/

-- my test
SHOW TABLES;

/*
+---------------------------------+------------+
| Tables_in_sql_in_10_minutes_5th | Table_type |
+---------------------------------+------------+
| CustomerEMailList               | VIEW       |
| Customers                       | BASE TABLE |
| OrderItems                      | BASE TABLE |
| OrderItemsExpanded              | VIEW       |
| Orders                          | BASE TABLE |
| Products                        | BASE TABLE |
| VendorLocations                 | VIEW       |
| Vendors                         | BASE TABLE |
+---------------------------------+------------+
8 rows in set (0.00 sec)
*/

-- 2. SQL Server (MSSQL)
SELECT name AS view_name, create_date, modify_date
FROM sys.views;

-- 3. PostgreSQL
-- 标准查询：
SELECT viewname AS view_name 
FROM pg_catalog.pg_views 
WHERE schemaname NOT IN ('pg_catalog', 'information_schema');

-- psql 命令行快捷键：直接输入 \dv 即可。

-- 4. Oracle
-- 查看当前用户拥有的视图：
SELECT view_name FROM user_views;

-- 查看有权限访问的所有视图：
SELECT view_name, owner FROM all_views;

-- 5. SQLite
SELECT name AS view_name 
FROM sqlite_master 
WHERE type = 'view';

/*
╭─────────────────────╮
│      view_name      │
╞═════════════════════╡
│ CustomersWithOrders │
╰─────────────────────╯
*/


-- 💡 实用小贴士如果你需要查看某个特定视图的具体创建语句（源代码），可以使用以下命令：
/* MySQL: */
  -- 获取精简 DDL 创建语句（最常用）： 
  -- 输出包含：视图名称、创建时的 SQL_MODE、字符集以及完整的 CREATE ALGORITHM... 语句。
  SHOW CREATE VIEW 视图名;

  /*
  SHOW CREATE VIEW  CustomersWithOrders;
  
  +---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+
  | View                | Create View                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      | character_set_client | collation_connection |
  +---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+
  | CustomersWithOrders | CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `CustomersWithOrders` AS select `Customers`.`cust_id` AS `cust_id`,`Customers`.`cust_name` AS `cust_name`,`Customers`.`cust_address` AS `cust_address`,`Customers`.`cust_city` AS `cust_city`,`Customers`.`cust_state` AS `cust_state`,`Customers`.`cust_zip` AS `cust_zip`,`Customers`.`cust_country` AS `cust_country`,`Customers`.`cust_contact` AS `cust_contact`,`Customers`.`cust_email` AS `cust_email` from (`Customers` join `Orders` on((`Customers`.`cust_id` = `Orders`.`cust_id`))) | latin1               | latin1_swedish_ci    |
  +---------------------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+
  1 row in set (0.00 sec)
  */

  -- 获取详细元数据（如是否可更新、定义者等）：
  SELECT * 
  FROM information_schema.views 
  WHERE table_schema = '你的数据库名' AND table_name = '视图名';

  /*
  SELECT * 
  FROM information_schema.views 
  WHERE table_schema = 'sql_in_10_minutes_5th' AND table_name = 'CustomersWithOrders';

  +---------------+-----------------------+---------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+--------------+----------------+---------------+----------------------+----------------------+
  | TABLE_CATALOG | TABLE_SCHEMA          | TABLE_NAME          | VIEW_DEFINITION                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | CHECK_OPTION | IS_UPDATABLE | DEFINER        | SECURITY_TYPE | CHARACTER_SET_CLIENT | COLLATION_CONNECTION |
  +---------------+-----------------------+---------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+--------------+----------------+---------------+----------------------+----------------------+
  | def           | sql_in_10_minutes_5th | CustomersWithOrders | select `sql_in_10_minutes_5th`.`Customers`.`cust_id` AS `cust_id`,`sql_in_10_minutes_5th`.`Customers`.`cust_name` AS `cust_name`,`sql_in_10_minutes_5th`.`Customers`.`cust_address` AS `cust_address`,`sql_in_10_minutes_5th`.`Customers`.`cust_city` AS `cust_city`,`sql_in_10_minutes_5th`.`Customers`.`cust_state` AS `cust_state`,`sql_in_10_minutes_5th`.`Customers`.`cust_zip` AS `cust_zip`,`sql_in_10_minutes_5th`.`Customers`.`cust_country` AS `cust_country`,`sql_in_10_minutes_5th`.`Customers`.`cust_contact` AS `cust_contact`,`sql_in_10_minutes_5th`.`Customers`.`cust_email` AS `cust_email` from (`sql_in_10_minutes_5th`.`Customers` join `sql_in_10_minutes_5th`.`Orders` on((`sql_in_10_minutes_5th`.`Customers`.`cust_id` = `sql_in_10_minutes_5th`.`Orders`.`cust_id`))) | NONE         | YES          | root@localhost | DEFINER       | latin1               | latin1_swedish_ci    |
  +---------------+-----------------------+---------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+--------------+--------------+----------------+---------------+----------------------+----------------------+
  1 row in set (0.00 sec)
  */

  -- VIEW_DEFINITION: 视图的核心 SELECT 查询语句。
  -- IS_UPDATABLE: 该视图是否支持 INSERT/UPDATE/DELETE 操作（YES 或 NO）。
  -- DEFINER: 视图的创建者账号。
  -- SECURITY_TYPE: 安全验证类型（DEFINER 或 INVOKER）。

/* SQL Server: */
  -- 获取原始创建文本（包含换行和注释）：
  -- 注意：如果视图被加密（使用了 WITH ENCRYPTION），此命令将无法查看。
  EXEC sp_helptext '视图名';

  -- 获取详细元数据及定义（现代推荐做法）：
  SELECT 
      v.name AS view_name,
      m.definition AS view_definition,
      v.create_date,
      v.modify_date,
      OBJECTPROPERTY(v.object_id, 'IsAnsiNullsOn') AS is_ansi_nulls_on,
      OBJECTPROPERTY(v.object_id, 'IsQuotedIdentOn') AS is_quoted_identifier_on
  FROM sys.views v
  INNER JOIN sys.sql_modules m ON v.object_id = m.object_id
  WHERE v.name = '视图名';

  -- definition: 视图的完整 T-SQL 创建语句。
  -- create_date / modify_date: 视图的创建时间和最后修改时间。

/* PostgreSQL: */
  -- 获取格式化后的 DDL 查询文本：
  -- 参数 true 表示对输出的 SQL 进行漂亮的格式化（Pretty-print），使其更易读。
  SELECT pg_get_viewdef('视图名', true);

  -- 获取包含所有者及权限的完整详细信息：
  SELECT 
      schemaname,
      viewname,
      viewowner,
      definition
  FROM pg_catalog.pg_views
  WHERE viewname = '视图名';

  -- viewowner: 该视图的所有者（Owner）。
  -- definition: 视图的详细 SELECT 查询定义。

  -- psql 命令行工具快捷命令：
  \d+ 视图名

/* Oracle: */
  -- 方法一：获取完整的 DDL 创建语句（最推荐）
  -- 注意：视图名和用户名必须大写，除非你创建时用了双引号。如果省略用户名，默认查询当前用户。
  SELECT DBMS_METADATA.GET_DDL('VIEW', '视图名', '用户名') FROM DUAL;

  -- 方法二：直接查询用户视图字典表
  SELECT text FROM user_views WHERE view_name = '视图名';

-- SQLite
  -- 标准 SQL 查询：
  SELECT sql FROM sqlite_master WHERE type = 'view' AND name = '视图名';

  /*
  SELECT sql FROM sqlite_master WHERE type = 'view' AND name = 'CustomersWithOrders';
  
  ╭────────────────────────────────────╮
  │                sql                 │
  ╞════════════════════════════════════╡
  │ CREATE VIEW CustomersWithOrders AS │
  │ SELECT Customers.cust_id,          │
  │        Customers.cust_name,        │
  │        Customers.cust_address,     │
  │        Customers.cust_city,        │
  │ ...                                │
  ╰────────────────────────────────────╯
  
  当你使用 column（列）或 box 模式时，SQLite 会尝试为每一列设置一个固定的宽度。如果你的视图定义包含很多行或很长的字符串，超出宽度的部分就会被替换为 ...。
  
  方法一：使用 .mode markdown 或 .mode line 行模式（每行显示一个字段）
    .mode markdown
    |                sql                 |
    |------------------------------------|
    | CREATE VIEW CustomersWithOrders AS |
    | SELECT Customers.cust_id,          |
    |        Customers.cust_name,        |
    |        Customers.cust_address,     |
    |        Customers.cust_city,        |
    | ...                                |
  
    .mode line
    sql: CREATE VIEW CustomersWithOrders AS
       SELECT Customers.cust_id,
              Customers.cust_name,
              Customers.cust_address,
              Customers.cust_city,
       ...
  
  方法二：使用专用的查看结构命令（最省事）
  .schema CustomersWithOrders
  */

  -- SQLite 命令行工具快捷命令：
  .schema 视图名

  /*
  .schema CustomersWithOrders
  
  CREATE VIEW CustomersWithOrders AS
  SELECT Customers.cust_id,
         Customers.cust_name,
         Customers.cust_address,
         Customers.cust_city,
         Customers.cust_state,
         Customers.cust_zip,
         Customers.cust_country,
         Customers.cust_contact,
         Customers.cust_email
  FROM Customers
  INNER JOIN Orders ON Customers.cust_id = Orders.cust_id;
  */
