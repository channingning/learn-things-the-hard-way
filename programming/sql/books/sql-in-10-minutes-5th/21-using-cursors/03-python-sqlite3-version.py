# create time: 2026-09-17 08:06

import sqlite3

# 1. 连接到 SQLite 数据库（如果文件不存在会自动创建）
conn = sqlite3.connect('test.db')
cursor = conn.cursor()

# 2. 执行查询：获取所有 cust_email 为 NULL 的客户
cursor.execute("""
    SELECT cust_id, cust_name, cust_email 
    FROM Customers 
    WHERE cust_email IS NULL;
""")

# 3. 循环遍历游标获取的结果集
for row in cursor.fetchall():
    cust_id = row[0]
    cust_name = row[1]
    
    # 4. 在这里编写你的业务逻辑
    print(f"Processing ID: {cust_id} | Name: {cust_name}")

# 5. 关闭连接
cursor.close()
conn.close()

# ---------------------------------------------------------

# 使用 try 和 with
try:
    # 1. 使用 with 语句管理数据库连接，离开代码块时会自动关闭 conn
    with sqlite3.connect('test.db') as conn:
        cursor = conn.cursor()
        
        # 2. 执行查询
        cursor.execute("""
            SELECT cust_id, cust_name, cust_email 
            FROM Customers 
            WHERE cust_email IS NULL;
        """)
        
        # 3. 循环遍历结果集
        for row in cursor.fetchall():
            cust_id = row[0]
            cust_name = row[1]
            print(f"Processing ID: {cust_id} | Name: {cust_name}")

except sqlite3.Error as e:
    # 4. 捕获数据库相关异常
    print(f"数据库操作出错: {e}")
