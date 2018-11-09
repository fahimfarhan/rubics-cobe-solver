ORG 100H
.STACK 100H
.MODEL SMALL
.DATA

UP 	  DW 'Y','Y','Y','Y'
FRONT DW 'G','G','G','G' 
LEFT  DW 'R','R','R','R'
RIGHT DW 'O','O','O','O'
BACK  DW 'B','B','B','B'
DOWN  DW 'W','W','W','W'

TEMP1  DW  0
TEMP2  DW  0
TEMP0  DW  0  

count52 DW 0
error1_52 db "array out of range! $"
moves dw 256 dup(0) ; accha , eta ki 256 er beshi ki rakha jabe? say 500 ?
index dw 0
.CODE

MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	MOV ES, AX
	;/*PORE EI KHANE CODE LEKHA HOBE*/ 
	CALL FI
	CALL PRINTER
	CALL F 
	CALL PRINTER
	CALL D 
	CALL PRINTER
	CALL ID
	CALL PRINTER
	CALL R
	CALL PRINTER
	CALL R
	CALL PRINTER
	;
	CALL R 
	CALL PRINTER
	CALL R
	CALL PRINTER
	CALL RI
	CALL PRINTER
	CALL Bi
	CALL PRINTER
	CALL B
	CALL PRINTER
	CALL F
	CALL PRINTER
	
	call ShowMoves
	            
	;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	;call Checker 
	;call ShowMoves
	
	
	;/*TO BE CONTINUED ...  ...  ...*/
MAIN ENDP

Checker proc 
                
    call BackChecker 
    call BackChecker
    
    Checker endp

;arrray moves has the F, u, ... and index points to the last pos
; count52 has the count 
Backchecker proc
 push ax 
 push bx 
 push cx 
 push dx 
 push si 
 push di 
 
 mov ax, index 
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

Backchecker endp


ShowMoves proc
push ax
push bx
push cx
push dx
push si
push di

lea Si, moves 
mov cx, 0 
Loop_PrinterShowMoves:
cmp cx, index 
JE ExitShowMoves 
mov bx, 0
mov bx, [si]
MOV DL, BL
MOV AH,2
INT 21H
add si, 2 
add cx, 2 
jmp Loop_PrinterShowMoves


;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED  
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
 ;PRINT S
    MOV AH,9
    LEA DX, error1_52
    INT 21H
    ;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
ExitShowMoves:	
pop di
pop si
pop dx 
pop cx 
pop bx 
pop ax
ret   
 
ShowMoves Endp
;/************/ 
;user manual
; mov ax, 'F'
;call savemoves
SaveMoves proc
push ax
push bx
push cx
push dx
push si
push di

mov Bx, index 
cmp bx, 500
JGE ArrayOutOfBondExceptionInShowMoves
;let Ax has the name( F, f, U, D, d ... ...) 
mov moves[Bx], Ax 
Add Bx, 2 
mov index, Bx 
ArrayOutOfBondExceptionInShowMoves:
pop di
pop si
pop dx 
pop cx 
pop bx 
pop ax
ret   
SaveMoves endp 


Counter1 proc 
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
Counter_for_loop: 
	
mov Ax, moves[bx]
cmp bx, 2 
JL counter_for_loop_break	
sub bx, 2 
cmp Ax, moves[bx] 
JNE counter_for_loop_break
Add Cx, 1 
cmp cx, 4 
JE counter_for_loop_break 
jmp  Counter_for_loop

counter_for_loop_break:

mov count52 , Cx 
pop di 
pop si 
pop dx 
pop cx 
pop bx 
pop ax 

Counter1 endp
;BASIC MOVE FUNCTIONS
FI PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, UP
	MOV AX, [SI+6] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, RIGHT
	MOV AX, [DI] 
	MOV [SI+6], AX 
	MOV AX, [DI+6]
	MOV [SI+4], AX
	;/*****************/
	;/*****************/
		
	LEA SI, DOWN
	MOV AX, [SI+2] 
	MOV [DI], AX 
	MOV AX, [SI]
	MOV [DI+6], AX
	;/**
	;/**
	LEA DI, LEFT
	MOV AX, [DI+2] 
	MOV [SI], AX 
	MOV AX, [DI+4]
	MOV [SI+2], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+4], AX 
	MOV AX, TEMP1 
	MOV [DI+2], AX
;/****************/
	
;/LEFT SIDE ROTATE*/
	LEA SI, FRONT
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'f' 
	call SaveMoves
	call Checker
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
FI ENDP;/***********/
F PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, UP
	MOV AX, [SI+6] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, LEFT
	MOV AX, [DI+4] 
	MOV [SI+6], AX 
	MOV AX, [DI+2]
	MOV [SI+4], AX
	;/*****************/
		
	LEA SI, DOWN
	MOV AX, [SI] 
	MOV [DI+2], AX 
	MOV AX, [SI+2]
	MOV [DI+4], AX
	;/**
	LEA DI, RIGHT 
	MOV AX, [DI+6] 
	MOV [SI], AX 
	MOV AX, [DI]
	MOV [SI+2], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI], AX 
	MOV AX, TEMP1 
	MOV [DI+6], AX
;/****************/

;/*****************/
;/LEFT SIDE ROTATE*/
	LEA SI, FRONT
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	       mov Ax, 'F' 
	call SaveMoves
	call Checker
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
F ENDP
;/***********/
B PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, UP 
	MOV AX, [SI] 
	MOV TEMP0 , AX 
	MOV AX, [SI+2] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, RIGHT
	MOV AX, [DI+2] 
	MOV [SI], AX 
	MOV AX, [DI+4]
	MOV [SI+2], AX
;/*****************/
;/*****************/
		
	LEA SI, DOWN
	MOV AX, [SI+6] 
	MOV [DI+4], AX 
	MOV AX, [SI+4]
	MOV [DI+2], AX
;/****************/
;/**
	LEA DI, LEFT 
	MOV AX, [DI] 
	MOV [SI+6], AX 
	MOV AX, [DI+6]
	MOV [SI+4], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI], AX
	;/LEFT SIDE ROTATE*/
	LEA SI, BACK
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/ 
	mov Ax, 'B' 
	call SaveMoves
	call Checker
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
B ENDP
;/***********/
Bi PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, UP 
	MOV AX, [SI] 
	MOV TEMP0 , AX 
	MOV AX, [SI+2] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, LEFT
	MOV AX, [DI+6] 
	MOV [SI], AX 
	MOV AX, [DI]
	MOV [SI+2], AX
;/*****************/
;/*****************/
		
	LEA SI, DOWN
	MOV AX, [SI+6] 
	MOV [DI], AX 
	MOV AX, [SI+4]
	MOV [DI+6], AX
;/****************/
;/**
	LEA DI, RIGHT
	MOV AX, [DI+4] 
	MOV [SI+6], AX 
	MOV AX, [DI+2]
	MOV [SI+4], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+2], AX 
	MOV AX, TEMP1 
	MOV [DI+4], AX
	;/*RIGHT SIDE ROTATE*/


	
	;/*RIGHT SIDE ROTATE*/	
	LEA SI, BACK  
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 
	
;/********/ 
mov Ax, 'b' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
Bi ENDP
;/***********/
Ri PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI] 
	MOV TEMP0 , AX 
	MOV AX, [SI+6] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, DOWN
	MOV AX, [DI+4] 
	MOV [SI], AX 
	MOV AX, [DI+2]
	MOV [SI+6], AX
;/*****************/

;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI+2] 
	MOV [DI+2], AX 
	MOV AX, [SI+4]
	MOV [DI+4], AX
;/****************/
;/**
	LEA DI, UP
	MOV AX, [DI+2] 
	MOV [SI+2], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/**;/**
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+4], AX 
	MOV AX, TEMP1 
	MOV [DI+2], AX
	;/*RIGHT SIDE ROTATE*/
	
	LEA SI, RIGHT  
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'r' 
	call SaveMoves
	call Checker
	
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
Ri ENDP
;/***********/

R PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI] 
	MOV TEMP0 , AX 
	MOV AX, [SI+6] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, UP
	MOV AX, [DI+4] 
	MOV [SI], AX 
	MOV AX, [DI+2]
	MOV [SI+6], AX
;/*****************/
;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI+2] 
	MOV [DI+2], AX 
	MOV AX, [SI+4]
	MOV [DI+4], AX
;/****************/
;/**
	LEA DI, DOWN
	MOV AX, [DI+2] 
	MOV [SI+2], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+4], AX 
	MOV AX, TEMP1 
	MOV [DI+2], AX
	
	;/LEFT SIDE ROTATE*/
	LEA SI, RIGHT
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'R' 
	call SaveMoves
	call Checker
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
R ENDP

;/********/
L PROC
	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI+2] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, DOWN
	MOV AX, [DI] 
	MOV [SI+4], AX 
	MOV AX, [DI+6]
	MOV [SI+2], AX
;/*****************/
;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI] 
	MOV [DI], AX 
	MOV AX, [SI+6]
	MOV [DI+6], AX
;/**;/**
	LEA DI, UP
	MOV AX, [DI] 
	MOV [SI], AX 
	MOV AX, [DI+6]
	MOV [SI+6], AX
;/**
;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI], AX
	;/LEFT SIDE ROTATE*/
	LEA SI, LEFT 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'L' 
	call SaveMoves
	call Checker
;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
L ENDP
;/********/
Li PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI+2] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/**********/
	;/**********/
	LEA DI, UP 
	MOV AX, [DI] 
	MOV [SI+4], AX 
	MOV AX, [DI+6]
	MOV [SI+2], AX
;/*****************/;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI] 
	MOV [DI], AX 
	MOV AX, [SI+6]
	MOV [DI+6], AX
;/**;/**
	LEA DI, DOWN 
	MOV AX, [DI] 
	MOV [SI], AX 
	MOV AX, [DI+6]
	MOV [SI+6], AX
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI], AX
	
;/*UP SIDE ROTATE*/
	
	LEA SI, LEFT 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 

	;/********/
	mov Ax, 'l' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
Li ENDP

;/**********/
iD PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI+6] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	;/*************/
	
	;/**********/
	LEA DI, LEFT  
	MOV AX, [DI+6] 
	MOV [SI+6], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
	;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI+6] 
	MOV [DI+6], AX 
	MOV AX, [SI+4]
	MOV [DI+4], AX
;/**;/**
	LEA DI, RIGHT
	MOV AX, [DI+6] 
	MOV [SI+6], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/**;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI+4], AX
	
	;/*UP SIDE ROTATE*/
	
	LEA SI, DOWN 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 

;/********/
mov Ax, 'd' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
iD ENDP

  ;/********/
Ui PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	MOV AX, 0
	;MOV SI, 0
	LEA SI, BACK ; SI = &B
	MOV AX, [SI] ; 
	MOV TEMP0, AX; TEMP0 = B[0]
	
	MOV AX, [SI+2] ; AX = B[1]
	MOV TEMP1, AX ; TEMP1 = B[1]

	;MOV DI, 0
	LEA DI, RIGHT 
	MOV AX, [DI]
	MOV [SI], AX; B[0] = R[0]
	MOV AX, [DI+2]
	MOV [SI+2], AX ;B1 = R1
	
	;MOV SI, 0
	LEA SI, FRONT 
	MOV AX, [SI] 
	MOV [DI], AX ; R0 = F0
	
	MOV AX, [SI+2]
	MOV [DI+2], AX ; R1 = F1
	
	LEA DI, LEFT 
	MOV AX, [DI] ; AX = L0
	MOV [SI], AX ; F0 = L0
	MOV AX, [DI+2]
	MOV [SI+2], AX
	
	MOV AX, TEMP0
	MOV [DI], AX; L0 = TEMP0
	MOV AX, TEMP1 
	MOV [DI+2], AX ; L1 = TEMP1 
	;/*UP SIDE ROTATE*/
	
	LEA SI, UP 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+2] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+2], AX ; U1 = U2 = AX 
	MOV AX, [SI+6]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+6], AX ; U3 = U0 = AX 

	;/********/
	mov Ax, 'u' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
Ui ENDP

U PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	MOV AX, 0
	MOV AX, 0
	;MOV SI, 0
	LEA SI, BACK ; SI = &B
	MOV AX, [SI] ; 
	MOV TEMP0, AX; TEMP0 = B[0]
	
	MOV AX, [SI+2] ; AX = B[1]
	MOV TEMP1, AX ; TEMP1 = B[1]
	;/***********/
	;MOV DI, 0
	LEA DI, LEFT 
	MOV AX, [DI]
	MOV [SI], AX; B[0] = R[0]
	MOV AX, [DI+2]
	MOV [SI+2], AX ;B1 = R1
	;/******/
	
	LEA SI, FRONT 
	MOV AX, [SI] 
	MOV [DI], AX ; R0 = F0
	
	MOV AX, [SI+2]
	MOV [DI+2], AX ; R1 = F1
	;/*********/
	LEA DI, RIGHT
	MOV AX, [DI] ; AX = L0
	MOV [SI], AX ; F0 = L0
	MOV AX, [DI+2]
	MOV [SI+2], AX
	
	MOV AX, TEMP0
	MOV [DI], AX; R0 = TEMP0
	MOV AX, TEMP1 
	MOV [DI+2], AX ; R1 = TEMP1 
	
	
	;/*UP SIDE ROTATE*/
	
	LEA SI, UP 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	mov Ax, 'U' 
	call SaveMoves
	call Checker
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
U ENDP

PRINTER PROC
push ax 
push bx 
push cx 
push dx 
push si 
push di 
;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
 
;UP 
LEA SI, UP 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
; LEFT

LEA SI, LEFT 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	
;FRONT 

LEA SI, FRONT 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	
;RIGHT
LEA SI, RIGHT  
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H

	;BACK
LEA SI, BACK 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	;DOWN 
LEA SI, DOWN 
MOV BX, [SI]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+2]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+4]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
MOV BX, [SI+6]
;OUPUT
    MOV DL, BL
    MOV AH,2
    INT 21H
	;PRINT NEW LINE
    MOV AH,2
    MOV DL, 0DH; CARRIAGE RETURN
    INT 21H
    
    MOV DL, 0AH; lINE FEED
    INT 21H
    ;NEWLINE CLOSED
	
	pop di 
	pop si 
	pop dx 
	pop cx 
	pop bx 
	pop ax 
	RET 
PRINTER ENDP

D PROC 

	PUSH AX
	PUSH BX
	PUSH CX
	PUSH DX
	PUSH SI
	PUSH DI
	;/********/
	MOV AX, 0 
	LEA SI, BACK 
	MOV AX, [SI+6] 
	MOV TEMP0 , AX 
	MOV AX, [SI+4] 
	MOV TEMP1 , AX 
	
	;/**********/
	LEA DI, RIGHT 
	MOV AX, [DI+6] 
	MOV [SI+6], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/*****************/
		
	LEA SI, FRONT 
	MOV AX, [SI+6] 
	MOV [DI+6], AX 
	MOV AX, [SI+4]
	MOV [DI+4], AX
;/**
	LEA DI, LEFT 
	MOV AX, [DI+6] 
	MOV [SI+6], AX 
	MOV AX, [DI+4]
	MOV [SI+4], AX
;/**
	MOV AX, TEMP0 
	MOV [DI+6], AX 
	MOV AX, TEMP1 
	MOV [DI+4], AX
	
	;/down SIDE ROTATE*/
	LEA SI, DOWN 
	MOV AX, [SI] 
	MOV TEMP1, AX ; TEMP1 = U0 
	MOV AX, [SI+6] ; AX = U1
	MOV [SI], AX  ; U0 = AX = U1
	MOV AX, [SI+4] ; AX = U2
	MOV  [SI+6], AX ; U1 = U2 = AX 
	MOV AX, [SI+2]
	MOV [SI+4], AX ; U2 = U3 = AX 
	MOV AX, TEMP1 ; AX = T1 = U0 
	MOV [SI+2], AX ; U3 = U0 = AX 
	;/********/
	;/********/
	POP DI
	POP SI
	POP DX
	POP CX
	POP BX
	POP AX
	RET
D ENDP  
;/*********/


;/********/
END MAIN




