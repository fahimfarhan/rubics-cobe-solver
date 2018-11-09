PlaceAnotherCorner proc 

push Ax 
push Bx 
Push cx 
Push Dx 
Push Si 
Push Di  
;/***************/ 
call PlaceAnotherCornerFromUpperSide 
mov Ax, bool1
cmp Ax, 1 
JE ExitPAC 
; 1st if 
	mov bx, 6 
	mov Ax, front[bx] 
	cmp Ax, 'W' 
	JE Do1stIfPAC
	mov bx, 4 
	mov Ax, left[bx] 
	cmp Ax, 'W' 
	JNE _1stElseIfPac
Do1stIfPAC:
		call Li 
		call Ui 
		call L 
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
		;1st else if 
_1stElseIfPac:

mov bx, 0 
	mov Ax, down[bx] 
	cmp Ax, 'W' 
	JNE _2ndElseIfPac
	mov bx, 6 
	mov Ax, front[bx] 
	cmp Ax, 'B' 
	JNE _2ndElseIfPac
Do1stElseIfPAC:
		call Li 
		call Ui 
		call L 
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac

_2ndElseIfPac:
;2nd else if 

	mov bx, 4 
	mov Ax, front[bx] 
	cmp Ax, 'W' 
	JE Do2ndElseIfPAC
	mov bx, 6 
	mov Ax, right[bx] 
	cmp Ax, 'W' 
	JNE _3rdElseIfPac
Do2ndElseIfPAC:
		call r 
		call U 
		call ri 
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
		
_3rdElseIfPac: 
mov bx, 02
	mov Ax, down[bx] 
	cmp Ax, 'W' 
	JNE _4thElseIfPac
	mov bx, 6 
	mov Ax, right[bx] 
	cmp Ax, 'R' 
	JE _4thElseIfPac
Do3rdtElseIfPAC:
		call Fi  
		call Ui 
		call F 
		call U 
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
	_4thElseIfPac:
	;4nd else if 

	mov bx, 4 
	mov Ax, right[bx] 
	cmp Ax, 'W' 
	JE Do4thElseIfPAC
	mov bx, 6 
	mov Ax, back[bx] 
	cmp Ax, 'W' 
	JNE _5thElseIfPac
Do4thElseIfPAC:
		call ri  
		call U 
		call r 
call U 		
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
	_5thElseIfPac:
	mov bx, 4
	mov Ax, down[bx] 
	cmp Ax, 'W' 
	JNE ExitPac
	mov bx, 6 
	mov Ax, back[bx] 
	cmp Ax, 'G' 
	JE exitPac
Do5thtElseIfPAC:
		call ri  
		call Ui 
		call ui  
		call r 
call u 		
		call PlaceAnotherCornerFromUpperSide 
		jmp ExitPac
;/***************/
ExitPAC :

	pop Di 
	pop Si 
	pop Dx 
	pop Cx 
	pop Bx 
	pop Ax 
	ret
PlaceAnotherCorner Endp