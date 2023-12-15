; ==========================================================================================
;; Name: John Akujobi
;; Class: CSC 314
;; Assign: Assignment 7
;; Due: Dec 15, 2023
; Description:
;   This Assembly program reads a person's full name and reformats it to display in the order
;   of lastname, firstname [middle name(s)]. It handles various name structures, including 
;   single names, names without middle names, and names with multiple middle names.
;
;   The program consists of two main parts:
;     - ReadingNameOfUser: A procedure to read the user's full name up to 80 characters
;       long, storing the characters in an array, and counting the number of characters entered.
;     - PrintNameOfUser: A procedure to process and print the name in the desired format.
;
;   Example Input: John Barley Smithson
;   Example Output: Smithson, John Barley
;
; Key Features:
;   - The program can handle names with zero or more middle names.
;   - It is capable of managing various test cases, including single names, empty input,
;     names with no middle names, and names with multiple middle names.
;   - Efficient string manipulation techniques are employed to reorder the name components.
;
; Usage:
;   - Run the program and enter a full name when prompted.
;   - The program will output the reformatted name in the specified order.
;
; Testing:
;   - The program has been thoroughly tested with different name formats to ensure robustness
;     and accuracy in name reformatting.
; ==========================================================================================


;;To Run
;; Open DosBox
;; Navigate to:
;;     c:\path\to\asm\file
;; Type:
;;      nasm -f obj AKUJOBIA7.asm
;; Type and enter:
;;     link AKUJOBIA7.obj,,,util
;; Type and enter:
;;     AKUJOBIA7.exe
;; (Note: Ensure the PCMAC.INC and UTIL.LIB files are in the same directory)

include pcmac.inc           ; Include pcmac.inc file
.model small                ; Set memory model to small
.586                        ; Target the Intel 586 processor
.stack 100h                 ; Set stack size to 256 bytes (100h in hexadecimal)

.data                       ; Start of data segment
NameArray db 80 dup(?)      ; Array to store the name, max 80 characters
NameLength dw ?                 ; Variable to store the length of the name

;Characters & Messages
enterKey db 13              ; ASCII code for Enter key
welcomeMsg db 13, 10, 13, 10, "Hi there!", 13, 10, 
    "Type your name at the arrow (--->) at the bottom of this message", 13, 10, 
    "* It should be in the form of [FirstName MiddleName LastName]", 13, 10, 
    "* No empty names please, and no more than 80 characters", 13, 10, 
    "* Put in letters only, no numbers or characters except for spaces and hyphens", 13, 10, 
    "After typing your name, press enter", 13, 10, "Thank You!", 13, 10, "--->", '$'
nameIsEmptymsg db 13, 10, "Huh! your name is...empty? Thats not a name!", 13, 10,
    "Remember to type your name (Letters, spaces and hyphens only) and press enter", 13, 10, "Let's try again!", 13, 10, '$'
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
    lea bx, NameArray           ; Load address of NameArray into di register (d for data)
    mov [bx - 1], ' '           
    xor al,al                   ; set ax to 0
    xor si, si ; set si to 0
readingLoop:
    _GetCh                      ; read a character
    cmp al, enterKey            ; check if enter key is pressed (register a has the character)
    je endReading               ; if yes, end reading

checkingCharacter: ; Check if the character is a letter or a space
    cmp al, ' '                 ; check if it's a space
    je storeCharacter           ; if yes, store it
    cmp al, '-'                 ; check if it's a space
    je storeCharacter           ; if yes, store it
    cmp al, 'A'                 ; check if it's a letter (upper case)
    jl notACharacter            ; if less than 'A', it's not a letter
    cmp al, 'Z'                 ; check if it's a letter (upper case)
    jg checkLowerCase           ; if greater than 'Z', check if it's a lower case letter
    jmp storeCharacter

checkLowerCase:
    cmp al, 'a'                 ; check if it's a letter (lower case)
    jl notACharacter            ; if less than 'a', it's not a letter
    cmp al, 'z'                 ; check if it's a letter (lower case)
    jg notACharacter            ; if greater than 'z', it's not a letter
    jmp storeCharacter          ; if it's a letter, store it

notACharacter:
    jmp readingLoop             ; if it's not a letter or a space, ignore it and read the next character

storeCharacter:
    mov [bx + si], al             ; store the character in the array
    inc si                      ; increment the pointer

    inc cx                      ; increment the counter
    cmp cx, 80                  ; check if the array is full
    jge callTooLong             ; if yes, end reading

    jmp readingLoop             ; continue reading
callTooLong:
    call toolong                ; call toolong procedure to print an error message
endReading:
    mov [bx + si], '$'           ; store the null character at the end of the array
    ;mov [bx + si + 1], '$'           ; store the null character at the end of the array
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
    dec si                      ; decrement si by 1

    ; Check if the name is a single letter
    cmp [bx + 1], '$'                   ; Compare si with 0
    je printSingleLetter        ; If si is 0, jump to printSingleLetter

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
    call Delay
    inc si
    cmp si, NameLength                  ; Compare si with 0
    jle actualPrintLastName             ; Restart the loop if si has not reached the end of the name

    _PutCh 8                            ; Print a backspace (learned from Assignment 5)
    call printCommmaSpace               ; Print a comma and a space
    jmp printingOtherNames              ; GO on to printing other names

printSingleLetter:
    mov al, [bx]                ; Move to the first character in the name
    _PutCh al                   ; Print the character
    call Delay
    jmp endPrintingName         ; Jump to endPrintingName

singleWordName:
    xor si, si                          ; Starting at the beginning of the single word name
actualPrintingSingleWordName:       
    mov al, [bx + si]                   ; Move to the first character in the single word name
    _PutCh al                           ; Print the first character
    call Delay
    add si, 1                           ; Increment si by 1
    cmp si, NameLength                  ; Compare si with the length of the name
    jne actualPrintingSingleWordName    ; Restart the loop if si is not equal to the length of the name
    jmp endPrintingName                 ; Jump to endPrintingName

printingOtherNames:
    xor si, si                          ; reset si to 0 to start at the beginning of the name
actualPrintingOtherNames:
    mov al, [bx + si]                   ; Move to the first character in the name
    _PutCh al                           ; Print the first character
    call Delay
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
    pusha
    mov cx, 0FFFFh                      ; Delay length (Learned this from stack overflow)
    delayLoop:
        nop
		dec cx
		jnz delayLoop
    popa
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

    ;_PutStr NameArray           ; Print the name stored in NameArray (for testing)

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


; ==========================================================================================
;; Name: John Akujobi
;; Class: CSC 314
;; Assign: Assignment 7
;; Due: Dec 15, 2023
; Description:
;   This Assembly program reads a person's full name and reformats it to display in the order
;   of lastname, firstname [middle name(s)]. It handles various name structures, including 
;   single names, names without middle names, and names with multiple middle names.
;
;   The program consists of two main parts:
;     - ReadingNameOfUser: A procedure to read the user's full name up to 80 characters
;       long, storing the characters in an array, and counting the number of characters entered.
;     - PrintNameOfUser: A procedure to process and print the name in the desired format.
;
;   Example Input: John Barley Smithson
;   Example Output: Smithson, John Barley
;
; Key Features:
;   - The program can handle names with zero or more middle names.
;   - It is capable of managing various test cases, including single names, empty input,
;     names with no middle names, and names with multiple middle names.
;   - Efficient string manipulation techniques are employed to reorder the name components.
;
; Usage:
;   - Run the program and enter a full name when prompted.
;   - The program will output the reformatted name in the specified order.
;
; Testing:
;   - The program has been thoroughly tested with different name formats to ensure robustness
;     and accuracy in name reformatting.
;
; ==========================================================================================
; Program Overview:
; - The program reads a user's full name and then displays it with the last name first,
;   followed by a comma, the first name, and any middle names.
; - The name's components are separated by spaces, and the program identifies the last name
;   as the word after the last space in the input.

; Functionality:
; - Name Input: Prompts the user to enter their full name, storing up to 80 characters.
; - Name Processing: Analyzes the entered name to identify and isolate the last name.
; - Reformatting Output: Prints the name in the format 'Lastname, Firstname [Middlename(s)]'.
; - Input Validation: Ensures the name does not exceed the maximum length and handles empty input.

; Technical Details:
; - The program is optimized for x86 Assembly, suitable for DOS-like environments.
; - Employs string manipulation techniques for processing the entered name.
; - Uses stack-based logic for storing and accessing the name data.

; User Interaction:
; - The user is prompted to enter their full name upon program start.
; - The reformatted name is displayed according to the specified format.
; - Handles a variety of name formats, including complex names with multiple components.

; Limitations and Considerations:
; - Designed for environments where direct memory access and stack manipulation are supported.
; - Assumes name components are separated by spaces and does not handle special characters.
; - The maximum name length is set to 80 characters; longer names are truncated.
; - The program assumes that the last name is the first word after the last space in the input.
; ==========================================================================================
