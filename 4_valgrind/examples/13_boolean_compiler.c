#include <stdbool.h>
#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

#include <sys/mman.h>

int const CODE_SIZE = 4096;

enum Instruction {
    MOV = 0xB8,
    RET = 0xC3,
};

struct Expr;
uint8_t* compile(struct Expr* expr);
bool execute(uint8_t* code);
int eval(struct Expr* expr);

enum Operator {
    AND,
    EQ,
    OR,
};

enum Tag {
    BOOL_LIT,
    EXPR,
    NUM_LIT,
    VAR,
};

union Value {
    bool boolean;
    struct Expr* expr;
    int num;
    int var;
};

struct Operand {
    enum Tag tag;
    union Value value;
};

struct Expr {
    struct Operand left;
    enum Operator operator;
    struct Operand right;
};

int variables[10] = {
    42,
    24,
    12,
    6,
    3,
    1,
    0,
    -1,
    -3,
    -6
};

void main(void) {
    union Value left_value;
    left_value.boolean = true;
    union Value left_value2;
    left_value2.num = 42;
    struct Expr expr = {
        .left = {
            .tag = NUM_LIT,
            .value = { .num = 42 }
        },
        .operator = EQ,
        .right = {
            .tag = VAR,
            .value = { .var = 0 }
        }
    };

    struct Expr bool_expr = {
        .left = {
            .tag = BOOL_LIT,
            .value = { .boolean = true }
        },
        .operator = AND,
        .right = {
            .tag = EXPR,
            .value = { .expr = &expr }
        }
    };
    uint8_t* code = compile(&bool_expr);
    bool result = execute(code);
    printf("Evaluated to %d\n", result);
    munmap(code, CODE_SIZE);
}

int eval_operand(struct Operand* operand) {
    switch(operand->tag) {
        case BOOL_LIT:
            return operand->value.boolean;
        case EXPR:
            return eval(operand->value.expr);
        case NUM_LIT:
            return operand->value.num;
        case VAR:
            return variables[operand->value.var];
    }
}

int eval(struct Expr* expr) {
    int left = eval_operand(&expr->left);
    int right = eval_operand(&expr->right);
    switch(expr->operator) {
        case AND:
            return left && right;
        case EQ:
            return left == right;
        case OR:
            return left || right;
    }
}

uint8_t* compile(struct Expr* expr) {
    int result = eval(expr);
    uint8_t* code = (uint8_t*) mmap(NULL, CODE_SIZE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    code[0] = MOV;
    *((int*)&code[1]) = result;
    code[5] = RET;
    return code;
}

bool execute(uint8_t* code) {
    int (*func)();
    func = (int (*)()) code;
    int result = func();
    return result;
}
