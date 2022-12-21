# FUN foo1
# arg $a0: nop
# return $v0: 0
foo1:
    addi	$sp, $sp, -4	    # $sp = $sp + -4
    lw		$t0, 0($sp)		    # 
    addi	$t1, $t0, 1			# $t1 = $t0 + 1
    sw		$t1, 0($sp)		    # 
    addi	$sp, $sp, 4			# $sp = $sp + 4
    jr		$ra					# jump to $ra


# C Code:
'''
void foo1(){
    int i;
    i++;
}
'''