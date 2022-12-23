# FUN cez
# Counting 0 from the right until 1.
# arg $a0: number
# return $v0: count
cez:
    addi $sp, $sp, -20
    sw $a0, 16($sp)
    li $t0, 1
    sw $t0, 12($sp)
    sw $zero, 8($sp)
    sw $zero, 4($sp)
    sw $zero, 0($sp)
    lw $t6, 0($sp)
    li $t7, 32
loop:
    slt $t5, $t6, $t7
    beq $t5, $zero, exit
    lw $t0, 8($sp)
    sw $zero, 8($sp)
    lw $t1, 12($sp)
    lw $t2, 16($sp)
    and $t0, $t1, $t2
    sw $t0, 8($sp)
    lw $t0, 8($sp)
    bne $t0, $zero, else
    lw $t0, 4($sp)
    addi $t0, $t0, 1
    sw $t0, 4($sp)
    j addV
else:
    j exit
addV:
    lw $t0, 12($sp)
    add $t0, $t0, $t0
    sw $t0, 12($sp)
    j loop
exit:
    lw $v0, 4($sp)
    addi $sp, $sp, 20
    jr $ra

# FUN check
# Checking whether a number is multiple of 64.
# arg $a0: n
# return $v0: 1(true) or 0(false)
check:
    addi $sp, $sp, -8
    sw $ra, 4($sp)
    sw $a0, 0($sp)
    jal cez
    nop 
    li $t0, 5
    slt $t1, $t0, $v0
    beq $t1, $zero, ret0
    li $v0, 1
    j end
ret0:
    li $v0, 0
    j end
end:
    lw $ra, 4($sp)
    addi $sp, $sp, 8
    jr $ra
    
# C Code:
'''
int cez(int number){
    int v = 1;
    int and = 0;
    int count = 0;
    int i = 0;
    for (i = 0; i < 32; i++){
        and = 0;
        and = v & number;
        if (and == 0) count++;
        else break;
        v = v + v;
    }
    return count;
}

int check(int n){
    if (cez(n) > 5) return 1;
    else return 0;
}
'''