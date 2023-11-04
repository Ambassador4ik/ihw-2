.macro SPUSH(%x)
	addi	sp, sp, -4
	sw	%x, (sp)
.end_macro

.macro SPOP(%x)
	lw	%x, (sp)
	addi	sp, sp, 4
.end_macro

.macro SPUSH_DOUBLE(%x)
	addi	sp, sp, -8
	fsd 	%x, (sp)
.end_macro 

.macro SPOP_DOUBLE(%x)
	fld 	%x, (sp)
	addi	sp, sp, 8
.end_macro 

.macro FUNC(%x, %n, %out)
	SPUSH_DOUBLE(fa1)
	SPUSH(a1)
	fmv.d fa1 %x
	mv a1 %n
	call function
	fmv.d %out fa0
	SPOP(a1)
	SPOP_DOUBLE(fa1)
.end_macro