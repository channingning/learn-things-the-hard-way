/*
 * create time: 2026-08-13 11:47
 */

#include <stdlib.h>
#include <stdio.h>

/* 链表节点结构体 */
typedef struct ListNode {
  int val;               // 节点值
  struct ListNode *next; // 指向下一节点的指针
} ListNode;

/* 构造函数 */
ListNode *newListNode(int val) {
  ListNode *node;
  node = (ListNode *)malloc(sizeof(ListNode));
  node->val = val;
  node->next = NULL;
  return node;
}

void initSingleLinkedList() {  
  // 备注：不能放全局，否则会报错

  /* 初始化链表 1 -> 3 -> 2 -> 5 -> 4 */
  // 初始化各个节点
  ListNode *n0 = newListNode(1);
  ListNode *n1 = newListNode(3);
  ListNode *n2 = newListNode(2);
  ListNode *n3 = newListNode(5);
  ListNode *n4 = newListNode(4);
  // 构建节点之间的引用
  n0->next = n1;
  n1->next = n2;
  n2->next = n3;
  n3->next = n4;
}

/* 在链表的节点 n0 之后插入节点 p */
void insert(ListNode *n0, ListNode *p) {
    ListNode *n1 = n0->next;
    p->next = n1;
    n0->next = p;
}

/* 删除链表的节点 n0 之后的首个节点 */
// 注意：stdio.h 占用了 remove 关键词
void removeItem(ListNode *n0) {
    if (!n0->next)  // 备注：等价于 n0->next == NULL
        return;
    // n0 -> p -> n1
    ListNode *p = n0->next;
    ListNode *n1 = p->next;
    n0->next = n1;
    // 释放内存
    free(p);
}

/* 访问链表中索引为 index 的节点 */
ListNode *access(ListNode *head, int index) {
    for (int i = 0; i < index; i++) {
        if (head == NULL)
            return NULL;
        head = head->next;
    }
    return head;
}

/* 在链表中查找值为 target 的首个节点 */
int find(ListNode *head, int target) {
    int index = 0;
    while (head) {
        if (head->val == target)
            return index;
        head = head->next;
        index++;
    }
    return -1;
}


/* 环形列表  补充 */
/* AI 优化的环形链表 —— 复用 ListNode 结构体，补齐操作函数 */
/* 返回：头节点指针，空链表返回 NULL */

/* 初始化环形列表  补充 */
ListNode *initCircularListOptimized() {
    ListNode *n0 = newListNode(1);
    ListNode *n1 = newListNode(3);
    ListNode *n2 = newListNode(2);
    ListNode *n3 = newListNode(5);
    ListNode *n4 = newListNode(4);
    n0->next = n1;
    n1->next = n2;
    n2->next = n3;
    n3->next = n4;
    n4->next = n0;  // 备注：实现环形列表 circular listed list
    return n0;
}

/* 判断环形链表是否为空  补充 */
int isCircularEmpty(ListNode *head) {
    return head == NULL;
}

/* 获取环形链表长度  补充 */
int circularLength(ListNode *head) {
    if (head == NULL) return 0;
    int len = 0;
    ListNode *cur = head;
    do {
        len++;
        cur = cur->next;
    } while (cur != head);
    return len;
}

/* 遍历环形链表（必须用 cur != head 作为终止条件，否则死循环）  补充 */
void traverseCircular(ListNode *head) {
    if (head == NULL) {
        printf("(空链表)\n");
        return;
    }
    ListNode *cur = head;
    do {
        printf("%d -> ", cur->val);
        cur = cur->next;
    } while (cur != head);
    printf("(回到 %d)\n", head->val);
}

/* 在尾部插入节点 p：需要找到尾节点（next == head） 补充 */
void insertCircularTail(ListNode *head, ListNode *p) {
    if (head == NULL) return;
    ListNode *tail = head;
    while (tail->next != head) {
        tail = tail->next;
    }
    tail->next = p;
    p->next = head;
}

/* 删除环形链表中值为 val 的第一个节点  补充 */
void removeCircularByValue(ListNode **headRef, int val) {
    if (*headRef == NULL) return;
    ListNode *head = *headRef;
    ListNode *cur = head->next;
    ListNode *prev = head;
    /* 单独处理头节点 */
    if (head->val == val) {
        /* 只有一个节点的情况 */
        if (head->next == head) {
            free(head);
            *headRef = NULL;
            return;
        }
        /* 找到尾节点，让它跳过 head */
        ListNode *tail = head;
        while (tail->next != head) {
            tail = tail->next;
        }
        tail->next = head->next;
        *headRef = head->next;
        free(head);
        return;
    }
    /* 非头节点 */
    while (cur != head) {
        if (cur->val == val) {
            prev->next = cur->next;
            free(cur);
            return;
        }
        prev = cur;
        cur = cur->next;
    }
}

/* 释放环形链表所有节点（避免内存泄漏）  补充 */
void freeCircularList(ListNode **headRef) {
    if (*headRef == NULL) return;
    ListNode *head = *headRef;
    ListNode *cur = head->next;
    while (cur != head) {
        ListNode *tmp = cur;
        cur = cur->next;
        free(tmp);
    }
    free(head);
    *headRef = NULL;
}


/* 双向列表 */
/* 双向链表节点结构体 */
typedef struct DoublyListNode {
    int val;                      // 节点值
    struct DoublyListNode *next;  // 指向后继节点的指针
    struct DoublyListNode *prev;  // 指向前继节点的指针
} DoublyListNode;

/* 构造函数 */
DoublyListNode *newListNodedoubly(int val) {
    DoublyListNode *node;
    node = (DoublyListNode *)malloc(sizeof(DoublyListNode));
    node->val = val;
    node->next = NULL;
    node->prev = NULL;
    return node;
}

/* 初始化双向列表  补充 */
DoublyListNode *initDoublyLinkedList() {
    DoublyListNode *n0 = newListNodedoubly(1);
    DoublyListNode *n1 = newListNodedoubly(3);
    DoublyListNode *n2 = newListNodedoubly(2);
    DoublyListNode *n3 = newListNodedoubly(5);
    DoublyListNode *n4 = newListNodedoubly(4);
    n0->next = n1;
    n1->prev = n0;
    n1->next = n2;
    n2->prev = n1;
    n2->next = n3;
    n3->prev = n2;
    n3->next = n4;
    n4->prev = n3;
    n4->next = n0;
    return n0;
}
