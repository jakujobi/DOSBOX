;; FIRST.ASM--Our first Assembly Language Program. This program 
;; displays the line 'Hello, my name is Bill Jones' on the CRT screen.
;;
;; Program text from "Assembly Language for the IBM PC Family" by
;; William B. Jones, (c) Copyright 1992, 1997, 2001, Scott/Jones Inc.
;;

;; I added some comments following the concepts learned from the last 2 classes
;; And from what i learned online in stack overflow and Github
 .MODEL SMALL  ; Set memory model to small
.586  ; Target the Intel 586 processor
.STACK 100h  ; Set stack size to 256 bytes (100h in hexadecimal)

.DATA  ; Start of data segment
Message DB 'Hello, my name is John Akujobi', 13, 10, 'The show I binge watched last summer was...The Last of Us', 13, 10, '$'  ; Declare a string with two messages

.CODE  ; Start of code segment

Hello PROC  ; Start of procedure named 'Hello'
 mov ax, @data  ; Load address of data segment into AX register
 mov ds, ax  ; Move contents of AX register to DS register
 mov dx, OFFSET Message  ; Load offset of 'Message' string into DX register
 mov ah, 9h  ; Set AH register to 9 (function code for 'display string' in DOS)
 int 21h  ; Call DOS with function specified in AH register (display string)
 mov al, 0  ; Set return code to 0
 mov ah, 4ch  ; Set AH register to 4C (function code for 'exit' in DOS)
 int 21h  ; Call DOS with function specified in AH register (exit program)
Hello ENDP  ; End of 'Hello' procedure

END Hello  ; Tell assembler to start execution at 'Hello' procedure