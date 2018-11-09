org 100h 
.model small 
.stack 100h 
.data 

StringUp52 db "Enter Up face: $"
Stringleft52 db "Enter left face: $"
Stringfront52 db "Enter front face: $"
Stringright52 db "Enter right face: $"
StringBack52 db "Enter back face: $"
StringDown52 db "Enter down face: $"

up dw   4 dup(0)
left dw 4 dup(0)
front dw 4 dup(0)
right dw 4 dup(0)
back dw 4 dup(0)
down dw 4 dup(0)

.code 
main proc 
call TakeInput 
call printer

main endp

jmp _end 

TakeInput proc 
push Ax 
push Bx 
push Cx 
push Dx 
push Si 
Push Di 

 ;PRINT StringUp52 
    MOV AH,9
    LEA DX, StringUp52 
    INT 21H
	;/**********/
	;1
	mov cx, 0 
	mov bx, 0 
	; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov up[bx], cx 
	add bx, 2 
	;2
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov up[bx], cx 
	add bx, 2 
	;3 
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov up[bx], cx 
	add bx, 2 
	;4
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov up[bx], cx 
	add bx, 2 
;/****** left *******/
;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
;PRINT Stringleft52 
    MOV AH,9
    LEA DX, Stringleft52 
    INT 21H
	;/**********/
	;1
	mov cx, 0 
	mov bx, 0 
	; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov left[bx], cx 
	add bx, 2 
	;2
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov left[bx], cx 
	add bx, 2 
	;3 
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov left[bx], cx 
	add bx, 2 
	;4
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov left[bx], cx 
	add bx, 2
	;/***** front ******/
	;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	;PRINT Stringfront52 
    MOV AH,9
    LEA DX, Stringfront52 
    INT 21H
	;/**********/
	;1
	mov cx, 0 
	mov bx, 0 
	; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov front[bx], cx 
	add bx, 2 
	;2
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov front[bx], cx 
	add bx, 2 
	;3 
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov front[bx], cx 
	add bx, 2 
	;4
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov front[bx], cx 
	add bx, 2
	;/*****right*****/ 
	;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
;PRINT Stringright52 
    MOV AH,9
    LEA DX, Stringright52 
    INT 21H
	;/**********/
	;1
	mov cx, 0 
	mov bx, 0 
	; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov right[bx], cx 
	add bx, 2 
	;2
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov right[bx], cx 
	add bx, 2 
	;3 
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov right[bx], cx 
	add bx, 2 
	;4
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov right[bx], cx 
	add bx, 2	
	;/****back****/
	;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	;PRINT Stringback52 
    MOV AH,9
    LEA DX, Stringback52 
    INT 21H
	;/**********/
	;1
	mov cx, 0 
	mov bx, 0 
	; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov back[bx], cx 
	add bx, 2 
	;2
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov back[bx], cx 
	add bx, 2 
	;3 
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov back[bx], cx 
	add bx, 2 
	;4
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov back[bx], cx 
	add bx, 2
;/*******down*********/	
	;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	;PRINT Stringdown52 
    MOV AH,9
    LEA DX, Stringdown52 
    INT 21H
	;/**********/
	;1
	mov cx, 0 
	mov bx, 0 
	; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov down[bx], cx 
	add bx, 2 
	;2
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov down[bx], cx 
	add bx, 2 
	;3 
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov down[bx], cx 
	add bx, 2 
	;4
		; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
	mov down[bx], cx 
	add bx, 2
Pop Di 
pop Si 
pop Dx 
pop cx 
pop bx 
pop Ax 
Ret 
TakeInput Endp
;_end:
;jmp _end2

PRINTER PROC
push ax 
push bx 
push cx 
push dx 
push si 
push di 
;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
 
;UP 
LEA SI, UP 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H 
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
; LEFT 

LEA SI, LEFT 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	  ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
;FRONT 

LEA SI, FRONT 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	 ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
;RIGHT
LEA SI, RIGHT  
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
     ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	;BACK
LEA SI, BACK 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H 
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	;DOWN 
LEA SI, DOWN 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	
	pop di 
	pop si 
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	RET 
PRINTER ENDP
    _end:
;_end2:
end main 