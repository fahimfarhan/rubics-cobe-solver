org 100h 
.stack 100h 
.model small 
 .data

up      dw 4 dup(0)
left    dw 4 dup(0)
front   dw 4 dup(0)
right   dw 4 dup(0)
back    dw 4 dup(0)
down    dw 4 dup(0)

backup dw 'a','b','c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't','u', 'v', 'w', 'x' 



.code
main proc 
    mov ax, @data 
    mov ds, ax
    mov es, ax
call InputRestor  
 ;OUPUT
    MOV DL, 48
    MOV AH,2
    INT 21H
call PRINTER

 ;OUPUT
    MOV DL, 48
    MOV AH,2
    INT 21H
main endp 

jmp endx 
;/*******************/
       
InputRestor proc  
    push ax 
push bx 
push cx 
push dx 
push si 
push di 

lea si, backup 
lea di, up 
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, left 
add si, 2 
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, front 
add si, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, right 
add si, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, back 
add si, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, down 
add si, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
        pop di 
	pop si 
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	RET 
InputRestor endp 
                     
                     
;/*******************/       
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
;endx:
;jmp endx1


endx:
 end main 