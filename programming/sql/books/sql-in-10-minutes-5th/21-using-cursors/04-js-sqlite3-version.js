/*
 * create time: 2026-09-17 08:11
 */

/* npm install sqlite3 */

const sqlite3 = require('sqlite3').verbose();

// 1. 连接到 SQLite 数据库（如果文件不存在会自动创建）
const db = new sqlite3.Database('test.db', (err) => {
    if (err) {
        console.error('数据库连接失败:', err.message);
        return;
    }
    console.log('成功连接到 SQLite 数据库。');
});

// 2. 执行查询：获取所有 cust_email 为 NULL 的客户
const query = `
    SELECT cust_id, cust_name, cust_email 
    FROM Customers 
    WHERE cust_email IS NULL;
`;

// 使用 serialize 确保按顺序执行
db.serialize(() => {
    // each 会针对查询出的每一行数据执行一次回调函数（相当于自动循环遍历）
    db.each(query, (err, row) => {
        if (err) {
            console.error('查询出错:', err.message);
            return;
        }

        // 3. 编写你的业务逻辑
        console.log(`Processing ID: ${row.cust_id} | Name: ${row.cust_name}`);
    }, (err, count) => {
        // 这是遍历完成后的回调（可选）
        if (err) {
            console.error('遍历出错:', err.message);
            return;
        }
        console.log(`共处理了 ${count} 条记录。`);

        // 4. 关闭数据库连接
        db.close((err) => {
            if (err) {
                console.error('关闭数据库失败:', err.message);
                return;
            }
            console.log('数据库连接已关闭。');
        });
    });
});

// --------------------------------------------------------------------------------

/* npm install sqlite sqlite3 */

import sqlite3 from 'sqlite3';
import { open } from 'sqlite';

async function processNullEmailCustomers() {
    try {
        // 1. 异步打开数据库连接
        const db = await open({
            filename: 'test.db',
            driver: sqlite3.Database
        });

        // 2. 异步执行查询，获取所有满足条件的数据
        const rows = await db.all(`
            SELECT cust_id, cust_name, cust_email 
            FROM Customers 
            WHERE cust_email IS NULL;
        `);

        // 3. 循环遍历结果集
        for (const row of rows) {
            console.log(`Processing ID: ${row.cust_id} | Name: ${row.cust_name}`);
        }

        // 4. 关闭数据库连接
        await db.close();
        console.log('数据库连接已安全关闭。');

    } catch (err) {
        // 5. 捕获异步执行过程中的任何错误（如文件不存在、SQL 语法错误等）
        console.error('异步数据库操作出错:', err.message);
    }
}

// 运行异步函数
processNullEmailCustomers();

// --------------------------------------------------------------------------------

/* 现代 Node.js 内置的 node:sqlite 模块（Node.js 22+ 原生支持） */
import { DatabaseSync } from 'node:sqlite';

try {
    // 1. 打开数据库连接
    const db = new DatabaseSync('test.db');

    // 2. 编写 SQL 查询
    const query = `
        SELECT cust_id, cust_name, cust_email 
        FROM Customers 
        WHERE cust_email IS NULL;
    `;

    // 3. 执行查询并获取所有行
    const rows = db.prepare(query).all();

    // 4. 循环遍历结果集
    for (const row of rows) {
        console.log(`Processing ID: ${row.cust_id} | Name: ${row.cust_name}`);
    }

    // 5. 关闭数据库连接
    db.close();

} catch (err) {
    // 捕获连接失败、SQL 语法错误或表不存在等异常
    console.error('数据库操作出错:', err.message);
}

// --------------------------------------------------------------------------------

/* 
better-sqlite3 是目前 Node.js 中性能极高、且极其受欢迎的 SQLite 库。它的最大特点是采用同步（Synchronous） API 设计，因此代码非常干净利落，并且天然支持 try...catch 异常捕获。
*/

/* npm install better-sqlite3 */

import Database from 'better-sqlite3';

try {
    // 1. 打开数据库连接（如果文件不存在会自动创建）
    const db = new Database('test.db', { verbose: console.log });

    // 2. 编写 SQL 查询
    const query = `
        SELECT cust_id, cust_name, cust_email 
        FROM Customers 
        WHERE cust_email IS NULL;
    `;

    // 3. 准备并执行查询，用 .all() 获取所有行数据
    const rows = db.prepare(query).all();

    // 4. 循环遍历结果集
    for (const row of rows) {
        console.log(`Processing ID: ${row.cust_id} | Name: ${row.cust_name}`);
    }

    // 5. 关闭数据库连接
    db.close();
    console.log('数据库连接已安全关闭。');

} catch (err) {
    // 6. 使用标准的 try...catch 捕获所有数据库错误或异常
    console.error('better-sqlite3 操作出错:', err.message);
}
