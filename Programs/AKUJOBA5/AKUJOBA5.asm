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
    userChar DB ?
    trips DB ?
    promptChar DB 'Enter a character: $'
    promptTrips DB 'Enter number of trips (1-3): $'
    errorMsg DB 'Invalid input. Enter a number between 1 and 3.$'

    

;;_________________________________________________________
_Exit 0 ; Exit the program with exit code 0
main    endp    ; End of main procedure

End main