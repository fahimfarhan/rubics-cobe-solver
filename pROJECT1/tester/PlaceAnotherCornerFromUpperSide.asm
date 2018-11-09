PlaceAnotherCornerFromUpperSide Proc
push Ax 
push Bx 
push Cx 
push Dx 
push Si 
push Di 

mov Cx, 0 
Level1Proc3For1: 
Add cx, 1 
cmp Cx,  4 
JG Level1Proc3For1End 

mov Bx, 0 
mov Ax, Right[bx] 
mov Dx, 'W' 
cmp Ax, Dx 
Je Level1Proc3For1If_If1 
;else 
call U 
jmp Level1Proc3For1 
 
Level1Proc3For1If_If1: 
mov Bx, 4 
mov Ax, up[bx] 
mov Dx, 'B' 
cmp Ax, Dx 
JNE Level1Proc3For1If_If2 
call U 
call F 
call U 
call Fi 
mov Ax, 1 
mov bool1, Ax 
jmp Level1Proc3End1 

Level1Proc3For1If_If2: 
mov Dx, 'G' 
cmp Ax, Dx 
JNE Level1Proc3For1If_If3 
call Ui 
call B 
call U 
call Bi 
mov Ax, 1 
mov bool1, Ax 
JMP Level1Proc3End1 
Level1Proc3For1If_If3: 
mov Dx, 'R' 
cmp Ax, Dx 
JNE Level1Proc3For1If_Else 
call R 
call U 
call Ri 
mov Ax, 1 
mov bool1, Ax 
JMP Level1Proc3End1 

Level1Proc3For1If_Else: 
jmp Level1Proc3For1 

Level1Proc3for1end: 
jmp Level1Proc3for2Start 

Level1Proc3End1: 
jmp Level1Proc3End2 
;/***********************/
Level1proc3for2Start: 
mov Cx, 0 
Level1Proc3For2: 
Add cx, 1 
cmp Cx,  4 
JG Level1Proc3For2End 

mov Bx, 2
mov Ax, front[bx] 
mov Dx, 'W' 
cmp Ax, Dx 
Je Level1Proc3For2If_If1 
;else 
call U 
jmp Level1Proc3For2 
 
Level1Proc3For2If_If1: 
mov Bx, 4 
mov Ax, up[bx] 
mov Dx, 'O' 
cmp Ax, Dx 
JNE Level1Proc3For2If_If2 
call U 
call Li 
call Ui 
call L 
mov Ax, 1 
mov bool1, Ax 
jmp Level1Proc3End2 

Level1Proc3For2If_If2: 
mov Dx, 'R' 
cmp Ax, Dx 
JNE Level1Proc3For2If_If3 
call Ui 
call Ri  
call Ui  
call R 
mov Ax, 1 
mov bool1, Ax 
JMP Level1Proc3End2 
Level1Proc3For2If_If3: 
mov Dx, 'B' 
cmp Ax, Dx 
JNE Level1Proc3For2If_Else 
call Fi  
call Ui  
call F  
mov Ax, 1 
mov bool1, Ax 
JMP Level1Proc3End2 

Level1Proc3For2If_Else: 
jmp Level1Proc3For2 

Level1Proc3for2end: 
jmp Level1Proc3for3Start 

Level1Proc3End2: 
jmp Level1Proc3End3 

Level1proc3for3Start: 
mov Cx, 0 
Level1Proc3For3: 
Add cx, 1 
cmp Cx,  4 
JG Level1Proc3For3End 

mov Bx, 4
mov Ax, up[bx] 
mov Dx, 'W' 
cmp Ax, Dx 
Je Level1Proc3For3If_If1 
;else 
call U 
jmp Level1Proc3For3 
 
Level1Proc3For3If_If1: 
mov Bx, 2 
mov Ax, front[bx] 
mov Dx, 'B' 
cmp Ax, Dx 
JNE Level1Proc3For3If_If2 
call U 
call Li 
call U 
call L
call U 
call U 
call Li 
call Ui 
call L  
mov Ax, 1 
mov bool1, Ax 
jmp Level1Proc3End3 

Level1Proc3For3If_If2: 
mov Dx, 'R' 
cmp Ax, Dx 
JNE Level1Proc3For3If_If3 
call R
call Ui  
call Ri  
call U 
call U 
call R 
call U 
call Ri 
mov Ax, 1 
mov bool1, Ax 
JMP Level1Proc3End3 
Level1Proc3For3If_If3: 
mov Dx, 'G' 
cmp Ax, Dx 
JNE Level1Proc3For3If_Else 
call Ui  
call Ri  
call U 
call R 
call U 
call U 
call Ri 
call Ui 
call R  
mov Ax, 1 
mov bool1, Ax 
JMP Level1Proc3End3 

Level1Proc3For3If_Else: 
jmp Level1Proc3For3 

Level1Proc3for3end:
;jmp Level1Proc3for3Start 
mov Ax, 0 
mov bool1, Ax
Level1Proc3End3:  

pop Di 
pop Si 
pop Dx 
pop Cx 
pop Bx 
pop Ax 
Ret 
PlaceAnotherCornerFromUpperSide Endp