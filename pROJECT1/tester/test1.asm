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
;jmp Level1Proc3End2 

 
