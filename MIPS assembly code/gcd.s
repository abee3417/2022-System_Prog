# FUN gcd
# arg $a0: a
# arg $a1: b
# return $v0: a (final gcd value)
gcd:
    addi $sp, $sp, -12
    sw $ra, 8($sp)
    sw $a0, 0($sp)
    sw $a1, 4($sp)
    slt $t0, $a1, $a0
    bne $t0, $zero, large_a
    slt $t0, $a0, $a1
    bne $t0, $zero, large_b
    lw $v0, 0($sp)
    j end

large_a:
    sub $a0, $a0, $a1
    jal gcd
    nop
    j end

large_b:
    sub $a0, $a1, $a0
    lw $a1, 0($sp)
    jal gcd
    nop
    j end

end:
    lw $ra, 8($sp)
    addi $sp, $sp, 12
    jr $ra
    
# C Code:
'''
int gcd(int a, int b){
    if (a > b) return gcd(a-b, b);
    else if (b > a) return gcd(b-a, a);
    else return a;
}
'''