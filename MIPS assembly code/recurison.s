# FUN rec
# arg $a0: n
# return $v0: result
rec:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)
    li $t0, 2
    slt $t1, $a0, $t0
    bne $t1, $zero, true
    addi $a0, $a0, -1
    jal rec
    nop
    lw $t0, 0($sp)
    add $v0, $v0, $t0
    sw $v0, 0($$sp)
    lw $v0, 0($sp)
    j end
true:
    li $v0, 1
    j end
end:
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
    
# C Code:
'''
int rec(int n){
    int result = n;
    if (n < 2) return 1;
    else result = sum(n - 1) + result;
    return result;
}
'''

