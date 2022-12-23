# FUN push
# arg $a0: *stack
# arg $a1: data
# return $v0: nop
push:
    addi $sp, $sp, -8
    sw $a0, 4($sp)
    sw $a1, 0($sp)
    lw $t0, 0($a0)
    addi $t0, $t0, 1
    sw $t0, 0($a0)
    sll $t1, $t0, 2
    add $t2, $a0, $t1
    sw $a1, 4($t2)
    addi $sp, $sp, 8
    jr $ra

# C Code:
'''
void push(Stack* stack, int data){
   stack->buf[++stack->top] = data;
}
'''

# FUN pop
# arg $a0: *stack
# return $v0: stack's top value
pop:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)
    jal empty
    nop
    bne $v0, $zero, end
    lw $t0, 0($a0)
    sll $t1, $t0, 2
    add $t2, $a0, $t1
    lw $v0, 4($t2)
    addi $t0, $t0, -1
    sw $t0, 0($a0)
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra

end:
    li $v0, -1
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
    
# C Code:
'''
int pop(Stack* stack){
   if (isEmpty(stack)) return -1;
   return(stack->buf[stack->top--]);
}
'''

# FUN peek
# arg $a0: *stack
# return $v0: stack's top value
peek:
    addi $sp, $sp, -4
    sw $a0, 0($sp)
    lw $t0, 0($a0)
    sll $t1, $t0, 2
    add $t2, $a0, $t1
    lw $v0, 4($t2)
    addi $sp, $sp, 4
    jr $ra

# C Code:
'''
int peek(Stack* stack){
   return(stack->buf[stack->top]);
}
'''
# FUN empty
# arg $a0: *stack
# return $v0: 1 or 0
empty:
    addi $sp, $sp, -4
    sw $a0, 0($sp)
    lw $t0, 0($a0)
    li $t1, -1
    bne $t0, $t1, false
    li $v0, 1
    addi $sp, $sp, 4
    jr $ra

false:
    li $v0, 0
    addi s0, s0, 4
    jr $ra
    
# C Code:
'''
int isEmpty(Stack* stack){
   return(stack->top == -1)
}
'''

# FUN main
# arg $a0: nop
# return $v0: nop
main:
    addi $sp, $sp, -48
    sw $ra, 44($sp)
    li $t0, -1
    sw $t0, 0($sp)
    addi $a0, $sp, 0
    li $a1, 100
    jal push
    nop
    addi $a0, 0($sp)
    li $a1, 500
    jal push
    nop
    addi $a0, 0($sp)
    jal peek
    nop
    addi $a0, 0($sp)
    jal pop
    nop
    lw $ra, 44($sp)
    addi $sp, $sp, 48
    jr $ra

# C Code:
'''
typedef struct Stack{
   int top;
   int buf[10];
}Stack;

void main(){
   Stack stack;
   stack.top = -1;
   push(&stack, 100);
   push(&stack, 500);
   peek(&stack);
   pop(&stack);
}
'''