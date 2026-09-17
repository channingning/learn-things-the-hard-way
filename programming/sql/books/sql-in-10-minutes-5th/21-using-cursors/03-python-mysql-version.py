# create time: 2026-09-17 08:27

# pip install pymysql

import pymysql

try:
    # 1. 使用 with 语句连接 MySQL 数据库（离开代码块时会自动关闭连接）
    with pymysql.connect(
        host='localhost',
        user='root',
        password='your_password',      # 替换为你的 MySQL 密码
        database='your_database_name', # 替换为你的数据库名
        charset='utf8mb4',
        cursorclass=pymysql.cursors.DictCursor  # 使用字典游标，方便通过字段名获取数据
    ) as conn:
        
        # 2. 获取游标对象
        with conn.cursor() as cursor:
            # 3. 编写并执行 SQL 查询（对应你的 MySQL 游标需求）
            sql = """
                SELECT cust_id, cust_name, cust_email 
                FROM Customers 
                WHERE cust_email IS NULL;
            """
            cursor.execute(sql)
            
            # 4. 获取所有结果集并循环遍历
            rows = cursor.fetchall()
            for row in rows:
                cust_id = row['cust_id']
                cust_name = row['cust_name']
                
                # 5. 编写你的业务逻辑
                print(f"Processing ID: {cust_id} | Name: {cust_name}")

except pymysql.MySQLError as e:
    # 6. 捕获 MySQL 数据库连接失败、SQL 语法错误等异常
    print(f"MySQL 数据库操作出错: {e}")
