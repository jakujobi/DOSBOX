;; FIRST.ASM--Our first Assembly Language Program.  This program 
;;   displays the line 'Hello, my name is Bill Jones' on the CRT screen.
;;
;;  Program text from "Assembly Language for the IBM PC Family" by
;;   William B. Jones, (c) Copyright 1992, 1997, 2001, Scott/Jones Inc.
;;
        .MODEL  SMALL
        .586

        .STACK  100h

        .DATA
include pcmac.inc
        .CODE


Delay	PROC
		push ecx ; save caller's CX
		mov cx,0; loop 65K times
for_2:	nop
		dec cx
		jnz for_2
		pop ecx ;restore caller's CX
		ret
Delay	ENDP

Hello   PROC
		_Begin	
		
        mov cx,79
for_1:	mov dl,'!'
		_PutCh
		call delay
		_PutCh 8
		_PutCh 32
		dec cx
		jnz for_1
		
		_Exit 0
Hello   ENDP

        END Hello ; Tells where to start execution
