		.data
testdata:	.word		2, 3, 4, 5, 6
target:		.word		3
		.text
		.globl		main
main:
		la	$t0, testdata		# Load address of array containing test data
		la	$s0, target		# Load address of target value
		sw	$s0, 0($s0)		# Store target value
		
		addi	$t1, $zero, 0		# Store 0 in register for start value
		addi	$t2, $zero, 16		# Store 16 in register for end value (4 * (length - 1))
		
startLoop:		
		addi	$t3, $t1, 1		# Add 1 to start
				
		bgt	$t3, $t2, endLoop	# if (start + 1 > end)
		beq	$t3, $t2, endLoop	# if (start + 1 == end)
		
		sub	$t4, $t2, $t1		# (end - start)
		div	$t4, $t4, 2		# (end - start) / 2
		add	$t5, $t1, $t4		# mid = start + ((end - start) / 2)
		
		add 	$t6, $t0, $t5		# testdata[mid]
		sw	$t6, 0($t6)		# store value from testdata[mid]
		
		bgt	$s0, $t6, afterElse	# if (target > data[mid]) jump to afterElse
		beq	$s0, $t6, afterElse	# if (target == data[mid]) jump to afterElse
		
		add	$t2, $zero, $t5		# end = mid
		j 	startLoop
afterElse:
		add	$t1, $zero, $t5		# start = mid
		j	startLoop
endLoop:	
		
		add 	$t6, $t0, $t1		# testdata[start]
		sw	$t6, 0($t6)		# store value at testdata[start]
		
		bne	$s0, $t6, notStart
		addi	$s1, $zero, 1  
notStart:	

		add 	$t6, $t0, $t2		# testdata[end]
		sw	$t6, 0($t6)		# store value at testdata[end]
		
		bne	$s0, $t6, notEnd
		addi	$s1, $zero, 1 
		j	finish
notEnd:		
	
		addi	$s1, $zero, 0

finish:	
		li	$v0, 10
		syscall			
