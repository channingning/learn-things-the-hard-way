# create time: 2026-09-16 07:31

import sqlite3

# 连接数据库
conn = sqlite3.connect("database.db")
cursor = conn.cursor()

try:
  # 1. 开启事务
  cursor.execute("BEGIN TRANSACTION;")

  # 2. 插入客户信息
  cursor.execute(
      "INSERT INTO Customers(cust_id, cust_name) VALUES (?, ?);",
      (1000000010, "Toys Emporium"),
  )

  # 3. 设置保留点
  cursor.execute("SAVEPOINT StartOrder;")

  # 4. 插入订单信息
  cursor.execute(
      "INSERT INTO Orders(order_num, order_date, cust_id) VALUES (?, ?, ?);",
      (20100, "2020-12-01", 1000000010),
  )

  # 5. 插入订单明细 1 & 2
  item_sql = """INSERT INTO OrderItems(order_num, order_item, Imageprod_id, quantity, item_price) 
                  VALUES (?, ?, ?, ?, ?);"""
  cursor.execute(item_sql, (20100, 1, "BR01", 100, 5.49))
  cursor.execute(item_sql, (20100, 2, "BR03", 100, 10.99))

  # 一切顺利，提交整个事务
  conn.commit()
  print("事务提交成功！")

except Exception as e:
  print(f"发生错误: {e}")
  try:
    # 模拟原脚本逻辑：如果订单部分出错，回滚到保留点（保留客户，丢弃订单）
    cursor.execute("ROLLBACK TO SAVEPOINT StartOrder;")
    conn.commit()  # 提交客户数据的保存
    print("已回滚到 StartOrder 保留点，客户数据已保存。")
  except Exception as rollback_err:
    conn.rollback()  # 彻底回滚
    print(f"完整回滚: {rollback_err}")

finally:
  conn.close()
