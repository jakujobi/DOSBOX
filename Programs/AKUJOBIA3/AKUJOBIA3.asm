; This program retrieves the current date and displays it in the format: Today's date is: MM/DD/YYYY

.MODEL SMALL  ; Set memory model to small
.586  ; Target the Intel 586 processor
.STACK 100h  ; Set stack size to 256 bytes (100h in hexadecimal)

.DATA  ; Start of data segment

msg db "Today's date is: ", "$" ; Define a string message to display the date

; Variables to store date values
current_month db 0 ; Define a variable to store the current month
current_day db 0 ; Define a variable to store the current day
current_year dw 0 ; Define a variable to store the current year

.CODE  ; Start of code segment
extrn PutDec:near  ; External procedure declaration

;start:
JAKUJ: ;PROC; Start of procedure named JAKUJ

    ; Call DOS Service to retrieve date
    mov ah, 2Ah ; Set the value of AH register to 2Ah to call DOS Service to retrieve date
    int 21h ; Call DOS Service to retrieve date

    ; Store retrieved values in memory
    mov [current_month], dh ; Store the retrieved month value in current_month variable
    mov [current_day], dl ; Store the retrieved day value in current_day variable
    mov [current_year], cx ; Store the retrieved year value in current_year variable

    ; Display "Today's date is: "
    ;mov ah, 9
    mov ax, ; Move the value of AX register to DS register
    mov ds, ax ; Move the value of OFFSET msg to DX register
    mov dx, OFFSET msg ; Set the value of DX register to the offset of the message string
    int 21h ; Call DOS Service to display the message

    ; Display Month
    mov dh, 0 ; Set the value of DH register to 0
    mov dl, [current_month] ; Move the value of current_month variable to DL register
    mov ax, dx ; Move the value of DX register to AX register
    call PutDec ; Call the PutDec procedure to display the month value

    ; Display '/'
    mov ah, 2 ; Set the value of AH register to 2 to display a character
    mov dl, '/' ; Set the value of DL register to '/' character
    int 21h ; Call DOS Service to display the character

    ; Display Day
    mov dh, 0 ; Set the value of DH register to 0
    mov dl, [current_day] ; Move the value of current_day variable to DL register
    mov ax, dx ; Move the value of DX register to AX register
    call PutDec ; Call the PutDec procedure to display the day value

    ; Display '/'
    mov ah, 2 ; Set the value of AH register to 2 to display a character
    mov dl, '/' ; Set the value of DL register to '/' character
    int 21h ; Call DOS Service to display the character

    ; Display Year
    mov ax, [current_year] ; Move the value of current_year variable to AX register
    call PutDec ; Call the PutDec procedure to display the year value

    ; Exit
    mov ah, 4Ch ; Set the value of AH register to 4Ch to exit the program
    int 21h ; Call DOS Service to exit the program

;AKUJ ENDP  ; End of procedure named AKUJ

END JAKUJ  ; Tell assembler to start execution at label named
;end start