# FUN foo2
# $a0: 0
# $a1: 0
# RETURN $v0: 100
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