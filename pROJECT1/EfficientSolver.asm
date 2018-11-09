.data 
temp45 dw 0
.code 

EfficientSolver proc 
push ax 
push bx 
push cx 
push dx 
push si 
push di 
;moves 
;index 
mov cx, 0 
lea si, moves 
EfficientSolverStart: 
cmp cx, index 
jL EfficientSolverStart1
jmp EfficientSolverEnd

EfficientSolverStart1: 
mov ax, [si] 
EfficientSolverCaseChecker:

EfficientSolvercaseU:
cmp ax, 'U' 
jne EfficientSolvercaseUi
call U 
jmp EfficientSolvercaseCheckerEnd 

EfficientSolvercaseUi:
    cmp ax, 'u' 
jne EfficientSolvercaseD
call Ui  
jmp EfficientSolvercaseCheckerEnd 
;
    
EfficientSolvercaseD:
    cmp ax, 'D' 
jne EfficientSolvercaseDi
call D  
jmp EfficientSolvercaseCheckerEnd
;
    
EfficientSolvercaseDi:
    cmp ax, 'd' 
    jne EfficientSolvercaseF
    call iD   
    jmp EfficientSolvercaseCheckerEnd
    ;
    EfficientSolvercaseF:
    cmp ax, 'F' 
    jne EfficientSolvercaseFi 
    call F   
    jmp EfficientSolvercaseCheckerEnd
    ;
    EfficientSolvercaseFi:
    cmp ax, 'f' 
    jne EfficientSolvercaseB
    call Fi   
    jmp EfficientSolvercaseCheckerEnd
;
    EfficientSolvercaseB: 
    cmp ax, 'B' 
    jne EfficientSolvercaseBi
    call B   
    jmp EfficientSolvercaseCheckerEnd
    EfficientSolvercaseBi:
    cmp ax, 'b' 
    jne EfficientSolvercaseL
    call bi   
    jmp EfficientSolvercaseCheckerEnd
EfficientSolvercaseL:
    cmp ax, 'L' 
    jne EfficientSolvercaseLi
    call L   
    jmp EfficientSolvercaseCheckerEnd
    EfficientSolvercaseLi:
    cmp ax, 'l' 
    jne EfficientSolvercaseR
    call li   
    jmp EfficientSolvercaseCheckerEnd
    EfficientSolvercaseR:
    cmp ax, 'R' 
    jne EfficientSolvercaseRi
    call R  
    jmp EfficientSolvercaseCheckerEnd
    EfficientSolvercaseRi:
    cmp ax, 'r' 
    jne EfficientSolvercasecheckerend 
    call Ri   
    jmp EfficientSolvercaseCheckerEnd
EfficientSolverCaseCheckerEnd:
;call the cube drawing function here 
    ;MOV AH, 1 ; CIN<<AL
    ;INT 21H   
    ;call printer 
;drawing function end
add cx, 2 
add si, 2  
mov dx, temp45
cmp cx, dx   
 jge  EfficientSolverEnd
jmp EfficientSolverStart

EfficientSolverEnd:
mov temp45, cx 
pop di 
pop si 
pop dx 
pop cx 
pop bx 
pop ax 
ret
EfficientSolver endp 
