PlaceCorner1 proc 
push Ax 
push Bx 
push Cx 
push Dx 
push Si 
push Di 
;if 
mov Bx, 6 
Mov Ax, Down[Bx] 
mov Dx, 'W' 
Cmp Ax, Dx 
JNE Level1Proc2Else
Mov Ax, Left[Bx] 
Mov Dx, 'O'
cmp Ax, Dx 
JNE Level1Proc2Else 
mov Ax, 1 
mov Bool1, Ax 
jmp Level1Proc2End
Level1Proc2Else:
call R 
call R 
call L 
call L 
call PlaceCorner1FromUpperSide
Level1Proc2End:
pop Di 
pop Si 
pop Dx 
pop Cx 
pop Bx 
pop Ax 
Ret 
PlaceCorner1 Endp