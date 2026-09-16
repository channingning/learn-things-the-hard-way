/*
 * create time: 2026-09-16 08:59
 *
 * npm install better-sqlite3
 * 注：better-sqlite3 是 Node.js 中非常高效且支持同步操作的 SQLite 驱动，对处理事务和 Savepoint 非常直观。
 */

const Database = require('better-sqlite3');
const db = new Database('database.db');

try {
    // 1. 开启事务
    db.exec('BEGIN TRANSACTION;');

    // 2. 插入客户
    const insertCust = db.prepare('INSERT INTO Customers(cust_id, cust_name) VALUES (?, ?);');
    insertCust.run(1000000010, 'Toys Emporium');

    // 3. 设置保留点
    db.exec('SAVEPOINT StartOrder;');

    // 4. 插入订单
    const insertOrder = db.prepare('INSERT INTO Orders(order_num, order_date, cust_id) VALUES (?, ?, ?);');
    insertOrder.run(20100, '2020-12-01', 1000000010);

    // 5. 插入订单明细
    const insertItem = db.prepare(`
        INSERT INTO OrderItems(order_num, order_item, Imageprod_id, quantity, item_price) 
        VALUES (?, ?, ?, ?, ?);
    `);
    insertItem.run(20100, 1, 'BR01', 100, 5.49);
    insertItem.run(20100, 2, 'BR03', 100, 10.99);

    // 提交事务
    db.exec('COMMIT;');
    console.log('事务提交成功！');

} catch (err) {
    console.error('发生错误:', err.message);
    try {
        // 回滚到保留点（保留客户，撤销订单）
        db.exec('ROLLBACK TO SAVEPOINT StartOrder;');
        db.exec('COMMIT;');
        console.log('已回滚到 StartOrder，客户数据已保留。');
    } catch (rollbackErr) {
        db.exec('ROLLBACK;');
        console.error('完全回滚失败:', rollbackErr.message);
    }
} finally {
    db.close();
}
