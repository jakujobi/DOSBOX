;; Name: Celsius to Fahrenheit Conversion
;; Class: CSC 314
;; Assign: Assignment 4
;; Due: 21st October 2023

;; Description:
;; This program converts a temperature from Celsius to Fahrenheit.
;; It uses the formula: Fahrenheit = (Celsius * 9/5) + 32

;;To Run
;; Open DosBox
;; Navigate to:
;;     c:\path\to\asm\file
;; Type:
;;      nasm -f obj filename.asm
;; Type and enter:
;;     link filename.obj,,,util
;; Type and enter:
;;     filename.exe

include pcmac.inc  ; Include pcmac.inc file
.model small  ; Set memory model to small
.586  ; Target the Intel 586 processor
.stack 100h  ; Set stack size to 256 bytes (100h in hexadecimal)

.data  ; Start of data segment
input_msg db "Enter temperature in Celsius: ", '$'
output_msg db "Fahrenheit: ", '$', 

.CODE
extrn PutDec:near
extrn GetDec:near

JAKUJ PROC  ; Start of main procedure
    _Begin
    _PutStr input_msg   ; Write the text in input_msg

    ; Get Celsius temperature from user
    call GetDec ; Get the celsius temperature and store in ax
    mov cx, ax  ; move the celsius temperature to cx
                ; this is to protect it in case PutStr changes ax

    _PutStr output_msg  ; Prints the text in output_msg
    int 21h

    ; Convert Celsius to Fahrenheit
    ; Fahrenheit = (Celsius * 9/5) + 32
    ; Multiply by 9
    mov ax, cx  ; move the celsius temperature back to ax
    mov bx, 9   ; put 9 into the bx register
    mul bx      ; multiply ax(celsius) by bx(9)
    
    mov cx, ax  ;just to keep a copy of the answer
    mov bl, 5   ; put 5 into the bl register
    div bl      ; divide ax(celsius*9) by bl(5)
                ; the answer is in ax
    
    add ax, 32 ; Add 32 to the answer

    call PutDec ; Display the result
                ; PutDec takes the value to display from ax

    _Exit 0     ; Exit the program with exit code 0

;;_________________________________________________________
_Exit 0 ; Exit the program with exit code 0
JAKUJ    endp    ; End of main procedure

End JAKUJ    ; End of program


;This program is designed to convert a temperature in Celsius to Fahrenheit.
;It prompts the user to enter a temperature in Celsius, reads the input,
; converts it to Fahrenheit using the formula Fahrenheit = (Celsius * 9/5) + 32, and displays the result.

;The program uses the following registers:
;   AX: used to store the Celsius temperature and the result of the multiplication and division operations
;   BX: used to store the value 9 for multiplication with the Celsius temperature
;   BL: used to store the value 5 for division with the result of the multiplication operation
;   CX: used to store the Celsius temperature and a copy of the result of the multiplication operation
;   INT 21h: used to display the output message

;The program also uses two external procedures:
;   PutDec: used to display the result of the Fahrenheit conversion
;   GetDec: used to read the Celsius temperature input from the user