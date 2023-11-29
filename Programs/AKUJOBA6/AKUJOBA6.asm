; AKUJOBA6.asm
; Test program for GCD procedure

;; Name: John Akujobi
;; Class: CSC 314
;; Assign: Assignment 6
;; Due: Nov 29, 2023

;; Description: This program tests the GCD procedure. It prompts the user to enter two numbers

include pcmac.inc               ; Include pcmac.inc file
.model small                    ; Set memory model to small
.586                            ; Target the Intel 586 processor
.stack 100h                     ; Set stack size to 256 bytes (100h in hexadecimal)

.data
    firstNum dw ?               ; First number for GCD calculation
    secondNum dw ?              ; Second number for GCD calculation
    continueFlag db ?           ; Flag to continue or stop the program
    prompt1 db "Enter first number: $"
    prompt2 db "Enter second number: $"
    promptContinue db "Do you want to continue? (Y/N): $"
    resultMsg db "The GCD is: $"

.code
extrn JCAGCD:near             ; External reference to JCAGCD procedure
extrn GetDec:near
extrn PutDec:near

; Main program
main proc
    mov ax, @data               ; Initialize data segment
    mov ds, ax

    ; Main loop
mainLoop:
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
    _PutStr resultMsg
    call PutDec               ; Display GCD result
    _PutCh 10                 ; New line
    _PutCh 13                 ; Carriage return

    ; Prompt to continue
    _PutStr promptContinue
    _GetCh
    cmp al, 'N'
    je exitLoop

    jmp mainLoop              ; Repeat main loop

exitLoop:
    _exit 0                   ; Exit program
main endp

end main