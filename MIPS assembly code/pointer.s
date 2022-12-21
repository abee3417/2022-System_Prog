# FUN main
# arg $a0: nop
# return $v0: nop
main:
    addi $sp, $sp, -8
    li $t0, 100
    sw $t0, 0($sp)
    sw $sp, 4($sp)
    lw $t0, 4($sp)
    lw $t1, 0($t0)
    sw $t1, 0($sp)
    addi $sp, $sp, 8
    jr $ra
    
# C Code:
'''
void main(){
    int a;
    int* ptr;
    a = 100;
    ptr = &a;
    a = *ptr;
}
'''
