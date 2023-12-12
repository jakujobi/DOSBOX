;; Name: John Akujobi
;; Class: CSC 314
;; Assign: Assignment #
;; Due: ##, 2023

;; Description:
;;
;;

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

include pcmac.inc           ; Include pcmac.inc file
.model small                ; Set memory model to small
.586                        ; Target the Intel 586 processor
.stack 100h                 ; Set stack size to 256 bytes (100h in hexadecimal)

.data                       ; Start of data segment
NameArray db 80 dup(?)      ; Array to store the name, max 80 characters
length dw 0                 ; Variable to store the length of the name

;
enterKey db 13              ; ASCII code for Enter key
comma db 44                 ; ASCII value for comma
theSpace db 32                 ; ASCII value for space

AskForName db "Hi there!", 13, 10 "Type your name at the arrow below in the form of [FirstName MiddleName LastName]", 13, 10 "->", '$'
    

;;_________________________________________________________
.code  ; Start of code segment
extrn GetDec:near
extrn PutDec:near

;;This ReadUsersName procedure 
ReadUsersName proc

ReadUsersName endp


JAKUJ    proc

JAKUJ    endp    ; End of main procedure

End main

