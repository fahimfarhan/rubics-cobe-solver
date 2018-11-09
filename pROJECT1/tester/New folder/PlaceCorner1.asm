PlaceCorner1 proc 
push Ax 
push Bx 
Push cx 
Push Dx 
Push Si 
Push Di  
;/***************/ 
mov Ax, bool1 
cmp Ax, 1
JE exitPlaceCorner1

	mov bx, 6 
	mov ax, down[bx] 
	cmp Ax, 'W' 
	JNE ElsePlaceCorner1
	mov bx, 6 
	mov ax, left[bx] 
	cmp Ax, 'O' 
	JNE ElsePlaceCorner1
	mov Ax, 1 
	mov bool1, Ax 	
jmp exitPlaceCorner1 
ElsePlaceCorner1: 
call R 
call R 
call L 
call L 
call PlaceCorner1FromUpperSide 

exitPlaceCorner1:
;/***************/
	pop Di 
	pop Si 
	pop Dx 
	pop Cx 
	pop Bx 
	pop Ax 
	ret

PlaceCorner1 Endp 