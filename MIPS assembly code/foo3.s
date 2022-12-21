# FUN foo3
# arg $a0: nop
# return $v0: 100
foo3:
    addi	$sp, $sp, 4			# $sp = $sp + 4
    li		$v0, 100		    # $v0 = 100
    sw		$v0, 0($sp)		    # 
    lw		$v0, 0($sp)		    # 
    addi	$sp, $sp, 4			# $sp = $sp + 4
    jr		$ra					# jump to $ra

    
# C Code:
'''
int foo3(){
    int a = 100;
    return a;
}
'''

