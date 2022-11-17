%ifndef WINDOWS_H_ASM
%define WINDOWS_H_ASM

%define CP_UTF8              65001

%define STD_INPUT_HANDLE     (-10)
%define STD_OUTPUT_HANDLE    (-11)
%define STD_ERROR_HANDLE     (-12)

%define INVALID_HANDLE_VALUE (-1)

%define CW_USEDEFAULT        80000000H

%define WS_EX_APPWINDOW      00040000H

%define WS_OVERLAPPED        00000000H
%define WS_CAPTION           00C00000H
%define WS_MAXIMIZEBOX       00010000H
%define WS_MINIMIZEBOX       00020000H
%define WS_SYSMENU           00080000H
%define WS_THICKFRAME        00040000H
%define WS_OVERLAPPEDWINDOW  (WS_OVERLAPPED | WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX)

%define SW_SHOWNORMAL       1

%define WM_DESTROY          2

	extern	__chkstk

	extern	memset

	extern	GetStdHandle
	extern	GetLastError
	extern	MultiByteToWideChar

	extern	WriteConsoleW

	extern	RegisterClassExW
	extern	UnregisterClassW
	extern	CreateWindowExW
	extern	ShowWindow
	extern	UpdateWindow
	extern	GetMessageW
	extern	TranslateMessage
	extern	DispatchMessageW
	extern	DefWindowProcW
	extern	PostQuitMessage

	struc	WNDCLASSEXW
	.cbSize:	resd	1
	.style:		resd	1
	.lpfnWndProc:	resq	1
	.cbClsExtra:	resd	1
	.cbWndExtra:	resd	1
	.hInstance:	resq	1
	.hIcon:		resq	1
	.hCursor:	resq	1
	.hbrBackground:	resq	1
	.lpszMenuName:	resq	1
	.lpszClassName:	resq	1
	.hIconSm:	resq	1
	endstruc

%if WNDCLASSEXW_size != 50H
%error "sizeof(WNDCLASSEXW) != 50H!"
%endif

	struc POINT
	.x:		resd	1
	.y:		resd	1
	endstruc

%if POINT_size != 8
%error "sizeof(POINT) != 8!"
%endif

	struc	MSG
	.hwnd:		resq	1
	.message:	resd	1
	.padding0:	resb	4
	.wParam:	resq	1
	.lParam:	resq	1
	.time:		resd	1
	.pt:		resb	POINT_size
	.padding1:	resb	4
	endstruc

%if MSG_size != 30H
%error "sizeof(MSG) != 30H!"
%endif

%endif
