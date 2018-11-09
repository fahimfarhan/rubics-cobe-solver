bool1 dw 0

PlaceCorner1FromUpperSide proc
push Ax 
push Bx 
push cx 
push dx 
push Si 
push di 

; code name Level1proc1 
mov cx, 0 
Level1proc1for1: 
add cx, 1 
cmp cx, 4 
JG Level1proc1for1End 
;if1
Level1proc1for1if1: 
	mov Bx, 0 
	Mov Ax, Up[Bx] 
	Mov Dx, 'W' 
	cmp Ax, Dx 
	JNE Level1proc1for1Else 
	;if 2 
	mov Ax, Left[bx] 
	mov Dx, 'G' 
	cmp Ax, Dx 
	JNE Level1proc1for1Else 
	call U 
	call B 
	call B 
	mov Ax, 1 
	mov bool1, ax 
	mov cx, 7 
	jmp Level1proc1End 
Level1proc1for1Else: 
	call U 
	jmp Level1Proc1  
Level1Proc1For1End:
;/**********************/ 
	mov cx, 0 
Level1Proc1for2: 
		add cx, 1 
		cmp cx, 4 
		JG Level1Proc1for2End 
	;if1 
	mov Bx, 0 
	mov Ax, left[Bx] 
	mov Dx, 'W' 
	cmp Ax, Dx 
	JNE Level1Proc1For2Else 
	; if2 
	mov Bx, 2 
	Mov Ax, Back[Bx] 
	Mov Dx, 'G' 
	cmp Ax, Dx 
	JNE Level1Proc1For2Else 
	call B 
	mov Ax, 1 
	Mov Bool1, Ax 
	mov Cx, 7 
	JMP Level1proc1End
Level1Proc1For2Else: 
	call U 
	jmp level1Proc1For2
Level1Proc1For2End: 
; 
mov cx, 0 
Level1Proc1For3: 
Add cx, 1 
Cmp cx, 4 
JG Level1Proc1For3End 
;if1 
mov Bx, 2 
 mov Ax, Back[Bx] 
mov Dx, 'W' 
cmp Ax, Dx 
JNE Level1Proc1For3Else 
;if2 
	mov Bx, 0 
	Mov Ax,up[Bx] 
	mov Dx, 'G' 
	cmp Ax, Dx 
	JNE Level1Proc1For3Else 
	call Li 
	mov Bool1, 1 
	mov Cx, 7 
	Jmp Level1proc1End 
Level1Proc1For3Else: 
call U 
jmp Level1Proc1For3 
Level1Proc1For3End: 
Level1Proc1End:
pop di  
pop si
pop dx 	
pop cx
pop bx	
pop ax	
 Ret
PlaceCorner1FromUpperSide endp