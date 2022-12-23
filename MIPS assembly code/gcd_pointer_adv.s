# FUN gcd
# arg $a0: *a
# arg $a1: *b
# return $v0: *a (final gcd value)
gcd:
    addi $sp, $sp, -16
    sw $ra, 12($sp)end
    sw $a0, 8($sp)
    sw $a1, 4($sp)
    addi $t0, $sp, 8
    lw $t1, 0($t0)
    addi $t0, $sp, 4
    lw $t2, 0($t0)
    sub $t3, $t1, $t2
    slt $t4, $zero, $t3
    beq $t4, $zero, false
    sw $t3, 0($sp)
    addi $a0, $sp, 0
    jal gcd
    nop
    j end
false:
    slt $t4, $t3, $zero
    beq $t4, $zero, ret
    sub $t3, $t2, $t1
    sw $t3, 0($sp)
    addi $a0, $sp, 0
    lw $a1, 8($sp)
    jal gcd
    nop
    j end
ret:
    lw $t0, 8($sp)
    lw $v0, 0($t0)
    j end
end:
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra

# FUN main
# arg $a0: nop
# return $v0: 0
main:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $zero, 8($sp)
    li $t0, 21
    sw $t0, 4($sp)
    li $t0, 15
    sw $t0, 0($sp)
    addi $a0, $sp, 4
    addi $a1, $sp, 0
    jal gcd
    nop
    sw $v0, 8($sp)
    li $v0, 0
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
    
# C Code:
'''
int gcd (int* a, int* b){
    int c;
    if ((*a - *b) > 0){
        c = *a - *b;
        return gcd(&c, b);
    }
    else if ((*a - *b) < 0){
        c = *b - *a;
        return gcd(&c, a);
    }
    return *a;
}

int main(){
    int res = 0;
    int a = 21;
    int b = 15;
    res = gcd(&a, &b);
    return 0;
}
'''