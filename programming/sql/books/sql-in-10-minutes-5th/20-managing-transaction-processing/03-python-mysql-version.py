# create time: 2026-09-16 07:35
# pip install pymysql

import pymysql

# 连接 MySQL 数据库
connection = pymysql.connect(
    host="localhost",
    user="root",
    password="your_password",
    database="your_database",
    charset="utf8mb4",
    cursorclass=pymysql.cursors.DictCursor,
)

try:
  with connection:
    # 1. 开启事务（关闭自动提交）
    connection.begin()

    with connection.cursor() as cursor:
      # 2. 插入客户信息
      sql_cust = (
          "INSERT INTO Customers(cust_id, cust_name) VALUES (%s, %s);"
      )
      cursor.execute(sql_cust, (1000000010, "Toys Emporium"))

      # 3. 设置保留点（MySQL 支持 SAVEPOINT）
      cursor.execute("SAVEPOINT StartOrder;")

      # 4. 插入订单信息
      sql_order = "INSERT INTO Orders(order_num, order_date, cust_id) VALUES (%s, %s, %s);"
      cursor.execute(sql_order, (20100, "2020-12-01", 1000000010))

      # 5. 插入订单明细
      sql_item = "INSERT INTO OrderItems(order_num, order_item, Imageprod_id, quantity, item_price) VALUES (%s, %s, %s, %s, %s);"
      cursor.execute(sql_item, (20100, 1, "BR01", 100, 5.49))
      cursor.execute(sql_item, (20100, 2, "BR03", 100, 10.99))

    # 一切顺利，提交整个事务
    connection.commit()
    print("MySQL 事务提交成功！")

except Exception as e:
  print(f"发生错误: {e}")
  try:
    # 回滚到保留点（保留客户数据，丢弃订单数据）
    with connection.cursor() as cursor:
      cursor.execute("ROLLBACK TO SAVEPOINT StartOrder;")
    connection.commit()  # 提交客户数据的保存
    print("已回滚到 StartOrder 保留点，客户数据已保存。")
  except Exception as rollback_err:
    connection.rollback()  # 如果保留点回滚失败，则彻底回滚整个事务
    print(f"完整回滚: {rollback_err}")
