	.option nopic
	.text
	.align	3
.LC0:
	.string "%llu "
	.text
	.align 1
	.globl	main
	.type	main, @function
.LC1:
	.string "%llu"
	.align 3
.LC2:
	.string "%llu "
	.align 3
.LC3:
	.string "\n%llu\n"
	.align 3
main:
	addi x2,x2,-32
	sd	x1,24(x2)
	sd	x8,16(x2)
	addi x8,x2,32

#########begin################

	addi x2, x2, -128
	
    	add x11, x8, zero
    	lui x15,%hi(.LC1)
    	addi x10,x15,%lo(.LC1)
    	call scanf
	
	ld x29, 0(x8)		
	sd x29, 120(x2)	#key
		
	li x9, 0	
	li x18, 1
	li x19, 2
	li x20, 3
	li x21, 4
	li x22, 5
	li x23, 6
	li x24, 7
	li x25, 8
	li x26, 9
	
	#addi x2, x2, -120
Input:	
    	add x11, x8, zero
    	lui x15,%hi(.LC1)
    	addi x10,x15,%lo(.LC1)
    	call scanf

	beq x9, x0, Array0
	beq x9, x18, Array1
	beq x9, x19, Array2
	beq x9, x20, Array3
	beq x9, x21, Array4
	beq x9, x22, Array5
	beq x9, x23, Array6
	beq x9, x24, Array7
	beq x9, x25, Array8
	beq x9, x26, Array9	

Array0:	
	ld x29, 0(x8)		
	sd x29, 0(x2)
	addi x9, x9, 1
	jal x0, Input
Array1:	
	ld x29, 0(x8)
	sd x29, 8(x2)
	addi x9, x9, 1
	jal x0, Input

Array2:	ld x29, 0(x8)
	sd x29, 16(x2)
	addi x9, x9, 1
	jal x0, Input

Array3:	
	ld x29, 0(x8)		
	sd x29, 24(x2)
	addi x9, x9, 1
	jal x0, Input
Array4:	
	ld x29, 0(x8)
	sd x29, 32(x2)
	addi x9, x9, 1
	jal x0, Input

Array5:	ld x29, 0(x8)
	sd x29, 40(x2)
	addi x9, x9, 1
	jal x0, Input

Array6:	
	ld x29, 0(x8)		
	sd x29, 48(x2)
	addi x9, x9, 1
	jal x0, Input
Array7:	
	ld x29, 0(x8)
	sd x29, 56(x2)
	addi x9, x9, 1
	jal x0, Input

Array8:	ld x29, 0(x8)
	sd x29, 64(x2)
	addi x9, x9, 1
	jal x0, Input

Array9:	
	ld x29, 0(x8)		
	sd x29, 72(x2)	

##########################

	li x1, 0
	li x22, 0
	li x21, 0
	li x20, 0
	li x19, 0

sort:    
    sd   x1, 112(x2)
    sd   x22, 104(x2)
    sd   x21, 96(x2)
    sd   x20, 88(x2)	#j
    sd   x19, 80(x2)	#i

    li x18, 11	
    mv x21, x2 
    mv x22, x18
    li	x19, 0		# i = 0

for1:
    bge	 x19, x22, exit1
    #inner loop
    addi x20, x19, -1 	#j = i - 1

for2:
    blt  x20, x0, exit2
    slli x5, x20, 3
    add  x5, x21, x5
    ld   x6, 0(x5)
    ld   x7, 8(x5)
    blt  x6, x7, exit2
    mv   x2, x21
    mv   x18, x20
    jal  x1, swap
    addi x20, x20, -1
    j    for2

exit2:
    addi x19, x19, 1
    j	 for1

swap:
    slli x6, x18, 3
    add  x6, x2, x6
    ld   x5, 0(x6)
    ld   x7, 8(x6)
    sd   x7, 0(x6)
    sd   x5, 8(x6)
    jalr x0, 0(x1)

exit1:
    ld   x19, 80(x2)
    ld   x20, 88(x2)
    ld   x21, 96(x2)
    ld   x22, 104(x2)
    ld   x1, 112(x2)

##########################

	li x19, 0
 	li x27, 10    	
Print:	
	#bge x19, x27, Search	
	slli x5, x19, 3 	
	add x5, x2, x5
	ld x29, 8(x5)
    	add x11, x29, 0 #將你要輸出的值存入x11
    	lui x15,%hi(.LC0)    
    	addi x10,x15,%lo(.LC0)
    	call printf
	addi x19, x19, 1
	blt x19, x27, Print

	li x23, 0
	li x24, 0
	li x25, 11
	
Search:	
	ld x26, 120(x2)				
	slli x5, x24, 3 	
	add x5, x2, x5
	ld x27, 0(x5)
	beq x26, x27, done	
	addi x23, x23, 1
	addi x24, x24, 1	
	blt x24, x25, Search
	
		
finish:	li x25, 0
	add x11, x25, 0 
    	lui x15,%hi(.LC3)    
    	addi x10,x15,%lo(.LC3)
    	call printf	
	j exit


done:	add x11, x23, 0
    	lui x15,%hi(.LC3)    
    	addi x10,x15,%lo(.LC3)
    	call printf


exit: addi x2, x2, 128

#########end####################

	li	x15,0
	mv	x10,x15
	ld	x1,24(x2)
	ld	x8,16(x2)
	addi x2,x2,32
	jr	x1
	.size	main, .-main
	.ident	"GCC: (GNU) 7.2.0"
