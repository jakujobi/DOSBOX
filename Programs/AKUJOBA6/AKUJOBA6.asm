; AKUJOBA6.asm
; Test program for GCD procedure

;; Name: John Akujobi
;; Class: CSC 314
;; Assign: Assignment 6
;; Due: Nov 29, 2023

;; Description: This program tests the GCD procedure. It prompts the user to enter two numbers

include pcmac.inc               ; Include pcmac.inc file
;include JCAGCD.asm
.model small                    ; Set memory model to small
.586                            ; Target the Intel 586 processor
.stack 100h                     ; Set stack size to 256 bytes (100h in hexadecimal)
EXTRN JCAGCD:NEAR
.data
    firstNum dw ?               ; First number for GCD calculation
    secondNum dw ?              ; Second number for GCD calculation
    continueFlag db ?           ; Flag to continue or stop the program

    prompt1 db          13, 10, "Enter first number: ", '$'
    prompt2 db          13, 10, "Enter second number: ", '$'
    promptContinue db   13, 10, "Do you want to continue? (Y/N): ", '$'
    resultMsg db        13, 10, "The GCD is: ", '$'

    errorMSGCont db     13, 10, "Whoops!Invalid input. ", 13, 10, "Please type Y or N.", '$'

.code
;PUBLIC JCAGCD            ; External reference to JCAGCD procedure
extrn GetDec:near
extrn PutDec:near

; Main program
JAKUJ proc
    _Begin
    ;mov ax, @data               ; Initialize data segment
    ;mov ds, ax

    ; Main loop
mainLoop:
    xor ax, ax
    xor bx, bx
    xor cx, cx
    xor dx, dx

    _PutStr prompt1            ; Prompt for first number
    call GetDec                ; Read first number
    mov firstNum, ax           ; Store first number

    _PutStr prompt2            ; Prompt for second number
    call GetDec                ; Read second number
    mov secondNum, ax          ; Store second number

    ; Call GCD procedure
    mov ax, firstNum
    mov bx, secondNum

    call JCAGCD                ; Call GCD procedure

    ; Display result

    mov cx, ax                 ; Move GCD to cx to avoid it being posibly changed by _PutStr
    _PutStr resultMsg

    mov ax, cx
    mov bx, cx

    call PutDec               ; Display GCD result
    _PutCh 10                 ; New line
    _PutCh 13                 ; Carriage return

AskContinue:
    ; Prompt to continue
    _PutStr promptContinue
    _GetCh
    cmp al, 'N'
    je exitLoop
    cmp al, 'n'
    je exitLoop
    cmp al, 'Y'
    je mainLoop
    cmp al, 'y'
    je mainLoop

    _PutStr errorMSGCont
    jmp AskContinue

exitLoop:
    _exit 0                   ; Exit program
JAKUJ endp

END JAKUJ