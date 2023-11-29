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
        cmp ax, bx
        je endGCD
        jg greaterAX

        ; If BX > AX
        sub bx, ax
        jmp gcdLoop

    greaterAX:
        ; If AX > BX
        sub ax, bx
        jmp gcdLoop

    zeroCase:
        ; Handle zero cases
        mov ax, 0
        jmp endGCD

    endGCD:
        ret
JCAGCD ENDP

END JCAGCD