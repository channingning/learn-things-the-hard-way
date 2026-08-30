/*
 * create time: 2026-08-22 13:29
 * 基于链表实现的栈
 */

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <limits.h>

// 备注：自引用，内部有指向自己的指针
// 备注：自引用不能匿名，必须带标签名
// List Node 结构体  补充
typedef struct ListNode {
    int val;               // 节点值
    struct ListNode *next; // 指向下一节点的指针
} ListNode;

// 备注：非自引用可以匿名，LinkedListStack 内部的 top 指向 ListNode ，不是指向 LinkedListStack 自己
typedef struct {
    ListNode *top;  // 将头节点作为栈顶
    int size;       // 栈的长度
} LinkedListStack;

/* 构造函数 */
LinkedListStack *newLinkedListStack() {
    LinkedListStack *s = malloc(sizeof(LinkedListStack));
    s->top = NULL;
    s->size = 0;
    return s;
}

/* 析构函数 */
void delLinkedListStack(LinkedListStack *s) {
    while (s->top) {
        ListNode *n = s->top->next;
        free(s->top);
        s->top = n;
    }
    free(s);
}

/* 获取栈的长度 */
int size(LinkedListStack *s) {
    return s->size;
}

/* 判断栈是否为空 */
bool isEmpty(LinkedListStack *s) {
    return size(s) == 0;
}

/* 入栈 */
void push(LinkedListStack *s, int num) {
    ListNode *node = malloc(sizeof(ListNode));
    node->next = s->top;  // 更新新加节点指针域
    node->val = num;      // 更新新加节点数据域
    s->top = node;        // 更新栈顶
    s->size++;            // 更新栈大小
}

/* 访问栈顶元素 */
int peek(LinkedListStack *s) {
    if (s->size == 0) {
        printf("栈为空\n");
        return INT_MAX;  // 返回 int 最大值表示错误
    }
    return s->top->val;
}

/* 出栈 */
int pop(LinkedListStack *s) {
    int val = peek(s);
    ListNode *tmp = s->top;
    s->top = s->top->next;
    // 释放内存
    free(tmp);
    s->size--;
    return val;
}
// 问题来源：链表实现栈，C语言版本的代码中:
// 问题：栈为空再调用出栈时会发生段错误
// 原因：peek里面虽然有判断但只是返回了INT_MAX，pop中没有对val判断程序会继续执行，
// 所以在s->top->next的时候会发生段错误问题，这个时候s->top是为NULL的，不会有next。

// 步骤 1: int val = peek(s)
//         → peek 里 s->size==0，返回 INT_MAX
//         → 你以为函数会停在这里？不会，peek 只是 return 了一个值给 val
// 步骤 2: ListNode *tmp = s->top
//         → tmp = NULL（栈空时 top=NULL）
// 步骤 3: s->top = s->top->next   ← 💥 段错误在这里！
//         → 等价于 NULL->next
//         → 解引用空指针，崩溃
// peek 只是"返回了一个哨兵值"，并没有让 pop 停下来。 哨兵值本身不能阻止后续代码的执行。

/* 解决出栈函数段错误  补充  */
int popV1(LinkedListStack *s) {
    if (s->size == 0) {
        printf("栈为空\n");
        return INT_MAX;     // ← 直接 return，不再往下跑
    }
    int val = s->top->val;  // ← 能跑到这里说明 top 肯定非空
    ListNode *tmp = s->top;
    s->top = s->top->next;  // ← s->top 非空，->next 安全
    free(tmp);
    s->size--;
    return val; 
}
