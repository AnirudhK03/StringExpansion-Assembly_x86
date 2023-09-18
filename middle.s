#Anirudh Kondapaneni
#SUBMITTING THIS FILE AS PART OF MY LAB ASSIGNMENT, I CERTIFY THAT
# ALL OF THE CODE FOUND WITHIN THIS FILE WAS CREATED BY ME WITH NO
# ASSISTANCE FROM ANY PERSON OTHER THAN THE INSTRUCTOR OF THIS COURSE
# OR ONE OF OUR UNDERGRADUATE GRADERS. I WROTE THIS CODE BY HAND,
# IT IS NOT MACHINE GENRATED OR TAKEN FROM MACHINE GENERATED CODE.


.file "middle.s"

.section .rodata

.expanding:
	.string "Expanding %s\n"
.numBytes:
	.string "%i bytes to expand '%s' to '%s'\n\n"

.global middle
	.type middle, @function

.text
	middle:
		#set up stack frame
		pushq %rbp
		movq %rsp, %rbp
		
		#allocate space for the output buffer
		subq $1024, %rsp


		#use r12 to svae the input pointer/we need it to survive the function calls
		pushq %r12
		#use r13 to save the start of the output buffer pinter we need to survive the function calls
		pushq %r13
		
		#set to the start of the 
		leaq -1024(%rbp), %r13

		#move rdi to r12 aka moving pointer to input string to r12 that way it survives function calls
		movq %rdi, %r12
	#-------------print setup------------------
		#print call needs rax to be 0
		xorq %rax, %rax
		#arranging parameters for print call
		#set value of second parameter to the start of input pointer
		movq %rdi, %rsi

		#"Expanding %s"
		movq $.expanding, %rdi

		call printf #call print "Expanding %s"
	#------------ ex_shim setup -----------------
		movq %r13, %rsi #output start pointer set to second parameter
		movq %r12 , %rdi #input start pointer set to first parameter

		call ex_shim #call ex_shim based on parameters set up
	#-----------print setup --------------
		movq $.numBytes, %rdi #1st param (string) "%i bytes to expand '%s' to '%s'..."

		movq %r12, %rdx #3rd param (input) pointer to input string
		movq %r13, %rcx #4th param (output) pointer to output buffer/string
		movq %rax, %rsi #2nd param (total bytes aka int) total bytes of expanded string

		movq %rax, %r12 #put total bytes into callee saved register

		xorq %rax, %rax #print needs 0 in return value

		call printf #call print "%i bytes to expand '%s' to '%s'..."

		movq %r12, %rax #put total bytes of expanded strings into return value

		#restore the values of r12-r13 since these are callee saved registers
		popq %r13
		popq %r12

		#leave stack frame + ret
		leave
		ret

.size middle, .-middle
