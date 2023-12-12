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

;Characters
enterKey db 13              ; ASCII code for Enter key
comma db 44                 ; ASCII value for comma
theSpace db 32                 ; ASCII value for space

;Message
AskForName db "Hi there!", 13, 10 "Type your name at the arrow below in the form of [FirstName MiddleName LastName]", 13, 10, "Then press enter", 13, 10, "->", '$'
    

;;_________________________________________________________
.code  ; Start of code segment
extrn GetDec:near
extrn PutDec:near

;;This ReadUsersName procedure 
ReadUsersName proc
    _PutStr AskForName
    xor cx, cx                  ; we'll set cx to 0 and use as an index for the array (c for counter)
readingLoop:
    _GetCh                      ; read a character
    cmp al, enterKey            ; check if enter key is pressed
    je endReading               ; if yes, end reading

    mov [dx], al                ; store the character in the array
    inc dx                      ; increment the pointer

    inc cx                      ; increment the counter
    cmp cx, 80                  ; check if the array is full
    jge endReading              ; if yes, end reading

    jmp readingLoop             ; continue reading

endReading:

ReadUsersName endp

; Procedure to read a name
ReadName PROC
    mov bx, 0                   ; Initialize index to 0
readLoop:
    _GetCh                      ; Read a character
    cmp al, enterKey            ; Compare with Enter key
    je endRead                  ; If Enter key, end reading
    mov name[bx], al            ; Store character in array
    inc bx                      ; Increment index
    jmp readLoop                ; Repeat loop
endRead:
    mov nameLength, bx          ; Store name length
    ret
ReadName ENDP

JAKUJ    proc

JAKUJ    endp    ; End of main procedure

End main

