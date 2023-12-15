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
welcomeMsg db 13, 10, "Hi there!", 13, 10, 
    "Type your name at the arrow (--->) at the bottom of this message", 13, 10, 
    "* It should be in the form of [FirstName MiddleName LastName]", 13, 10, 
    "* No empty names please, and no more than 80 characters", 13, 10, 
    "After that, press enter", 13, 10, 
    "Thank You!", 13, 10, "--->", '$'

nameIsEmptymsg db 13, 10, "Huh!, your name is _...empty? Thats not a name!", 13, 10,
    "Let's try again!", 13, 10, '$'

errorMSGCont db 13, 10, "Whoops!Invalid input. ", 13, 10,
    "Please type Y or N.", '$' ; Error message for invalid input
toolongMsg db 13, 10, "Array limit of 80 characters reached!", 13, 10, '$'

promptContinue db 13, 10, "Do you want to continue? (Y/N): ", '$' ; Prompt for continuing the program

comma db ", ", '$'

theSpace db " ", '$',

;;___________________________________________________________________
.code  ; Start of code segment
;extrn GetDec:near
;extrn PutDec:near

;;Printing Procedures, subroutines: I made these to avoid accidentally overwriting registers when i us _PutStr

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
printSpace proc
    pusha
    _PutStr theSpace
    popa
    ret
printSpace endp



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

    lea dx, NameArray           ; Load address of NameArray into di register (d for data)
    ;add dx, si                 ; move the pointer to the end of the name

;Find the last space in the name
getLastSpace:
    mov al, [dx+si]             ; Move to the previous character going backwards in the name
    cmp al, ' '                 ; Compare with space character
    mov cx, si                  ; Move si to cx (saving it to print the rest of the names in printingOtherNames)
    je printLastName            ; If space, print the last name
    test ax, ax                 ; Perform bitwise AND on AX with itself
    jz singleWordName           ; Jump to Zero if the result is 0

    dec si                      ; Decrement si by 1
    cmp si, 0                   ; Compare si with 0
    je printLastName            ; Jump to singleWordName if si is 0

    jmp getLastSpace            ; If not space, continue searching for space

;Print the name
printLastName:
    mov si, cx                          ; Print from where we left off
actualPrintLastName:
    mov al, [bx + si]                   ; Move to the first character in the last name
    _PutCh al                           ; Print the first character
    inc si
    cmp si, NameLength                  ; Compare si with 0
    jne actualPrintLastName             ; Restart the loop if si has not reached the end of the name
    call printCommmaSpace               ; Print a comma and a space
    jmp printingOtherNames              ; GO on to printing other names

singleWordName:
    xor si, si                           ; Starting at the beginning of the single word name
actualPrintingSingleWordName:       
    mov al, [bx + si]                   ; Move to the first character in the single word name
    _PutCh al                           ; Print the first character
    add si, 1                           ; Increment si by 1
    cmp si, NameLength                  ; Compare si with 0
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
    popa
    ret
PrintUsersName endp


;;JAKUJ procedure is the main procedure
JAKUJ    proc
    _Begin
    xor bx, bx                  ; set bx to 0
JAKUJprogramstart:
    call WelcomeMessage
    call ReadUsersName

    _PutStr NameArray

    ;check if name is empty
    mov bx, NameLength ;
    cmp bx, 0
    jg Notempty

    call nameIsEmpty
    ;;jmp programstart

Notempty:
    ;;call PrintUsersName

AskContinue:
    _PutStr promptContinue      ; Prompt user to continue or exit
    _GetCh                      ; Get a single character input
    cmp al, 'N'                 ; Compare input with 'N'
    je exitLoop             ; Jump to exit if input is 'N'
    cmp al, 'n'                 ; Compare input with 'n'
    je exitLoop             ; Jump to exit if input is 'n'
    cmp al, 'Y'                 ; Compare input with 'Y'
    je JAKUJprogramstart             ; Jump to main loop if input is 'Y'
    cmp al, 'y'                 ; Compare input with 'y'
    je JAKUJprogramstart             ; Jump to main loop if input is 'y'

    _PutStr errorMSGCont        ; Display error message for invalid input
    jmp AskContinue             ; Jump back to ask continue prompt

exitLoop:
    _Exit 0

JAKUJ    endp    ; End of main procedure called JAKUJ

End JAKUJ

