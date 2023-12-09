; JCAGCD.asm
; GCD procedure for calculating the greatest common divisor

;; Name: John Akujobi
;; Class: CSC 314
;; Assign: Assignment 6
;; Due: Nov 29, 2023


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


; JCAGCD.asm
; Description: Greatest Common Divisor (GCD) Calculation Procedure
; Author: John Akujobi
; Course: CSC 314
; Assignment: Assignment 6
; Due Date: November 29, 2023
;
; This program defines the JCAGCD procedure, which calculates the GCD of two integers.
; It is designed to be used in conjunction with other assembly programs that require
; GCD computation. The procedure takes two integers in the AX and BX registers,
; processes them using the Euclidean algorithm, and returns the GCD in the AX register.
;
; The program shows important assembly language concepts like conditional
; branching, loops, register management, and modular programming. It is optimized for
; the Intel 586 processor and follows the small memory model convention.
;
; Usage:
; 1. AX should contain the first integer and BX the second integer before calling JCAGCD.
; 2. After the call, AX will contain the calculated GCD.
; 3. JCAGCD can be included in other assembly programs by declaring it as an external procedure.
;
; Note: The procedure includes checks and conversions for negative inputs and handles
; cases where either or both input integers are zero.
;
; ==========================================================================================


; ===============================================================
; Sample Usage: Running AKUJOBA6 with JCAGCD Procedure
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