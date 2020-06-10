	.option nopic
	.text
	.align	3
.LC0:
	.string "%lli\n"
	.text
	.align 1
	.globl	main
	.type	main, @function
.LC1:
	.string "%lli"
	.align 3
.LC2:
	.string "%lli "
	.align 3
.LC3:
	.string "\n"
	.align 3
main:
	addi x2,x2,-32
	sd	x1,24(x2)
	sd	x8,16(x2)
	addi x8,x2,32
	
	#begin

input:	
	add x11, x8, zero
	lui x15,%hi(.LC1)
	addi x10,x15,%lo(.LC1)
	call scanf

	ld x27, 0(x8)

	jal x1, F

print:	
	add x11, x26, 0
	lui x15,%hi(.LC0)    
	addi x10,x15,%lo(.LC0)
	call printf

	beq x0, x0, end	
F:
	addi x2, x2, -16
	sd x1, 8(x2)		#return address
	sd x27, 0(x2)		#xth floor	

	addi x5, x27, 0		#x5 = x
	li x6, 21			#x6 = 21
	li x7, 11			#x7 = 11
	li x28, 2			#x28 = 2
	li x23, 1			#x23 = 1

	bge	x5, x6,  L1		#x >= 21
	bge x5, x7,  L2		#x >= 11
	bge x5, x28, L3		#x >= 2
	beq x5, x0,  L4		#x = 0
	beq x5, x23, L5		#x = 1

	addi x26, x26, -1	#otherwise, return value to -1
	addi x2, x2, 16		#pop stack
	jalr x0, 0(x1)		#return

L1:						#x > 20
	li x31, 5			#x31 = 5
	div x27, x27, x31	#x = x / 5
	jal x1, F			#call F(x/5)	
	addi x20, x26, 0	#move result of F(x/5) to x20

	ld x27, 0(x2)		#restore caller's x
	ld x1, 8(x2)		#restore caller's return address	

	li x28, 2			#x28 = 2
	mul x21, x27, x28	#x21 = x * 2
	add x26, x21, x20	#return 2 * x + F(x/5)	

	addi x2, x2 ,16 	#pop stack
	jalr x0, 0(x1)		#return	
	
L2: 					#10 < x < 21
	li x30, 2			#x30 = 2
	sub x27, x27, x30	#x = x - 2
	jal x1, F			#call F(x-2)			
	ld x27, 0(x2)		#restore caller's x
	ld x1, 8(x2)		#restore caller's return address	

	li x29, 3			#x29 = 3
	sub x27, x27, x29	#x = x - 3
	
	jal x1, F			#call F(x-3)			
	ld x27, 0(x2)		#restore caller's x
	ld x1, 8(x2)		#restore caller's return address

	addi x2, x2 ,16 	#pop stack
	jalr x0, 0(x1)		#return	

L3: 					#1 < x < 11
	li x30, 1			#x30 = 1
	sub x27, x27, x30	#x = x - 1
	jal x1, F			#call F(x-1)	
	ld x27, 0(x2)		#restore caller's x
	ld x1, 8(x2)		#restore caller's return address

	li x29, 2			#x29 = 2
	sub x27, x27, x29	#x = x - 2
	jal x1, F			#call F(x-2)		
	ld x27, 0(x2)		#restore caller's x
	ld x1, 8(x2)		#restore caller's return address	

	addi x2, x2 ,16 	#pop stack	
	jalr x0, 0(x1)		#return

L4: 					#x = 0
	addi x26, x26, 1	#if x = 0, return value to 1
	addi x2, x2, 16		#pop stack
	jalr x0, 0(x1)		#return
	
L5:
	addi x26, x26, 5
	addi x2, x2, 16
	jalr x0, 0(x1)
end:
	
	
	
    
	#end

	li	x15,0
	mv	x10,x15
	ld	x1,24(x2)
	ld	x8,16(x2)
	addi x2,x2,32
	jr	x1
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
