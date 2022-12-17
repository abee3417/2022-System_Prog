# FUN bar
# $a0: 100
# $a1: 0
# RETURN $v0: 101
bar:
    addi		$sp, $sp, -8			# $sp = $sp + -8
    sw			$a0, 0($sp)			    # 
    lw			$t0, 0($sp)			    # 
    addi		$t1, $t0, 1			    # $t1 = $t0 + 1
    sw			$t1, 4($sp)			    # 
    lw			$v0, 4($sp)			    # 
    addi		$sp, $sp, 4			    # $sp = $sp + 4
    jr			$ra					    # jump to $ra


# FUN foo
# $a0: 0
# $a1: 0
# RETURN $v0: 201
foo:
    addi		$sp, $sp, -16			# $sp = $sp + -16
    sw			$ra, 12($sp)			# 
    li			$t0, 100				# $t0 = 100
    sw			$t0, 0($sp)			    # 
    lw			$a0, 0($sp)			    # 
    jal			bar				        # jump to bar and save position to $ra
    nop
    sw			$v0, 4($sp)			    # 
    lw			$t0, 0($sp)			    # 
    lw			$t1, 4($sp)			    # 
    add			$v0, $t0, $t1		    # $v0 = $t0 + $t1
    sw			$v0, 8($sp)			    # 
    lw			$v0, 8($sp)			    # 
    lw			$ra, 12($sp)			# 
    addi		$sp, $sp, 16			# $sp = $sp + 16
    jr			$ra					    # jump to $ra


# C Code:
'''
int bar(int arg){
    int res = arg + 1;
    return res;
}

int foo(){
    int a = 100;
    int b;
    int c;
    b = bar(a);
    c = a + b;
    return c;
}
'''

