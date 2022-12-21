# FUN fac
# arg $a0: n
# return $v0: fac(n-1) * n
fac:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)
    li $t0, 1
    slt $t1, $a0, $t0
    bne $t1, $zero, true
    addi $a0, $a0, -1
    jal fac
    nop
    lw $t2, 0($sp)
    mult $v0, $v0, $t2
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
int fac(int n){
    if(n < 1) return 1;
    else return fac(n-1) * n;
}
'''

