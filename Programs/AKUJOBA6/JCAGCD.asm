; JCAGCD.asm
; GCD procedure for calculating the greatest common divisor
include pcmac.inc               ; Include pcmac.inc file
.model small
.586
.stack 100h

.code
; Procedure to calculate GCD of two numbers in AX and BX
; Returns GCD in AX
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