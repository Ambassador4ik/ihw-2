# Taylor series calculation module
# IN: fa1 - value of X
# IN: fa2 - value of Epsilon
# IN (hardcoded) func.asm - function for Taylor series member calculation
# OUT: fa0 - sum of Taylor series members greater than Epsilon
.include "stack.asm"
.data
	null: .double 0.0
.text
.globl taylor
	taylor:
	
	init:
		SPUSH(ra)
		SPUSH(s0)
		SPUSH_DOUBLE(fs0)
		SPUSH_DOUBLE(fs1)
		SPUSH_DOUBLE(fs2)
		
		fmv.d fs0 fa1 		# X value
		fmv.d fs1 fa2 		# Epsilon value
		
		fld fs2 null t0		# Series sum
		
		li s0 1			# N value
		
		li t6 100		# Max N value
		
	loop:
		FUNC(fs0, s0, ft0) 	# f(x, n) value stored in ft0
		fabs.d ft1 ft0		# abs(f) 
		
		fge.d t0 ft1 fs1	
		beqz t0 loop_end	# if abs(f) <= Epsilon
		
		addi s0 s0 1		# N++
		fadd.d fs2 fs2 ft0	# sum = sum + f(x, n)
		
		bge s0 t6 loop_end	# Maximum taylor series depth reached
		
		j loop

	loop_end:
		
		fmv.d fa0 fs2		# Return result

		SPOP_DOUBLE(fs2)
		SPOP_DOUBLE(fs1)
		SPOP_DOUBLE(fs0)
		SPOP(s0)
		SPOP(ra)
		
		ret
