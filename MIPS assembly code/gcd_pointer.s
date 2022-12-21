# FUN gcd
# arg $a0: *a
# arg $a1: b
# return $v0: b (final gcd value)
gcd:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    lw $t0, 0($a0)
    slt $t1, $a1, $t0
    bne $t1, $zero, large_a
    slt $t1, $t0, $a1
    bne $t1, $zero, large_b
    lw $v0, 4($sp)
    j end

large_a:
    sub $t2, $t0, $a1
    sw $t2, 8($sp)
    addi $a0, $sp, 8
    jal gcd
    nop
    j end

large_b:
    sub $t2, $a1, $t0
    sw $t2, 8($sp)
    addi $a0, $sp, 8
    move $a1, $t0
    lw $a1, 0($sp)
    jal gcd
    nop
    j end

end:
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
    
# C Code:
'''
int gcd(int *a, int b){
    if (*a > b){
        ptr = *a - b;
        return gcd(&ptr, b);
    else if (b > a){
        ptr = b - *a;
        return gcd(&ptr, *a);
    else return b;
}
'''