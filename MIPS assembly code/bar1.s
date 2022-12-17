# FUN bar
# $a0: 0
# $a1: 0
# RETURN $v0: 100
bar:
    addi		$sp, $sp, -4			# $sp = $sp + -4
    li			$t0, 100				# $t0 = 100
    sw			$t0, 0($sp)			    # 
    lw			$v0, 0($sp)			    # 
    addi		$sp, $sp, 4			    # $sp = $sp + 4
    jr			$ra					    # jump to $ra


# FUN foo
# $a0: 0
# $a1: 0
# RETURN $v0: 200
foo:
    addi		$sp, $sp, -16			# $sp = $sp + -16
    sw			$ra, 12($sp)			# 
    li			$t0, 100				# $t0 = 100
    sw			$t0, 0($sp)			    # 
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
int bar(){
    int a = 100;
    return a;
}

int foo(){
    int a = 100;
    int b;
    b = bar();
    int c = a + b;
    return c;
}
'''

