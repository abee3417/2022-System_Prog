# FUN sum
# arg $a0: a
# arg $a1: b
# return $v0: c or 0 or a
sum:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $a0, 8($sp)
    sw $a1, 4($sp)
loop:
    slt $t0, $a0, $a1
    beq $t0, $t0, exit
    addi $a0, $a0, 1
    addi $a1, $a1, -1
    jal sum
    nop
    sw $v0, 0($sp)
    add $t0, $v0, $a0
    sw $t0, 0($sp)
    add $t1, $t0, $a1
    sw $t1, 0($sp)
    lw $v0, 0($sp)
    j end
exit:
    bne $a0, $a1, ret0
    beq $a0, $a1, retA
ret0:
    li $v0, 0
retA:
    move $v0, $a0
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
    li $t0, 15
    sw $t0, 4($sp)
    li $t0, 21
    sw $t0, 0($sp)
    lw $a0, 4($sp)
    lw $a1, 0($sp)
    jal sum
    nop
    sw $v0, 8($sp)
    li $v0, 0
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
    
# C Code:
'''
int sum(int a, int b)
    int c;
    while (a < b){
        c = sum(a+1, b+1);
        c = c + a;
        c = c + b;
        return c;
    }
    if (a != b) return 0;
    if (a == b) return a;
}

int main(){
    int res = 0;
    int a = 15;
    int b = 21;
    res = sum(a, b);
    return 0;
}
'''