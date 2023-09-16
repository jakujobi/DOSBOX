; Name: John Akujobi
; Class: CSC 314
; Assign: Assignment 2
; Due: 20th September 2023
;
; Description: This program is a console application written in Assembly language that displays two messages on the console:
;               'Hello, my name is John Akujobi' and 'The show I binge watched last summer was...The Last of Us'.

; Notes by John Akujobi on the 15th of September 2023:
;      I added some comments following the concepts learned from the last 2 classes
;      And from what i learned online in stack overflow and Github

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