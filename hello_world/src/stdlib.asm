%include "common.h.asm"
%include "stdlib.h.asm"
%include "Windows.h.asm"
	default rel

prints:
	mov	qword [rsp+32], rdi
	mov	qword [rsp+24], r8
	mov	qword [rsp+16], rdx
	mov	qword [rsp+ 8], rcx
	push	rbx
	calcsz	6, 1, 0
	salloc	.RESERVE_SIZE

%define ENTRY   (rsp+.ENTRY_OFFSET)

	xor	r11d, r11d
	mov	qword [rsp+(5*8)], r11
	mov	qword [rsp+(4*8)], r11
	mov	r9, r8
	mov	r8, rdx
	xor	edx, edx
	mov	ecx, CP_UTF8
	call	MultiByteToWideChar
	mov	ebx, eax

	add	eax, eax
	mov	ecx, eax
	call	malloc
	mov	rdi, rax

	mov	dword [rsp+(5*8)], ebx
	mov	qword [rsp+(4*8)], rax
	mov	r9, qword [ENTRY+24]
	mov	r8, qword [ENTRY+16]
	xor	edx, edx
	mov	ecx, CP_UTF8
	call	MultiByteToWideChar

	xor	r9d, r9d
	mov	qword [rsp+(4*8)], r9
	mov	r8d, ebx
	mov	rdx, rdi
	mov	rcx, qword [ENTRY+8]
	call	WriteConsoleW

	mov	rcx, rdi
	sfree	.RESERVE_SIZE
	pop	rbx
	mov	rdi, qword [rsp+32]
	jmp	free
