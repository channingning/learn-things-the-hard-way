/*
 * create time: 2026-09-17 08:37
 */

/* 1. 准备工作（Maven 依赖） */
/*
<dependency>
    <groupId>com.mysql</groupId>
    <artifactId>mysql-connector-j</artifactId>
    <version>8.3.0</version> <!-- 请根据实际情况选择较新版本 -->
</dependency>
*/

/* 2. Java (MySQL 版本) 完整代码 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class MysqlCustomerProcessor {
    public static void main(String[] args) {
        // MySQL 连接 URL（请替换你的主机、端口和数据库名）
        String url = "jdbc:mysql://localhost:3306/your_database_name?useSSL=false&serverTimezone=UTC";
        String user = "root";          // 你的 MySQL 用户名
        String password = "your_password"; // 你的 MySQL 密码

        // 使用 try-with-resources 自动关闭 Connection、Statement 和 ResultSet
        try (Connection conn = DriverManager.getConnection(url, user, password);
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(
                 "SELECT cust_id, cust_name, cust_email FROM Customers WHERE cust_email IS NULL;"
             )) {

            // 循环遍历结果集
            while (rs.next()) {
                String custId = rs.getString("cust_id");
                String custName = rs.getString("cust_name");
                
                // 编写你的业务逻辑
                System.out.println("Processing ID: " + custId + " | Name: " + custName);
            }

        } catch (SQLException e) {
            // 捕获连接失败、密码错误或 SQL 语法错误等异常
            System.err.println("MySQL 数据库操作出错: " + e.getMessage());
        }
    }
}
