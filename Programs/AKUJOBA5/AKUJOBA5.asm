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
    userChar db ?      ; srores the character to move
    trips db ?      ; stores the number of trips

    promptChar db "Enter a character: ", '$'    ; prompt for character
    promptTrips DB "Enter number of trips (1-3): ", '$' ; prompt for number of trips
    errorMsg DB "Invalid input. Enter a number between 1 and 3.", '$'   ; error message

.code
extrn GetDec:near
;_________________________________________________________________________________
; Get single character from user
;_________________________________________________________________________________
GetCharacter proc
    _PutStr promptChar      ; Write prompt to screen
    _GetCh                ; Read a character from user
    mov userChar, al        ; Store the character in userChar
    ret
GetCharacter endp

;_________________________________________________________________________________
; Get the number of trips from the user
;_________________________________________________________________________________
GetTrips PROC
    mov trips, 0               ; Initialize trips to 0
getTripsLoop:
    _PutStr promptTrips        ; Load prompt message address
    call GetDec                ; Get the number of trips from the user
    cmp ax, 1                  ; Compare input with 1
    jl invalidInput            ; Jump if less than 1
    cmp ax, 3                  ; Compare input with 3
    jg invalidInput            ; Jump if greater than 3
    mov trips, al              ; Store valid input
    ret                        ; Return from procedure
invalidInput:
    _PutStr errorMsg           ; Load error message address
    jmp getTripsLoop           ; Repeat input prompt
GetTrips endp

;_________________________________________________________________________________
; Delay
;_________________________________________________________________________________
Delay	PROC
		push ecx                ; save caller's CX
        push ax                 ; save caller's AX
		mov cx,0                ; loop 65K times
        mov cx, 0FFFFh          ; Delay length
delayLoop:
        nop
		dec cx
		jnz delayLoop
        
        pop ax ;restore caller's AX
		pop ecx ;restore caller's CX
		ret
Delay	ENDP

;_________________________________________________________________________________
; Procedure to move character across the screen
;_________________________________________________________________________________
PrintCharacter proc
    push ax
    push bx
    push cx
    push dx
    
    mov cl, trips              ; Number of trips
tripLoop:
    call OneTrip               ; Move character across screen for one trip

    dec cl                     ; Decrement trip counter
    cmp cl, 0                  ; Check if trips are completed
    jne tripLoop               ; Repeat if not completed

    pop dx
    pop cx
    pop bx
    pop ax
    ret                        ; Return from procedure
PrintCharacter endp

;_________________________________________________________________________________
; One trip accross the screen
;_________________________________________________________________________________
OneTrip proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 79                  ; Lines on screen
oneLoop:
    mov dl, userChar            ; Character to move
    _PutCh                      ; Write character to screen
    call delay
    _PutCh 8                    ; Write backspace to screen
    _PutCh 32                   ; Write space to screen
    dec cx
    jnz oneLoop
	
    _PutCh 13                   ; Write carriage return to screen

	pop dx
    pop cx
    pop bx
    pop ax
    ret                         ; Return from procedure
OneTrip endp

;_________________________________________________________________________________
; Main program
;_________________________________________________________________________________
JAKUJ proc
    mov ax, @DATA               ; Initialize data segment
    mov ds, ax
    call GetCharacter           ; Get character from user
    _PutCh 10                   ; Write line feed to screen
    _PutCh 13                   ; Write carriage return to screen
    call GetTrips               ; Get number of trips from user
    call PrintCharacter         ; Move character across screen

    _exit 0                     ; Exit the program with exit code 0
JAKUJ ENDP

END JAKUJ