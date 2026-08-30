/*
 * create time: 2026-08-22 14:47
 * 基于数组实现的栈
 */

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <limits.h>

#define MAX_SIZE 1000

typedef struct {
    int *data;
    int size;
} ArrayStack;

/* 构造函数 */
ArrayStack *newArrayStack() {
    ArrayStack *stack = malloc(sizeof(ArrayStack));
    // 初始化一个大容量，避免扩容
    stack->data = malloc(sizeof(int) * MAX_SIZE);
    stack->size = 0;
    return stack;
}

/* 析构函数 */
void delArrayStack(ArrayStack *stack) {
    free(stack->data);
    free(stack);
}

/* 获取栈的长度 */
int size(ArrayStack *stack) {
    return stack->size;
}

/* 判断栈是否为空 */
bool isEmpty(ArrayStack *stack) {
    return stack->size == 0;
}

/* 入栈 */
void push(ArrayStack *stack, int num) {
    if (size(stack) == MAX_SIZE) {
        printf("栈已满\n");
        return;
    }
    stack->data[stack->size] = num;
    stack->size++;
}

/* 访问栈顶元素 */
int peek(ArrayStack *stack) {
    if (stack->size == 0) {
        printf("栈为空\n");
        return INT_MAX;  // 备注：返回 int 最大值表示错误
    }
    return stack->data[stack->size - 1];
}

/* 出栈 */
int pop(ArrayStack *stack) {
    int val = peek(stack);  // 备注：不能图省事依赖 peek 的返回值，自己加判空
    stack->size--;
    return val;
}
// 没有段错误，但有数据污染。
// 栈空时调用 pop():
//   size 从 0 → -1

// 下次调用 peek():
//   return stack->data[-1 - 1] = stack->data[-2]
//   ↑ 访问数组 data 的负索引，读到垃圾值（undefined behavior）

// 下次调用 push():
//   stack->data[stack->size] = num;   // data[-1] = num
//   ↑ 把值写到 data 外面去了，覆盖其他内存 → 隐患无穷

/* 优化出栈函数  补充 */
int popV1(ArrayStack *stack) {
    if (stack->size == 0) {
        printf("栈为空\n");
        return INT_MAX;  // ← 直接 return，不再往下跑
    }
    int val = stack->data[stack->size - 1];  // ← 能跑到这里说明 top 肯定非空
    stack->size--;
    return val;
}
