/*
 * create time: 2026-09-17 08:23
 */

/* 1. 准备工作（Maven 依赖） */
/*
<dependency>
    <groupId>org.xerial</groupId>
    <artifactId>sqlite-jdbc</artifactId>
    <version>3.45.1.0</version> <!-- 请根据实际情况选择较新版本 -->
</dependency>
*/

/* 2. Java 完整代码 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CustomerProcessor {
    public static void main(String[] args) {
        // SQLite 数据库连接 URL
        String url = "jdbc:sqlite:test.db";

        // 使用 try-with-resources 自动关闭资源（相当于 Python 的 with 和 try 结合）
        try (Connection conn = DriverManager.getConnection(url);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(
                 "SELECT cust_id, cust_name, cust_email FROM Customers WHERE cust_email IS NULL;"
             )) {

            // 循环遍历结果集（rs.next() 指向下一行，直到没有数据为止）
            while (rs.next()) {
                String custId = rs.getString("cust_id");
                String custName = rs.getString("cust_name");
                
                // 编写你的业务逻辑
                System.out.println("Processing ID: " + custId + " | Name: " + custName);
            }

        } catch (SQLException e) {
            // 捕获数据库连接、SQL 语法错误等异常
            System.err.println("数据库操作出错: " + e.getMessage());
        }
    }
}
