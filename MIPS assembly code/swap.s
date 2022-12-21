# FUN swap
# arg $a0: *a
# arg $a1: *b
# return $v0: nop
swap:
    addi $sp, $sp, -12
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    lw $t0, 0($sp)
    lw $t1, 0($t0)
    sw $t1, 8($sp)
    lw $t0, 4($sp)
    lw $t1, 0($t0)
    lw $t0, 0($sp)
    sw $t1, 0($t0)
    lw $t0, 8($sp)
    lw $t1, 4($sp)
    sw $t0, 0($t1)
    addi $sp, $sp, 12
    jr $ra
    
# C Code:
'''
void swap(int* a, int* b){
    int temp = *a;
    *a = *b;
    *b = temp;
}
'''