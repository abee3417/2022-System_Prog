# FUN main
# arg $a0: nop
# return $v0: nop
main:
    addi $sp, $sp, -20
    li $t0, 5
    sw $t0, 0($sp)
    li $t0, 15
    sw $t0, 8($sp)
    addi $t0, $sp, 8
    sw $t0, 4($sp)
    addi $t0, $sp, 0
    sw $t0, 16($sp)
    addi $sp, $sp, 20
    jr $ra
    
# C Code:
'''
typedef struct_node{
    int data;
    struct _node* next;
}Node;

void main(){
    Node n1, n2;
    n1.data = 5;
    n2.data = 15;
    n1.next = &n2;
    n2.next = NULL;
    Node* ptr = &n1;
}
'''