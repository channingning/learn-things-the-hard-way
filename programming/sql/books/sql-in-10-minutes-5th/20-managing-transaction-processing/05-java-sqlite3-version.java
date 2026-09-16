/*
 * create time: 2026-09-16 09:05
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Savepoint;

public class TransactionExample {
    public static void main(String[] args) {
        String url = "jdbc:sqlite:database.db"; // 或 jdbc:mysql://...
        Connection conn = null;
        Savepoint startOrder = null;

        try {
            conn = DriverManager.getConnection(url);
            conn.setAutoCommit(false); // 关闭自动提交，开启事务

            // 1. 插入客户
            String sqlCust = "INSERT INTO Customers(cust_id, cust_name) VALUES (?, ?);";
            try (PreparedStatement pstmt = conn.prepareStatement(sqlCust)) {
                pstmt.setLong(1, 1000000010L);
                pstmt.setString(2, "Toys Emporium");
                pstmt.executeUpdate();
            }

            // 2. 设置保留点
            startOrder = conn.setSavepoint("StartOrder");

            // 3. 插入订单
            String sqlOrder = "INSERT INTO Orders(order_num, order_date, cust_id) VALUES (?, ?, ?);";
            try (PreparedStatement pstmt = conn.prepareStatement(sqlOrder)) {
                pstmt.setInt(1, 20100);
                pstmt.setString(2, "2020-12-01");
                pstmt.setLong(3, 1000000010L);
                pstmt.executeUpdate();
            }

            // 4. 插入订单明细
            String sqlItem = "INSERT INTO OrderItems(order_num, order_item, Imageprod_id, quantity, item_price) VALUES (?, ?, ?, ?, ?);";
            try (PreparedStatement pstmt = conn.prepareStatement(sqlItem)) {
                pstmt.setInt(1, 20100);
                pstmt.setInt(2, 1);
                pstmt.setString(3, "BR01");
                pstmt.setInt(4, 100);
                pstmt.setDouble(5, 5.49);
                pstmt.executeUpdate();
                
                pstmt.setInt(1, 20100);
                pstmt.setInt(2, 2);
                pstmt.setString(3, "BR03");
                pstmt.setInt(4, 100);
                pstmt.setDouble(5, 10.99);
                pstmt.executeUpdate();
            }

            conn.commit(); // 提交事务
            System.out.println("事务提交成功！");

        } catch (Exception e) {
            System.err.println("发生错误: " + e.getMessage());
            try {
                if (conn != null && startOrder != null) {
                    conn.rollback(startOrder); // 回滚到保留点
                    conn.commit(); // 提交客户数据
                    System.out.println("已回滚到 StartOrder，客户数据已保留。");
                } else if (conn != null) {
                    conn.rollback();
                }
            } catch (Exception rbEx) {
                rbEx.printStackTrace();
            }
        } finally {
            try {
                if (conn != null) conn.close();
            } catch (Exception closeEx) {
                closeEx.printStackTrace();
            }
        }
    }
}
