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
NameLength dw ?                 ; Variable to store the length of the name

;Characters
enterKey db 13              ; ASCII code for Enter key
;comma db 44                 ; ASCII value for comma
;theSpace db 32                 ; ASCII value for space  

;Messages
welcomeMsg db 13, 10, 13, 10, "Hi there!", 13, 10, 
    "Type your name at the arrow (--->) at the bottom of this message", 13, 10, 
    "* It should be in the form of [FirstName MiddleName LastName]", 13, 10, 
    "* No empty names please, and no more than 80 characters", 13, 10, 
    "After that, press enter", 13, 10, "Thank You!", 13, 10, "--->", '$'
nameIsEmptymsg db 13, 10, "Huh! your name is ...empty? Thats not a name!", 13, 10,
    "Let's try again!", 13, 10, '$'
errorMSGCont db 13, 10, "Whoops!Invalid input. ", 13, 10,
    "Please type Y or N.", '$' ; Error message for invalid input
toolongMsg db 13, 10, "Array limit of 80 characters reached!", 13, 10, '$'
easterEgg db 13, 10, "Thank you for your great work teaching us!", 13, 10, 
    "Happy Holidays!", 13, 10, "John Akujobi", 13, 10, '$'
promptContinue db 13, 10, "Do you want to continue? (Y / N / or E): ", '$' ; Prompt for continuing the program
comma db ", ", '$'
borderline db 13, 10, 76 dup("_"), 13, 10, '$'

;;___________________________________________________________________
.code  ; Start of code segment

;;Printing Procedures, subroutines: I made these to avoid accidentally overwriting registers when i us _PutStr
;The procedures push all the registers onto the stack, call the _PutStr function,
;and then pops all the registers from the stack before returning.

; WelcomeMessage procedure prints a welcome message telling the user what to do
WelcomeMessage proc
    pusha
    _PutStr welcomeMsg
    popa
    ret
WelcomeMessage endp

;;toolong procedure prints an error message if the name is too long
toolong proc
    pusha                      ; save all registers
    _PutStr toolongMsg
    popa                       ; restore all registers
    ret
toolong endp

;;NameIsEmpty procedure prints an error message if the name is empty
nameIsEmpty proc
    pusha                       ; save all registers
    _PutStr nameIsEmptymsg
    popa                        ; restore all registers
    ret
nameIsEmpty endp

;;printCommmaSpace procedure prints a comma and a space
printCommmaSpace proc
    pusha
    _PutStr comma
    popa
    ret
printCommmaSpace endp

;;printSpace procedure prints a space
printBorderline proc
    pusha
    _PutStr borderline
    popa
    ret
printBorderline endp


;_________________________________________________________________________

;;ReadUsersName procedure gets the name from the user
ReadUsersName proc
    xor cx, cx                  ; we'll set cx to 0 and use as an index for the array (c for counter)
    lea di, NameArray           ; Load address of NameArray into di register (d for data)
    xor ax,ax                   ; set ax to 0
readingLoop:
    _GetCh                      ; read a character
    cmp al, enterKey            ; check if enter key is pressed (register a has the character)
    je endReading               ; if yes, end reading

    mov [di], al                ; store the character in the array
    add di, 1                   ; increment the pointer

    inc cx                      ; increment the counter
    cmp cx, 80                  ; check if the array is full
    jge callTooLong             ; if yes, end reading

    jmp readingLoop             ; continue reading
callTooLong:
    call toolong                ; call toolong procedure to print an error message
endReading:
    mov NameLength , cx         ; store the length of the name into length variable
    ret
ReadUsersName endp


;;PrintUsersName procedure prints the name in the form of [LastName, FirstName MiddleName]
PrintUsersName proc
    pusha ; save all registers

    xor si, si                  ; we'll set si to 0 and use as an index for the array (c for counter)
    mov si, NameLength          ; load the length of the name into si
    dec si                      ; decrement si by 1
    lea bx, NameArray           ; Load address of NameArray into di register 

;Find the last space in the name
getLastSpace:
    mov cx, si                  ; Move si to cx (saving it to print the rest of the names in printingOtherNames)
    mov al, [bx + si]           ; Move to the previous character going backwards in the name
    cmp al, ' '                 ; Compare with space character
    je printLastName            ; If space, print the last name

    dec si                      ; Decrement si by 1
    cmp si, 0                   ; Compare si with 0
    je singleWordName           ; Jump to singleWordName if si is 0

    jmp getLastSpace            ; If not space, continue searching for space

;Print the name
printLastName:
    mov si, cx                          ; Print from where we left off
    inc si                              ; Decrement si by 1
actualPrintLastName:
    mov al, [bx + si]                   ; Move to the first character in the last name
    _PutCh al                           ; Print the first character
    inc si
    cmp si, NameLength                  ; Compare si with 0
    jle actualPrintLastName             ; Restart the loop if si has not reached the end of the name

    _PutCh 8                            ; Print a backspace (learned from Assignment 5)
    call printCommmaSpace               ; Print a comma and a space
    jmp printingOtherNames              ; GO on to printing other names

singleWordName:
    xor si, si                          ; Starting at the beginning of the single word name
actualPrintingSingleWordName:       
    mov al, [bx + si]                   ; Move to the first character in the single word name
    _PutCh al                           ; Print the first character
    add si, 1                           ; Increment si by 1
    cmp si, NameLength                  ; Compare si with the length of the name
    jne actualPrintingSingleWordName    ; Restart the loop if si is not equal to the length of the name
    jmp endPrintingName                 ; Jump to endPrintingName

printingOtherNames:
    xor si, si                          ; reset si to 0 to start at the beginning of the name
actualPrintingOtherNames:
    mov al, [bx + si]                   ; Move to the first character in the name
    _PutCh al                           ; Print the first character
    inc si                              ; Increment si by 1
    cmp si, cx                          ; Check if we reached the position we stopped at in the last name
    jne actualPrintingOtherNames        ; Restart the loop if si is not equal to the length of the name
    jmp endPrintingName                 ; Jump to endPrintingName

endPrintingName:
    popa                                ; Restore all registers
    ret                                 ; Return
PrintUsersName endp

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

printEasterEgg proc
    call printBorderline
    pusha                          ; Restore all registers
    lea bx, easterEgg             ; Load address of easterEgg
    xor si, si
easterLoop:
    mov al, [bx + si]
    call Delay
    _PutCh al
    inc si
    cmp si, 75
    jl easterLoop ; Restart the loop 

    call printBorderline

    popa
    ret
printEasterEgg endp

;;JAKUJ procedure is the main procedure
JAKUJ    proc
    _Begin
    xor bx, bx                  ; set bx to 0
JAKUJprogramstart:
    call printBorderline        ; Print a borderline
    call printBorderline        ; Print a borderline
    call WelcomeMessage         ; Tell the user what to do
    call ReadUsersName          ; Read the name
    call printBorderline        ; Print a borderline


    ;check if name is empty
    mov bx, NameLength ;        ; Load the length of the name into bx
    cmp bx, 0                   ; Compare bx with 0
    jg Notempty                 ; Jump to Notempty if bx is greater than 0

    call nameIsEmpty            ; Print an error message if the name is empty
    call printBorderline        ; Print a borderline
    jmp AskContinue             ; Ask the user if they want to continue

Notempty:
    _PutCh 10                   ; Print a new line
    call PrintUsersName         ; Print the name in the form of [LastName, FirstName MiddleName]
    call printBorderline        ; Print a borderline
    jmp AskContinue             ; Ask the user if they want to continue

AskContinue:
    xor al, al                  ; Clear al register
    _PutStr promptContinue      ; Prompt user to continue or exit
    _GetCh                      ; Get a single character input
    cmp al, 'N'                 ; 
    je exitLoop                 ; Jump to exit if input is 'N'
    cmp al, 'n'                 ; 
    je exitLoop                 ; Jump to exit if input is 'n'
    cmp al, 'Y'                 ; 
    je JAKUJprogramstart        ; Jump to main loop if input is 'Y'
    cmp al, 'y'                 ; 
    je JAKUJprogramstart        ; Restart the program if input is 'y'

    cmp al, 'E'         
    je EasterChristmas
    cmp al, 'e'         
    je EasterChristmas

    _PutStr errorMSGCont        ; Display error message for invalid input
    jmp AskContinue             ; Jump back to ask continue prompt

EasterChristmas:
    call printBorderline
    call printEasterEgg
    jmp exitLoop

exitLoop:
    _Exit 0                     ; Exit program with status 0

JAKUJ    endp                   ; End of main procedure called JAKUJ

End JAKUJ                       ; End of program