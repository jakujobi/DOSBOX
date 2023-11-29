; JCAGCD.asm
; GCD procedure for calculating the greatest common divisor
.model small                    ; Set memory model to small
.586                            ; Target the Intel 586 processor
.stack 100h                     ; Allocate 256 bytes for the stack
PUBLIC JCAGCD                   ; Declare JCAGCD as a public procedure for external access

.code                           ; Start of the code segment

; Procedure to calculate GCD of two numbers in AX and BX
; Returns GCD in AX
JCAGCD PROC
    ; Save registers on the stack
    ;PUSH AX                    ; Commented out as AX will be used for return value
    ;PUSH BX                    ; Commented out as BX is an input register
    ;PUSH CX                    ; CX not used, so push is commented out
    PUSH DX                    ; Save DX as it will be modified
    PUSH SI                    ; Save SI register
    PUSH DI                    ; Save DI register
    PUSH BP                    ; Save BP register

    ; Check if either input is zero
    cmp ax, 0                  ; Compare AX with zero
    je zeroCase                ; Jump to zeroCase if AX is zero
    cmp bx, 0                  ; Compare BX with zero
    je zeroCase                ; Jump to zeroCase if BX is zero

    ; Convert negative numbers to positive
    cmp ax, 0                  ; Check if AX is negative
    jg skipNegAX               ; Jump if AX is positive
    neg ax                     ; Negate AX if negative
skipNegAX:
    cmp bx, 0                  ; Check if BX is negative
    jg skipNegBX               ; Jump if BX is positive
    neg bx                     ; Negate BX if negative
skipNegBX:

    ; GCD calculation loop using the Euclidean algorithm
gcdLoop:
    xor dx, dx                 ; Clear DX for division
    div bx                     ; Divide AX by BX, quotient in AX, remainder in DX
    mov ax, bx                 ; Move BX to AX for the next iteration
    mov bx, dx                 ; Move remainder (DX) to BX for the next iteration
    cmp bx, 0                  ; Check if remainder is zero
    jne gcdLoop                ; If not zero, repeat the loop
    je endGCD                  ; If zero, end the loop

zeroCase:
    ; Handle cases where either input is zero
    mov ax, 0                  ; Set AX to 0 (GCD of 0 and any number is 0)
    jmp endGCD                 ; Jump to the end of the procedure

endGCD:
    ; Restore registers and return
    POP BP                     ; Restore BP register
    POP DI                     ; Restore DI register
    POP SI                     ; Restore SI register
    POP DX                     ; Restore DX register
    ;POP CX                    ; CX not used, so pop is commented out
    ;POP BX                    ; BX is an input register, so pop is commented out
    ;POP AX                    ; AX is used for return value, so pop is commented out
    ret                        ; Return from the procedure, GCD is in AX

JCAGCD ENDP                    ; End of the JCAGCD procedure

end                            ; End of the program