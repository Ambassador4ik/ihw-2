.macro PRINT_INT (%x)
	li a7, 1
	mv a0, %x
	ecall
.end_macro

.macro READ_INT(%x)
	push (a0)
	li a7, 5
	ecall
	mv %x, a0
	pop (a0)
.end_macro

.macro PRINT_STR (%x)
	.data
		str: .asciz %x
   	.text
		push (a0)
		li a7, 4
		la a0, str
		ecall
		pop (a0)
.end_macro

.macro PRINT_CHAR(%x)
   li a7, 11
   li a0, %x
   ecall
.end_macro

.macro NEWLINE
	PRINT_CHAR('\n')
.end_macro

.macro EXIT
    li a7, 10
    ecall
.end_macro

# Pop and Push are used in this file too 
# They are left here for everything to work proberly
# However other modules use stack.asm to avoid recursive include issues
.macro push(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

.macro pop(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro push_double(%x)
	addi	sp, sp, -8
	fsd 	%x, (sp)
.end_macro 

.macro pop_double(%x)
	fld 	%x, (sp)
	addi	sp, sp, 8
.end_macro 

.macro READ_DOUBLE(%x)
	push_double(fa0)
	li a7, 7
	ecall
	fmv.d %x fa0
	pop_double(fa0)
.end_macro 

.macro PRINT_DOUBLE(%x)
	li a7, 3
	fmv.d fa0 %x
	ecall
.end_macro 

.macro F(%x, %n, %out)
	push_double(fa1)
	push(a1)
	fmv.d fa1 %x
	mv a1 %n
	call function
	fmv.d %out fa0
	pop(a1)
	pop_double(fa1)
.end_macro

.macro TAYLOR_SERIES(%x, %eps, %out)
	push_double(fa1)
	push_double(fa2)
	fmv.d fa1 %x
	fmv.d fa2 %eps
	call taylor
	fmv.d %out fa0
	pop_double(fa2)
	pop_double(fa1)
.end_macro

.macro CHECK_INPUT(%x)
	.data 
		min: .double -1.0
		max: .double 1.0
	.text
		init:
			push(s0)
			push_double(fs0)
			
			fld fs0 max s0
			flt.d s0 %x fs0
			beqz s0 error_exit
			
			fld fs0 min s0
			fge.d s0 %x fs0
			beqz s0 error_exit
			
			j cont
			
		error_exit:
			PRINT_STR("Invalid argument!")
			NEWLINE
			EXIT
			
		cont:
			pop_double(fs0)
			pop(s0)
.end_macro
