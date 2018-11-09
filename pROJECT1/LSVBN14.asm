; 1. this language is case insensitive, but we are NOT :|
; 2. damn indexing. array indexes should be 0,2,4,6-- after all, we have word array >_<
org 100h
.model small
.stack 100h

.data
up      dw 4 dup(0)
left    dw 4 dup(0)
front   dw 4 dup(0)
right   dw 4 dup(0)
back    dw 4 dup(0)
down    dw 4 dup(0) 

backup dw 24 dup(0)

temp1  dw  0
temp2  dw  0
temp0  dw  0
temp45  dw  0 

count52 dw 0
error1_52 db "array out of range! $"
moves dw 256 dup(0) 
index dw 0
StringAlgo52 db "Algorithm: $"
String525252 db "Please Enter the Inputs! $"
StringUp52 db "Enter Up face: $"
Stringleft52 db "Enter left face: $"
Stringfront52 db "Enter front face: $"
Stringright52 db "Enter right face: $"
StringBack52 db "Enter back face: $"
StringDown52 db "Enter down face: $"

;used by nobel
temp4  dw  0
bool dw 0
oll_prompt_sym db 'oll symmetric',0dh,0ah,'$'
oll_prompt_nonsym db 'oll non-symmetric',0dh,0ah,'$'
oll_prompt_sune db 'oll sune',0dh,0ah,'$'
oll_prompt_antisune db 'oll antisune',0dh,0ah,'$'
oll_prompt_diagonalcorners db 'oll diagonal corners',0dh,0ah,'$'
oll_prompt_chameleon db 'oll chameleon',0dh,0ah,'$'
oll_prompt_headlight db 'oll headlight',0dh,0ah,'$'
oll_prompt_skip db 'oll skip!',0dh,0ah,'$'
pll_prompt_adjacent db 'pll adjacent$'
pll_prompt_diagonal db 'pll diagonal$'
pll_prompt_skip db 'pll skip!$'

.code
main proc
    mov ax, @data
    mov ds, ax
    mov es, ax

    ;PRINT StringUp52 
    MOV AH,9
    LEA DX, String525252 
    INT 21H
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    ;/****enter the inputs 1st*****/
    call TakeInput
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED 
    call InputBackUp        ;/*************New line added **************/
    
    call place_corner_1
    
    call place_another_corner
    call place_another_corner   
    call place_another_corner
    
    call do_oll
    call do_pll
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    call printer
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    ;PRINT StringUp52 
    MOV AH,9
    LEA DX, StringAlgo52 
    INT 21H
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    
    call showmoves
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    
    mov Ax, index
    Mov temp45, Ax 
    mov cl, 1 
    SHR ax, cl
    call OUTDEC
    
    ;
    call  InputRestor ;/***********new line added ****************/
    call printer 
    call EfficientSolver       ;/**********new line added*****************/
    call printer
    mov Ax, temp45
    mov cl, 1 
    SHR ax, cl 
    call outdec 
    mov ah,4ch
    int 21h
main endp

jmp mainexit52_1 

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
    call printer 
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

InputRestor proc  
    push ax 
push bx 
push cx 
push dx 
push si 
push di 

lea si, backup 
lea di, up 
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, left 
add si, 2 
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, front 
add si, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, right 
add si, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, back 
add si, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
lea di, down 
add si, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
add si,2 
add di, 2
mov ax, [si]
mov [di], ax 
        pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    RET 
InputRestor endp 

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


TakeInput proc 
push Ax 
push Bx 
push Cx 
push Dx 
push Si 
Push Di 

 ;PRINT StringUp52 
    MOV AH,9
    LEA DX, StringUp52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov up[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov up[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov up[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov up[bx], cx 
    add bx, 2 
;/****** left *******/
;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
;PRINT Stringleft52 
    MOV AH,9
    LEA DX, Stringleft52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov left[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov left[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov left[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov left[bx], cx 
    add bx, 2
    ;/***** front ******/
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    ;PRINT Stringfront52 
    MOV AH,9
    LEA DX, Stringfront52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov front[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov front[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov front[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov front[bx], cx 
    add bx, 2
    ;/*****right*****/ 
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
;PRINT Stringright52 
    MOV AH,9
    LEA DX, Stringright52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov right[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov right[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov right[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov right[bx], cx 
    add bx, 2   
    ;/****back****/
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    ;PRINT Stringback52 
    MOV AH,9
    LEA DX, Stringback52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov back[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov back[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov back[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov back[bx], cx 
    add bx, 2
;/*******down*********/ 
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    ;PRINT Stringdown52 
    MOV AH,9
    LEA DX, Stringdown52 
    INT 21H
    ;/**********/
    ;1
    mov cx, 0 
    mov bx, 0 
    ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov down[bx], cx 
    add bx, 2 
    ;2
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov down[bx], cx 
    add bx, 2 
    ;3 
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov down[bx], cx 
    add bx, 2 
    ;4
        ; INPUT
    MOV AH, 1 ; CIN<<AL
    INT 21H   
    MOV cl, AL ; A = AL
    mov down[bx], cx 
    add bx, 2
Pop Di 
pop Si 
pop Dx 
pop cx 
pop bx 
pop Ax 
Ret 
TakeInput Endp


mainexit52_1:  
jmp mainexit9

;Logic Functions by Nobel
place_corner_1 proc
    ;Input : Cube Array
    ;Output: Corner 1 placed correctly in cube array
    ;        Success or failure as bool = 1 or 0
    ;Uses  : place_corner_1_from_upper_side proc
    
    push ax
    
    call place_corner_1_from_upper_side
    
    ;bool == 0 if failed
    cmp bool,0
    jne return_pc1 ;okay bool==1. so direct return.

    ;now, when bool==0, check if corner 1 is already placed
    cmp down[6],'w'
    jne else_pc1_1
    cmp left[6],'o'
    jne else_pc1_1
        ;yap corner 1 is placed already! make bool=1 and return
        mov ax,1
        mov bool,ax
        jmp return_pc1
    else_pc1_1:
        ;let's have a x2 move and place corner 1 from upper side :3
        call R
        call R
        call L
        call L
        call place_corner_1_from_upper_side
    
    return_pc1:
    pop ax
    ret
place_corner_1 endp

place_corner_1_from_upper_side proc
    ;Input : Cube Array
    ;Output: Corner placed correctly in cube array if it is in upper side
    ;        Success or failure as bool = 1 or 0
    ;Uses  : None
    
    push ax
    push cx
    
    ;for return value
    mov ax,0
    mov bool,ax
    
    ;if in upperface
    mov cx,4
    for_pc1fus_1:
        cmp up[0],'w'
        jne else_pc1fus_1
        cmp left[0],'g'
        jne else_pc1fus_1
            call U
            call B
            call B
            mov ax,1
            mov bool,ax ;for return value
            pop cx
            pop ax
            ret
        else_pc1fus_1:
            call U
            loop for_pc1fus_1
        
    ;if in left face
    mov cx,4
    for_pc1fus_2:
        cmp left[0],'w'
        jne else_pc1fus_2
        cmp back[2],'g'
        jne else_pc1fus_2
            call B
            mov ax,1
            mov bool,ax ;for return value
            pop cx
            pop ax
            ret
        else_pc1fus_2:
            call U
            loop for_pc1fus_2
        
    ;if in right face
    mov cx,4
    for_pc1fus_3:
        cmp back[2],'w'
        jne else_pc1fus_3
        cmp up[0],'g'
        jne else_pc1fus_3
            call Li
            mov ax,1
            mov bool,ax ;for return value
            pop cx
            pop ax
            ret
        else_pc1fus_3:
            call U
            loop for_pc1fus_3
    
    ;if it comes down here, false (bool=0) will be returned
    pop cx
    pop ax
    ret
place_corner_1_from_upper_side endp

place_another_corner proc
    ;Input : Cube Array
    ;Output: Another corner placed correctly in cube array
    ;        Success or failure as bool = 1 or 0
    ;Uses  : place_another_corner_from_upper_side
    
    push ax
    
    call place_another_corner_from_upper_side
    
    ;now bool==1 if another corner is placed correctly
    cmp bool,1
    jne try_recovering
    jmp return_pac ;okay bool==1. so direct return
    
    try_recovering:
    ;try recovering FLD
    cmp front[6],'w'
    je  if_pac_11
    cmp left[4],'w'
    je  if_pac_11
    ;else
    jmp if_pac_12   
    if_pac_11:
        call Li
        call Ui
        call L
        call place_another_corner_from_upper_side
        jmp return_pac
        
    if_pac_12:
        cmp down[0],'w'
        jne if_pac_13
        cmp front[6],'b'
        je  if_pac_13
            call Li
            call Ui
            call L
            call place_another_corner_from_upper_side
            jmp return_pac
    
    ;try recovering FRD
    if_pac_13:
        cmp front[4],'w'
        je  if_pac_14
        cmp right[6],'w'
        je  if_pac_14
        ;else
            jmp if_pac_15
    
    if_pac_14:
        call R
        call U
        call Ri
        call place_another_corner_from_upper_side
        jmp return_pac
    
    if_pac_15:
        cmp down[2],'w'
        jne if_pac_16
        cmp right[6],'r'
        je  if_pac_16
            call Fi
            call Ui
            call F
            call U
            call place_another_corner_from_upper_side
            jmp return_pac
    
    ;try recovering RBD
    if_pac_16:
        cmp right[4],'w'
        je  if_pac_17
        cmp back[6],'w'
        je  if_pac_17
        ;else
            jmp if_pac_18
    
    if_pac_17:
        call Ri
        call U
        call R
        call U
        call place_another_corner_from_upper_side
        jmp return_pac
    
    if_pac_18:
        cmp down[4],'w'
        jne if_pac_19
        cmp back[6],'g'
        je  if_pac_19
            call Ri
            call Ui
            call Ui
            call R
            call U
            call place_another_corner_from_upper_side
            jmp return_pac
                
    if_pac_19:
    return_pac:
        pop ax
        ret
place_another_corner endp

place_another_corner_from_upper_side proc
    ;Input : Cube Array
    ;Output: Another corner placed correctly in cube array if it is in upper side
    ;        Success or failure as bool = 1 or 0
    ;Uses  : None
    
    push ax
    push cx
    
    xor ax,ax
    mov bool,ax ; bool = 0 initially
    
    ;search for a RURi
    mov cx,4
    for_pacfus_1:
        cmp right[0],'w'
        jne else_pacfus_1
            cmp up[4],'b'
            jne else_pacfus_11
                call U
                call F
                call U
                call Fi
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_11:
            cmp up[4],'g'
            jne else_pacfus_12
                call Ui
                call B
                call U
                call Bi
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_12:
            cmp up[4],'r'
            jne else_pacfus_13
                call R
                call U
                call Ri
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_13:
        else_pacfus_1:
            call U
            loop for_pacfus_1
        
    ;search for the mirror of previous one
    mov cx,4
    for_pacfus_2:
        cmp front[2],'w'
        jne else_pacfus_2
            cmp up[4],'o'
            jne else_pacfus_21
                call U
                call Li
                call Ui
                call L
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_21:
            cmp up[4],'r'
            jne else_pacfus_22
                call Ui
                call Ri
                call Ui
                call R
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_22:
            cmp up[4],'b'
            jne else_pacfus_23
                call Fi
                call Ui
                call F
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_23:
        else_pacfus_2:
            call U
            loop for_pacfus_2
        
    ;search in the upper side
    mov cx,4
    for_pacfus_3:
        cmp up[4],'w'
        jne else_pacfus_3
            cmp front[2],'b'
            jne else_pacfus_31
                call U
                call Li
                call U
                call L
                call U
                call U
                call Li
                call Ui ;SHOW SOME RESPECT TO THIS UP INVERSE!
                call L
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_31:
            cmp front[2],'r'
            jne else_pacfus_32
                call R
                call Ui
                call Ri
                call U
                call U
                call R
                call U
                call Ri
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_32:
            cmp front[2],'g'
            jne else_pacfus_33
                call Ui
                call Ri
                call U
                call R
                call U
                call U
                call Ri
                call Ui
                call R
                ;yao, return true
                mov ax,1
                mov bool,ax
                jmp return_pacfus
            else_pacfus_33:
        else_pacfus_3:
            call U
            ;loop for_pacfus_3
            dec cx
            cmp cx,0
                je return_pacfus
            ;else
            jmp for_pacfus_3
    
    return_pacfus:
        pop cx
        pop ax
        ret
place_another_corner_from_upper_side endp

do_oll proc
    ;Input : Cube Array
    ;Output: OLL done in Cube Array
    ;        Success or failure as bool = 1 or 0
    ;Uses  : 
    
    push ax
    push dx
    
    ;make bool=0 and look for the number of yellows on upper side
    xor ax,ax
    mov bool,ax  ;bool  = 0
    mov temp4,ax ;temp4 = 0
    
    cmp up[0],'y'
    jne oll_cmp2
        inc temp4
    
    oll_cmp2:
    cmp up[2],'y'
    jne oll_cmp3
        inc temp4
    
    oll_cmp3:
    cmp up[4],'y'
    jne oll_cmp4
        inc temp4
    
    oll_cmp4:
    cmp up[6],'y'
    jne oll_cmp_end
        inc temp4
    
    oll_cmp_end: ;now temp4 == number of yellows on up
    
    cmp temp4,0
    je  no_yellow_on_up
    jmp one_or_more_yellows_on_up
    
    no_yellow_on_up:
        ;move yellow on front[2]
        while_oll_1:
            cmp  front[2],'y'
            je   end_while_oll_1
            call U
            jmp  while_oll_1
        end_while_oll_1:
        
        ;look for case symmetric
        cmp back[2],'y'
        jne nonsym_oll
            ;case sym
            mov ah,9
            lea dx,oll_prompt_sym
            int 21h
            ;algo for symmetric
            call R
            call R
            call U
            call U
            call R
            call U
            call U
            call R
            call R
            ;return true
            mov ax,1
            mov bool,ax
            jmp return_do_oll           
        nonsym_oll:
            ;case nonsym
            mov ah,9
            lea dx,oll_prompt_nonsym
            int 21h
            ;setup move
            cmp front[0],'y'
            jne no_setup_move_for_nonsym
                call U
            no_setup_move_for_nonsym:
            ;algo for non symmetric
            call F
            call R
            call U
            call Ri
            call Ui
            call R
            call U
            call Ri
            call Ui
            call Fi
            ;return true
            mov ax,1
            mov bool,ax
            jmp return_do_oll
    
    one_or_more_yellows_on_up:
        cmp temp4,1
        je  one_yellow_on_up
        jmp two_or_more_yellows_on_up
        
        one_yellow_on_up:
            ;search for sune and antisune
            ;first search for sune
            cmp front[2],'y'
            jne again_search_for_sune
                mov ah,9
                lea dx,oll_prompt_sune
                int 21h
                ;setup moves
                oll_sune_while1:
                    cmp up[6],'y'
                    je oll_sune_while_end1
                    call Ui
                    jmp oll_sune_while1
                oll_sune_while_end1:
                ;algo for sune
                call R
                call U
                call Ri
                call U 
                call R
                call U
                call U
                call Ri
                ;return true
                mov ax,1
                mov bool,ax
                jmp return_do_oll
            again_search_for_sune:
                call U
                cmp front[2],'y'
                jne surely_antisune
                    mov ah,9
                    lea dx,oll_prompt_sune
                    int 21h
                    ;setup moves
                    oll_sune_while2:
                        cmp up[6],'y'
                        je oll_sune_while_end2
                        call Ui
                        jmp oll_sune_while2
                    oll_sune_while_end2:
                    ;algo for sune
                    call R
                    call U
                    call Ri
                    call U 
                    call R
                    call U
                    call U
                    call Ri
                    ;return true
                    mov ax,1
                    mov bool,ax
                    jmp return_do_oll
            ;if still not returned, the case is surely antisune
            surely_antisune:
                mov ah,9
                lea dx,oll_prompt_antisune
                int 21h
                ;setup moves
                oll_antisune_while:
                    cmp up[0],'y'
                    je oll_antisune_while_end
                    call U
                    jmp oll_antisune_while
                oll_antisune_while_end:
                ;algo for antisune
                call Ri
                call Ui
                call R
                call Ui
                call Ri
                call Ui
                call Ui
                call R
                ;return true
                mov ax,1
                mov bool,ax
                jmp return_do_oll
        
        two_or_more_yellows_on_up:
            cmp temp4,2
            je  two_yellows_on_up
            jmp four_yellows_on_up
            
            two_yellows_on_up:
                ;search for headlight, chameleon or diagonal corners
                oll_tyup_while:
                    cmp front[2],'y'
                    je oll_tyup_while_end
                    call U
                    jmp oll_tyup_while
                oll_tyup_while_end:
                
                cmp left[0],'y'
                je  oll_diagonal_corners
                jmp oll_chameleon_or_headlight
                
                oll_diagonal_corners:
                    mov ah,9
                    lea dx,oll_prompt_diagonalcorners
                    int 21h
                    ;algo for diagonal corners
                    call Fi 
                    call R
                    call U
                    call Ri
                    call Ui
                    call Ri
                    call F
                    call R
                    ;return true
                    mov ax,1
                    mov bool,ax
                    jmp return_do_oll
                
                oll_chameleon_or_headlight:
                    cmp back[0],'y'
                    je oll_chameleon
                    jmp oll_headlight
                    
                    oll_chameleon:
                        mov ah,9
                        lea dx,oll_prompt_chameleon
                        int 21h
                        ;setup moves
                        call U
                        call U
                        ;algo for chameleon
                        call R
                        call U
                        call Ri
                        call Ui
                        call Ri
                        call F
                        call R
                        call Fi
                        ;return true
                        mov ax,1
                        mov bool,ax
                        jmp return_do_oll
                    
                    oll_headlight:
                        mov ah,9
                        lea dx,oll_prompt_headlight
                        int 21h
                        ;setup move
                        call Ui
                        ;algo for headlight
                        call F
                        call U
                        call R
                        call Ui
                        call Ri
                        call Fi
                        ;return true
                        mov ax,1
                        mov bool,ax
                        jmp return_do_oll
                
        four_yellows_on_up:
            ;this is necessarily oll skip! :D
            mov ah,9
            lea dx,oll_prompt_skip
            int 21h
            mov ax,1
            mov bool,ax
            jmp return_do_oll
            
    return_do_oll:
        pop dx
        pop ax
        ret 
do_oll endp

do_pll proc
    ;Input : Cube Array
    ;Output: PLL done in Cube Array
    ;        Success or failure as bool = 1 or 0
    ;Uses  : Move functions only
    
    push ax
    push cx
    push dx
    
    ;make bool=0 initially
    xor ax,ax
    mov bool,ax
    
    ;first look for adjacent (tperm)
    mov cx,4
    pll_adjacent_for_loop:
        mov ax,left[0]
        cmp ax,left[2]
        jne else_pll_adjacent_try_again
            mov ax,right[0]
            cmp ax,right[2]
            jne pll_t_perm
                ;it is the pll skip case
                mov ah,9
                lea dx,pll_prompt_skip
                int 21h
                ;finish with ups
                till_up_move_needed_1:
                    mov ax,front[0]
                    cmp ax,front[6]
                    je end_till_up_move_needed_1
                    call U
                    jmp till_up_move_needed_1
                end_till_up_move_needed_1:
                ;return true
                mov ax,1
                mov bool,ax
                jmp return_do_pll
            pll_t_perm:
                ;yap adjacent. apply t perm
                mov ah,9
                lea dx,pll_prompt_adjacent
                int 21h
                ;algo for t perm
                call R
                call U
                call Ri
                call Ui
                call Ri
                call F
                call R
                call R
                call Ui
                call Ri
                call Ui
                call R
                call U
                call Ri
                call Fi
                ;finish with ups
                till_up_move_needed_2:
                    mov ax,front[0]
                    cmp ax,front[6]
                    je end_till_up_move_needed_2
                    call U
                    jmp till_up_move_needed_2
                end_till_up_move_needed_2:
                ;return true
                mov ax,1
                mov bool,ax
                jmp return_do_pll               
        else_pll_adjacent_try_again:
            call U          
        loop pll_adjacent_for_loop
        
    ;as still not returned, it must be the diagonal case
    mov ah,9
    lea dx,pll_prompt_diagonal
    int 21h
    ;algo for diagonal case
    call R
    call Ui
    call Ri
    call Ui
    call F 
    call F
    call Ui
    call R
    call U
    call Ri
    call D
    call R
    call R
    ;and yeah, finish with ups
    till_up_move_needed_3:
        mov ax,front[0]
        cmp ax,front[6]
        je end_till_up_move_needed_3
        call U
        jmp till_up_move_needed_3
    end_till_up_move_needed_3:
    ;return true
    mov ax,1
    mov bool,ax
    jmp return_do_pll
    
    return_do_pll:
    pop dx
    pop cx
    pop ax
    ret
do_pll endp

;Procedures by Fahim.............................................................................................
outdec proc
    ;input ax
    push ax
    push bx
    push cx
    push dx
    or ax,ax
    jge @end_if1
    push ax
    mov dl,'-'
    mov ah,2
    int 21h
    pop ax
    neg ax
    
    @end_if1:
    xor cx,cx
    mov bx,10d
    
    @repeat1:
    xor dx,dx
    div bx
    push dx
    inc cx
    or ax,ax
    jne @repeat1
    
    mov ah,2
    
    @print_loop:
    
    pop dx
    or dl,30h
    int 21h
    loop @print_loop
    
    pop dx
    pop cx
    pop bx
    pop ax
    ret
outdec endp

mainexit9:
jmp mainexit1 

showmoves proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di 
    ;print new line
        mov ah,2
        mov dl, 0dh; carriage return
        int 21h
        
        mov dl, 0ah; line feed
        int 21h
        ;newline closed
    
    lea si, moves 
    mov cx, 0 
    loop_printershowmoves:
    cmp cx, index 
    jge exitshowmoves 
    mov bx, 0
    mov bx, [si]
    mov dl, bl
    mov ah,2
    int 21h
    add si, 2 
    add cx, 2 
    jmp loop_printershowmoves
    
    
    ;print new line
        mov ah,2
        mov dl, 0dh; carriage return
        int 21h
        
        mov dl, 0ah; line feed
        int 21h
        ;newline closed
     ;print s
        mov ah,9
        lea dx, error1_52
        int 21h
        ;print new line
        mov ah,2
        mov dl, 0dh; carriage return
        int 21h
        
        mov dl, 0ah; line feed
        int 21h
        ;newline closed
    exitshowmoves:  
    pop di
    pop si
    pop dx 
    pop cx 
    pop bx 
    pop ax
    ret 
showmoves endp

;arrray moves has the f, u, ... and index points to the last pos
; count52 has the count 
backchecker proc
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
    push di 
    
    mov ax, index 
    cmp ax, 4 
    jle exit_backchecker1
    call counter1 
    mov ax, count52 
    cmp ax, 3 
    jne exit_backchecker1 
    mov bx, index
    sub bx, 2  
    mov ax, 0 
    mov moves[bx], ax 
    sub bx, 2
    mov moves[bx], ax
    mov index, bx
    sub bx, 2 
    mov ax, moves[bx] 
    cmp ax, 96 
    jg u_to_u 
    add ax, 32 
    mov moves[bx], ax 
    jmp exit_backchecker1
    
    u_to_u: 
    sub ax, 32 
    mov moves[bx], ax 
    exit_backchecker1: 
    
    mov ax, index 
    cmp ax, 4 
    jl exit_backcheccker2
    ; else 
    mov bx, index 
    sub bx, 2 
    mov ax, moves[bx] 
    sub bx, 2 
    sub ax, moves[bx] 
    cmp ax, 32 
    je backcheckercaseuui 
    
    cmp ax,  0ffe0h;-32  
    jne exit_backcheccker2
    backcheckercaseuui:
        mov ax, 0 
        mov moves[bx], ax 
        mov index, bx 
        add bx, 2 
        mov moves[bx], 0 
    exit_backcheccker2:
    
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    ret
backchecker endp
mainexit1:
jmp mainexit2

checker proc 
    push ax
    push bx
    push cx
    push dx
    push si
    push di              
    call backchecker 
    call backchecker
    pop di
    pop si
    pop dx 
    pop cx 
    pop bx 
    pop ax
    ret   
checker endp


 

;/************/ 
;user manual
; mov ax, 'f'
;call savemoves
savemoves proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    
    mov bx, index 
    cmp bx, 500
    jge arrayoutofbondexceptioninshowmoves
    ;let ax has the name( f, f, u, d, d ... ...) 
    mov moves[bx], ax 
    add bx, 2 
    mov index, bx 
    arrayoutofbondexceptioninshowmoves:
    pop di
    pop si
    pop dx 
    pop cx 
    pop bx 
    pop ax
    ret   
savemoves endp 


counter1 proc 
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
    push di 
    ; assuming index variable has the index pos; save output in the count52 var  
    mov bx, index 
    mov cx , 1
    sub bx, 2 
    counter_for_loop: 
        
    mov ax, moves[bx]
    cmp bx, 2 
    jl counter_for_loop_break   
    sub bx, 2 
    cmp ax, moves[bx] 
    jne counter_for_loop_break
    add cx, 1 
    cmp cx, 4 
    jge counter_for_loop_break 
    jmp  counter_for_loop
    
    counter_for_loop_break:
    
    mov count52 , cx 
    pop di 
    pop si 
    pop dx 
    pop cx 
    pop bx 
    pop ax 
    ret
counter1 endp

;basic move functions...........................................................................................
fi proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, up
    mov ax, [si+6] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, right
    mov ax, [di] 
    mov [si+6], ax 
    mov ax, [di+6]
    mov [si+4], ax
    ;/*****************/
    ;/*****************/
        
    lea si, down
    mov ax, [si+2] 
    mov [di], ax 
    mov ax, [si]
    mov [di+6], ax
    ;/**
    ;/**
    lea di, left
    mov ax, [di+2] 
    mov [si], ax 
    mov ax, [di+4]
    mov [si+2], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di+4], ax 
    mov ax, temp1 
    mov [di+2], ax
;/****************/
    
;/left side rotate*/
    lea si, front
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'f' 
    call savemoves
    call checker
    ;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
fi endp;/***********/
mainexit2:
jmp mainexit3
f proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, up
    mov ax, [si+6] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, left
    mov ax, [di+4] 
    mov [si+6], ax 
    mov ax, [di+2]
    mov [si+4], ax
    ;/*****************/
        
    lea si, down
    mov ax, [si] 
    mov [di+2], ax 
    mov ax, [si+2]
    mov [di+4], ax
    ;/**
    lea di, right 
    mov ax, [di+6] 
    mov [si], ax 
    mov ax, [di]
    mov [si+2], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di], ax 
    mov ax, temp1 
    mov [di+6], ax
;/****************/

;/*****************/
;/left side rotate*/
    lea si, front
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
           mov ax, 'F' 
    call savemoves
    call checker
    ;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
f endp
;/***********/
b proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, up 
    mov ax, [si] 
    mov temp0 , ax 
    mov ax, [si+2] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, right
    mov ax, [di+2] 
    mov [si], ax 
    mov ax, [di+4]
    mov [si+2], ax
;/*****************/
;/*****************/
        
    lea si, down
    mov ax, [si+6] 
    mov [di+4], ax 
    mov ax, [si+4]
    mov [di+2], ax
;/****************/
;/**
    lea di, left 
    mov ax, [di] 
    mov [si+6], ax 
    mov ax, [di+6]
    mov [si+4], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di], ax
    ;/left side rotate*/
    lea si, back
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/ 
    mov ax, 'B' 
    call savemoves
    call checker
    ;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
b endp
;/***********/
mainexit3:
jmp mainexit4
bi proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, up 
    mov ax, [si] 
    mov temp0 , ax 
    mov ax, [si+2] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, left
    mov ax, [di+6] 
    mov [si], ax 
    mov ax, [di]
    mov [si+2], ax
;/*****************/
;/*****************/
        
    lea si, down
    mov ax, [si+6] 
    mov [di], ax 
    mov ax, [si+4]
    mov [di+6], ax
;/****************/
;/**
    lea di, right
    mov ax, [di+4] 
    mov [si+6], ax 
    mov ax, [di+2]
    mov [si+4], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di+2], ax 
    mov ax, temp1 
    mov [di+4], ax
    ;/*right side rotate*/


    
    ;/*right side rotate*/  
    lea si, back  
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 
    
;/********/ 
mov ax, 'b' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
bi endp
;/***********/
ri proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si] 
    mov temp0 , ax 
    mov ax, [si+6] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, down
    mov ax, [di+4] 
    mov [si], ax 
    mov ax, [di+2]
    mov [si+6], ax
;/*****************/

;/*****************/
        
    lea si, front 
    mov ax, [si+2] 
    mov [di+2], ax 
    mov ax, [si+4]
    mov [di+4], ax
;/****************/
;/**
    lea di, up
    mov ax, [di+2] 
    mov [si+2], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/**;/**
;/**;/**
    mov ax, temp0 
    mov [di+4], ax 
    mov ax, temp1 
    mov [di+2], ax
    ;/*right side rotate*/
    
    lea si, right  
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'r' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
ri endp
;/***********/
mainexit4:
jmp mainexit5

r proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si] 
    mov temp0 , ax 
    mov ax, [si+6] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, up
    mov ax, [di+4] 
    mov [si], ax 
    mov ax, [di+2]
    mov [si+6], ax
;/*****************/
;/*****************/
        
    lea si, front 
    mov ax, [si+2] 
    mov [di+2], ax 
    mov ax, [si+4]
    mov [di+4], ax
;/****************/
;/**
    lea di, down
    mov ax, [di+2] 
    mov [si+2], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/**;/**
    mov ax, temp0 
    mov [di+4], ax 
    mov ax, temp1 
    mov [di+2], ax
    
    ;/left side rotate*/
    lea si, right
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'R' 
    call savemoves
    call checker
    ;/********/
    
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
r endp

;/********/
l proc
    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si+2] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, down
    mov ax, [di] 
    mov [si+4], ax 
    mov ax, [di+6]
    mov [si+2], ax
;/*****************/
;/*****************/
        
    lea si, front 
    mov ax, [si] 
    mov [di], ax 
    mov ax, [si+6]
    mov [di+6], ax
;/**;/**
    lea di, up
    mov ax, [di] 
    mov [si], ax 
    mov ax, [di+6]
    mov [si+6], ax
;/**
;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di], ax
    ;/left side rotate*/
    lea si, left 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'L' 
    call savemoves
    call checker
;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
l endp
;/********/
mainexit5:
jmp mainexit6
li proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si+2] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/**********/
    ;/**********/
    lea di, up 
    mov ax, [di] 
    mov [si+4], ax 
    mov ax, [di+6]
    mov [si+2], ax
;/*****************/;/*****************/
        
    lea si, front 
    mov ax, [si] 
    mov [di], ax 
    mov ax, [si+6]
    mov [di+6], ax
;/**;/**
    lea di, down 
    mov ax, [di] 
    mov [si], ax 
    mov ax, [di+6]
    mov [si+6], ax
;/**;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di], ax
    
;/*up side rotate*/
    
    lea si, left 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 

    ;/********/
    mov ax, 'l' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
li endp

;/**********/
id proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si+6] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    ;/*************/
    
    ;/**********/
    lea di, left  
    mov ax, [di+6] 
    mov [si+6], ax 
    mov ax, [di+4]
    mov [si+4], ax
    ;/*****************/
        
    lea si, front 
    mov ax, [si+6] 
    mov [di+6], ax 
    mov ax, [si+4]
    mov [di+4], ax
;/**;/**
    lea di, right
    mov ax, [di+6] 
    mov [si+6], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/**;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di+4], ax
    
    ;/*up side rotate*/
    
    lea si, down 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 

;/********/
mov ax, 'd' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
id endp
mainexit6:
jmp mainexit7
  ;/********/
ui proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    mov ax, 0
    ;mov si, 0
    lea si, back ; si = &b
    mov ax, [si] ; 
    mov temp0, ax; temp0 = b[0]
    
    mov ax, [si+2] ; ax = b[1]
    mov temp1, ax ; temp1 = b[1]

    ;mov di, 0
    lea di, right 
    mov ax, [di]
    mov [si], ax; b[0] = r[0]
    mov ax, [di+2]
    mov [si+2], ax ;b1 = r1
    
    ;mov si, 0
    lea si, front 
    mov ax, [si] 
    mov [di], ax ; r0 = f0
    
    mov ax, [si+2]
    mov [di+2], ax ; r1 = f1
    
    lea di, left 
    mov ax, [di] ; ax = l0
    mov [si], ax ; f0 = l0
    mov ax, [di+2]
    mov [si+2], ax
    
    mov ax, temp0
    mov [di], ax; l0 = temp0
    mov ax, temp1 
    mov [di+2], ax ; l1 = temp1 
    ;/*up side rotate*/
    
    lea si, up 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+2] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+2], ax ; u1 = u2 = ax 
    mov ax, [si+6]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+6], ax ; u3 = u0 = ax 

    ;/********/
    mov ax, 'u' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
ui endp

u proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    mov ax, 0
    mov ax, 0
    ;mov si, 0
    lea si, back ; si = &b
    mov ax, [si] ; 
    mov temp0, ax; temp0 = b[0]
    
    mov ax, [si+2] ; ax = b[1]
    mov temp1, ax ; temp1 = b[1]
    ;/***********/
    ;mov di, 0
    lea di, left 
    mov ax, [di]
    mov [si], ax; b[0] = r[0]
    mov ax, [di+2]
    mov [si+2], ax ;b1 = r1
    ;/******/
    
    lea si, front 
    mov ax, [si] 
    mov [di], ax ; r0 = f0
    
    mov ax, [si+2]
    mov [di+2], ax ; r1 = f1
    ;/*********/
    lea di, right
    mov ax, [di] ; ax = l0
    mov [si], ax ; f0 = l0
    mov ax, [di+2]
    mov [si+2], ax
    
    mov ax, temp0
    mov [di], ax; r0 = temp0
    mov ax, temp1 
    mov [di+2], ax ; r1 = temp1 
    
    
    ;/*up side rotate*/
    
    lea si, up 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'U' 
    call savemoves
    call checker
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
u endp
mainexit7:
jmp mainexit8

printer proc
    push ax 
    push bx 
    push cx 
    push dx 
    push si 
    push di 
    ;print new line
        mov ah,2
        mov dl, 0dh; carriage return
        int 21h
        
        mov dl, 0ah; line feed
        int 21h
        ;newline closed
     
    ;up 
    lea si, up 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    ; left
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    lea si, left 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
        
    ;front 
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    lea si, front 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
        
    ;right
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    lea si, right  
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    
        ;back
        ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
    lea si, back 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
        ;down
       ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED 
    lea si, down 
    mov bx, [si]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+2]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+4]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
    mov bx, [si+6]
    ;ouput
        mov dl, bl
        mov ah,2
        int 21h
        ;print new line
        mov ah,2
        mov dl, 0dh; carriage return
        int 21h
        
        mov dl, 0ah; line feed
        int 21h
        ;newline closed
        
        pop di 
        pop si 
        pop dx 
        pop cx 
        pop bx 
        pop ax 
        ret 
printer endp

d proc 

    push ax
    push bx
    push cx
    push dx
    push si
    push di
    ;/********/
    mov ax, 0 
    lea si, back 
    mov ax, [si+6] 
    mov temp0 , ax 
    mov ax, [si+4] 
    mov temp1 , ax 
    
    ;/**********/
    lea di, right 
    mov ax, [di+6] 
    mov [si+6], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/*****************/
        
    lea si, front 
    mov ax, [si+6] 
    mov [di+6], ax 
    mov ax, [si+4]
    mov [di+4], ax
;/**
    lea di, left 
    mov ax, [di+6] 
    mov [si+6], ax 
    mov ax, [di+4]
    mov [si+4], ax
;/**
    mov ax, temp0 
    mov [di+6], ax 
    mov ax, temp1 
    mov [di+4], ax
    
    ;/down side rotate*/
    lea si, down 
    mov ax, [si] 
    mov temp1, ax ; temp1 = u0 
    mov ax, [si+6] ; ax = u1
    mov [si], ax  ; u0 = ax = u1
    mov ax, [si+4] ; ax = u2
    mov  [si+6], ax ; u1 = u2 = ax 
    mov ax, [si+2]
    mov [si+4], ax ; u2 = u3 = ax 
    mov ax, temp1 ; ax = t1 = u0 
    mov [si+2], ax ; u3 = u0 = ax 
    ;/********/
    mov ax, 'D' 
    call savemoves
    call checker
    ;/********/
    pop di
    pop si
    pop dx
    pop cx
    pop bx
    pop ax
    ret
d endp  
;/*********/
mainexit8:

;/********/
end main


