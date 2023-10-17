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

include pcmac.inc  ; Include pcmac.inc file
.model small  ; Set memory model to small
.586  ; Target the Intel 586 processor
.stack 100h  ; Set stack size to 256 bytes (100h in hexadecimal)

.data  ; Start of data segment
;; msg db "Hello World!", 13. 10 "$"  ; Define a string
;; Define variables here


;;_________________________________________________________
.code  ; Start of code segment
main    proc
_Begin
;_PutStr msg  ; Print the string (msg) to the screen [This overwrites ax]
;; Type your code here


;;_________________________________________________________
_Exit 0 ; Exit the program with exit code 0
main    endp    ; End of main procedure

End main