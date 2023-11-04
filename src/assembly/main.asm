.include "macros.asm"
.data 
	epsilon: .double 0.0001
.text 
.globl main 	# Needed for "Start Main" RARS feature to work

	main:
		PRINT_STR("Enter x: ")
		READ_DOUBLE(ft0)
		CHECK_INPUT(ft0)
		
		fld ft1 epsilon t0
		
		TAYLOR_SERIES(ft0, ft1, ft2)
		
		PRINT_STR("Found taylor series sum: ")
		PRINT_DOUBLE(ft2)
		
		NEWLINE
		EXIT
