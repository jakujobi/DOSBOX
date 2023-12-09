; AKUJOBA6.asm
; Test program for GCD procedure

;; Name: John Akujobi
;; Class: CSC 314
;; Assign: Assignment 6
;; Due: Nov 29, 2023

;; Description: This program tests the JCAGCD procedure. It prompts the user to enter two numbers

include pcmac.inc               ; Include the pcmac.inc file for macro definitions and utilities
;include JCAGCD.asm              ; Previously used for direct inclusion, now replaced by external declaration
.model small                    ; Define the memory model as 'small' (suitable for most DOS programs)
.586                            ; Target the Intel 586 processor for instruction set compatibility
.stack 100h                     ; Allocate 256 bytes (100h in hexadecimal) for the stack

EXTRN JCAGCD:NEAR               ; Declare JCAGCD as an external procedure that will be linked

.data                           ; Start of the data segment
    firstNum dw ?               ; Reserve a word for the first number for GCD calculation
    secondNum dw ?              ; Reserve a word for the second number for GCD calculation
    continueFlag db ?           ; Reserve a byte for the flag to continue or stop the program

    prompt1 db 13, 10, "Enter first number: ", '$'  ; Define a string for prompting the first number input
    prompt2 db 13, 10, "Enter second number: ", '$' ; Define a string for prompting the second number input
    promptContinue db 13, 10, "Do you want to continue? (Y/N): ", '$' ; Prompt for continuing the program
    resultMsg db 13, 10, "The GCD is: ", '$'        ; Message to display before showing the GCD result

    errorMSGCont db 13, 10, "Whoops!Invalid input. ", 13, 10, "Please type Y or N.", '$' ; Error message for invalid input

.code                           ; Start of the code segment
;PUBLIC JCAGCD                   ; Commented out: JCAGCD is no longer part of this file
extrn GetDec:near               ; External declaration of the GetDec procedure (for input)
extrn PutDec:near               ; External declaration of the PutDec procedure (for output)

; Main program entry point
JAKUJ proc
    _Begin
    ;mov ax, @data               ; (Commented out) Initialize data segment
    ;mov ds, ax

    ; Main loop for program execution
mainLoop:
    xor ax, ax                  ; Clear AX register
    xor bx, bx                  ; Clear BX register
    xor cx, cx                  ; Clear CX register
    xor dx, dx                  ; Clear DX register

    _PutStr prompt1             ; Display prompt for first number
    call GetDec                 ; Call GetDec to read the first number
    mov firstNum, ax            ; Store the first number in firstNum

    _PutStr prompt2             ; Display prompt for second number
    call GetDec                 ; Call GetDec to read the second number
    mov secondNum, ax           ; Store the second number in secondNum

    ; Prepare and call the GCD procedure
    mov ax, firstNum            ; Move first number into AX for JCAGCD
    mov bx, secondNum           ; Move second number into BX for JCAGCD
    call JCAGCD                 ; Call the external GCD procedure

    ; Display the result
    mov cx, ax                  ; Move GCD result to CX to preserve it
    _PutStr resultMsg           ; Display result message
    mov ax, cx                  ; Move GCD result back to AX for PutDec
    mov bx, cx                  ; Redundant move to BX, could be used for future modifications
    call PutDec                 ; Call PutDec to display the GCD result
    _PutCh 10                   ; Print new line
    _PutCh 13                   ; Print carriage return

    ; Loop to ask user if they want to continue or exit
AskContinue:
    _PutStr promptContinue      ; Prompt user to continue or exit
    _GetCh                      ; Get a single character input
    cmp al, 'N'                 ; Compare input with 'N'
    je exitLoop                 ; Jump to exit if input is 'N'
    cmp al, 'n'                 ; Compare input with 'n'
    je exitLoop                 ; Jump to exit if input is 'n'
    cmp al, 'Y'                 ; Compare input with 'Y'
    je mainLoop                 ; Jump to main loop if input is 'Y'
    cmp al, 'y'                 ; Compare input with 'y'
    je mainLoop                 ; Jump to main loop if input is 'y'

    _PutStr errorMSGCont        ; Display error message for invalid input
    jmp AskContinue             ; Jump back to ask continue prompt

exitLoop:
    _exit 0                     ; Exit program with status 0
JAKUJ endp                      ; End of main procedure

END JAKUJ                       ; End of program


; ===============================================================
; Project Documentation: Running AKUJOBA6 with JCAGCD Procedure
; ===============================================================
;
; This project consists of two separate assembly files:
;   1. JCAGCD.asm - Contains the GCD procedure.
;   2. AKUJOBA6.asm - Main program that uses the GCD procedure.
;
; The following steps outline how to compile, link, and run the project:
;
; Step 1: Assemble JCAGCD.asm
; - Open a command line or terminal in the directory containing the files.
; - Use the following command to assemble JCAGCD.asm into an object file:
;     masm JCAGCD.asm;
; - This command will generate JCAGCD.obj.
;
; Step 2: Assemble AKUJOBA6.asm
; - Make sure that AKUJOBA6.asm contains the line 'EXTRN JCAGCD:NEAR'.
; - Assemble AKUJOBA6.asm into an object file using the command:
;     masm AKUJOBA6.asm;
; - This will produce AKUJOBA6.obj.
;
; Step 3: Link the Object Files
; - Link the two object files to create the executable:
;     link AKUJOBA6.obj JCAGCD.obj,,,util;
; - This will create the executable file (AKUJOBA6.exe).
;
; Step 4: Run the Program
; - Finally, run the executable in your command line or emulator:
;     AKUJOBA6.exe
;
; Note: Ensure both assembly files are in the same directory and 
; that all commands are executed in this directory.
; Also ensure the PCMAC.INC and UTIL.LIB files are in the same directory.
;
; ===============================================================
; End of Documentation
; ===============================================================