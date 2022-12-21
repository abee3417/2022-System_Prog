# FUN foo2
# arg $a0: nop
# return $v0: 100
foo2:
    addi	$sp, $sp, -4		# $sp = $sp + -4
    li		$v0, 100		    # $v0 = 100
    addi	$sp, $sp, 4			# $sp = $sp + 4
    jr		$ra					# jump to $ra

    
# C Code:
'''
int foo2(){
    return 100;
}
'''