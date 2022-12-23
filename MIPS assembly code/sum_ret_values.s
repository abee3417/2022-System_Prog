# FUN foo
# arg $a0: value
# return $v0: foo(value-1) + foo(value-2)
foo:
    addi $sp, $sp, -16
    sw $ra, 12($sp)
    sw $a0, 8($sp)
    lw $t0, 8($sp)
    li $t1, 2
    slt $t2, $t1, $t0
    beq $t2, $zero, ret
    addi $a0, $t0, -1
    jal foo
    nop
    move $t3, $v0
    lw $t0, 8($sp)
    addi $a0, $t0, -2
    jal foo
    nop
    move $t4, $v0
    add $v0, $t3, $t4
    j end
ret:
    li $v0, 1
end:
    lw $ra, 12($sp)
    addi $sp, $sp, 16
    jr $ra
    
# C Code:
'''
int foo(int value){
    if(value > 2){
        return foo(value-1) + foo(value-2);
    }
    return 1;
}
'''