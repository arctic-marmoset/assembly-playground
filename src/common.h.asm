%ifndef COMMON_H_ASM
%define COMMON_H_ASM

%define ROUND_UP(num, mult) ((((num) + ((mult) - 1)) / (mult)) * (mult))

; Calculates the size of memory that should be reserved on the stack in order to satisfy alignment requirements.
; arg1 The maximum number of arguments that are passed to any functions called in the routine. Set to 0 if no functions
;      are called.
; arg2 The number of registers that will be pushed onto the stack during the prologue.
; arg3 The total size of all local variables used in the routine.
%macro calcsz 3
%if 0 < %1 && %1 < 4
.MAX_ARG_COUNT	equ	4
%else
.MAX_ARG_COUNT	equ	%1
%endif
.MAX_ARG_SIZE	equ	.MAX_ARG_COUNT * 8
.SAVED_SIZE	equ	%2 * 8
.STACK_SIZE	equ	.MAX_ARG_SIZE + %3
%if 0 < .MAX_ARG_COUNT  && (.STACK_SIZE + .SAVED_SIZE) % 16 != 8
.ALIGN_SIZE	equ	8
%else
.ALIGN_SIZE	equ	0
%endif
.RESERVE_SIZE	equ	.STACK_SIZE + .ALIGN_SIZE
.ENTRY_OFFSET	equ	.RESERVE_SIZE + .SAVED_SIZE
%endmacro

; Conditionally allocates space on the stack.
; arg1 The size of memory to allocate.
%macro salloc 1
%if %1 > 0
	sub	rsp, %1
%endif
%endmacro

; Conditionally deallocates space on the stack.
; arg1 The size of memory to deallocate. This should match the size passed to salloc.
%macro sfree 1
%if %1 > 0
	add	rsp, %1
%endif
%endmacro

%endif
