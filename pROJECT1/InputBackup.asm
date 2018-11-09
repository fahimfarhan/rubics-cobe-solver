org 100h 
.stack 100h 
.model small 

.data
up      dw  'a', 'b' , 'c', 'd' 
left    dw  'e', 'f', 'g', 'h'
front   dw  'i','j','k','l'
right   dw  'm','n','o','p'
back    dw  'q','r','s','t'
down    dw  'u','v','w','x' 

backup dw 24 dup(0)

.code
main proc 
call InputBackup 
call backupPrinter
main endp 
jmp endmain

;/*************************/ 
InputBackUp proc
    push ax 
push bx 
push cx 
push dx 
push si 
push di 
    
	lea Si, backup
	lea di, up 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	lea di, left 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
		mov ax, [di]
	mov [si], ax 
	add si, 2 
	lea di, front 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	lea di, right 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	lea di, back 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	lea di, down 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	add si, 2 
	add di, 2 
	mov ax, [di]
	mov [si], ax 
	;add si, 2 
	;add di, 2 
	 pop di 
	pop si 
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	RET 
InputBackUp endp
 ;/*******************/
backupPrinter proc  
    push ax 
push bx 
push cx 
push dx 
push si 
push di 
    
	lea si, backup 
	mov cx, 0
	mov dx, 0 
	loopBackupPrinter:
	cmp cx, 24
	jge endbackupPrinter
	mov dx, [si] 
	;mov dl, bl
	MOV AH,2
    INT 21H
	add si, 2 
	add cx, 1
	
	;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	jmp loopBackupPrinter
	endbackupPrinter:
	 pop di 
	pop si 
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	RET 
backupPrinter endp

EndMain: 
end main 