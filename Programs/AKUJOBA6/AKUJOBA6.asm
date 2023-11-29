; AKUJOBA6.asm
; Test program for GCD procedure

;; Name: John Akujobi
;; Class: CSC 314
;; Assign: Assignment 6
;; Due: Nov 29, 2023

;; Description: This program tests the GCD procedure. It prompts the user to enter two numbers

include pcmac.inc               ; Include pcmac.inc file
include jcagcd.obj              ;Include jcagcd.asm file
.model small                    ; Set memory model to small
.586                            ; Target the Intel 586 processor
.stack 100h                     ; Set stack size to 256 bytes (100h in hexadecimal)

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
extrn JCAGCD:near             ; External reference to JCAGCD procedure
extrn GetDec:near
extrn PutDec:near


JCAGCD PROC
    ;PUSH AX
    ;PUSH BX
    ;PUSH CX
    PUSH DX
    PUSH SI
    PUSH DI
    PUSH BP

    ; Check for zero cases
    cmp ax, 0
    je zeroCase
    cmp bx, 0
    je zeroCase

    ; Convert negative numbers to positive
    cmp ax, 0
    jg skipNegAX
    neg ax
skipNegAX:
    cmp ax, 0
    jg skipNegBX
    neg bx
skipNegBX:

; GCD calculation loop
gcdLoop:
    ; Performing the Euclidean algorithm
    ;i learned this from stackoverflow
    xor dx, dx      ; Clear dx for division
    div bx          ; Divide ax by bx, quotient in ax, remainder in dx
    mov ax, bx      ; Move the divisor to the dividend's place
    mov bx, dx      ; Move the remainder to the divisor's place

    cmp bx, 0       ; Check if the remainder is 0
    jne gcdLoop    ; If not, repeat the loop
    je endGCD      ; If so, end the loop

zeroCase:
    ; Handle zero cases
    mov ax, 0
    jmp endGCD

endGCD:
    ; Return
    POP BP
    POP DI
    POP SI
    POP DX
    ;POP CX
    ;POP BX
    ;POP AX

    ret
    ;the GCD is stored in ax

JCAGCD ENDP



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