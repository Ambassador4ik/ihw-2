# Function calculation module
# f(x, n) = -x^n/n
# IN: fa1 - value of x: DOUBLE
# IN: a1 - value of n: INT
# OUT: fa0 - value of f(x, n)
.include "stack.asm"
.data
	one: .double 1.0
.text 
.globl function
	function:
	
	init:
		SPUSH(ra)
		SPUSH(s0)
		SPUSH(s1)
		SPUSH_DOUBLE(fs0)
		SPUSH_DOUBLE(fs1)
		
		fmv.d fs0 fa1 		# X value
		mv s0 a1		# N value
		
		fld fs1 one t0 		# Multiplication result
		
		li s1 0		 	# Counter
		
	loop:
		beq s0 s1 loop_end	# n == counter
		
		fmul.d fs1 fs1 fs0 	# mul = mul * x
		addi s1 s1 1		# counter++
		
		j loop
	
	loop_end:
		fcvt.d.w ft0 s0		# double(n)
		fdiv.d fs1 fs1 ft0 	# mul = mul / n
		fneg.d fs1 fs1		# mul = -mul
		fmv.d fa0 fs1 		# return result

		SPOP_DOUBLE(fs1)
		SPOP_DOUBLE(fs0)
		SPOP(s1)
		SPOP(s0)
		SPOP(ra)
		
		ret
