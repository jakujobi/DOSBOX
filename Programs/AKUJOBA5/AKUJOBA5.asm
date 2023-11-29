;; Name: John Akujobi
;; Class: CSC 314
;; Assign: Assignment 5
;; Due: Nov 15, 2023

;; Description:
;; This Assembly program displays a character moving back and forth across the screen.
;; The character's movement spans from the leftmost to the rightmost side of the screen.
;; The 'trips' (back-and-forth movements) are determined by user input.

;;To Run
;; Open DosBox
;; Navigate to:
;;     c:\path\to\asm\file
;; Type:
;;      masm  AKUJOBA5.asm 
;; Type and enter:
;;     link AKUJOBA5.obj,,,util
;; Type and enter:
;;     AKUJOBA5.exe

include pcmac.inc               ; Include pcmac.inc file
.model small                    ; Set memory model to small
.586                            ; Target the Intel 586 processor
.stack 100h                     ; Set stack size to 256 bytes (100h in hexadecimal)

.data  
    userChar db ?               ; stores the character to move
    trips db ?                  ; stores the number of trips

    promptChar db "Enter a character: ", '$'                ; prompt for character
    promptTrips DB "Enter number of trips (1-3): ", '$'     ; prompt for number of trips
    errorMsg DB "Invalid input. Enter a number between 1 and 3.", '$'   ; error message

.code
extrn GetDec:near

; Get single character from user__________________________________________________
GetCharacter proc
    _PutStr promptChar          ; Write prompt to screen
    _GetCh                      ; Read a character from user
    mov userChar, al            ; Store the character in userChar
    ret
GetCharacter endp

; Get the number of trips from the user___________________________________________
GetTrips PROC
    mov trips, 0                ; Initialize trips to 0
    getTripsLoop:
        _PutStr promptTrips         ; Load prompt message address
        call GetDec                 ; Get the number of trips from the user
        cmp ax, 1                   ; Compare input with 1
        jl invalidInput             ; Jump if less than 1
        cmp ax, 3                   ; Compare input with 3
        jg invalidInput             ; Jump if greater than 3
        mov trips, al               ; Store valid input
        ret                         ; Return from procedure
    invalidInput:
        _PutStr errorMsg            ; Load error message address
        jmp getTripsLoop            ; Repeat input prompt
GetTrips endp

; Delay the program for a while___________________________________________________
Delay	PROC
    push ecx                    ; save caller's CX
    push ax                     ; save caller's AX
    mov cx, 0FFFFh              ; Delay length (Learned this from stack overflow)
    delayLoop:
        nop
		dec cx
		jnz delayLoop
        
    pop ax                      ;restore caller's AX
    pop ecx                     ;restore caller's CX
    ret
Delay	ENDP

; Procedure to move character across the screen___________________________________
PrintCharacter proc
    push ax
    push bx
    push cx
    push dx
    
    mov cl, trips               ; Number of trips
    tripLoop:
        call OneTrip            ; Move character across screen for one trip
        dec cl                  ; Decrement trip counter
        cmp cl, 0               ; Check if trips are completed
        jne tripLoop            ; Repeat if not completed

    pop dx
    pop cx
    pop bx
    pop ax
    ret                         ; Return from procedure
PrintCharacter endp

; One trip accross the screen_____________________________________________________
OneTrip proc
    push ax
    push bx
    push cx
    push dx

    mov cx, 79                  ; Lines on screen
    forthLoop:
        mov dl, userChar        ; Character to move
        _PutCh                  ; Write character to screen
        call delay
        _PutCh 8                ; Write backspace to screen
        _PutCh 32               ; Write space to screen
        dec cx
        jnz forthLoop           ; Repeat until end of line
    backLoop:
        _PutCh 8                ; Write backspace to screen twice (to move back)
        _PutCh 8
        mov dl, userChar        ; Character to move
        _PutCh                  ; Write character to screen
        call delay
        _PutCh 8                ; Write backspace to screen
        _PutCh 32               ; Write space to screen
        inc cx
        cmp cx, 79
        jne backLoop            ; Repeat until end of line
    _PutCh 13                   ; Write carriage return to screen

	pop dx
    pop cx
    pop bx
    pop ax
    ret                         ; Return from procedure
OneTrip endp

; Main program ___________________________________________________________________
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


; Program Overview:
; This Assembly program displays a character moving back and forth across the screen.
; The character's movement spans from the leftmost to the rightmost side of the screen.
; The 'trips' (back-and-forth movements) are determined by user input.

; Functionality:
; - Character Input: Prompts user for a single printable character for display.
; - Number of Trips: User specifies trips (1-3). Validates input and re-prompts if out of range.
; - Movement Logic: Moves character across the screen without reaching the 80th position.
;   Erases the previous character (using backspace and space) for smooth movement.
; - Delay Mechanism: Includes a delay loop to slow down character movement for visibility.

; Technical Details:
; - Written in Assembly for x86 processors, suitable for DOS-like environments.
; - Utilizes BIOS interrupts for screen manipulation and character display.
; - Delay implemented as a no-operation loop for controlled movement pacing.

; User Interaction:
; - Starts with prompts for character input and number of trips.
; - Executes character movement across the screen as per user specifications.
; - Program concludes after completing the specified number of trips.

; Limitations and Considerations:
; - Designed for systems supporting BIOS interrupts (e.g., DOS).
; - Assumes an 80-character width display; different sizes may alter behavior.
; - Delay duration may require adjustment for different CPU speeds.