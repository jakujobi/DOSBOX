CSc 314 Assign #3 - Due: 10/13/23

The DOS Services function number 2Ah returns the current
date.  To call use:

    mov ah, 2Ah

    int 21h

Your program may only issue this call only once, save all
values in memory locations for later use. The results are then left in the
following registers:

    DH = month (1 to 12)

    DL = day (1 to 31)

    CX = year (4 digit number)

    AL = day of week (0 to 6)

You are to display the results as:

    **Today's date is: 10/4/2023**

You will need to use the print character function (2h) to
display the dashes, the display string function (9h), and the PutDec procedure
from the book’s link library (util.lib).  You must copy util.lib from the book cd in
order to complete this assignment. Copy the file into the same directory as
your assembly programs. You will need this file for the rest of the semester.

You will need to use the following command to link your program
with the util library:

    link myProg,,,util;

PutDec expects a word sized value so you must extend the
byte sized values to word sized before calling PutDec.

    mov dl, 9

    mov dh,0 ; now the dl value is extended into dh

    mov ax, dx

    call PutDec

remember that you need to include the line:

    .code

    extrn PutDec:near

at the beginning of your code segment to include information
for the assembler that PutDec is an external procedure that will be added at
link time.

**What to hand in:**

Place a copy of the source program into the Assignment 3
Dropbox on D2L with the naming convention:

    **LNameA3** .asm (**max of 8 chars** for file name)

You do not have to send me a copy of your output; I will
assemble and run everyone’s programs. Make sure that you include a comment
block in the beginning of your program that has the following format:

;           Name:              Your Name

;           Class:               CSc 314

;           Assign:            Current Assign Number

;           Due:                Due date

;

;           Description:     A short description of what the program
does
