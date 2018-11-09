
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
