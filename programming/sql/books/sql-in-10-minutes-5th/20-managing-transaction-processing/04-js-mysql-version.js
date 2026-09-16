/*
 * create time: 2026-09-16 09:02
 * 
 * npm install mysql2
 * 注：推荐使用 mysql2 的 Promise 风格 API，方便使用 async/await 处理事务。
 */

const mysql = require('mysql2/promise');

async function runTransaction() {
    // 创建数据库连接池或连接
    const connection = await mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: 'your_password',
        database: 'your_database'
    });

    try {
        // 1. 开启事务
        await connection.beginTransaction();

        // 2. 插入客户信息
        const sqlCust = 'INSERT INTO Customers(cust_id, cust_name) VALUES (?, ?);';
        await connection.execute(sqlCust, [1000000010, 'Toys Emporium']);

        // 3. 设置保留点
        await connection.execute('SAVEPOINT StartOrder;');

        // 4. 插入订单信息
        const sqlOrder = 'INSERT INTO Orders(order_num, order_date, cust_id) VALUES (?, ?, ?);';
        await connection.execute(sqlOrder, [20100, '2020-12-01', 1000000010]);

        // 5. 插入订单明细
        const sqlItem = `
            INSERT INTO OrderItems(order_num, order_item, Imageprod_id, quantity, item_price) 
            VALUES (?, ?, ?, ?, ?);
        `;
        await connection.execute(sqlItem, [20100, 1, 'BR01', 100, 5.49]);
        await connection.execute(sqlItem, [20100, 2, 'BR03', 100, 10.99]);

        // 提交整个事务
        await connection.commit();
        console.log('MySQL 事务提交成功！');

    } catch (err) {
        console.error('发生错误:', err.message);
        try {
            // 回滚到保留点（保留客户，撤销订单）
            await connection.execute('ROLLBACK TO SAVEPOINT StartOrder;');
            await connection.commit(); // 提交保留的客户数据
            console.log('已回滚到 StartOrder，客户数据已保留。');
        } catch (rollbackErr) {
            await connection.rollback(); // 彻底回滚
            console.error('完全回滚失败:', rollbackErr.message);
        }
    } finally {
        await connection.end();
    }
}

runTransaction();
