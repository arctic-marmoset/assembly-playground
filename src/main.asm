%include "common.h.asm"
%include "stdlib.h.asm"
%include "Windows.h.asm"
	default	rel

	section	.text
	global	main
main:
	calcsz	3, 0, 0
	salloc	.RESERVE_SIZE

	mov	ecx, STD_OUTPUT_HANDLE
	call	GetStdHandle
	cmp	rax, INVALID_HANDLE_VALUE
	je	.exit

	mov	r8d, (greeting.len - 1)
	lea	rdx, [greeting]
	mov	rcx, rax
	call	prints

.exit:
	xor	eax, eax
	sfree	.RESERVE_SIZE
	ret


	section .rdata
greeting:
	db	`Hello, world!\n\0`
.len:	equ	$ - greeting
