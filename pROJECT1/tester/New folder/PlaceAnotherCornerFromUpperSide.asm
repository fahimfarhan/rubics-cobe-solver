bool2 dw 0 

PlaceAnotherCornerFromUpperSide proc 
push Ax 
push Bx 
Push cx 
Push Dx 
Push Si 
Push Di  
;/***************/ 

mov Cx, 0 
_1stForPACFUS: 
cmp cx, 4 
JGE End1stForPACFUS

	mov Bx, 0 
	mov Ax, right[Bx] 
	cmp Ax, 'W' 
	JNE Else1stForPACFUS
	
	mov Bx, 4 
	mov Ax, up[bx] 
	cmp Ax, 'B' 
	JNE _1stElseIf1stForPACFUS 
	call U
	call f 
	call u 
	call fi
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_1stElseIf1stForPACFUS: 
mov Bx, 4 
	mov Ax, up[Bx] 
	cmp Ax,'G'
	JNE _2ndElseIf1stForPACFUS 
	call Ui 
	call B 
	call U 
	call Bi 
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_2ndElseIf1stForPACFUS: 
	mov Bx, 4 
	mov Ax, up[Bx] 
	cmp Ax,'R' 
	call R 
	call U 
	call Ri 
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	 
	
	
Else1stForPACFUS:
	call U 
	jmp _1stForPACFUS

End1stForPACFUS: 
;/****************/
;/**2nd loop **/
;/***************/ 

mov Cx, 0 
_2ndForPACFUS: 
cmp cx, 4 
JGE End2ndForPACFUS

	mov Bx, 2
	mov Ax, front[Bx] 
	cmp Ax, 'W' 
	JNE Else2ndForPACFUS
	
	mov Bx, 4 
	mov Ax, up[bx] 
	cmp Ax, 'O' 
	JNE _1stElseIf2ndForPACFUS 
	call U
	call Li 
	call ui 
	call L
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_1stElseIf2ndForPACFUS: 
mov Bx, 4 
	mov Ax, up[Bx] 
	cmp Ax,'R'
	JNE _2ndElseIf2ndForPACFUS 
	call Ui 
	call Ri  
	call Ui  
	call R  
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_2ndElseIf2ndForPACFUS: 
	mov Bx, 4 
	mov Ax, up[Bx] 
	cmp Ax,'B' 
	call Fi 
	call Ui  
	call F  
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	 
	
	
Else2ndForPACFUS:
	call U 
	jmp _2ndForPACFUS

End2ndForPACFUS: 
;/**3rd for loop**/

mov Cx, 0 
_3rdForPACFUS: 
cmp cx, 4 
JGE End3rdForPACFUS

	mov Bx, 4
	mov Ax, up[Bx] 
	cmp Ax, 'W' 
	JNE Else3rdForPACFUS
	
	mov Bx, 2 
	mov Ax, front[bx] 
	cmp Ax, 'B' 
	JNE _1stElseIf3rdForPACFUS 
	call U
	call Li 
	call u 
	call L
	call u 
	call u 
	call li 
	call ui 
	call L 
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_1stElseIf3rdForPACFUS: 
mov Bx, 2 
	mov Ax, front[Bx] 
	cmp Ax,'R'
	JNE _2ndElseIf3rdForPACFUS 
	call R 
	call ui  
	call ri  
	call u 
call u 
call r 
call u 
call ri 
	
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	
_2ndElseIf3rdForPACFUS: 
	mov Bx, 2
	mov Ax, front[Bx] 
	cmp Ax,'G'  
	call ui 
	call ri  
	call u  
call r 
call u 
call u 
call ri 
call ui 
call r 
	
	Mov Ax, 1 
	mov Bool2, Ax 
	Jmp ExitPACFUS 
	 
	
	
Else3rdForPACFUS:
	call U 
	jmp _3rdForPACFUS

End3rdForPACFUS: 

ExitPACFUS:
Mov Ax, 0 
	mov Bool2, Ax 
;/***************/
	pop Di 
	pop Si 
	pop Dx 
	pop Cx 
	pop Bx 
	pop Ax 
	ret
PlaceAnotherCornerFromUpperSide Endp