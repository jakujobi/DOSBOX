;   This program retrieve the system date and time,
;   converts it to ASCII, and displays it to the screen

;   Define constants
;
CR      EQU 0DH ;define carriage return
LF      EQU 0AH ;define line feed
EOM     EQU '$' ;define end of message marker
NULL    EQU 00H ;define NULL byte
;
;   Define variables
;
JMP START
PROMPT  DB  CR, LF, "The current time is: ",EOM
PROMPT2 DB  CR, LF, "The date is: ",EOM
TIME    DB  "00:00:00", CR, LF, EOM
DATE    DB  "00/00/0000", CR, LF, EOM
;
;   Program code
;
START:  
CALL GET_TIME   ;call function to get system time
CALL GET_DATE   ;call function to get system date

LEA DX, PROMPT  ;print time prompt to screen
MOV AH, 09H
INT 21H

LEA DX, TIME    ;print time
MOV AH, 09H
INT 21H

LEA DX, PROMPT2 ;print date prompt to screen
MOV AH, 09H
INT 21H

LEA DX, DATE    ;print date
MOV AH, 09H
INT 21H


CVT_TIME:   ;converts the time to ASCII
CALL CVT_HR
CALL CVT_MIN
CALL CVT_SEC
RET

CVT_HR:
MOV BH, CH  ;copy contents of hours to BH
SHR CH,4    ;convert high char to low order bits
ADD CH, 30H ;add 30H to convert to ASCII
MOV [TIME], CH  ;save it
AND BH, 0FH ;isolate lower 4 bits
ADD BH, 30H ;convert to ASCII
MOV [TIME+1], BH    ;save it
RET

CVT_MIN:
MOV BH, CL  ;copy contents of minutes to BH
SHR CL, 4   ;convert high char to low order bits
ADD CL, 30H ;add 30H to convert to ASCII
MOV [TIME+3], CL    ;save it
AND BH, 0FH ;isolate lower 4 bits
ADD BH, 30H ; convert to ASCII
MOV[TIME+4], BH ;save it

CVT_SEC:
MOV BH, DH  ;copy contents of seconds to BH
SHR DH, 4   ;convert high char to low order bits
ADD DH, 30H ;add 30H to convert to ASCII
MOV [TIME+6], DH    ;save it
AND BH, 0FH ;isolate lower 4 bits
ADD BH, 30H ;convert to ASCII
MOV[TIME+7], BH ;save it

GET_DATE:   ;get date from the system
    MOV AH, 04H    ;BIOS function to read date
    INT 1AH        ;call to BIOS, run 04H
    CALL CVT_DATE
    RET
;CH = Century
;CL = Year
;DH = Month
;DL = Day
;CF = 0 if clock is running, otherwise 1

CVT_DATE:
    CALL CVT_MO
    CALL CVT_DAY
    CALL CVT_YR
    CALL CVT_CT
    RET

CVT_MO:     ;convert the month to ASCII
MOV BH, DH  ;copy month to BH
SHR BH, 4   ;convert high char to low order bits
ADD BH, 30H ;add 30H to convert to ASCII
MOV [DATE], BH  ;save in DATE string
MOV BH, DH  ;copy month to BH
AND BH, 0FH ;isolate lower 4 bits
ADD BH, 30H ;convert lower bits to ASCII
MOV [DATE+1], BH;save in DATE string
RET

CVT_DAY:    ;convert the day to ASCII
MOV BH, DL  ;copy days to BH
SHR BH, 4   ;convert high char to low order bits
ADD BH, 30H ;add 30H to convert to ASCII
MOV [DATE+3], BH    ;save in DATE string
MOV BH, DL  ;copy days to BH
AND BH, 0FH ;isolate lower 4 bits
ADD BH, 30H ;convert lower bits to ASCII
MOV [DATE+4], BH;save in DATE string
RET

CVT_YR:     ;convert the year to ASCII
MOV BH, CL      ;copy year to BH
SHR BH, 4       ;convert high char to low order bits
ADD BH, 30H     ;convert to ASCII
MOV [DATE+8], BH    ;save it
MOV BH, CL      ;copy year to BH
AND BH, 0FH     ;isolate low order bits
ADD BH, 30H     ;convert to ASCII
MOV [DATE+9], BH    ;save in DATE string
RET

CVT_CT:     ;convert the century to ASCII
MOV BH, CH      ;copy century to BH
SHR BH, 4       ;convert high char to low order bits
ADD BH, 30H     ;convert to ASCII
MOV [DATE+6], BH    ;save it
MOV BH, CH      ;copy century to BH
AND BH, 0FH     ;isolate low order bits
ADD BH, 30H     ;convert to ASCII
MOV [DATE+7], BH    ;save it
RET
;
;Program End
;

End