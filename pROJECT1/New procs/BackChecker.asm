;arrray moves has the F, u, ... and index points to the last pos
; count52 has the count 
Backchecker proc
 push ax 
 push bx 
 push cx 
 push dx 
 push si 
 push di 
 
 moc ax, index 
 cmp ax, 4 
 JLE Exit_BackChecker1
 call counter1 
 mov Ax, count52 
 cmp Ax, 3 
 JNE Exit_BackChecker1 
 mov Bx, index
sub Bx, 2  
 mov Ax, 0 
 mov moves[bx], Ax 
 sub bx, 2 
 mov Ax, moves[Bx] 
 cmp Ax, 96 
 JG u_to_U 
 Add Ax, 32 
 mov moves[bx], ax 
 jmp Exit_BackChecker1

 u_to_U: 
 sub Ax, 32 
 mov moves[bx], Ax 
 Exit_BackChecker1: 
 
 mov ax, index 
 cmp Ax, 4 
 JL Exit_BackCheccker2
 ; else 
	mov bx, index 
	sub bx, 2 
	mov Ax, moves[bx] 
	sub Bx, 2 
	sub Ax, moves[bx] 
	cmp Ax, 32 
	JE BackCheckerCaseUUi 
	
	cmp Ax,  0FFE0h;-32  
	Jne Exit_BackCheccker2
	BackCheckerCaseUUi:
		mov ax, 0 
		mov moves[bx], ax 
		mov index, bx 
		add bx, 2 
		mov moves[bx], 0 
 Exit_BackCheccker2:
 
 pop di 
 pop si 
 pop dx 
 pop cx 
 pop bx 
 pop ax 
 RET
Backchecker endp
