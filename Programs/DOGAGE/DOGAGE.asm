include pcmac.inc               ; Include the pcmac.inc file for macro definitions and utilities
.model small                    ; Define the memory model as 'small'
.stack 100h                     ; Allocate 256 bytes for the stack

.data                           ; Start of the data segment
    age dw ?                    ; Reserve a word for the age
    result dw ?                 ; Reserve a word for the result
    prompt db "Enter your age: ", '$'
    resultMsg db "Your age multiplied by 7 is: ", '$'

.code                           ; Start of the code segment
extrn GetDec:near               ; External declaration of the GetDec procedure (for input)
extrn PutDec:near               ; External declaration of the PutDec procedure (for output)

; Main program entry point
start proc

    _PutStr prompt              ; Display prompt for age
    call GetDec                 ; Call GetDec to read the age
    mov age, ax                 ; Store the age in 'age'

    ; Multiply age by 7
    mov ax, age                 ; Move age into AX for multiplication
    mov bx, 7                   ; Set BX to 7
    imul bx                     ; Multiply AX by BX (AX = AX * BX)
    mov result, dx              ; Store the result

    ; Display the result
    _PutStr resultMsg           ; Display result message
    mov dx, result              ; Move result back to AX for PutDec
    call PutDec                 ; Call PutDec to display the multiplied result

    _exit 0                     ; Exit program with status 0
start endp                      ; End of main procedure

END start                       ; End of program