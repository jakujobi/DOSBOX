; Name: Celsius to Fahrenheit Conversion
; Class: CSC 314
; Assign: Assignment 4
; Due: 21st October 2023

; Description:
; This program converts a temperature from Celsius to Fahrenheit.
; It uses the formula: Fahrenheit = (Celsius * 9/5) + 32

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

JAKUJ PROC

    _Begin
    _PutStr input_msg

    ; Get Celsius temperature from user
    call GetDec ; Get the celsius temperature and store in ax
    mov cx, ax  ; move the celsius temperature to cx

    _PutStr output_msg
    int 21h

    ; Convert Celsius to Fahrenheit
    ; Fahrenheit = (Celsius * 9/5) + 32
    ; Multiply by 9
    mov al, cx
    mov bx, 9
    mul ax

    ; Exit
    _Exit 0

;;_________________________________________________________
_Exit 0 ; Exit the program with exit code 0
JAKUJ    endp    ; End of main procedure

End JAKUJ    ; End of program