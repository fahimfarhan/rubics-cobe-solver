org 100h 
.stack 100h 
.model small 


.data

error1_52 db "array out of range! $"
moves dw 256 dup(0) ; accha , eta ki 256 er beshi ki rakha jabe? say 500 ?
index dw 0

.code 

main proc
mov ax, @data 
mov ds, ax 
mov es, ax 

mov ax, 0 
mov ax, 'F' 
call SaveMoves 

mov ax, 'f' 
call SaveMoves 

mov ax, 'D' 
call SaveMoves 

call B

mov ax, 'b' 
call SaveMoves 

call ShowMoves
 
main endp
jmp End_Main 
;/*************/
ShowMoves proc
push ax
push bx
push cx
push dx
push si
push di

lea Si, moves 
mov cx, 0 
Loop_PrinterShowMoves:
cmp cx, index 
JE ExitShowMoves 
mov bx, 0
mov bx, [si]
MOV DL, BL
MOV AH,2
INT 21H
add si, 2 
add cx, 2 
jmp Loop_PrinterShowMoves


;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
 ;PRINT S
    MOV AH,9
    LEA DX, error1_52
    INT 21H
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
ExitShowMoves:	
pop di
pop si
pop dx 
pop cx 
pop bx 
pop ax
ret   
 
ShowMoves Endp
;/************/ 
;user manual
; mov ax, 'F'
;call savemoves
SaveMoves proc
push ax
push bx
push cx
push dx
push si
push di

mov Bx, index 
cmp bx, 500
JGE ArrayOutOfBondExceptionInShowMoves
;let Ax has the name( F, f, U, D, d ... ...) 
mov moves[Bx], Ax 
Add Bx, 2 
mov index, Bx 
ArrayOutOfBondExceptionInShowMoves:
pop di
pop si
pop dx 
pop cx 
pop bx 
pop ax
ret   
SaveMoves endp 

Checker proc 
; it is guaranteed that the backchecker pushes and pops all 
; the registers, so there shouldn't be a problem!
call BackChecker
call BackChecker

Checker endp

Backchecker proc 

Backcheckerr endp

End_Main:
end main 