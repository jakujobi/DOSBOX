;; Name: Izak Benitez-Lopez
;; Class: CSC 314
;; Assign: Assignment 3
;; Due: 10/15/22
;; Description: All this program does is give you todays date and displays it for you

include pcmac.inc

.MODEL SMALL
.586
.STACK 100h

.DATA
Message DB "Today's European Format is ", '$'
Month	DW 5

.CODE
extrn PutDec:near
extrn GetDec:near

Main PROC
    _Begin
    _PutStr Message
    mov ah, 2Ah
    int 21h
    mov bl, dl
    mov bh,0
    mov ax, bx
    call PutDec	
    mov bl,dh
    mov bh,0
    mov Month,bx
    _PutCh '-'
    mov ax,Month
    call PutDec
    _PutCh '-'
    mov ax,cx
    call PutDec
    _Exit 0
Main ENDP
END Main ; Tells where to start execution

