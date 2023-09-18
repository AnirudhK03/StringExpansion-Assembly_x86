#Anirudh Kondapaneni
#SUBMITTING THIS FILE AS PART OF MY LAB ASSIGNMENT, I CERTIFY THAT
# ALL OF THE CODE FOUND WITHIN THIS FILE WAS CREATED BY ME WITH NO
# ASSISTANCE FROM ANY PERSON OTHER THAN THE INSTRUCTOR OF THIS COURSE
# OR ONE OF OUR UNDERGRADUATE GRADERS. I WROTE THIS CODE BY HAND,
# IT IS NOT MACHINE GENRATED OR TAKEN FROM MACHINE GENERATED CODE.



.file "search.s"

.section .rodata

.finalout:
	.string "Search: The longest conversion is %i.\n"

.global search
	.type search, @function

.text
	search:
		#set up stack frame
		pushq %rbp
		movq %rsp, %rbp

		#r12 is used to store the value of the const array pointer
		pushq %r12

		#r13 is used as a intermediate register so we dont go to memory twice
		pushq %r13

		#r14 will hold the longest string pointer
		pushq %r14

		#r15 will hold the largest count
		pushq %r15

		#count has to survive function calls so save it in designated calle saved register
		movq %rsi, %r13

		#the original char *string[] needs to survive so we save that
		movq %rdi, %r12

		#the largest count should be set to 0
		xorq %r15, %r15

	loop:
	#------------- loop start ------------------- 

		#get the string pointer from array
		movq (%r12), %rdi

		#use register as intermidiate so we dont do second memory touch later
		movq %rdi, %r13

		#check if the pointer we at is null
		cmp $0, %rdi

		#if it is then we jump to end cuz we at the end of array
		je end
	
		#clearing rax
		xorq %rax, %rax

		#call m_shim since the desired pointer is in location
		call m_shim

		#compare wether the return value (current count) is greater than longest count fr fr
		cmpq %r15, %rax

		#if it is, update longest count
		cmovaq %rax, %r15

		#if it is, update longest string pointer aka the current pointer becomes longest
		cmovaq %r13, %r14

		#increase our array pointer to point to the next 'element'
		addq $8, %r12
		
		#we jump back up to the beginning of loop
		jmp loop


	end:
		#time to do some printing / this is set-up for print
		movq $.finalout, %rdi # "Search: The longest conversion is %i"
		movq %r15, %rsi # this is the integer/ largest byte count of expanded strings

		call print #call print

		movq %r14, %rax # make the pointer to longest string the return value 

		#restore values of r12-r15 since they are callee saved registers
		popq %r15
		popq %r14
		popq %r13
		popq %r12

		#leave stack frame
		leave 
		ret




