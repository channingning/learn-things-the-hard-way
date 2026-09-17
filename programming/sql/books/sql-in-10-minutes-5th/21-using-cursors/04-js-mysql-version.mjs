/*
 * create time: 2026-09-17 08:29
 *
 * npm install mysql2
 * 在 Node.js 中操作 MySQL，目前最流行、性能最好且完美支持 async/await 与 try...catch 的库是 mysql2。
 */

import mysql from 'mysql2/promise';

async function processNullEmailCustomers() {
    let connection;
    
    try {
        // 1. 异步建立 MySQL 数据库连接
        connection = await mysql.createConnection({
            host: 'localhost',
            user: 'root',
            password: 'your_password',      // 替换为你的 MySQL 密码
            database: 'your_database_name', // 替换为你的数据库名
            charset: 'utf8mb4'
        });

        console.log('成功连接到 MySQL 数据库。');

        // 2. 编写 SQL 查询
        const query = `
            SELECT cust_id, cust_name, cust_email 
            FROM Customers 
            WHERE cust_email IS NULL;
        `;

        // 3. 执行查询（返回结果为一个数组，第一个元素是行数据）
        const [rows] = await connection.execute(query);

        // 4. 循环遍历结果集
        for (const row of rows) {
            console.log(`Processing ID: ${row.cust_id} | Name: ${row.cust_name}`);
        }

    } catch (err) {
        // 5. 使用 try...catch 捕获连接失败、密码错误或 SQL 语法错误等异常
        console.error('MySQL 数据库操作出错:', err.message);

    } finally {
        // 6. 确保无论成功还是失败，最后都能安全关闭数据库连接
        if (connection) {
            await connection.end();
            console.log('MySQL 数据库连接已安全关闭。');
        }
    }
}

// 运行异步函数
processNullEmailCustomers();
