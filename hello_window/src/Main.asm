%include "Common.h.asm"
%include "Windows.h.asm"

	default	rel

	section	.text
	global	wWinMain
wWinMain:
%define MAX_ARG_COUNT 12
%define MAX_ARG_SIZE  (MAX_ARG_COUNT * 8)
%define LOCALS_SIZE   (8 + MSG_size + WNDCLASSEXW_size)
%define STACK_SIZE    ROUND_UP(MAX_ARG_SIZE + LOCALS_SIZE, 16)

%define hInstance     (rsp+STACK_SIZE+ 8)
%define hPrevInstance (rsp+STACK_SIZE+16)
%define pCmdLine      (rsp+STACK_SIZE+24)
%define nShowCmd      (rsp+STACK_SIZE+32)

%define Locals        (rsp+MAX_ARG_SIZE)
%define hWnd          (Locals+0)
%define msg           (hWnd+8)
%define wndClass      (msg+MSG_size)

	mov	[rsp+32], r9d
	mov	[rsp+24], r8
	mov	[rsp+16], rdx
	mov	[rsp+ 8], rcx
	push	rbx
	sub	rsp, STACK_SIZE
	mov	rbx, rcx

	mov	r8d, WNDCLASSEXW_size
	xor	edx, edx
	lea	rcx, [wndClass]
	call	memset
	mov	r8d, WNDCLASSEXW_size
	lea	rax, [WindowProc]
	lea	rcx, [WndClassName]
	mov	qword [wndClass+WNDCLASSEXW.cbSize], r8
	mov	qword [wndClass+WNDCLASSEXW.hInstance], rbx
	mov	qword [wndClass+WNDCLASSEXW.lpfnWndProc], rax
	mov	qword [wndClass+WNDCLASSEXW.lpszClassName], rcx

	lea	rcx, [wndClass]
	call	RegisterClassExW
	test	eax, eax
	jz	.Exit

	xor	eax, eax
	mov	qword [rsp+(11*8)], rax
	mov	qword [rsp+(10*8)], rbx
	mov	qword [rsp+( 9*8)], rax
	mov	qword [rsp+( 8*8)], rax
	mov	dword [rsp+( 7*8)], CW_USEDEFAULT
	mov	dword [rsp+( 6*8)], CW_USEDEFAULT
	mov	dword [rsp+( 5*8)], CW_USEDEFAULT
	mov	dword [rsp+( 4*8)], CW_USEDEFAULT
	mov	r9d, WS_OVERLAPPEDWINDOW
	lea	r8, [WindowName]
	lea	rdx, [WndClassName]
	mov	ecx, WS_EX_APPWINDOW
	call	CreateWindowExW
	test	rax, rax
	jz	.CleanupWndClass
	mov	qword [hWnd], rax

	mov	edx, SW_SHOWNORMAL
	mov	rcx, rax
	call	ShowWindow

	mov	rcx, qword [hWnd]
	call	UpdateWindow
.MsgLoop:
	xor	r9d, r9d
	xor	r8d, r8d
	xor	edx, edx
	lea	rcx, [msg]
	call	GetMessageW
	test	eax, eax
	jz	.CleanupWndClass

	lea	rcx, [msg]
	call	TranslateMessage

	lea	rcx, [msg]
	call	DispatchMessageW

	jmp	.MsgLoop
.CleanupWndClass:
	mov	rdx, rbx
	lea	rcx, [WndClassName]
	call	UnregisterClassW
.Exit:
	xor	eax, eax
	add	rsp, STACK_SIZE
	pop	rbx
	ret


WindowProc:
%define MAX_ARG_COUNT 4
%define MAX_ARG_SIZE  (MAX_ARG_COUNT * 8)
%define STACK_SIZE    (8 + MAX_ARG_SIZE)
	sub	rsp, STACK_SIZE
	cmp	edx, WM_DESTROY
	je	.HandleDestroy
	add	rsp, STACK_SIZE
	jmp	DefWindowProcW
.HandleDestroy:
	xor	ecx, ecx
	call	PostQuitMessage
	xor	eax, eax
	add	rsp, STACK_SIZE
	ret


	section .rdata
WndClassName:
	db	__?utf16?__(`NASMWndClass\0`)


WindowName:
	db	__?utf16?__(`NASM Window\0`)
