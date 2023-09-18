#Anirudh Kondapaneni
#SUBMITTING THIS FILE AS PART OF MY LAB ASSIGNMENT, I CERTIFY THAT
# ALL OF THE CODE FOUND WITHIN THIS FILE WAS CREATED BY ME WITH NO
# ASSISTANCE FROM ANY PERSON OTHER THAN THE INSTRUCTOR OF THIS COURSE
# OR ONE OF OUR UNDERGRADUATE GRADERS. I WROTE THIS CODE BY HAND,
# IT IS NOT MACHINE GENRATED OR TAKEN FROM MACHINE GENERATED CODE.




.file "expand.s"

.section .rodata

.Plus:
	.string "plus"
.Sub:
	.string "minus"
.Mult:
	.string "times"
.Equal:
	.string "equals"
.DivideP1:
	.string "divided"
.DivideP2:
	.string " by"

# .section .data
	#ops: ["plus", "minus", "times", "divided by", "equals"]

.global expand
	.type expand, @function

.text
	expand:

		#each char = 1 byte (b)

		pushq %rbp #set-up stack frame
		movq %rsp, %rbp #set-up stack frame

		#rax used as index pointer for outptu buffer + counter of bytes set to 0
		xorq %rax, %rax

		#rdi = pointer to input string
		#rsi = pointer to output buffer

	copyLoop:
		#find/get the first character in input string
		movb (%rdi), %r8b

		#lets do some checking

		#check if the char is '+' and jump to that section
		cmpb $0x2B, %r8b
		je add # jump to the code that does expanding for '+' (like the if-else)

		#check if the char is '-' and jump to that section
		cmpb $0x2D, %r8b
		je sub # jump to the code that does expanding for '-' (like the if-else)

		#check if the char is '*' and jump to that section
		cmpb $0x2A, %r8b 
		je mult # jump to the code that does expanding for '*' (like the if-else)

		#check ifthe char is '/' and jump to that ection
		cmpb $0x2F, %r8b
		je div # jump to the code that does expanding for '/' (like the if-else)

		#check if the char is '=' and jump to that section
		cmpb $0x3D, %r8b
		je equal # jump to the code that does expanding for '=' (like the if-else)

		#write the character to the output buffer or it would pointer to first byte[index] then write to that place
		movb %r8b, (%rsi, %rax, 1)

		#now go to next character
		
		#incremnt rdi aka forces the pointer to go to next char in the input
		incq %rdi
		#increment rax so now that where the next place to write to is one past what we just wrote to in the output buffer
		incq %rax
		
		#check if current character in input striing is 0 (NULL)
		cmpb $0, %r8b
		#if it ain't, then we jump back to start of loop
		jnz copyLoop

		#exit stack + return
		leave
		ret

	add:
		movq .Plus, %r8 # "plus" to r8
		movq %r8, (%rsi, %rax,) # write 'plus' to the output buffer
		incq %rdi #increment rdi by one so it is at next charcter to look at
		addq $4, %rax #add 4 to our 'index' value for output string, not 5 because that would mean the null char gets included (this same thing applies to the rest of the cases)
		jmp copyLoop #jump to start of copy loop since we are done with special case
	sub:
                movq .Sub, %r8 # "minus" to r8
                movq %r8, (%rsi, %rax,) # write 'minus' to output buffer
                incq %rdi # increment rdi by one so it points to next char in input string
                addq $5, %rax # add 5 to 'index' of output string 
                jmp copyLoop # restart back with string copy

	mult:
                movq .Mult, %r8 # "times" to r8
                movq %r8, (%rsi, %rax,) # write 'times' to output buffer
                incq %rdi # increment rdi by one so it points to next char in input string
                addq $5, %rax # add 5 to 'index' of output string 
                jmp copyLoop # restart back with string copy

	div:
		#notice that this has to be seprated into two different parts since 'divided by' is more than 8 bytes long, thus we have to seprate so we can grab the correct amount
                movq .DivideP1, %r8 # "divided" to r8
                movq %r8, (%rsi, %rax,) # write 'divided' to output buffer
                incq %rdi  # increment rdi by one so it points to next char in input string
                addq $7, %rax  # add 7 to 'index' of output string
		
		movq .DivideP2, %r8 # " by" to r8
		movq %r8, (%rsi, %rax,) # increment rdi by one so it points to next char in input string
		addq $3, %rax # add 3 (since " " (space) is a char too) to 'index' of output string
                jmp copyLoop # restart back with string copy

	equal:
                movq .Equal, %r8 # "equals" to r8
                movq %r8, (%rsi, %rax,) # write 'equals' to output buffer
                incq %rdi # increment rdi by one so it points to next char in input string
                addq $6, %rax # add 6 to 'index' of output string 
                jmp copyLoop # restart back with string copy
		

.size expand, .-expand


