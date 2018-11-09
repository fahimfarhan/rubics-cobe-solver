ORG 100H
.STACK 100H
.MODEL SMALL
.DATA

UP 	   DW 'R','O','W','Y'
LEFT   DW 'Y','G','B','G' 
FRONT  DW 'O','R','B','Y'
RIGHT  DW 'B','W','R','O'
BACK   DW 'B','G','W','G'
DOWN   DW 'R','Y','W','O'

TEMP1  DW  0
TEMP2  DW  0
TEMP0  DW  0  

count52 DW 0
error1_52 db "array out of range! $"
moves dw 256 dup(0) ; accha , eta ki 256 er beshi ki rakha jabe? say 500 ?
index dw 0
bool1 dw 0
.CODE

MAIN PROC
	MOV AX, @DATA
	MOV DS, AX
	MOV ES, AX
	;/*PORE EI KHANE CODE LEKHA HOBE*/ 
	call printer 
	
	call PlaceCorner1FromUpperSide
	call Printer
	
	mov Ax, bool1 
	cmp Ax, 1 
	JE EscapePlaceCorner1
	call PlaceCorner1
	call Printer	
EscapePlaceCorner1:
    call PlaceAnotherCornerFromUpperSide 
    call Printer

	call ShowMoves
	mov Ax, index
	mov cl, 1 
	SHR ax, cl
	call OUTDEC
	
	
	;/*TO BE CONTINUED ...  ...  ...*/
MAIN ENDP
mainExit13: 
jmp mainExit12
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
MainExit12:
jmp MainExit11 

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

MainExit11:
jmp MAINEXIT10 

OUTDEC PROC
;INPUT AX
PUSH AX
PUSH BX
PUSH CX
PUSH DX
OR AX,AX
JGE @END_IF1
PUSH AX
MOV DL,'-'
MOV AH,2
INT 21H
POP AX
NEG AX

@END_IF1:
XOR CX,CX
MOV BX,10D

@REPEAT1:
XOR DX,DX
DIV BX
PUSH DX
INC CX
OR AX,AX
JNE @REPEAT1

MOV AH,2

@PRINT_LOOP:

POP DX
OR DL,30H
INT 21H
LOOP @PRINT_LOOP

POP DX
POP CX
POP BX
POP AX
RET
OUTDEC ENDP  

MAINEXIT10: 
jmp MAINEXIT9
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
	jmp Level1Proc1for1  
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
MAINEXIT9:
JMP MAINEXIT1 

ShowMoves proc
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

lea Si, moves 
mov cx, 0 
Loop_PrinterShowMoves:
cmp cx, index 
JGE ExitShowMoves 
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
 mov moves[bx], Ax
 mov index, bx
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
  RET
Backchecker endp
MAINEXIT1:
JMP MAINEXIT2

Checker proc 
  push ax
push bx
push cx
push dx
push si
push di              
call BackChecker 
call BackChecker
   pop di
pop si
pop dx 
pop cx 
pop bx 
pop ax
ret   
Checker endp


 

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
JGE counter_for_loop_break 
jmp  Counter_for_loop

counter_for_loop_break:

mov count52 , Cx 
pop di 
pop si 
pop dx 
pop cx 
pop bx 
pop ax 
RET
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
MAINEXIT2:
JMP MAINEXIT3
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
MAINEXIT3:
JMP MAINEXIT4
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
MAINEXIT4:
JMP MAINEXIT5

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
MAINEXIT5:
JMP MAINEXIT6
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
MAINEXIT6:
JMP MAINEXIT7
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
MAINEXIT7:
JMP MAINEXIT8

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
	mov Ax, 'D' 
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
D ENDP  
;/*********/
MAINEXIT8:

;/********/
END MAIN




