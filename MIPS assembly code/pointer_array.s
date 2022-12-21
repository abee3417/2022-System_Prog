# FUN foo
# arg $a0: nop
# return $v0: nop
foo:
    addi $sp, $sp, -20
    li $t0, 1
    sw $t0, 0($sp)
    addi $t0, $sp, 8
    sw $t0, 4($sp)
    lw $t0, 4($sp)
    li $t1, 1
    sw $t1, 0($t0)
    lw $t0, 4($sp)
    li $t1, 2
    sw $t1, 0($t0)
    lw $t0, 4($sp)
    addi $t0, $t0, 4
    li $t1, 3
    sw $t1, 0($t0)
    li $t1, 4
    sw $t1, 16($sp)
    lw $t0, 0($sp)
    sll $t0, $t0, 2
    lw $t1, 4($sp)
    add $t1, $t1, $t0
    li $t2, 5
    sw $t2, 0($t1)
    addi $sp, $sp, 20
    jr $ra
    
# C Code:
'''
void foo(){
    int i = 1;
    int* parr;
    int arr[3];
    parr = arr;
    *parr = 1;
    parr[0] = 2;
    parr[1] = 3;
    arr[2] = 4;
    parr[i] = 5;
}
'''