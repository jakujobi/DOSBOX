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

.model small  ; Set memory model to small
.586  ; Target the Intel 586 processor
.stack 100h  ; Set stack size to 256 bytes (100h in hexadecimal)

.data  ; Start of data segment
    userChar DB ?
    trips DB ?
    promptChar DB 'Enter a character: $'
    promptTrips DB 'Enter number of trips (1-3): $'
    errorMsg DB 'Invalid input. Enter a number between 1 and 3.$'

include pcmac.inc  ; Include pcmac.inc file

; Procedure to get a single character from the user
GetCharacter proc
    mov DX, OFFSET promptChar ; Load prompt message address
    call WriteString           ; Write prompt to screen
    call ReadChar              ; Read a character from user
    mov userChar, AL           ; Store the character
    ret
GetCharacter endp


; Procedure to get the number of trips from the user
GetTrips PROC
    mov trips, 0               ; Initialize trips to 0
getTripsLoop:
    mov dx, OFFSET promptTrips ; Load prompt message address
    call WriteString           ; Write prompt to screen
    call ReadInt               ; Read integer from user
    cmp ax, 1                  ; Compare input with 1
    jl invalidInput            ; Jump if less than 1
    cmp ax, 3                  ; Compare input with 3
    jg invalidInput            ; Jump if greater than 3
    mov trips, AL              ; Store valid input
    ret                        ; Return from procedure
invalidInput:
    mov dx, OFFSET errorMsg    ; Load error message address
    call WriteString           ; Write error message to screen
    jmp getTripsLoop           ; Repeat input prompt
GetTrips endp


; Procedure to move character across the screen
MoveCharacter proc
    mov cl, trips              ; Number of trips
    mov ch, 0                  ; Counter for trips
tripLoop:
    ; Move character to the right
    mov dl, 0                  ; Position counter

    ; Loop to move character to the right
    moveRightLoop:
        mov ah, 2              ; Set function to move cursor
        mov bh, 0              ; Set page number
        mov dh, 0              ; Set row number
        mov dl, dl              ; Set column number
        int 10h                ; Call interrupt to move cursor
        mov dl, userChar       ; Load character to move
        int 21h                ; Call interrupt to write character
        call Delay             ; Call delay procedure
        inc dl                 ; Increment column number
        cmp dl, 79             ; Compare column number with 79
        jle moveRightLoop      ; Jump if less than or equal to 79
    
    ; Move character to the left
moveLeft:
    mov ah, 2                  ; Function to set cursor position
    mov bh, 0                  ; Page number
    mov dh, 0                  ; Row
    mov dl, dl                 ; Column
    int 10h                    ; BIOS video interrupt
    mov ah, 9                  ; Function to write character
    mov al, userChar           ; Character to write
    mov bl, 7                  ; Attribute
    mov cx, 1                  ; Write one character
    int 10h                    ; BIOS video interrupt
    call Delay                 ; Delay to slow down movement
    dec dl                     ; Move to previous position
    cmp dl, 0                  ; Check if start of line reached
    jge moveLeft               ; Loop if not start of line

    dec ch                     ; Decrement trip counter
    cmp ch, 0                  ; Check if trips are completed
    jne tripLoop               ; Repeat if not completed
    ret                        ; Return from procedure

MoveCharacter endp


; Delay procedure
Delay proc
    push ax
    push cx
    mov cx, 0FFFFh             ; Delay length
delayLoop:
    nop          ;or nope :)   ; No operation (delay)
    LOOP delayLoop
    pop cx
    pop ax
    ret

Delay endp




; Main program
START:
    mov ax, @DATA              ; Initialize data segment
    mov ds, ax
    call GetCharacter          ; Get character from user
    call GetTrips              ; Get number of trips from user
    call MoveCharacter         ; Move character across screen

    _exit 0                    ; Exit the program with exit code 0
END START


;;_________________________________________________________
_Exit 0 ; Exit the program with exit code 0
main    endp    ; End of main procedure

End main